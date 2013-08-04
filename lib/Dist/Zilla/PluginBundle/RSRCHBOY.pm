package Dist::Zilla::PluginBundle::RSRCHBOY;

# ABSTRACT: Zilla your distributions like RSRCHBOY!

use Moose;
use namespace::autoclean;
use MooseX::AttributeShortcuts;
use Moose::Util::TypeConstraints;

use autodie 0.20;

use Dist::Zilla;
with
    'Dist::Zilla::Role::PluginBundle::Easy',
    'Dist::Zilla::Role::PluginBundle::Config::Slicer',
    ;

use Config::MVP::Slicer 0.302;
use Path::Class;

use Dist::Zilla::PluginBundle::Git 1.121770            ( );
use Dist::Zilla::PluginBundle::Git::CheckFor           ( );
use Dist::Zilla::Plugin::ArchiveRelease                ( );
use Dist::Zilla::Plugin::Authority                     ( );
use Dist::Zilla::Plugin::CheckChangesHasContent        ( );
use Dist::Zilla::Plugin::CheckPrereqsIndexed           ( );
use Dist::Zilla::Plugin::CopyFilesFromBuild            ( );
use Dist::Zilla::Plugin::ConfirmRelease                ( );
use Dist::Zilla::Plugin::ConsistentVersionTest         ( );
use Dist::Zilla::Plugin::ContributorsFromGit           ( );
use Dist::Zilla::Plugin::CPANFile                      ( );
use Dist::Zilla::Plugin::EOLTests                      ( );
use Dist::Zilla::Plugin::ExtraTests                    ( );
use Dist::Zilla::Plugin::Git::CommitBuild 2.009        ( );
use Dist::Zilla::Plugin::Git::Describe                 ( );
use Dist::Zilla::Plugin::Git::NextVersion              ( );
use Dist::Zilla::Plugin::GitHub::Meta                  ( );
use Dist::Zilla::Plugin::GitHub::Update                ( );
use Dist::Zilla::Plugin::HasVersionTests               ( );
use Dist::Zilla::Plugin::InstallGuide                  ( );
use Dist::Zilla::Plugin::InstallRelease                ( );
use Dist::Zilla::Plugin::MetaConfig                    ( );
use Dist::Zilla::Plugin::MetaJSON                      ( );
use Dist::Zilla::Plugin::MetaYAML                      ( );
use Dist::Zilla::Plugin::MetaNoIndex                   ( );
use Dist::Zilla::Plugin::MetaProvides::Package         ( );
use Dist::Zilla::Plugin::MinimumPerl                   ( );
use Dist::Zilla::Plugin::NoSmartCommentsTests          ( );
use Dist::Zilla::Plugin::NoTabsTests                   ( );
use Dist::Zilla::Plugin::PodWeaver                     ( );
use Dist::Zilla::Plugin::PodCoverageTests              ( );
use Dist::Zilla::Plugin::PodSyntaxTests                ( );
use Dist::Zilla::Plugin::Prepender                     ( );
use Dist::Zilla::Plugin::PruneFiles                    ( );
use Dist::Zilla::Plugin::ReadmeFromPod                 ( );
use Dist::Zilla::Plugin::ReadmeAnyFromPod              ( );
use Dist::Zilla::Plugin::ReportVersions::Tiny          ( );
use Dist::Zilla::Plugin::Signature                     ( );
use Dist::Zilla::Plugin::SurgicalPkgVersion            ( );
use Dist::Zilla::Plugin::TaskWeaver                    ( );
use Dist::Zilla::Plugin::Test::Compile                 ( );
use Dist::Zilla::Plugin::Test::MinimumVersion 2.000005 ( );
use Dist::Zilla::Plugin::Test::Pod::LinkCheck          ( );
use Dist::Zilla::Plugin::Test::PodSpelling 2.002001    ( );
use Dist::Zilla::Plugin::TestRelease                   ( );
use Dist::Zilla::Plugin::Twitter                       ( );
use Dist::Zilla::Plugin::UploadToCPAN                  ( );

# non-plugin / dist.ini deps
use Dist::Zilla::Stash::PAUSE::Encrypted 0.003 ( );

# additional deps
use Archive::Tar::Wrapper   ( );
use Test::MinimumVersion    ( );
use Test::NoSmartComments   ( );
use Test::Pod::Coverage     ( );
use Test::Pod               ( );
use Test::Pod::Content      ( );
use Test::Pod::LinkCheck    ( );
use Pod::Coverage::TrustPod ( );

# debugging...
#use Smart::Comments '###';

#has is_task    => (is => 'lazy', isa => 'Bool');
has is_app     => (is => 'lazy', isa => 'Bool');
has is_private => (is => 'lazy', isa => 'Bool');
has rapid_dev  => (is => 'lazy', isa => 'Bool');

#sub _build_is_task    { $_[0]->payload->{task}                             }
sub _build_is_app     { $_[0]->payload->{cat_app} || $_[0]->payload->{app} }
sub _build_is_private { $_[0]->payload->{private}                          }
sub _build_rapid_dev  { $_[0]->payload->{rapid_dev}                        }

my $_d = sub { my $key = shift; sub { shift->payload->{$key} } };

has $_ => (is => 'lazy', isa => 'Bool')
    for qw{ sign tweet github install_on_release };
has "is_$_" => (is => 'lazy', isa => 'Bool', default => $_d->($_))
    for qw{ task };

#sub _build_is_task    { shift->payload->{task}                             }
sub _build_sign               { shift->payload->{sign}               || 1 }
sub _build_tweet              { shift->payload->{tweet}              || 0 }
sub _build_github             { shift->payload->{github}             || 1 }
sub _build_install_on_release { shift->payload->{install_on_release} || 1 }

