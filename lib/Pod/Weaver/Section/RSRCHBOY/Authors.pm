package Pod::Weaver::Section::RSRCHBOY::Authors;

# ABSTRACT: Authors with materialistic pleasures

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

    my $name         = $input->{distmeta}->{name};
    my $flattr_title = uri_escape("RsrchBoy's CPAN $name");
    my $flattr_tag   = uri_escape(qq{"RsrchBoy's $name in the CPAN"});
    my $flattr_url   = uri_escape($input->{distmeta}->{resources}->{homepage});

    my $text = <<"EOT";
Please note B<I do not expect to be gittip'ed or flattr'ed for this work>,
rather B<it is simply a very pleasant surprise>. I largely create and release
works like this because I need them or I find it enjoyable; however, don't let
that stop you giving me money if you feel like it ;)
EOT

    my $links = <<"EOT";
L<flattr this!|https://flattr.com/submit/auto?user_id=RsrchBoy&url=$flattr_url&title=$flattr_title&tags=$flattr_tag>
L<gittip me!|https://www.gittip.com/RsrchBoy/>
L<Amazon Wishlist|http://www.amazon.com/gp/registry/wishlist/3G2DQFPBA57L6>
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
            content => 'SAYING THANKS IN A MATERIALISTIC WAY',
        }),
        Ordinary->new({ content => $text  }),
        Ordinary->new({ content => $links }),
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
