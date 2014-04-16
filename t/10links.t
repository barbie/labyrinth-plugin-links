#!/usr/bin/perl -w
use strict;

use lib qw(t/lib);
use Fake::Loader;

use Test::More tests => 19;

my $test_vars = {
          'testing' => '0',
          'copyright' => '2002-2014 Barbie',
          'cgiroot' => 'http:/',
          'lastpagereturn' => '0',
          'autoguest' => '1',
          'administrator' => 'barbie@cpan.org',
          'timeout' => '3600',
          'docroot' => 'http:/',
          'blank' => 'images/blank.png',
          'realm' => 'public',
          'iname' => 'Test Site',
          'mailhost' => '',
          'maxpasslen' => '20',
          'minpasslen' => '6',
          'cookiename' => 'session',
          'webdir' => 't/_DBDIR/html',
          'links' => [
                       {
                         'body' => undef,
                         'href' => 'http://www.example.com',
                         'category' => 'Category 1',
                         'title' => 'Example Link 1',
                         'orderno' => '1',
                         'catid' => '1',
                         'linkid' => '1'
                       },
                       {
                         'body' => undef,
                         'href' => 'http://www.example.com',
                         'category' => 'Category 2',
                         'title' => 'Example Link 2',
                         'orderno' => '2',
                         'catid' => '2',
                         'linkid' => '2'
                       },
                       {
                         'body' => undef,
                         'href' => 'http://www.example.com',
                         'category' => 'Category 3',
                         'title' => 'Example Link 3',
                         'orderno' => '3',
                         'catid' => '3',
                         'linkid' => '3'
                       }
                     ],
          'ipaddr' => '',
          'script' => '',
          'maxpicwidth' => '500',
          'requests' => 't/_DBDIR/cgi-bin/config/requests',
          'cgidir' => 't/_DBDIR/cgi-bin',
          'host' => '',
          'cgipath' => '/cgi-bin',
          'basedir' => 't/_DBDIR',
          'htmltags' => '+img',
          'icode' => 'testsite',
          'evalperl' => '1',
          'webpath' => '',
          'randpicwidth' => '400'
        };

my $test_data = { 
    'links' => [
        {
            'body' => undef,
            'href' => 'http://www.example.com',
            'category' => 'Category 2',
            'title' => 'Example Link 2',
            'orderno' => '2',
            'catid' => '2',
            'linkid' => '2'
        },
        {
            'body' => undef,
            'href' => 'http://www.example.com',
            'category' => 'Category 3',
            'title' => 'Example Link 3',
            'orderno' => '3',
            'catid' => '3',
            'linkid' => '3'
        }
    ],
    'cats' => [
        {
            'category' => 'Category 2',
            'orderno' => '2',
            'catid' => '2'
        },
        {
            'category' => 'Category 3',
            'orderno' => '3',
            'catid' => '3'
        }
    ],
    'newcats' => [
           {
             'category' => 'Category 2',
             'orderno' => '2',
             'catid' => '2'
           },
           {
             'category' => 'Category 3',
             'orderno' => '3',
             'catid' => '3'
           },
           {
             'category' => 'Test',
             'orderno' => '4',
             'catid' => '4'
           }
    ],
    'newlinks' => [
           {
             'body' => undef,
             'href' => 'http://www.example.com',
             'category' => 'Category 2',
             'title' => 'Example Link 2',
             'orderno' => '2',
             'catid' => '2',
             'linkid' => '2'
           },
           {
             'body' => undef,
             'href' => 'http://www.example.com',
             'category' => 'Category 3',
             'title' => 'Example Link 3',
             'orderno' => '3',
             'catid' => '3',
             'linkid' => '3'
           },
           {
             'body' => '<p>Blah Blah Blah</p>',
             'href' => 'http://example.com',
             'category' => 'Test',
             'title' => 'Test Link',
             'orderno' => '4',
             'catid' => '4',
             'linkid' => '4'
           }
    ],
    'newcats2' => [
           {
             'category' => 'Another Test',
             'orderno' => '1',
             'catid' => '5'
           },
           {
             'category' => 'Category 2',
             'orderno' => '2',
             'catid' => '2'
           },
           {
             'category' => 'Category 3',
             'orderno' => '3',
             'catid' => '3'
           },
           {
             'category' => 'Test',
             'orderno' => '4',
             'catid' => '4'
           }
    ]
};

my $test_add = { 
    ddcats => '<select id="catid" name="catid"><option value="1">Category 1</option><option value="2">Category 2</option><option value="3">Category 3</option></select>'
};

my $test_edit = { 
    'body' => undef,
    'ddcats' => '<select id="catid" name="catid"><option value="1" selected="selected">Category 1</option><option value="2">Category 2</option><option value="3">Category 3</option></select>',
    'href' => 'http://www.example.com',
    'title' => 'Example Link 1',
    'ddpublish' => '<select id="publish" name="publish"><option value="0">Select Status</option><option value="1">Draft</option><option value="2">Submitted</option><option value="3">Published</option><option value="4">Archived</option></select>',
    'linkid' => '1',
    'catid' => '1'
 };

my $test_cats = [
    {
      'category' => 'Category 1',
      'orderno' => '1',
      'catid' => '1'
    },
    {
      'category' => 'Category 2',
      'orderno' => '2',
      'catid' => '2'
    },
    {
      'category' => 'Category 3',
      'orderno' => '3',
      'catid' => '3'
    }
  ];

