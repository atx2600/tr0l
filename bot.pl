use strict;
use Irssi;
use LWP::Simple;
use HTML::TokeParser;
use vars qw($VERSION %IRSSI);

$VERSION = '0.1.0';
%IRSSI = (
    authors => 'Reid McKenzie',
    name => 'Bot',
    description => 'All around Irssi bot.',
    license => 'GPL',
);

$Bot::KARMA = ( );
%Bot::IS = ( );

sub process_message {
    my ($server, $msg, $target, $nick) = @_;
    my @command = 0;
    my ($cmd, $m1, $m2, $m3) = 0;
    return unless $target =~ /^#(atx2600)/;
    @command = split(' ', $msg);
    if(@command[0] =~ /arrdem-lurkin:?/) {
        shift(@command);
    }
    $cmd = @command[0];
    shift(@command);
    $m1 = @command[0];
    $m2 = @command[1];
    $m3 = @command[2];

#    Irssi::print("\$target   " . $target);
#    Irssi::print("\$nick     " . $nick);
#    Irssi::print("\$msg      " . $msg);
#    Irssi::print("\@command  " . @command);
#    Irssi::print("\$command  " . $cmd);
#    Irssi::print("\$1        " . $m1);
#    Irssi::print("\$2        " . $m2);
#    Irssi::print("\$3        " . $m3);

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
            and not exists({map { $_ => 1 } $Bot::IS{$nick}}->{$nick})) {
        if ($cmd eq "!inc")
        {
            my ($n) = 0;
            $n = 1 + $Bot::KARMA{$m1};
            $Bot::KARMA{$m1} = $n;
            $output = "$m1 -> $n";
        }
        elsif($cmd eq "!dec")
        {
            my ($n) = 0;
            $n = $Bot::KARMA{$m1} - 1;
            $Bot::KARMA{$m1} = $n;
            $output = "$m1 -> $n";
        }
        elsif($cmd eq "!karma")
        {
            my ($n) = 0;
            $n = $Bot::KARMA{$m1} | 0;

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
        $Bot::IS{$m1} .= $m2;
        $output = "okay $nick, $m2 is an alias of $m1.";
    }
    elsif ( $cmd eq "!aliases" )
    {
        $output = "$m1 is also known as $Bot::IS{$m1}.";
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
