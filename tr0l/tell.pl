package tr0l;
use strict;
use warnings;

our %MSGS = ("arrdem" => ());

command_set_handler("!tell", "!tell <user> [text], leave a message",
                    sub{
                        my ($chan, $nick, $server, @cmdargs) = @_;
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
                        my ($chan, $nick, $server, @cmdargs) = @_;
                        my (@msgs) = @MSGS{$nick};
                        foreach my $msg(@msgs) {
                            $server->command("msg $nick $msg");
                        }
                        @MSGS{$nick} = ();
                        return "";
                    });
