package Pod::Weaver::SectionBase::CollectWithIntro;

# ABSTRACT: Extends CollectWithIntro to provide a better default plugin name

use Moose;
use namespace::autoclean;
use autobox::Core;
use MooseX::AttributeShortcuts;
use MooseX::NewDefaults;

extends 'Pod::Weaver::Section::CollectWithIntro';

default_for plugin_name => sub { shift->ref->split(qr/::/)->pop };

__PACKAGE__->meta->make_immutable;
!!42;
__END__
