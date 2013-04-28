use strict;
use Irssi;
use vars qw($VERSION %IRSSI);
use tr0l;

push(@tr0l::CHANNELS, "atx2600");

while(my $line = <STDIN>) {
  chomp($line);
  my $r = tr0l::respond($line, "atx2600", "");
  print("[resp] '$r'\n");
}
