#!/usr/bin/perl -w

use strict;

BEGIN {
	chdir 't' if -d 't';
	unshift @INC, '../lib';
}

use Test::More tests => 2;
use Text::WikiFormat;

my $wikitext =<<WIKI;
StudlyCaps

WIKI

my %opts = ( 
	prefix => 'rootdir/wiki.pl?page=',
);

my $htmltext = Text::WikiFormat::format($wikitext, {}, \%opts );
like( $htmltext, qr!<a href="rootdir/wiki\.pl\?page=StudlyCaps">!m,
	'should create links from StudlyCaps if implicit_links is left alone' );

$opts{implicit_links} = 0;
$htmltext = Text::WikiFormat::format($wikitext, {}, \%opts );
unlike( $htmltext, qr!<a href="rootdir/wiki\.pl\?page=StudlyCaps">!m,
	'... but not if implicit_links set to 0' );
