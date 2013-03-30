#
# This file is part of Dist-Zilla-PluginBundle-RSRCHBOY
#
# This software is Copyright (c) 2011 by Chris Weyl.
#
# This is free software, licensed under:
#
#   The GNU Lesser General Public License, Version 2.1, February 1999
#
package Pod::Weaver::PluginBundle::RSRCHBOY;
{
  $Pod::Weaver::PluginBundle::RSRCHBOY::VERSION = '0.038';
}

# ABSTRACT: Document your modules like RSRCHBOY does

use strict;
use warnings;

# for prereqs
use Pod::Elemental::Transformer::List                  ( );
use Pod::Weaver::Plugin::Encoding                      ( );
use Pod::Weaver::Plugin::StopWords                     ( );
use Pod::Weaver::Section::SeeAlso                      ( );
use Pod::Weaver::Section::SourceGitHub                 ( );
use Pod::Weaver::Section::CollectWithIntro             ( );
use Pod::Weaver::Section::Contributors                 ( );
use Pod::Weaver::Section::RSRCHBOY::LazyAttributes     ( );
use Pod::Weaver::Section::RSRCHBOY::RequiredAttributes ( );

use Pod::Weaver::Config::Assembler;

sub _exp { Pod::Weaver::Config::Assembler->expand_package($_[0]) }
sub _exp2 { [ "\@RSRCHBOY/$_[0]", _exp($_[0]), {} ] }

my $vformat = 'This document describes version %v of %m - released %{LLLL dd, yyyy}d as part of %r.';

# this.... needs some work.

sub mvp_bundle_config {
    return (
        [ '@RSRCHBOY/StopWords', _exp('-StopWords'), {} ],
        [ '@RSRCHBOY/CorePrep',  _exp('@CorePrep'),  {} ],
        _exp2('Name'),
        [ '@RSRCHBOY/Version', _exp('Version'),      { format      => $vformat  } ],
        [ '@RSRCHBOY/prelude', _exp('Region'),      { region_name => 'prelude' } ],

        [ 'SYNOPSIS',         _exp('Generic'),      {} ],
        [ 'DESCRIPTION',      _exp('Generic'),      {} ],
        [ 'OVERVIEW',         _exp('Generic'),      {} ],

        [ 'ROLE PARAMETERS', _exp('RSRCHBOY::RoleParameters'), {} ],

        [ 'REQUIRED ATTRIBUTES', _exp('RSRCHBOY::RequiredAttributes'), { } ],
        [ 'LAZY ATTRIBUTES',     _exp('RSRCHBOY::LazyAttributes'),     { } ],

        [ 'ATTRIBUTES',       _exp('Collect'), { command => 'attr'            } ],
        [ 'METHODS',          _exp('Collect'), { command => 'method'          } ],
        [ 'REQUIRED METHODS', _exp('Collect'), { command => 'required_method' } ],
        [ 'FUNCTIONS',        _exp('Collect'), { command => 'func'            } ],
        [ 'TYPES',            _exp('Collect'), { command => 'type'            } ],
        [ 'TEST_FUNCTIONS',   _exp('Collect'), { command => 'test'            } ],

        _exp2('Leftovers'),

        [ '@RSRCHBOY/postlude',  _exp('Region'),       { region_name => 'postlude' } ],

        _exp2('SeeAlso'),
        _exp2('SourceGitHub'),
        _exp2('Bugs'),

        _exp2('Authors'),
        _exp2('Contributors'),
        _exp2('Legal'),

        [ '@RSRCHBOY/List',      _exp('-Transformer'), { transformer => 'List' } ],
        [ '@RSRCHBOY/Encoding',  _exp('-Encoding'),    {} ],
    );
}

!!42;

__END__

=pod

=encoding utf-8

=for :stopwords Chris Weyl

=head1 NAME

Pod::Weaver::PluginBundle::RSRCHBOY - Document your modules like RSRCHBOY does

=head1 VERSION

This document describes version 0.038 of Pod::Weaver::PluginBundle::RSRCHBOY - released March 29, 2013 as part of Dist-Zilla-PluginBundle-RSRCHBOY.

=head1 SYNOPSIS

In weaver.ini:

  [@RSRCHBOY]

or in dist.ini:

  [PodWeaver]
  config_plugin = @RSRCHBOY

=head1 DESCRIPTION

This is the L<Pod::Weaver> config I use for building my
documentation.

=head1 OVERVIEW

This plugin bundle is equivalent to the following weaver.ini file:

  [@CorePrep]

  [Name]

  [Region / prelude]

  [Generic / SYNOPSIS]
  [Generic / DESCRIPTION]
  [Generic / OVERVIEW]

  [Collect / ATTRIBUTES]
  command = attr

  [Collect / METHODS]
  command = method

  [Collect / FUNCTIONS]
  command = func

  [Collect / TEST_FUNCTIONS]
  command = test

  [Leftovers]

  [Region / postlude]

  [SeeAlso]
  [SourceGitHub]
  [Bugs]
  [Authors]
  [Legal]

  [-Transformer]
  transformer = List

  [-Encoding]

=for Pod::Coverage mvp_bundle_config

=head1 SEE ALSO

Please see those modules/websites for more information related to this module.

=over 4

=item *

L<Dist::Zilla::PluginBundle::RSRCHBOY|Dist::Zilla::PluginBundle::RSRCHBOY>

=back

=head1 SOURCE

The development version is on github at L<http://github.com/RsrchBoy/Dist-Zilla-PluginBundle-RSRCHBOY>
and may be cloned from L<git://github.com/RsrchBoy/Dist-Zilla-PluginBundle-RSRCHBOY.git>

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
https://github.com/RsrchBoy/Dist-Zilla-PluginBundle-RSRCHBOY/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Chris Weyl <cweyl@alumni.drew.edu>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2011 by Chris Weyl.

This is free software, licensed under:

  The GNU Lesser General Public License, Version 2.1, February 1999

=cut
