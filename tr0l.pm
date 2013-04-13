package tr0l;
use strict;
use warnings;
use Irssi;

my $vfile = "VERSION"
open( FILE, '<', $vfile ) or die 'Could not open file:  ' . $!;
our $VERSION = <FILE>;
our @EXPORT = qw(respond, command_set_handler);

our (@CHANNELS, %COMMANDS, %HELP, $DEFAULT) = ( );

sub respond {
    my ($server, $msg, $target, $nick) = @_;
    my (@command, $cmd, $m1, $m2, $m3, @arguments, $chans) = 0;
    # test that message came from a joined chan
    $chans = join("|", @CHANNELS);
    return unless $target =~ /^#($chans)/;

    @command = split(' ', $msg);

    # account for possible nick prefix
    if($command[0] =~ /tr0l:?/) {
        shift(@command);
    }

    $cmd = $command[0];
    shift(@command);
    @arguments = @command;

    return unless $cmd;
    return if $msg eq $cmd;

    # invoke handler
    my $responder = $COMMANDS{$cmd} // $COMMANDS{$DEFAULT};
    $output = $responder->($server ,$target, $nick, $arguments);

    if($output) {
        # respond with what is assumed to be a returned string
        $server->command("msg $target $output");
    }
}

sub command_set_handler {
    my ($cmd, $doc, $handler) = @_;
    $COMMANDS{$cmd} = $handler;
    $HELP{$cmd} = $doc;
}

sub command_set_default {
    my ($cmd, $hander) = @_;
    $DEFAULT = $cmd;
    $COMMANDS{$cmd} = $hander;
}

command_set_default("_DEFAULT_",
                    sub{
                        Irssi::print("Failed command:");
                        Irssi::print("  \$target   " . $target);
                        Irssi::print("  \$nick     " . $nick);
                        Irssi::print("  \$msg      " . $msg);
                        Irssi::print("  \@command  " . @command);
                        Irssi::print("  \$command  " . $cmd);
                        Irssi::print("  \$1        " . $m1);
                        Irssi::print("  \$2        " . $m2);
                        Irssi::print("  \$3        " . $m3);
                        return "no intiendo."
                    });

command_set_handler("!help", "Prints this help message",
                    sub {
                        return "Commands: " .
                            join(",\n", map("$_ : $COMMANDS{$_}",
                                           keys %COMMANDS));
                    });

command_set_handler("!slap", "!slap <user> slaps a ho",
                    sub{
                        my ($server, $chan, $nick, $args) = @_;
                        return "$args[0] got slapped around a bit with a large trout.";
                    });

# split out command suites
require "tr0l/karma.pl";
require "tr0l/alias.pl";
