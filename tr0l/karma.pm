package tr0l::karma;
use strict;
use warnings;
use tr0l::alias;

our (%KARMA);

our (%COMMANDS) = (
    "!inc" => sub{
        my ($server, $chan, $nick, @args) = @_;
        if ( $nick ne $args[0]
             and not $tr0l::alias::is->($nick, $args[0])) {
            my ($n) = 0;
            $n = 1 + $KARMA{$args[1]};
            $KARMA{$args[1]} = $n;
            return "$args[1] -> $n";
        }
    },
    "!dec" => sub {
        my ($server, $chan, $nick, @args) = @_;
        my ($n) = 0;
        $n = $KARMA{$args[1]} - 1;
        $KARMA{$args[1]} = $n;
        return "$args[1] -> $n";
    },
    "!karma" => sub{
        my ($server, $chan, $nick, @args) = @_;
        my ($n, $output) = (0, "");
        $n = $KARMA{$nick} | 0;

        if($nick eq $args[0]) {
            $output .= "you have";
        } else {
            $output .= "$args[1] has";
        }

        $output .= " $n ultra-valuable karma point";
        if(not $n eq 1) {
            $output = $output . "s";
        }
        return $output;
    }
    );

our (%HELP) = ("!inc" => "!inc <user> upvotes",
               "!dec" => "!dec <user> downvotes",
               "!karma" => "!karma <user> prints the user's karma count"
    );

sub new {
    my($class, %args) = @_;
    my $self = bless({}, $class);
    $self->{COMMANDS} = %COMMANDS;
    $self->{HELP} = %HELP;
    return $self;
}

1;
