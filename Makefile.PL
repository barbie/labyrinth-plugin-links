#!/usr/bin/perl

use strict;
use warnings;
use 5.006;

use ExtUtils::MakeMaker;

WriteMakefile(
    AUTHOR              => 'Barbie <barbie@cpan.org>',
    NAME                => 'Labyrinth::Plugin::Links',
    VERSION_FROM        => 'lib/Labyrinth/Plugin/Links.pm',
    ABSTRACT            => 'Links plugin for the Labyrinth framework',
    NO_META             => 1,
    PREREQ_PM           => {

        # prereqs
        'Labyrinth'             => '5.10',

        # build/test prereqs
        'IO::File'              => '0',
        'Test::More'            => '0.70'

    }
);
