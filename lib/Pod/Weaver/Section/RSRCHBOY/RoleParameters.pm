package Pod::Weaver::Section::RSRCHBOY::RoleParameters;

# ABSTRACT: Prefaced role parameters section

use Moose;
use namespace::autoclean;
use autobox::Core;
use MooseX::NewDefaults;

extends 'Pod::Weaver::SectionBase::CollectWithIntro';

default_for command => 'roleparam';

default_for content => [
    'Parameterized roles accept parameters that influence their',
    'construction.  This role accepts the following parameters.',
]->join(q{ });

__PACKAGE__->meta->make_immutable;
!!42;
__END__
