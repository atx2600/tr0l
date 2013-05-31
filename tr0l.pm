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
     %IS,
     $NICK);
our $DEFAULT = "_DEFAULT_";

sub respond {
    my ($msg, $target, $nick, $server) = @_;
    my (@command, $cmd, $chans, $output);

    @command = split(' ', $msg);
    if ($command[0] =~ m/$NICK *:?/) {
      shift(@command);
    }

    $cmd = shift(@command);
    if (not $cmd =~ m/^!\w+/) {
      return "";
    }

    # invoke handler
    my $responder = $COMMANDS{$cmd} // $COMMANDS{"_DEFAULT_"};

    return $responder->($target, $nick,  $server, @command) // "";
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

# load other commands..
my $path = './tr0l/*\.pl';
my @files = < $path >;
foreach my $mod(@files){
  my($filename, $directories, $suffix) = fileparse($mod);
  require "./tr0l/$filename";
}

1;
