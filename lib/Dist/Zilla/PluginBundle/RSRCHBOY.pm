package Dist::Zilla::PluginBundle::RSRCHBOY;

# ABSTRACT: Zilla your distributions like RSRCHBOY!

use v5.10;

use Moose;
use namespace::autoclean;
use MooseX::AttributeShortcuts;
use Moose::Util::TypeConstraints;

use Dist::Zilla;
with 'Dist::Zilla::Role::PluginBundle::Easy';

use Config::MVP::Slicer 0.302;
use Path::Class;

use Dist::Zilla::PluginBundle::Git 1.121770         ( );
use Dist::Zilla::PluginBundle::Git::CheckFor        ( );
use Dist::Zilla::Plugin::ArchiveRelease             ( );
use Dist::Zilla::Plugin::CheckChangesHasContent     ( );
use Dist::Zilla::Plugin::CheckPrereqsIndexed        ( );
use Dist::Zilla::Plugin::CopyFilesFromBuild         ( );
use Dist::Zilla::Plugin::ConfirmRelease             ( );
use Dist::Zilla::Plugin::ConsistentVersionTest      ( );
use Dist::Zilla::Plugin::EOLTests                   ( );
use Dist::Zilla::Plugin::ExtraTests                 ( );
use Dist::Zilla::Plugin::Git::NextVersion           ( );
use Dist::Zilla::Plugin::GitHub::Meta               ( );
use Dist::Zilla::Plugin::GitHub::Update             ( );
use Dist::Zilla::Plugin::HasVersionTests            ( );
use Dist::Zilla::Plugin::InstallGuide               ( );
use Dist::Zilla::Plugin::InstallRelease             ( );
use Dist::Zilla::Plugin::MetaConfig                 ( );
use Dist::Zilla::Plugin::MetaJSON                   ( );
use Dist::Zilla::Plugin::MetaYAML                   ( );
use Dist::Zilla::Plugin::MetaNoIndex                ( );
use Dist::Zilla::Plugin::MetaProvides::Package      ( );
use Dist::Zilla::Plugin::MinimumPerl                ( );
use Dist::Zilla::Plugin::NoSmartCommentsTests       ( );
use Dist::Zilla::Plugin::NoTabsTests                ( );
use Dist::Zilla::Plugin::PodWeaver                  ( );
use Dist::Zilla::Plugin::PodCoverageTests           ( );
use Dist::Zilla::Plugin::PodSyntaxTests             ( );
use Dist::Zilla::Plugin::Prepender                  ( );
use Dist::Zilla::Plugin::PruneFiles                 ( );
use Dist::Zilla::Plugin::ReadmeFromPod              ( );
use Dist::Zilla::Plugin::ReadmeAnyFromPod           ( );
use Dist::Zilla::Plugin::ReportVersions::Tiny       ( );
use Dist::Zilla::Plugin::Signature                  ( );
use Dist::Zilla::Plugin::SurgicalPkgVersion         ( );
use Dist::Zilla::Plugin::TaskWeaver                 ( );
use Dist::Zilla::Plugin::Test::Compile              ( );
use Dist::Zilla::Plugin::Test::PodSpelling 2.002001 ( );
use Dist::Zilla::Plugin::Test::Portability          ( );
use Dist::Zilla::Plugin::TestRelease                ( );
use Dist::Zilla::Plugin::Twitter                    ( );
use Dist::Zilla::Plugin::UploadToCPAN               ( );

# non-plugin / dist.ini deps
use Dist::Zilla::Stash::PAUSE::Encrypted 0.003 ( );

# additional deps
use Archive::Tar::Wrapper   ( );
use Test::NoSmartComments   ( );
use Test::Pod::Coverage     ( );
use Test::Pod               ( );
use Test::Pod::Content      ( );
use Pod::Coverage::TrustPod ( );

# debugging...
#use Smart::Comments '###';

has is_task    => (is => 'lazy', isa => 'Bool');
has is_app     => (is => 'lazy', isa => 'Bool');
has is_private => (is => 'lazy', isa => 'Bool');
has rapid_dev  => (is => 'lazy', isa => 'Bool');

sub _build_is_task    { $_[0]->payload->{task}                             }
sub _build_is_app     { $_[0]->payload->{cat_app} || $_[0]->payload->{app} }
sub _build_is_private { $_[0]->payload->{private}                          }
sub _build_rapid_dev  { $_[0]->payload->{rapid_dev}                        }

has $_ => (is => 'lazy', isa => 'Bool')
    for qw{ sign tweet };

