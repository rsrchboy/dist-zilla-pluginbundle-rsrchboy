package Pod::Weaver::Section::RSRCHBOY::BundleInDescription;

# ABSTRACT: Fill DESCRIPTION with the roughly equivalent dist.ini

use v5.10;
use autobox::Core;

use Moose;
use namespace::autoclean;
use MooseX::AttributeShortcuts;

use aliased 'Dist::Zilla::Util::BundleInfo';

use aliased 'Pod::Elemental::Element::Pod5::Command';
use aliased 'Pod::Elemental::Element::Pod5::Ordinary';
use aliased 'Pod::Elemental::Element::Pod5::Verbatim';
use aliased 'Pod::Elemental::Element::Nested';

with 'Pod::Weaver::Role::Section';

sub weave_section {
    my ($self, $output, $input) = @_;

    my $zilla = $input->{zilla}
        or die 'Please use Dist::Zilla with this module!';
    return if $zilla->main_module->name ne $input->{filename};

    my $pb = BundleInfo->new(bundle_name => '@RSRCHBOY');

    $output->children->push(Nested->new({
        command  => 'head1',
        content  => 'DESCRIPTION',
        children => [
            map { Verbatim->new({ content => $_ }) }
            map { chomp; $_ }
            map { join "\n", $_->to_dist_ini }
            $pb->plugins,
        ],
    }));

    return;
}

__PACKAGE__->meta->make_immutable;
!!42;
__END__

=for :stopwords Wishlist flattr flattr'ed gittip gittip'ed frak

=head1 DESCRIPTION

Use L<Dist::Zilla::Util::BundleInfo> to grok the default state of the bundle (that is, without any
options set) and put it in the DESCRIPTION section.

=cut
