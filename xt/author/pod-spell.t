use strict;
use warnings;
use Test::More;

# generated by Dist::Zilla::Plugin::Test::PodSpelling 2.007005
use Test::Spelling 0.12;
use Pod::Wordlist;


add_stopwords(<DATA>);
all_pod_files_spelling_ok( qw( bin lib ) );
__DATA__
ABEND
AFAICT
Authors
Bowers
Chris
CollectWithIntro
Dist
Formattable
GeneratedAttributes
Gratipay
LazyAttributes
Neil
PayPal
PluginBundle
Pod
RSRCHBOY
RSRCHBOY's
RequiredAttributes
RoleParameters
Romanov
Section
SectionBase
Sergey
Weaver
Weyl
Zilla
codebase
coderef
complefor
cweyl
formattable
gpg
implementers
ini
lib
metaclass
metaclasses
neil
parameterization
parameterized
subclasses
