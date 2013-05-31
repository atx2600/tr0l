package tr0l;
use strict;
use warnings;

our %IS = ( );

command_set_handler("!alias", "!alias <user> <name> records an alias",
                    sub{
                       my ($chan, $nick, $server, @args) = @_;
                        $IS{$args[1]} .= $args[2];
                        return "okay $nick, $args[2] is also known as $args[1].";
                    });

command_set_handler("!aliases", "!aliases <user> prints a user's aliases",
                    sub {
                        my ($chan, $nick, $server, @args) = @_;
                        return "$args[1] is also known as $IS{$args[1]}.";
                    });
