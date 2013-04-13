use strict;
use warnings;
use vars qw($VERSION %IRSSI);

use Irssi;
use tr0l;
use tr0l::core;
use tr0l::karma;
use tr0l::alias;

$VERSION = $tr0l::VERSION;
%IRSSI = (
    authors => 'Reid McKenzie',
    name => 'tr0l',
    description => 'relatively modular Irssi bot.',
    license => 'EPL',
    url => 'http://github.com/atx2600/tr0l',
);

my ($troll) = tr0l->new();
my ($t) = tr0l::core->new();
$troll->install_module($t);
$t = tr0l::karma->new();
$troll->install_module($t);
$t = tr0l::alias->new();
$troll->install_module($t);

$troll->{CHANNELS} .= "atx2600";
Irssi::print("\$chans : " . join(" ,", $troll->{CHANNELS}));

Irssi::print("\$commands:");
while( my ($k, $v) = each $troll->{HELP} ) {
    Irssi::print("  $k : $v");
}

Irssi::signal_add_last('message public', sub {
    my ($server, $msg, $nick, $mask, $target) = @_;
    troll->respond($server, $msg, $target, $nick);
    Irssi::signal_continue($server, $msg, $nick, $mask, $target);
});

Irssi::signal_add_last('message own_public', sub {
    my ($server, $msg, $target) = @_;
    troll->respond($server, $msg, $target);
    Irssi::signal_continue($server, $msg, $target);
});

1;
