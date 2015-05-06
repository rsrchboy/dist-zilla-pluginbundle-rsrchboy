package Pod::Weaver::PluginBundle::RSRCHBOY;

# ABSTRACT: Document your modules like RSRCHBOY does

use strict;
use warnings;

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
        [ '@RSRCHBOY/Version', _exp('Version'), { format      => $vformat  } ],
        [ '@RSRCHBOY/prelude', _exp('Region'),  { region_name => 'prelude' } ],

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
        _exp2('Bugs'),

        [ 'RSRCHBOY::Authors',     _exp('RSRCHBOY::Authors'),     { } ],
        _exp2('Contributors'),
        _exp2('Legal'),

        [ '@RSRCHBOY/List',      _exp('-Transformer'), { transformer => 'List' } ],
        [ '@RSRCHBOY/SingleEncoding', _exp('-SingleEncoding'), {} ],
    );
}

!!42;

__END__

=head1 SYNOPSIS

In weaver.ini:

  [@RSRCHBOY]

or in C<dist.ini>:

  [PodWeaver]
  config_plugin = @RSRCHBOY

=head1 DESCRIPTION

This is the L<Pod::Weaver> config I use for building my
documentation.

=head1 OVERVIEW

This plugin bundle is B<ROUGHLY> equivalent to the following weaver.ini file:

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

  [-SingleEncoding]

=for Pod::Coverage mvp_bundle_config

=cut
