package Pod::Weaver::Section::RSRCHBOY::Authors;

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

=for :stopwords Wishlist flattr flattr'ed gittip gittip'ed frak

=head1 DESCRIPTION

This is an extension to the L<Authors|Pod::Weaver::Section::Authors> section,
appending information as to the means of sating the author's materialistic
desires.

What the frak; let's see what happens.

=cut