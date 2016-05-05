use strict;
use warnings;
use Test::More;

# generated by Dist::Zilla::Plugin::Test::PodSpelling 2.007000
use Test::Spelling 0.12;
use Pod::Wordlist;


add_stopwords(<DATA>);
all_pod_files_spelling_ok( qw( bin lib  ) );
__DATA__
ABEND
AFAICT
Gratipay
RSRCHBOY
RSRCHBOY's
codebase
coderef
gpg
implementers
ini
metaclass
metaclasses
parameterization
parameterized
subclasses
Formattable
formattable
Chris
Weyl
cweyl
Neil
Bowers
neil
Sergey
Romanov
complefor
lib
Dist
Zilla
PluginBundle
Role
Git
Pod
Weaver
Section
Authors
GeneratedAttributes
LazyAttributes
RequiredAttributes
RoleParameters
SectionBase
CollectWithIntro
