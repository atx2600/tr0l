package tr0l;
use strict;
use warnings;
our %KARMA = ("arrdem", 1);

command_set_handler("!inc", "!inc <user> upvotes",
                    sub{
                        my ($chan, $nick, @args) = @_;
                        if (not defined($args[0])) {
                          return "msg $chan $nick !inc requires a nick argument";
                        }
                        if ( $nick ne $args[0] ) {
                            my ($n) = 1 + ($KARMA{$args[0]} // 0);
                            $KARMA{$args[0]} = $n;
                            return "msg $chan $args[0] -> $n";
                        }});

command_set_handler("!dec", "!dec <user> downvotes",
                    sub {
                        my ($chan, $nick, @args) = @_;
                        my ($n) = 0;
                        if (not defined($args[0])) {
                          return "msg $chan $nick !dec requires a nick argument";
                        }
                        $n = $KARMA{$args[1]} - 1;
                        $KARMA{$args[1]} = $n;
                        return "msg $chan $args[1] -> $n";
                    });

command_set_handler("!karma", "!karma <user> prints the user's karma count",
                    sub{
                        my ($chan, $nick, @args) = @_;
                        my ($n, $output);

                        if (not defined($args[0])) {
                          return "msg $chan $nick !karma requires a nick argument";
                        }

                        $n = $KARMA{$args[0]} // 0;

                        $output = "msg $chan ";
                        if($nick eq $args[0]) {
                            $output .= "you have";
                        } else {
                            $output .= "$args[0] has";
                        }

                        $output .= " $n ultra-valuable karma point";
                        if(not $n eq 1) {
                            $output = $output . "s";
                        }
                        return $output;
                    });
