package Dist::Zilla::PluginBundle::RSRCHBOY;

# ABSTRACT: Zilla your Dists like RSRCHBOY!

use Moose;
use namespace::autoclean;

use Dist::Zilla;
with 'Dist::Zilla::Role::PluginBundle::Easy';

use Dist::Zilla::PluginBundle::Git;

use Dist::Zilla::Plugin::Authority;
use Dist::Zilla::Plugin::ArchiveRelease;
use Dist::Zilla::Plugin::CheckPrereqsIndexed;
use Dist::Zilla::Plugin::CompileTests;
use Dist::Zilla::Plugin::ConfirmRelease;
use Dist::Zilla::Plugin::ConsistentVersionTest;
use Dist::Zilla::Plugin::EOLTests;
use Dist::Zilla::Plugin::ExtraTests;
use Dist::Zilla::Plugin::Git::NextVersion;
use Dist::Zilla::Plugin::GitHub::Meta;
use Dist::Zilla::Plugin::GitHub::Update;
use Dist::Zilla::Plugin::HasVersionTests;
use Dist::Zilla::Plugin::InstallGuide;
use Dist::Zilla::Plugin::InstallRelease;
use Dist::Zilla::Plugin::MetaConfig;
use Dist::Zilla::Plugin::MetaJSON;
use Dist::Zilla::Plugin::MetaYAML;
use Dist::Zilla::Plugin::MinimumPerl;
use Dist::Zilla::Plugin::NoSmartCommentsTests;
use Dist::Zilla::Plugin::NoTabsTests;
use Dist::Zilla::Plugin::PodWeaver;
use Dist::Zilla::Plugin::PodCoverageTests;
use Dist::Zilla::Plugin::PodSyntaxTests;
use Dist::Zilla::Plugin::PortabilityTests;
use Dist::Zilla::Plugin::Prepender;
use Dist::Zilla::Plugin::ReadmeFromPod;
use Dist::Zilla::Plugin::ReadmeAnyFromPod;
use Dist::Zilla::Plugin::ReportVersions;
use Dist::Zilla::Plugin::TaskWeaver;
use Dist::Zilla::Plugin::TestRelease;
use Dist::Zilla::Plugin::UploadToCPAN;

has is_task => (
    is      => 'ro',
    isa     => 'Bool',
    lazy    => 1,
    default => sub { shift->payload->{task} },
);

sub configure {
    my $self = shift @_;

    my $autoprereq_opts = $self->config_slice({ autoprereqs_skip => 'skip' });

    $self->add_plugins(qw{ NextRelease });

    $self->add_bundle(Git => {
        allow_dirty => [ qw{ dist.ini README.pod Changes } ],
        tag_format  => '%v',
    });

    $self->add_plugins([ 'Git::NextVersion' =>
        #;first_version = 0.001       ; this is the default
        #;version_regexp  = ^v(.+)$   ; this is the default
        { version_regexp => '^(\d.\d+)$' },
    ]);

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
            PkgVersion
            ReadmeFromPod
        },
        [ AutoPrereqs => $autoprereq_opts ],
        qw{
            ConsistentVersionTest
            PodCoverageTests
            PodSyntaxTests
            NoTabsTests
            EOLTests
            CompileTests
            HasVersionTests
            PortabilityTests
            ExtraTests
            MinimumPerl
            ReportVersions
            Prepender
            NoSmartCommentsTests

            Authority

            MetaConfig
            MetaJSON
            MetaYAML

            TestRelease
            ConfirmRelease
            UploadToCPAN
            CheckPrereqsIndexed

            GitHub::Meta
            GitHub::Update
        },

        ($self->is_task ? 'TaskWeaver' : 'PodWeaver'),

        [ ReadmeAnyFromPod  => ReadmePodInRoot => {
            type     => 'pod',
            filename => 'README.pod',
            location => 'root',
        }],

        [ ArchiveRelease => {
            directory => 'releases',
        }],

        [ InstallRelease => {
            install_command => 'cpanm .',
        }],
    );

    return;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=for Pod::Coverage configure

=head1 SYNOPIS

    # in your dist.ini...
    [@RSRCHBOY]

=head1 DESCRIPTION

This is RSRCHBOY's current L<Dist::Zilla> dist.ini config for his packages.
He's still figuring this all out, so it's probably wise to not depend on
this being too terribly consistent/sane until the version gets to 1.

=cut