# -----------------------------------------------------------------------------
# Set up

my $loader = Fake::Loader->new;
my $dir = $loader->directory;

$loader->prep("$dir/cgi-bin/db/plugin-base.sql","t/data/test-base.sql");
$loader->labyrinth('Labyrinth::Plugin::Links');

# -----------------------------------------------------------------------------
# Public methods

$loader->action('Links::List');
my $vars = $loader->vars;
is_deeply($vars,$test_vars,'stored variables are the same');

# -----------------------------------------------------------------------------
# Admin Link methods

# TODO - test bad access

# refresh instance
refresh(
    $loader,
    { loggedin => 1, loginid => 1 } );

# test basic admin
$loader->action('Links::Admin');
$vars = $loader->vars;
is_deeply($vars->{data},$test_vars->{links},'stored variables are the same');


# refresh instance
refresh(
    $loader,
    { loggedin => 1, loginid => 1, data => undef } );

# test adding a link
$loader->action('Links::Add');
$vars = $loader->vars;
is_deeply($vars->{data}{ddcats},$test_add->{ddcats},'dropdown variables are the same');


# refresh instance
refresh(
    $loader,
    { loggedin => 1, loginid => 1, data => undef },
    { linkid => 1 } );

# test editing a link
$loader->action('Links::Edit');
$vars = $loader->vars;
is_deeply($vars->{data},$test_edit,'stored variables are the same');


# check link changes
my %hrefs = (
    ''                      => '',
    'www.example.com'       => 'http://www.example.com',
    'http://example.com'    => 'http://example.com',
    'ftp://example.com'     => 'ftp://example.com',
    'https://example.com'   => 'https://example.com',
    'git://www.example.com' => 'git://www.example.com',
    '/examples'             => '/examples',
    'blah://examples'       => 'http://blah://examples',
);

for my $href (keys %hrefs) {
    $loader->set_params( href => $href );
    $loader->action('Links::CheckLink');
    my $params = $loader->params;
    is($params->{href},$hrefs{$href});
}


# -----------------------------------------------------------------------------
# Admin Link Category methods

# refresh instance
$loader->labyrinth('Labyrinth::Plugin::Links');

# test basic admin
$loader->action('Links::CatAdmin');
$vars = $loader->vars;
is_deeply($vars->{data},$test_cats,'stored variables are the same');


# refresh instance
refresh(
    $loader,
    { loggedin => 1, loginid => 1, data => undef },
    { catid => 1 } );


# test editing a link
$loader->action('Links::CatEdit');
$vars = $loader->vars;
is_deeply($vars->{data},$test_cats->[0],'stored variables are the same');


# test select box list
#$loader->action('Links::CatSelect');
#$vars = $loader->vars;
#use Data::Dumper;
#diag(Dumper($vars));
#is_deeply($vars,$test_vars,'stored variables are the same');


# -----------------------------------------------------------------------------
# Admin Link Delete/Save methods - as we change the db

# refresh instance
refresh(
    $loader,
    { loggedin => 1, loginid => 1, data => undef },
    { LISTED => [ 1 ], doaction => 'Delete' } );

# test delete via admin
$loader->action('Links::Admin');
$vars = $loader->vars;
is_deeply($vars->{data},$test_data->{links},'stored variables are the same');


# refresh instance
refresh(
    $loader,
    { loggedin => 1, loginid => 1, data => undef },
    { LISTED => [ 1 ], doaction => 'Delete' } );

# test delete via admin
$loader->action('Links::CatAdmin');
$vars = $loader->vars;
is_deeply($vars->{data},$test_data->{cats},'stored variables are the same');


# refresh instance
refresh(
    $loader,
    { loggedin => 1, loginid => 1, data => undef },
    { 'category' => 'Test', 'orderno' => '4', 'catid' => '' } );

# test saving a (new and existing) category
$loader->action('Links::CatSave');
$loader->action('Links::CatAdmin');
$vars = $loader->vars;
is_deeply($vars->{data},$test_data->{newcats},'stored variables are the same');


# refresh instance
refresh(
    $loader,
    { loggedin => 1, loginid => 1, data => undef },
    { 'body' => '<p>Blah Blah Blah</p>', 'href' => 'http://example.com', 'title' => 'Test Link', 'catid' => '4', 'linkid' => '' } );

# test saving a (new and existing) link
$loader->action('Links::Save');
$loader->action('Links::Admin');
$vars = $loader->vars;
#use Data::Dumper;
#diag(Dumper($vars->{data}));
is_deeply($vars->{data},$test_data->{newlinks},'stored variables are the same');


# refresh instance
refresh(
    $loader,
    { loggedin => 1, loginid => 1, data => undef },
    { 'category' => 'Another Test', 'orderno' => '', 'catid' => '' } );

# test saving a (new and existing) category without order
$loader->action('Links::CatSave');
$loader->action('Links::CatAdmin');
$vars = $loader->vars;
is_deeply($vars->{data},$test_data->{newcats2},'stored variables are the same');




# -----------------------------------------------------------------------------
# Private Functions

sub refresh {
    my ($lab,$vars,$params) = @_;

    $lab->labyrinth('Labyrinth::Plugin::Links');
    $lab->set_vars( %$vars )        if($vars);
    $lab->set_params( %$params )    if($params);
}
