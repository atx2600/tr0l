use strict;
use Irssi;
use LWP::Simple;
use HTML::TokeParser;
use vars qw($VERSION %IRSSI);

my $vfile = "VERSION"
open( FILE, '<', $vfile ) or die 'Could not open file:  ' . $!;
$VERSION = <FILE>;
%IRSSI = (
    authors => 'Reid McKenzie',
    name => 'tr0l',
    description => 'All around Irssi bot.',
    license => 'EPL',
    url => 'http://github.com/atx2600/tr0l',
);

%tr0l::KARMA = ( );
@tr0l::CHANNELS = ( );
%tr0l::IS = ( );
%tr0l::COMMANDS = ( );

sub process_message {
    my ($server, $msg, $target, $nick) = @_;
    my @command = 0;
    my ($cmd, $m1, $m2, $m3, @arguments) = 0;
    return unless $target =~ /^#(atx2600)/;
    @command = split(' ', $msg);
    if($command[0] =~ /tr0l:?/) {
        shift(@command);
    }
    $cmd = $command[0];
    shift(@command);
    @arguments = @command;
    $m1 = $command[0];
    $m2 = $command[1];
    $m3 = $command[2];

    return unless $cmd;
    return if $msg eq $cmd;

    my $output = "";
    if ($cmd eq "help")
    {
        $output = "Commands: "
                 ."!slap <user>, "
                 ."!inc <user>, "
                 ."!dec <user>, "
                 ."!karma <user>, "
                 ;
                 #"!alias <user> <alias>, ".
                 #"!aliases <user>";
    }
    elsif ( $nick ne $1
            and not exists({map { $_ => 1 } $tr0l::IS{$nick}}->{$nick})) {
        if ($cmd eq "!inc")
        {
            my ($n) = 0;
            $n = 1 + $tr0l::KARMA{$m1};
            $tr0l::KARMA{$m1} = $n;
            $output = "$m1 -> $n";
        }
        elsif($cmd eq "!dec")
        {
            my ($n) = 0;
            $n = $tr0l::KARMA{$m1} - 1;
            $tr0l::KARMA{$m1} = $n;
            $output = "$m1 -> $n";
        }
        elsif($cmd eq "!karma")
        {
            my ($n) = 0;
            $n = $tr0l::KARMA{$m1} | 0;

            if($nick eq $m1) {
                $output .= "you have";
            } else {
                $output .= "$m1 has";
            }

            $output .= " $n ultra-valuable karma point";
            if(not $n eq 1) {
                $output = $output . "s";
            }
        }
        elsif ($cmd eq "!slap" && $1)
        {
            $output = "$1 got slapped around a bit with a large trout.";
        }
    }
    elsif ( $cmd eq "!alias" )
    {
        $tr0l::IS{$m1} .= $m2;
        $output = "okay $nick, $m2 is an alias of $m1.";
    }
    elsif ( $cmd eq "!aliases" )
    {
        $output = "$m1 is also known as $tr0l::IS{$m1}.";
    }
    else
    {
        Irssi::print("Failed command:");
        Irssi::print("  \$target   " . $target);
        Irssi::print("  \$nick     " . $nick);
        Irssi::print("  \$msg      " . $msg);
        Irssi::print("  \@command  " . @command);
        Irssi::print("  \$command  " . $cmd);
        Irssi::print("  \$1        " . $m1);
        Irssi::print("  \$2        " . $m2);
        Irssi::print("  \$3        " . $m3);
    }

    $server->command("msg $target $output");
}

Irssi::signal_add_last('message public', sub {
    my ($server, $msg, $nick, $mask, $target) = @_;
    Irssi::signal_continue($server, $msg, $nick, $mask, $target);
    process_message($server, $msg, $target, $nick);
});

Irssi::signal_add_last('message own_public', sub {
    my ($server, $msg, $target) = @_;
    Irssi::signal_continue($server, $msg, $target);
    process_message($server, $msg, $target);
});
