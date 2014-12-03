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
our $AUTHORITY = 'cpan:RSRCHBOY';
$Dist::Zilla::PluginBundle::RSRCHBOY::Role::Git::VERSION = '0.054';
# ABSTRACT: A helper role for Git::Raw operations

use Moose::Role;
use namespace::autoclean;
use MooseX::AttributeShortcuts 0.023;

use autobox::Core;
use Git::Raw 0.32;

with 'MooseX::RelatedClasses' => {
    namespace        => 'Git::Raw',
    all_in_namespace => 1,
    private          => 1,
};


has repo => (
    is              => 'lazy',
    isa_instance_of => 'Git::Raw::Repository',
    builder         => sub { Git::Raw::Repository->open('.') },
    handles         => [ qw{ head index } ],
);


sub has_file_in_head { shift->repo->head->target->tree->entry_bypath(q{} . shift) ? 1 : 0 }

!!42;

__END__

=pod

=encoding UTF-8

=for :stopwords Chris Weyl Bowers Neil Romanov Sergey

=for :stopwords Wishlist flattr flattr'ed gittip gittip'ed

=head1 NAME

Dist::Zilla::PluginBundle::RSRCHBOY::Role::Git - A helper role for Git::Raw operations

=head1 VERSION

This document describes version 0.054 of Dist::Zilla::PluginBundle::RSRCHBOY::Role::Git - released December 02, 2014 as part of Dist-Zilla-PluginBundle-RSRCHBOY.

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

=head2 I'm a material boy in a material world

=begin html

<a href="https://www.gittip.com/RsrchBoy/"><img src="https://raw.githubusercontent.com/gittip/www.gittip.com/master/www/assets/%25version/logo.png" /></a>
<a href="http://bit.ly/rsrchboys-wishlist"><img src="http://wps.io/wp-content/uploads/2014/05/amazon_wishlist.resized.png" /></a>
<a href="https://flattr.com/submit/auto?user_id=RsrchBoy&url=https%3A%2F%2Fgithub.com%2FRsrchBoy%2Fdist-zilla-pluginbundle-rsrchboy&title=RsrchBoy's%20CPAN%20Dist-Zilla-PluginBundle-RSRCHBOY&tags=%22RsrchBoy's%20Dist-Zilla-PluginBundle-RSRCHBOY%20in%20the%20CPAN%22"><img src="http://api.flattr.com/button/flattr-badge-large.png" /></a>

=end html

Please note B<I do not expect to be gittip'ed or flattr'ed for this work>,
rather B<it is simply a very pleasant surprise>. I largely create and release
works like this because I need them or I find it enjoyable; however, don't let
that stop you if you feel like it ;)

L<Flattr this|https://flattr.com/submit/auto?user_id=RsrchBoy&url=https%3A%2F%2Fgithub.com%2FRsrchBoy%2Fdist-zilla-pluginbundle-rsrchboy&title=RsrchBoy's%20CPAN%20Dist-Zilla-PluginBundle-RSRCHBOY&tags=%22RsrchBoy's%20Dist-Zilla-PluginBundle-RSRCHBOY%20in%20the%20CPAN%22>,
L<gittip me|https://www.gittip.com/RsrchBoy/>, or indulge my
L<Amazon Wishlist|http://bit.ly/rsrchboys-wishlist>...  If you so desire.

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Chris Weyl.

This is free software, licensed under:

  The GNU Lesser General Public License, Version 2.1, February 1999

=cut
