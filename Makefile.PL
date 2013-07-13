
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Zilla your distributions like RSRCHBOY!",
  "AUTHOR" => "Chris Weyl <cweyl\@alumni.drew.edu>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Dist-Zilla-PluginBundle-RSRCHBOY",
  "EXE_FILES" => [],
  "LICENSE" => "lgpl",
  "NAME" => "Dist::Zilla::PluginBundle::RSRCHBOY",
  "PREREQ_PM" => {
    "Archive::Tar::Wrapper" => 0,
    "Config::MVP::Slicer" => "0.302",
    "Dist::Zilla" => 0,
    "Dist::Zilla::Plugin::ArchiveRelease" => 0,
    "Dist::Zilla::Plugin::Authority" => 0,
    "Dist::Zilla::Plugin::CPANFile" => 0,
    "Dist::Zilla::Plugin::CheckChangesHasContent" => 0,
    "Dist::Zilla::Plugin::CheckPrereqsIndexed" => 0,
    "Dist::Zilla::Plugin::ConfirmRelease" => 0,
    "Dist::Zilla::Plugin::ConsistentVersionTest" => 0,
    "Dist::Zilla::Plugin::ContributorsFromGit" => 0,
    "Dist::Zilla::Plugin::CopyFilesFromBuild" => 0,
    "Dist::Zilla::Plugin::EOLTests" => 0,
    "Dist::Zilla::Plugin::ExtraTests" => 0,
    "Dist::Zilla::Plugin::Git::CommitBuild" => "2.009",
    "Dist::Zilla::Plugin::Git::Describe" => 0,
    "Dist::Zilla::Plugin::Git::NextVersion" => 0,
    "Dist::Zilla::Plugin::GitHub::Meta" => 0,
    "Dist::Zilla::Plugin::GitHub::Update" => 0,
    "Dist::Zilla::Plugin::HasVersionTests" => 0,
    "Dist::Zilla::Plugin::InstallGuide" => 0,
    "Dist::Zilla::Plugin::InstallRelease" => 0,
    "Dist::Zilla::Plugin::MetaConfig" => 0,
    "Dist::Zilla::Plugin::MetaJSON" => 0,
    "Dist::Zilla::Plugin::MetaNoIndex" => 0,
    "Dist::Zilla::Plugin::MetaProvides::Package" => 0,
    "Dist::Zilla::Plugin::MetaYAML" => 0,
    "Dist::Zilla::Plugin::MinimumPerl" => 0,
    "Dist::Zilla::Plugin::NoSmartCommentsTests" => 0,
    "Dist::Zilla::Plugin::NoTabsTests" => 0,
    "Dist::Zilla::Plugin::PodCoverageTests" => 0,
    "Dist::Zilla::Plugin::PodSyntaxTests" => 0,
    "Dist::Zilla::Plugin::PodWeaver" => 0,
    "Dist::Zilla::Plugin::Prepender" => 0,
    "Dist::Zilla::Plugin::PruneFiles" => 0,
    "Dist::Zilla::Plugin::ReadmeAnyFromPod" => 0,
    "Dist::Zilla::Plugin::ReadmeFromPod" => 0,
    "Dist::Zilla::Plugin::ReportVersions::Tiny" => 0,
    "Dist::Zilla::Plugin::Signature" => 0,
    "Dist::Zilla::Plugin::SurgicalPkgVersion" => 0,
    "Dist::Zilla::Plugin::TaskWeaver" => 0,
    "Dist::Zilla::Plugin::Test::Compile" => 0,
    "Dist::Zilla::Plugin::Test::MinimumVersion" => "2.000005",
    "Dist::Zilla::Plugin::Test::Pod::LinkCheck" => 0,
    "Dist::Zilla::Plugin::Test::PodSpelling" => "2.002001",
    "Dist::Zilla::Plugin::TestRelease" => 0,
    "Dist::Zilla::Plugin::Twitter" => 0,
    "Dist::Zilla::Plugin::UploadToCPAN" => 0,
    "Dist::Zilla::PluginBundle::Git" => "1.121770",
    "Dist::Zilla::PluginBundle::Git::CheckFor" => 0,
    "Dist::Zilla::Role::PluginBundle::Config::Slicer" => 0,
    "Dist::Zilla::Role::PluginBundle::Easy" => 0,
    "Dist::Zilla::Stash::PAUSE::Encrypted" => "0.003",
    "Moose" => 0,
    "Moose::Util::TypeConstraints" => 0,
    "MooseX::AttributeShortcuts" => 0,
    "MooseX::NewDefaults" => 0,
    "Path::Class" => 0,
    "Pod::Coverage::TrustPod" => 0,
    "Pod::Elemental::Transformer::List" => 0,
    "Pod::Weaver::Config::Assembler" => 0,
    "Pod::Weaver::Plugin::Encoding" => 0,
    "Pod::Weaver::Plugin::StopWords" => 0,
    "Pod::Weaver::Section::CollectWithIntro" => 0,
    "Pod::Weaver::Section::Contributors" => 0,
    "Pod::Weaver::Section::SeeAlso" => 0,
    "Pod::Weaver::Section::SourceGitHub" => 0,
    "Test::MinimumVersion" => 0,
    "Test::NoSmartComments" => 0,
    "Test::Pod" => 0,
    "Test::Pod::Content" => 0,
    "Test::Pod::Coverage" => 0,
    "Test::Pod::LinkCheck" => 0,
    "autobox::Core" => 0,
    "namespace::autoclean" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Find" => 0,
    "File::Temp" => 0,
    "Test::More" => "0.88"
  },
  "VERSION" => "0.040",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
  my $br = $WriteMakefileArgs{BUILD_REQUIRES};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



