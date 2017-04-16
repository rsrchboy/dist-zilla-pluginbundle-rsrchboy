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

        [ 'ATTRIBUTES', _exp('Collect'), { command => 'attr' }],

        [ 'BEFORE METHOD MODIFIERS', _exp('Collect'), { command => 'before' } ],
        [ 'AROUND METHOD MODIFIERS', _exp('Collect'), { command => 'around' } ],
        [ 'AFTER METHOD MODIFIERS',  _exp('Collect'), { command => 'after'  } ],

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

=head1 SYNOPSIS

In weaver.ini:

  [@RSRCHBOY]

or in C<dist.ini>:

  [PodWeaver]
  config_plugin = @RSRCHBOY

=head1 DESCRIPTION

This is the L<Pod::Weaver> config I use for building my
documentation.

=for Pod::Coverage mvp_bundle_config

=cut
