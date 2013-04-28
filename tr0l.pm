package tr0l;
use strict;
use warnings;
use Irssi;
use File::Basename;

my $vfile = "VERSION";
open( FILE, '<', $vfile ) or die 'Could not open file:  ' . $!;
our $VERSION = <FILE>;
our @EXPORT = qw(respond command_set_handler);

our (@CHANNELS,
     %COMMANDS,
     %HELP,
     %IS);
our $DEFAULT = "_DEFAULT_";

sub respond {
    my ($msg, $target, $nick) = @_;
    my (@command, $cmd, $chans, $output);

    @command = split(' ', $msg);

    $cmd = shift(@command);

    return unless $cmd;

    # invoke handler
    my $responder = $COMMANDS{$cmd} // $COMMANDS{"_DEFAULT_"};

    return $responder->($target, $nick, @command);
}

sub command_set_handler {
    my ($cmd, $doc, $handler) = @_;
    $COMMANDS{$cmd} = $handler;
    $HELP{$cmd} = $doc;
}

sub command_set_default {
    my ($cmd, $hander) = @_;
    $DEFAULT = $cmd;
    $COMMANDS{$cmd} = $hander;
}
command_set_default("_DEFAULT_",
                    sub{
                      my ($chan, $nick, @args) = @_;
                        return "msg $chan no intiendo.";
                    });

command_set_handler("!help", "Prints this help message",
                    sub {
                      my ($chan, $nick, @args) = @_;
                        return "msg $chan Commands:\n  " .
                            join(",\n  ", map("$_ : $HELP{$_}",
                                            keys %HELP));
                    });

command_set_handler("!slap", "!slap <user> slaps a ho",
                    sub{
                        my ($chan, $nick, @args) = @_;
                        return "msg $chan ".
                          "$args[0] got slapped around a bit with a large trout.";
                    });

command_set_handler("!version", "!version prints tr0l's version number.",
                    sub{
                      my ($chan, $nick, @args) = @_;
                        return "msg $chan $VERSION";
                    });

# load other commands..
my $path = './tr0l/*\.pl';
my @files = < $path >;
foreach my $mod(@files){
  my($filename, $directories, $suffix) = fileparse($mod);
  require "./tr0l/$filename";
}

1;
