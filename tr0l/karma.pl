package tr0l;
use strict;
use warnings;
our %KARMA = ( );

command_set_handler("!inc", "!inc <user> upvotes",
                    sub{
                        my ($server, $chan, $nick, $args) = @_;
                        if ( $nick ne $args[0]
                             and not exists({map { $_ => 1 }
                                             $tr0l::IS{$nick}}->{$nick})) {
                            my ($n) = 0;
                            $n = 1 + $tr0l::KARMA{$m1};
                            $tr0l::KARMA{$m1} = $n;
                            return "$m1 -> $n";
                        }});

command_set_handler("!dec", "!dec <user> downvotes",
                    sub {
                        my ($n) = 0;
                        $n = $tr0l::KARMA{$m1} - 1;
                        $tr0l::KARMA{$m1} = $n;
                        $output = "$m1 -> $n";
                    });

command_set_handler("!karma", "!karma <user> prints the user's karma count",
                    sub{
                        my ($server, $chan, $nick, $args) = @_;
                        my ($n, $output) = (0, "");
                        $n = $tr0l::KARMA{$nick} | 0;

                        if($nick eq $args[0]) {
                            $output .= "you have";
                        } else {
                            $output .= "$m1 has";
                        }

                        $output .= " $n ultra-valuable karma point";
                        if(not $n eq 1) {
                            $output = $output . "s";
                        }
                        return $output;
                    });
