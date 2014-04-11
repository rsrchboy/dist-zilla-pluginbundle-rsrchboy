#
# This file is part of Dist-Zilla-PluginBundle-RSRCHBOY
#
# This software is Copyright (c) 2013 by Chris Weyl.
#
# This is free software, licensed under:
#
#   The GNU Lesser General Public License, Version 2.1, February 1999
#
package Dist::Zilla::PluginBundle::RSRCHBOY::Role::Git;
BEGIN {
  $Dist::Zilla::PluginBundle::RSRCHBOY::Role::Git::AUTHORITY = 'cpan:RSRCHBOY';
}
$Dist::Zilla::PluginBundle::RSRCHBOY::Role::Git::VERSION = '0.046';
# ABSTRACT: A helper role for Git::Raw operations

use Moose::Role;
use namespace::autoclean;
use MooseX::AttributeShortcuts 0.023;

use Git::Raw 0.32;


has repo => (
    is              => 'lazy',
    isa_instance_of => 'Git::Raw::Repository',
    builder         => sub { Git::Raw::Repository->open('.') },
);


sub has_file_in_head { shift->repo->head->target->tree->entry_bypath(q{} . shift) ? 1 : 0 }

!!42;

__END__

=pod

=encoding UTF-8

=for :stopwords Chris Weyl Neil Bowers <neil@bowers.com>

=head1 NAME

Dist::Zilla::PluginBundle::RSRCHBOY::Role::Git - A helper role for Git::Raw operations

=head1 VERSION

This document describes version 0.046 of Dist::Zilla::PluginBundle::RSRCHBOY::Role::Git - released April 11, 2014 as part of Dist-Zilla-PluginBundle-RSRCHBOY.

=head1 ATTRIBUTES

=head2 repo

A L<Git::Raw::Repository> object referring to the current, working repository.

=head1 METHODS

=head2 has_file_in_head($filename)

Given a file / path name, check to see if it exists in the current HEAD. Note
that we only test existence, not if the file is dirty, or differs in the
index, etc.

C<$filename> may be a string or anything capable of being stringified (e.g. a
L<Path::Class> or L<Path::Tiny> object).

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
