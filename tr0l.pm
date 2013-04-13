package tr0l;
use strict;
use warnings;

use Irssi;

our $VERSION = "X.Y.Z-SNAPSHOT-UNSTABLE";

sub respond {
    my ($self) = shift;
    my ($server, $msg, $target, $nick) = @_;
    my (@command, $cmd, $m1, $m2, $m3, @arguments, $chans, $output);

    # test that message came from a joined chan
    $chans = join("|", @$self->{CHANNELS});
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
    my $responder = $self->{COMMANDS}{$cmd}
                    // $$self->{COMMANDS}{$self->{DEFAULT}};
    $output = $responder->($server, $target, $nick, @arguments);

    if($output) {
        # respond with what is assumed to be a returned string
        $server->command("msg $target $output");
    } else {
        Irssi::print("no reply produced...");
    }
}

sub install_module {
    my ($self) = shift;
    my ($mod) = @_;
    $self->{COMMANDS} = ($self->{COMMANDS}, $mod->{COMMANDS});
    $self->{HELP}     = ($self->{HELP}, $mod->{HELP});
}

sub new {
    my($class, %args) = @_;
    my $self = bless({}, $class);
    $self->{VERSION} = $VERSION;
    $self->{COMMANDS};
    $self->{HELP};
    return $self;
}

1;
