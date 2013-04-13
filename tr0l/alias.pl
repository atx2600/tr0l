package tr0l;
use strict;
use warnings;

our %IS = ( );

command_set_handler("!alias", "!alias <user> <name> records an alias",
                    sub{
                       my ($server, $chan, $nick, $args) = @_;
                        $IS{$args[1]} .= $args[2];
                        return "okay $nick, $m2 also known as $m1.";
                    });

t_handler("!aliases", "!aliases <user> prints a user's aliases",
                    sub {
                        my ($server, $chan, $nick, $args) = @_;
                        return "$args[1] is also known as $IS{$args[1]}.";
                    });
