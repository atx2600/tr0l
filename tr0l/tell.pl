package tr0l;
use strict;
use warnings;

use Irssi;

our %MSGS = ("arrdem" => ());

command_set_handler("!tell", "!tell <user> [text], leave a message",
                    sub{
                        my ($chan, $nick, @cmdargs, $server) = @_;
                        my ($user) = shift(@cmdargs);
                        if (not defined($user)) {
                            return "msg $chan $nick !tell requires a nick argument";
                        }
                        my (@msgs) = (@MSGS{$user} // ());
                        @msgs = ((join(" ",(("$nick:"),
                                            @cmdargs))),
                                 @msgs);
                        @MSGS{$user} = @msgs;
                        return "msg $chan $nick: OK, I'll tell $user that!";
                    });

command_set_handler("!mail", "!mail, get your messages in messages in PMs",
                    sub{
                        my ($chan, $nick, @cmdargs, $server) = @_;
                        my (@msgs) = @MSGS{$nick};
                        @MSGS{$nick} = ();
                        return "msg $nick " . join("\n", @msgs);
                    });
