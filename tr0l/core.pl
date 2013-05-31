package tr0l;
use strict;
use warnings;

command_set_default("_DEFAULT_",
                    sub{
                      my ($chan, $nick, $server, @args) = @_;
                        return "msg $chan no intiendo.";
                    });

command_set_handler("!help", "Prints this help message",
                    sub {
                      my ($chan, $nick, $server, @args) = @_;
                        return "msg $chan Commands:\n  " .
                            join(",\n  ", map("$_ : $tr0l::HELP{$_}",
                                            keys %tr0l::HELP));
                    });

command_set_handler("!slap", "!slap <user> slaps a ho",
                    sub{
                        my ($chan, $nick, $server, @args) = @_;
                        return "msg $chan ".
                          "$args[0] got slapped around a bit with a large trout.";
                    });

command_set_handler("!version", "!version prints tr0l's version number.",
                    sub{
                      my ($chan, $nick, $server, @args) = @_;
                        return "msg $chan $tr0l::VERSION";
                    });
