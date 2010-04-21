#!/usr/bin/env perl

use strict;
use warnings;

use Dir::Self qw( __DIR__ );
use File::Spec ();
use Template ();
use YAML ();

my %file_for = (
    data    => 'index.yml',
    input   => 'index.html.tt',
    output  => 'public/index.html',
);

for my $file ( keys %file_for ) {
    $file = File::Spec->catfile( __DIR__, $file );
}

my $link_columns = YAML::LoadFile( $file_for{data} );

my %vars = (
    link_columns => $link_columns,
    column_count => scalar @{$link_columns}
);

my $template = Template->new({
    ABSOLUTE => 1,
    INCLUDE_PATH => __DIR__,
    PRE_CHOMP => 1,
    POST_CHOMP => 1,
});

$template->process( $file_for{input}, \%vars, $file_for{output} )
    or die $template->error();
