use 5.006;
use ExtUtils::MakeMaker;
WriteMakefile(
    NAME            => 'Labyrinth::Plugin::Links',
    VERSION_FROM    => 'lib/Labyrinth/Plugin/Links.pm',
    PREREQ_PM       => {
        'Labyrinth'         => '5.10'
    },
    NO_META     => 1,
    ABSTRACT    => 'Links plugin for the Labyrinth framework',
    AUTHOR      => 'Barbie <barbie@cpan.org>',
);