=method copy_from_build

Returns a list of files that, once built, will be copied back into the root.

=cut

sub copy_from_build {
    my ($self) = @_;

    my @copy = (qw{ LICENSE });
    push @copy, 'Makefile.PL'
        if $self->is_app;

    return @copy;
}

=method release_plugins

Plugin configuration for public release.

=cut

sub release_plugins {
    my $self = shift @_;

    my @allow_dirty = qw{
        .gitignore
        .travis.yml
        Changes
        LICENSE
        README.mkdn
        cpanfile
        dist.ini
        weaver.ini
    };

    my @plugins = (
        qw{
            TestRelease
            CheckChangesHasContent
            CheckPrereqsIndexed
        },
        [ 'Git::Check'  => { allow_dirty => [ @allow_dirty ] } ],
        'ConfirmRelease',
        [ 'Git::Commit' => { allow_dirty => [ @allow_dirty ] } ],
    );
    push @plugins, [ 'Git::Tag' => {
        tag_format  => '%v',
        signed      => $self->sign, # 1,
    }];
    push @plugins, [ 'Git::CommitBuild' => {
        release_branch       => 'release/cpan',
        release_message      => 'Full build of CPAN release %v%t',
        multiple_inheritance => 1,
    }];
    push @plugins, 'UploadToCPAN'
        unless $self->is_private;
    push @plugins, [ 'Git::Push' => {
        push_to => [
            'origin',
            'origin refs/heads/release/cpan:refs/heads/release/cpan',
            #'origin refs/heads/build/*:refs/heads/build/*',
        ],
    }];
    push @plugins, 'Signature', # [ Signature => { sign => 'always' } ]
        if $self->sign;
    push @plugins, [ Twitter => { hash_tags => '#perl #cpan' } ]
        if $self->tweet;
    push @plugins, [ InstallRelease => { install_command => 'cpanm .' } ]
        if $self->install_on_release;
    push @plugins, [ 'GitHub::Update' => { metacpan  => 1 } ]
        if $self->github;

    push @plugins,
        [ ArchiveRelease => { directory => 'releases' } ];

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
            ExtraTests
            NoSmartCommentsTests
            Test::Pod::LinkCheck
        },
        [ 'Test::MinimumVersion' => { max_target_perl => '5.008008' } ],
    );
}

=method meta_provider_plugins

Plugins that mess about with what goes into META.*.

=cut

sub meta_provider_plugins {
    my ($self) = @_;

    my @plugins = (
        [ Authority => { authority => 'cpan:RSRCHBOY' } ],
        qw{ MetaConfig MetaJSON MetaYAML },
        [ MetaNoIndex => { directory => [ qw{ corpus t } ] } ],
        'MetaProvides::Package',
    );

    push @plugins, 'GitHub::Meta'
        if $self->github;

    return @plugins;
}

=method configure

Preps plugin lists / config; see L<Dist::Zilla::Role::PluginBundle::Easy>.

=cut

sub configure {
    my $self = shift @_;

    $self->ensure_current;

    my $autoprereq_opts = $self->config_slice({ autoprereqs_skip => 'skip' });
    my $prepender_opts  = $self->config_slice({ prepender_skip   => 'skip' });

    # if we have a weaver.ini, use that; otherwise use our bundle
    my $podweaver
        = file('weaver.ini')->stat
        ? 'PodWeaver'
        : [ PodWeaver => { config_plugin => '@RSRCHBOY' } ]
        ;

    $self->add_plugins(
        [ NextRelease => { format => '%-8V  %{yyyy-MM-dd HH:mm:ss ZZZZ}d' }],
    );

    $self->add_plugins([ 'Git::NextVersion' =>
        #;first_version = 0.001       ; this is the default
        #;version_regexp  = ^v(.+)$   ; this is the default
        { version_regexp => '^(\d.\d+(_\d\d)?)(-TRIAL|)$' },
    ]);

    $self->add_plugins('ContributorsFromGit');

    $self->add_bundle('Git::CheckFor');

    $self->add_plugins(
        # FIXME
        [ GatherDir => { exclude_filename => [ 'LICENSE', 'cpanfile' ] } ],
        qw{
            Git::Describe
            PruneCruft
            ExecDir
            ShareDir
            MakeMaker
            InstallGuide
            Manifest
            SurgicalPkgVersion
            ReadmeFromPod
            MinimumPerl

            ReportVersions::Tiny
        },
        [ AutoPrereqs => $autoprereq_opts ],
        [ Prepender   => $prepender_opts  ],

        $self->author_tests,
        $self->meta_provider_plugins,
        $self->release_plugins,

        'License',
        [ CopyFilesFromBuild => { copy => [ $self->copy_from_build ] } ],

        [ ReadmeAnyFromPod  => ReadmeMarkdownInRoot => {
            type     => 'markdown',
            filename => 'README.mkdn',
            location => 'root',
        }],

        'CPANFile',

        ($self->is_task ? 'TaskWeaver' : $podweaver),
    );

    return;
}

=method ensure_current

Sometimes things change.  (I know, I know, the horror!)  This seeks to
minimize that pain by automatically making what changes it can.

=cut

sub ensure_current {
    my $self = shift @_;

    # cpanfile was added in 0.42
    system 'touch cpanfile && git add cpanfile && git commit cpanfile'
        unless -f 'cpanfile';

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
        coderef
    };
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=for Pod::Coverage configure

=for :stopwords GitHub Plugins

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

=head2 github (boolean; default: true)

This enables various GitHub related plugins to update dist and GitHub metadata
automatically.

=head2 install_on_release (boolean; default: true)

After a release, install the distribution locally. Our default install command
is (from inside the built release directory):

    cpanm .

You can change this by setting the C<InstallRelease.install_command> option.

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
