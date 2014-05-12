#
# This file is part of Dist-Zilla-PluginBundle-RSRCHBOY
#
# This software is Copyright (c) 2013 by Chris Weyl.
#
# This is free software, licensed under:
#
#   The GNU Lesser General Public License, Version 2.1, February 1999
#
package Pod::Weaver::Section::RSRCHBOY::Authors;
BEGIN {
  $Pod::Weaver::Section::RSRCHBOY::Authors::AUTHORITY = 'cpan:RSRCHBOY';
}
$Pod::Weaver::Section::RSRCHBOY::Authors::VERSION = '0.049';
# ABSTRACT: An AUTHORS section with materialistic pleasures

use v5.10;
use autobox::Core;

use Moose;
use namespace::autoclean;
use MooseX::AttributeShortcuts;

use aliased 'Pod::Elemental::Element::Pod5::Command';
use aliased 'Pod::Elemental::Element::Pod5::Ordinary';

use URI::Escape::XS 'uri_escape';

extends 'Pod::Weaver::Section::Authors';

after weave_section => sub {
    my ($self, $output, $input) = @_;

    my $name = $input->{distmeta}->{name};

    my $flattr_img   = 'http://api.flattr.com/button/flattr-badge-large.png';
    my $flattr_title = uri_escape("RsrchBoy's CPAN $name");
    my $flattr_tag   = uri_escape(qq{"RsrchBoy's $name in the CPAN"});
    my $flattr_url   = uri_escape($input->{distmeta}->{resources}->{homepage});
    my $flattr_link  = "https://flattr.com/submit/auto?user_id=RsrchBoy&url=$flattr_url&title=$flattr_title&tags=$flattr_tag";

    my $gittip_link = 'https://www.gittip.com/RsrchBoy/';
    my $gittip_img  = 'https://raw.githubusercontent.com/gittip/www.gittip.com/master/www/assets/%25version/logo.png';

    # L<Amazon Wishlist|http://www.amazon.com/gp/registry/wishlist/3G2DQFPBA57L6>.
    my $amzn_img  = 'http://wps.io/wp-content/uploads/2014/05/amazon_wishlist.resized.png';
    my $amzn_link = 'http://bit.ly/rsrchboys-wishlist';

    my $html = <<"EOT";
<a href="$gittip_link"><img src="$gittip_img" /></a>
<a href="$amzn_link"><img src="$amzn_img" /></a>
<a href="$flattr_link"><img src="$flattr_img" /></a>
EOT

    my $links = <<"EOT";
L<Flattr this|$flattr_link>,
L<gittip me|$gittip_link>, or indulge my
L<Amazon Wishlist|$amzn_link>...  If you so desire.
EOT

    my $text = <<"EOT";
Please note B<I do not expect to be gittip'ed or flattr'ed for this work>,
rather B<it is simply a very pleasant surprise>. I largely create and release
works like this because I need them or I find it enjoyable; however, don't let
that stop you if you feel like it ;)
EOT

    $output->children->unshift(
        Command->new({
            command => 'for',
            content => q{:stopwords Wishlist flattr flattr'ed gittip gittip'ed},
        }),
    );
    $output->children->[-1]->children->push(
        Command->new({
            command => 'head2',
            content => q{I'm a material boy in a material world},
        }),
        Command ->new({ command => 'begin', content => 'html' }),
        Ordinary->new({ content => $html                      }),
        Command ->new({ command => 'end',   content => 'html' }),
        Ordinary->new({ content => $text                      }),
        Ordinary->new({ content => $links                     }),
    );

    return;
};

__PACKAGE__->meta->make_immutable;
!!42;

__END__

=pod

=encoding UTF-8

=for :stopwords Chris Weyl Neil Bowers Sergey Romanov Wishlist flattr flattr'ed gittip
gittip'ed frak

=for :stopwords Wishlist flattr flattr'ed gittip gittip'ed

=head1 NAME

Pod::Weaver::Section::RSRCHBOY::Authors - An AUTHORS section with materialistic pleasures

=head1 VERSION

This document describes version 0.049 of Pod::Weaver::Section::RSRCHBOY::Authors - released May 12, 2014 as part of Dist-Zilla-PluginBundle-RSRCHBOY.

=head1 DESCRIPTION

This is an extension to the L<Authors|Pod::Weaver::Section::Authors> section,
appending information as to the means of sating the author's materialistic
desires.

What the frak; let's see what happens.

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
