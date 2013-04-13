use strict;
use Irssi;
use vars qw($VERSION %IRSSI);
use tr0l;

$VERSION = $tr0l::VERSION;
%IRSSI = (
    authors => 'Reid McKenzie',
    name => 'tr0l',
    description => 'relatively modular Irssi bot.',
    license => 'EPL',
    url => 'http://github.com/atx2600/tr0l',
);

$tr0l::CHANNELS .= "atx2600";

Irssi::signal_add_last('message public', sub {
    my ($server, $msg, $nick, $mask, $target) = @_;
    Irssi::signal_continue($server, $msg, $nick, $mask, $target);
    tr0l::respond($server, $msg, $target, $nick);
});

Irssi::signal_add_last('message own_public', sub {
    my ($server, $msg, $target) = @_;
    Irssi::signal_continue($server, $msg, $target);
    tr0l::respond($server, $msg, $target);
});
