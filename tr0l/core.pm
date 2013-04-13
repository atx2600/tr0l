package tr0l::core;
use strict;
use warnings;
use Irssi;
use tr0l;

our (%COMMANDS) = (
    "_DEFAULT_" => sub{
        my ($server, $chan, $nick, @args) = @_;
        Irssi::print("Failed command:");
        Irssi::print("  \$target   " . $chan);
        Irssi::print("  \$nick     " . $nick);
        Irssi::print("  \$args     " . @args);
        return "no intiendo."
    },
    "!help" => sub {
        return "Commands: " .
            join(",\n", map("$_ : $tr0l::COMMANDS{$_}",
                            keys %tr0l::COMMANDS));
    },
    "!slap" => sub{
        my ($server, $chan, $nick, @args) = @_;
        return "$args[0] got slapped around a bit with a large trout.";
    },
    "!version" => sub{return $tr0l::VERSION;}
    );

our (%HELP) = (
    "!help" =>  "Prints this help message",
    "!slap" => "!slap <user> slaps a ho",
    "!version" => "!version prints tr0l's version number."
    );

1;
