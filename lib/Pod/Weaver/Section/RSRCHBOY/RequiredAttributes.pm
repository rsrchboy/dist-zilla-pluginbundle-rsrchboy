package Pod::Weaver::Section::RSRCHBOY::RequiredAttributes;

# ABSTRACT: Prefaced required attributes section

use Moose;
use namespace::autoclean;
use autobox::Core;
use MooseX::NewDefaults;

extends 'Pod::Weaver::SectionBase::CollectWithIntro';

default_for command => 'reqatt';

default_for content => [
    'These attributes are required, and must have their values supplied',
    'during object construction.',
]->join(q{ });

__PACKAGE__->meta->make_immutable;
!!42;
__END__
