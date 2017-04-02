#
# This file is part of Dist-Zilla-PluginBundle-RSRCHBOY
#
# This software is Copyright (c) 2013 by Chris Weyl.
#
# This is free software, licensed under:
#
#   The GNU Lesser General Public License, Version 2.1, February 1999
#
package Pod::Weaver::PluginBundle::RSRCHBOY;
our $AUTHORITY = 'cpan:RSRCHBOY';
$Pod::Weaver::PluginBundle::RSRCHBOY::VERSION = '0.073';
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

        [ 'SYNOPSIS',    _exp('Generic'), {} ],
        [ 'DESCRIPTION', _exp('Generic'), {} ],
        [ 'OVERVIEW',    _exp('Generic'), {} ],

        [ 'EXTENDS',    _exp('Collect'), { command => 'extends'    } ],
        [ 'IMPLEMENTS', _exp('Collect'), { command => 'implements' } ],
        [ 'CONSUMES',   _exp('Collect'), { command => 'consumes'   } ],

        [ 'ROLE PARAMETERS', _exp('RSRCHBOY::RoleParameters'), {} ],

        [ 'REQUIRED ATTRIBUTES', _exp('RSRCHBOY::RequiredAttributes'), {         } ],
        [ 'LAZY ATTRIBUTES',     _exp('RSRCHBOY::LazyAttributes'),     {         } ],
        [ 'REQUIRED METHODS',    _exp('Collect'), { command => 'required_method' } ],

        [ 'ATTRIBUTES',       _exp('Collect'), { command => 'attr'       } ],
        [ 'METHODS',          _exp('Collect'), { command => 'method'     } ],
        [ 'PRIVATE METHODS',  _exp('Collect'), { command => 'pvt_method' } ],
        [ 'FUNCTIONS',        _exp('Collect'), { command => 'func'       } ],
        [ 'TYPES',            _exp('Collect'), { command => 'type'       } ],
        [ 'TEST FUNCTIONS',   _exp('Collect'), { command => 'test'       } ],

        _exp2('Leftovers'),

        [ '@RSRCHBOY/postlude',  _exp('Region'),       { region_name => 'postlude' } ],

        _exp2('SeeAlso'),
        _exp2('Bugs'),

        [ 'RSRCHBOY::Authors', _exp('RSRCHBOY::Authors'), { feed_me => 0 } ],
        _exp2('Contributors'),
        _exp2('Legal'),

        [ '@RSRCHBOY/List',      _exp('-Transformer'), { transformer => 'List' } ],
        [ '@RSRCHBOY/SingleEncoding', _exp('-SingleEncoding'), {} ],
    );
}

!!42;

__END__

=pod

=encoding UTF-8

=for :stopwords Chris Weyl Bowers Neil Romanov Sergey

=head1 NAME

Pod::Weaver::PluginBundle::RSRCHBOY - Document your modules like RSRCHBOY does

=head1 VERSION

This document describes version 0.073 of Pod::Weaver::PluginBundle::RSRCHBOY - released April 01, 2017 as part of Dist-Zilla-PluginBundle-RSRCHBOY.

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

=head1 SEE ALSO

Please see those modules/websites for more information related to this module.

=over 4

=item *

L<Dist::Zilla::PluginBundle::RSRCHBOY|Dist::Zilla::PluginBundle::RSRCHBOY>

=back

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
L<https://github.com/RsrchBoy/dist-zilla-pluginbundle-rsrchboy/issues>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Chris Weyl <cweyl@alumni.drew.edu>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Chris Weyl.

This is free software, licensed under:

  The GNU Lesser General Public License, Version 2.1, February 1999

=cut
