package tr0l::alias;
use strict;
use warnings;

our (%IS);

our (%COMMANDS) = (
    "!alias" => sub{
        my ($server, $chan, $nick, @args) = @_;
        $IS{$args[1]} .= $args[2];
        return "okay $nick, $args[2] is also known as $args[1].";
    },
    "!aliases" => sub {
        my ($server, $chan, $nick, @args) = @_;
        return "$args[1] is also known as $IS{$args[1]}.";
    }
    );

sub is {
    my ($name, $alias) = @_;
    return exists({map { $_ => 1 }
                   $IS{$name}}->{$name});
}

our (%HELP) = ("!alias" => "!alias <user> <name> records an alias",
               "!aliases" => "!aliases <user> prints a user's aliases");

sub new {
    my($class, %args) = @_;
    my $self = bless({}, $class);
    $self->{COMMANDS} = %COMMANDS;
    $self->{HELP} = %HELP;
    return $self;
}

1;
