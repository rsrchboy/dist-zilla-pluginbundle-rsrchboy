package Pod::Weaver::Section::RSRCHBOY::GeneratedAttributes;

# ABSTRACT: Prefaced generated-only attributes

use Moose;
use namespace::autoclean;
use MooseX::NewDefaults;

extends 'Pod::Weaver::SectionBase::CollectWithIntro';

default_for command => 'genatt';

default_for content => join(q{ },
    'These attributes have their values built or supplied internally by the',
    'class; generally through a default, a builder, a BUILD method, a',
    "private writer, or some other mechanisim that you shouldn't be",
    'touching, anyways.',
);

__PACKAGE__->meta->make_immutable;
!!42;
__END__
