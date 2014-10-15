use strict;
use warnings;
use Test::More 0.88;
# This is a relatively nice way to avoid Test::NoWarnings breaking our
# expectations by adding extra tests, without using no_plan.  It also helps
# avoid any other test module that feels introducing random tests, or even
# test plans, is a nice idea.
our $success = 0;
END { $success && done_testing; }

# List our own version used to generate this
my $v = "\nGenerated by Dist::Zilla::Plugin::ReportVersions::Tiny v1.10\n";

eval {                     # no excuses!
    # report our Perl details
    my $want = 'v5.10.0';
    $v .= "perl: $] (wanted $want) on $^O from $^X\n\n";
};
defined($@) and diag("$@");

# Now, our module version dependencies:
sub pmver {
    my ($module, $wanted) = @_;
    $wanted = " (want $wanted)";
    my $pmver;
    eval "require $module;";
    if ($@) {
        if ($@ =~ m/Can't locate .* in \@INC/) {
            $pmver = 'module not found.';
        } else {
            diag("${module}: $@");
            $pmver = 'died during require.';
        }
    } else {
        my $version;
        eval { $version = $module->VERSION; };
        if ($@) {
            diag("${module}: $@");
            $pmver = 'died during VERSION check.';
        } elsif (defined $version) {
            $pmver = "$version";
        } else {
            $pmver = '<undef>';
        }
    }

    # So, we should be good, right?
    return sprintf('%-45s => %-10s%-15s%s', $module, $pmver, $wanted, "\n");
}

eval { $v .= pmver('Archive::Tar::Wrapper','any version') };
eval { $v .= pmver('Config::MVP::Slicer','0.302') };
eval { $v .= pmver('Dist::Zilla','any version') };
eval { $v .= pmver('Dist::Zilla::App::Command::cover','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::ArchiveRelease','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::Authority','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::CPANFile','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::CheckChangesHasContent','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::CheckExtraTests','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::CheckPrereqsIndexed','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::CheckSelfDependency','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::ConfirmRelease','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::ConsistentVersionTest','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::ContributorsFromGit','0.010') };
eval { $v .= pmver('Dist::Zilla::Plugin::CopyFilesFromBuild','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::EOLTests','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::Git::CommitBuild','2.009') };
eval { $v .= pmver('Dist::Zilla::Plugin::Git::Describe','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::Git::NextVersion','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::Git::Remote::Check','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::GitHub::Update','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::GithubMeta','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::HasVersionTests','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::InstallRelease','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::MetaConfig','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::MetaJSON','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::MetaNoIndex','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::MetaProvides::Package','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::MetaYAML','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::MinimumPerl','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::NoSmartCommentsTests','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::PodCoverageTests','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::PodSyntaxTests','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::PodWeaver','4.000') };
eval { $v .= pmver('Dist::Zilla::Plugin::Prepender','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::PromptIfStale','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::PruneFiles','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::ReadmeAnyFromPod','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::ReadmeFromPod','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::ReportVersions::Tiny','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::Run::AfterMint','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::RunExtraTests','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::SchwartzRatio','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::Signature','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::SurgicalPkgVersion','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::TaskWeaver','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::Test::CheckDeps','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::Test::Compile','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::Test::MinimumVersion','2.000005') };
eval { $v .= pmver('Dist::Zilla::Plugin::Test::NoTabs','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::Test::Pod::LinkCheck','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::Test::PodSpelling','2.002001') };
eval { $v .= pmver('Dist::Zilla::Plugin::TestRelease','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::Travis::ConfigForReleaseBranch','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::Twitter','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::UploadToCPAN','any version') };
eval { $v .= pmver('Dist::Zilla::PluginBundle::Git','1.121770') };
eval { $v .= pmver('Dist::Zilla::PluginBundle::Git::CheckFor','any version') };
eval { $v .= pmver('Dist::Zilla::Role::PluginBundle::Config::Slicer','any version') };
eval { $v .= pmver('Dist::Zilla::Role::PluginBundle::Easy','any version') };
eval { $v .= pmver('Dist::Zilla::Role::PluginBundle::PluginRemover','0.102') };
eval { $v .= pmver('Dist::Zilla::Stash::PAUSE::Encrypted','0.003') };
eval { $v .= pmver('ExtUtils::MakeMaker','any version') };
eval { $v .= pmver('File::Spec','any version') };
eval { $v .= pmver('Git::Raw','0.32') };
eval { $v .= pmver('IO::Handle','any version') };
eval { $v .= pmver('IPC::Open3','any version') };
eval { $v .= pmver('Moose','any version') };
eval { $v .= pmver('Moose::Role','any version') };
eval { $v .= pmver('Moose::Util::TypeConstraints','any version') };
eval { $v .= pmver('MooseX::AttributeShortcuts','0.023') };
eval { $v .= pmver('MooseX::NewDefaults','any version') };
eval { $v .= pmver('MooseX::RelatedClasses','any version') };
eval { $v .= pmver('Path::Class','any version') };
eval { $v .= pmver('Pod::Coverage::TrustPod','any version') };
eval { $v .= pmver('Pod::Elemental::Element::Pod5::Command','any version') };
eval { $v .= pmver('Pod::Elemental::Element::Pod5::Ordinary','any version') };
eval { $v .= pmver('Pod::Elemental::Transformer::List','any version') };
eval { $v .= pmver('Pod::Weaver::Config::Assembler','any version') };
eval { $v .= pmver('Pod::Weaver::Plugin::SingleEncoding','any version') };
eval { $v .= pmver('Pod::Weaver::Plugin::StopWords','any version') };
eval { $v .= pmver('Pod::Weaver::Section::Authors','any version') };
eval { $v .= pmver('Pod::Weaver::Section::CollectWithIntro','any version') };
eval { $v .= pmver('Pod::Weaver::Section::Contributors','any version') };
eval { $v .= pmver('Pod::Weaver::Section::SeeAlso','any version') };
eval { $v .= pmver('Pod::Weaver::Section::SourceGitHub','any version') };
eval { $v .= pmver('Test::CheckDeps','0.010') };
eval { $v .= pmver('Test::MinimumVersion','any version') };
eval { $v .= pmver('Test::More','0.94') };
eval { $v .= pmver('Test::NoSmartComments','any version') };
eval { $v .= pmver('Test::Pod','any version') };
eval { $v .= pmver('Test::Pod::Content','any version') };
eval { $v .= pmver('Test::Pod::Coverage','any version') };
eval { $v .= pmver('Test::Pod::LinkCheck','any version') };
eval { $v .= pmver('URI::Escape::XS','any version') };
eval { $v .= pmver('aliased','any version') };
eval { $v .= pmver('autobox::Core','any version') };
eval { $v .= pmver('autodie','0.20') };
eval { $v .= pmver('namespace::autoclean','any version') };
eval { $v .= pmver('strict','any version') };
eval { $v .= pmver('warnings','any version') };


# All done.
$v .= <<'EOT';

Thanks for using my code.  I hope it works for you.
If not, please try and include this output in the bug report.
That will help me reproduce the issue and solve your problem.

EOT

diag($v);
ok(1, "we really didn't test anything, just reporting data");
$success = 1;

# Work around another nasty module on CPAN. :/
no warnings 'once';
$Template::Test::NO_FLUSH = 1;
exit 0;
