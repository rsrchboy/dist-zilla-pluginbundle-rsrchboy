package Pod::Weaver::Section::RSRCHBOY::LazyAttributes;

# ABSTRACT: Prefaced lazy attributes section

use Moose;
use namespace::autoclean;
use autobox::Core;
use MooseX::NewDefaults;

extends 'Pod::Weaver::SectionBase::CollectWithIntro';

default_for command => 'lazyatt';

default_for content => [
    'These attributes are lazily constructed from another source (e.g.',
    'required attributes, external source, some combo of the two).',
    'You can, but are generally recommended to not, set these values at',
    'construction time.',
]->join(q{ });

__PACKAGE__->meta->make_immutable;
!!42;
__END__
