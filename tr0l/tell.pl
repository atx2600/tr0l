package tr0l;
use strict;
use warnings;

use Irssi;

our %MSGS = ("arrdem" => ());

command_set_handler("!tell", "!tell <user> [text], leave a message",
                    sub{
                        my ($chan, $nick, @args) = @_;
                        my ($user) = pop(@args);
                        if (not defined($user)) {
                            return "msg $chan $nick !tell requires a nick argument";
                        }
                        my (@msgs) = ($MSGS{$user} // ());
                        @msgs = ((join(" ",(("$nick:"), @args))),@msgs);
                        $MSGS{$user} = @msgs;
                        return "msg $chan $nick: OK, I'll tell $user that!";
                    });

command_set_handler("!mail", "!mail, get your messages in messages in PMs",
                    sub{
                        my ($chan, $nick, @args, $server) = @_;
                        foreach ($MSGS{$nick}) {
                            $server->command("msg $nick $_\n");
                        }
                        $MSGS{$nick} = ();
                        return "";
                    });