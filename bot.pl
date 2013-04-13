use strict;
use Irssi;
use vars qw($VERSION %IRSSI);
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

BEGIN {
    tr0l::install_module(\&tr0l::core);
    tr0l::install_module(\&tr0l::karma);
    tr0l::install_module(\&tr0l::alias);

    $tr0l::CHANNELS .= "atx2600";
    Irssi::print("\$chans : " . join(" ," @r0l::CHANNELS));

    Irssi::print("\$commands:");
    while( my ($k, $v) = each %$tr0l::COMMANDS ) {
        Irssi::print("  \$$k : $v");
    }
}

Irssi::signal_add_last('message public', sub {
    my ($server, $msg, $nick, $mask, $target) = @_;
    tr0l::respond($server, $msg, $target, $nick);
    Irssi::signal_continue($server, $msg, $nick, $mask, $target);
});

Irssi::signal_add_last('message own_public', sub {
    my ($server, $msg, $target) = @_;
    tr0l::respond($server, $msg, $target);
    Irssi::signal_continue($server, $msg, $target);
});
