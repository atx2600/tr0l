package tr0l;
use strict;
use warnings;

use Irssi;

our $VERSION = "X.Y.Z-SNAPSHOT-UNSTABLE";
our (@CHANNELS, %COMMANDS, %HELP, $DEFAULT);

sub respond {
    my ($server, $msg, $target, $nick) = @_;
    my (@command, $cmd, $m1, $m2, $m3, @arguments, $chans, $output);

    # test that message came from a joined chan
    $chans = join("|", @tr0l::CHANNELS);
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
    $output = $responder->($server, $target, $nick, @arguments);

    if($output) {
        # respond with what is assumed to be a returned string
        $server->command("msg $target $output");
    }
}

sub install_module {
    my ($mod) = @_;
    %COMMANDS = (%COMMANDS, %mod::COMMANDS);
    %HELP     = (%HELP, %mod::HELP);
}

1;
