use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::NoTabsTests 0.06

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/Dist/Zilla/PluginBundle/RSRCHBOY.pm',
    'lib/Dist/Zilla/PluginBundle/RSRCHBOY/Role/Git.pm',
    'lib/Pod/Weaver/PluginBundle/RSRCHBOY.pm',
    'lib/Pod/Weaver/Section/RSRCHBOY/GeneratedAttributes.pm',
    'lib/Pod/Weaver/Section/RSRCHBOY/LazyAttributes.pm',
    'lib/Pod/Weaver/Section/RSRCHBOY/RequiredAttributes.pm',
    'lib/Pod/Weaver/Section/RSRCHBOY/RoleParameters.pm',
    'lib/Pod/Weaver/SectionBase/CollectWithIntro.pm'
);

notabs_ok($_) foreach @files;
done_testing;