sub _build_sign  { shift->payload->{sign}  // 1 }
sub _build_tweet { shift->payload->{tweet} // 0 }

has _slicer => (
    is      => 'lazy',
    isa     => class_type('Config::MVP::Slicer'),
    handles => {
        _merge_cfg => 'merge',
    },
);

sub _build__slicer { Config::MVP::Slicer->new({ config => shift->payload }) }

#around add_plugins => sub {
my $_merger = sub {
    my ($orig, $self) = (shift, shift);

    my $_n = sub { 'Dist::Zilla::Plugin::' . shift };

    ### @_
    my @plugins =
        map { $self->_merge_cfg($_) }
        map { @$_ == 2 ? [ $_->[0], $_n->($_->[0]), $_->[1] ] : $_ }
        map { (!ref $_ && !blessed $_) ? [ $_, $_n->($_), {} ] : $_ }
        @_;

    ### @plugins
    return $self->$orig(@plugins);
};

around add_plugins => $_merger;
#around add_bundle  => $_merger;

=method copy_from_build

Returns a list of files that, once built, will be copied back into the root.

=cut

sub copy_from_build {
    my ($self) = @_;

    my @copy= qw{ LICENSE };
    push @copy, 'Makefile.PL'
        if $self->is_app;

    return @copy;
}

=method release_plugins

Plugin configuration for public release.

=cut

sub release_plugins {
    my $self = shift @_;

    my @plugins = (
        qw{
            TestRelease
            ConfirmRelease
            CheckChangesHasContent
            UploadToCPAN
            CheckPrereqsIndexed
        },
        [ 'GitHub::Update' => { metacpan  => 1          } ],
        ( $self->sign
            ? ([ Signature => { sign => 'always' } ])
            : (                                     )
        ),
        [ ArchiveRelease   => { directory => 'releases' } ],
    );

    push @plugins, [ Twitter => { hash_tags => '#perl #cpan' } ]
        if $self->tweet;

    return @plugins;
}

=method author_tests

=cut

sub author_tests {
    my ($self) = @_;

    return () if $self->rapid_dev;

    return (
        [ 'Test::PodSpelling' => { stopwords => [ $self->stopwords ] } ],
        qw{
            ConsistentVersionTest
            PodCoverageTests
            PodSyntaxTests
            NoTabsTests
            EOLTests
            HasVersionTests
            Test::Compile
            Test::Portability
            ExtraTests
            NoSmartCommentsTests
        },
    );
}

=method meta_provider_plugins

Plugins that mess about with what goes into META.*.

=cut

sub meta_provider_plugins {
    my ($self) = @_;

    return (
        qw{ GitHub::Meta MetaConfig MetaJSON MetaYAML },
        [ MetaNoIndex => { directory => [ qw{ corpus t } ] } ],
        'MetaProvides::Package',
    );
}

=method configure

Preps plugin lists / config; see L<Dist::Zilla::Role::PluginBundle::Easy>.

=cut

sub configure {
    my $self = shift @_;

    my $autoprereq_opts = $self->config_slice({ autoprereqs_skip => 'skip' });
    my $prepender_opts  = $self->config_slice({ prepender_skip   => 'skip' });

    # if we have a weaver.ini, use that; otherwise use our bundle
    my $podweaver
        = file('weaver.ini')->stat
        ? 'PodWeaver'
        : [ PodWeaver => { config_plugin => '@RSRCHBOY' } ]
        ;

    $self->add_plugins(qw{ NextRelease });

    $self->add_bundle(Git => {
        allow_dirty => [ qw{ .gitignore LICENSE dist.ini weaver.ini README.pod Changes } ],
        tag_format  => '%v',
        signed      => $self->sign, # 1,
    });

    $self->add_plugins([ 'Git::NextVersion' =>
        #;first_version = 0.001       ; this is the default
        #;version_regexp  = ^v(.+)$   ; this is the default
        { version_regexp => '^(\d.\d+)(-TRIAL|)$' },
    ]);

    $self->add_bundle('Git::CheckFor');

    $self->add_plugins(
        qw{
            GatherDir
            PruneCruft
            License
            ExecDir
            ShareDir
            MakeMaker
            InstallGuide
            Manifest
            SurgicalPkgVersion
            ReadmeFromPod
        },
        [ AutoPrereqs => $autoprereq_opts ],
        [ Prepender   => $prepender_opts  ],

        $self->author_tests,

        qw{
            MinimumPerl
            ReportVersions::Tiny
        },

        $self->meta_provider_plugins,
        $self->release_plugins,

        ($self->is_task ? 'TaskWeaver' : $podweaver),

        [ PruneFiles => { filenames => [ $self->copy_from_build ] } ],
        [ CopyFilesFromBuild => { copy => [ $self->copy_from_build ] } ],

        [ ReadmeAnyFromPod  => ReadmePodInRoot => {
            type     => 'pod',
            filename => 'README.pod',
            location => 'root',
        }],

        [ InstallRelease => {
            install_command => 'cpanm .',
        }],
    );

    return;
}

=method stopwords

A list of words our POD spell checker should ignore.

=cut

sub stopwords {

    return qw{
        AFAICT
        ABEND
        RSRCHBOY
        RSRCHBOY's
        gpg
        ini
        metaclass
        metaclasses
        parameterized
        parameterization
        subclasses
    };
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=for Pod::Coverage configure

=head1 SYNOPSIS

    # in your dist.ini...
    [@RSRCHBOY]

=head1 DESCRIPTION

This is RSRCHBOY's current L<Dist::Zilla> dist.ini config for his packages.
He's still figuring this all out, so it's probably wise to not depend on
this being too terribly consistent/sane until the version gets to 1.

=head1 OPTIONS

=head2 sign (boolean; default: true)

On release, use your gpg key to sign the version tag created (if you're using
git) and also generate a SIGNATURE file.

See also L<Dist::Zilla::Plugin::Signature>.

=head2 tweet (boolean; default: false)

If set to a true value, we'll use L<Dist::Zilla::Plugin::Twitter> to tweet
when a release occurs.

=head1 BUNDLED PLUGIN OPTIONS

It's possible to pass options to our bundled plugins directly:

    ; format is Plugin::Name.option
    [@RSRCHBOY]
    GatherDir.exclude_filename = cpanfile

For information on specific plugins and their options, you should refer to the
plugin's documentation.

=head1 SEE ALSO

L<Dist::Zilla::Role::PluginBundle::Easy>

L<Config::MVP::Slicer>

=cut
