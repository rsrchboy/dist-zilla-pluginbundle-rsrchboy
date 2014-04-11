#
# This file is part of Dist-Zilla-PluginBundle-RSRCHBOY
#
# This software is Copyright (c) 2013 by Chris Weyl.
#
# This is free software, licensed under:
#
#   The GNU Lesser General Public License, Version 2.1, February 1999
#
package Pod::Weaver::SectionBase::CollectWithIntro;
BEGIN {
  $Pod::Weaver::SectionBase::CollectWithIntro::AUTHORITY = 'cpan:RSRCHBOY';
}
$Pod::Weaver::SectionBase::CollectWithIntro::VERSION = '0.046';
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

=pod

=encoding UTF-8

=for :stopwords Chris Weyl Neil Bowers <neil@bowers.com>

=head1 NAME

Pod::Weaver::SectionBase::CollectWithIntro - Extends CollectWithIntro to provide a better default plugin name

=head1 VERSION

This document describes version 0.046 of Pod::Weaver::SectionBase::CollectWithIntro - released April 11, 2014 as part of Dist-Zilla-PluginBundle-RSRCHBOY.

=head1 SEE ALSO

Please see those modules/websites for more information related to this module.

=over 4

=item *

L<Dist::Zilla::PluginBundle::RSRCHBOY|Dist::Zilla::PluginBundle::RSRCHBOY>

=back

=head1 SOURCE

The development version is on github at L<http://https://github.com/RsrchBoy/dist-zilla-pluginbundle-rsrchboy>
and may be cloned from L<git://https://github.com/RsrchBoy/dist-zilla-pluginbundle-rsrchboy.git>

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
https://github.com/RsrchBoy/dist-zilla-pluginbundle-rsrchboy/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Chris Weyl <cweyl@alumni.drew.edu>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Chris Weyl.

This is free software, licensed under:

  The GNU Lesser General Public License, Version 2.1, February 1999

=cut
