package Pod::Weaver::PluginBundle::RSRCHBOY;

# ABSTRACT: Document your modules like RSRCHBOY does

use strict;
use warnings;

use Pod::Weaver::Config::Assembler;

use constant COLLECT => Pod::Weaver::Config::Assembler->expand_package('Collect');
use constant GENERIC => Pod::Weaver::Config::Assembler->expand_package('Generic');
use constant VFORMAT => 'This document describes version %v of %m - released %{LLLL dd, yyyy}d as part of %r.';

sub mvp_bundle_config {

    my $_exp  = sub { Pod::Weaver::Config::Assembler->expand_package($_[0]) };
    my $_exp2 = sub { [ "\@RSRCHBOY/$_[0]", $_exp->($_[0]), {} ] };

    my $_collect = sub { ( COLLECT, { command => $_[0] } ) };
    my $_generic = sub { [ $_[0] => GENERIC, { } ] };

    return (
        [ '@RSRCHBOY/StopWords', $_exp->('-StopWords'), {} ],
        [ '@RSRCHBOY/CorePrep',  $_exp->('@CorePrep'),  {} ],

        $_exp2->('Name'),
        [ '@RSRCHBOY/Version', $_exp->('Version'), { format      => VFORMAT   } ],
        [ '@RSRCHBOY/prelude', $_exp->('Region'),  { region_name => 'prelude' } ],

        $_generic->('SYNOPSIS'),
        $_generic->('DESCRIPTION'),
        $_generic->('OVERVIEW'),

        [ 'EXTENDS',    $_collect->('extends')    ],
        [ 'IMPLEMENTS', $_collect->('implements') ],
        [ 'CONSUMES',   $_collect->('consumes')   ],

        [ 'ROLE PARAMETERS', $_exp->('RSRCHBOY::RoleParameters'), {} ],

        [ 'REQUIRED ATTRIBUTES', $_exp->('RSRCHBOY::RequiredAttributes'), { } ],
        [ 'LAZY ATTRIBUTES',     $_exp->('RSRCHBOY::LazyAttributes'),     { } ],
        [ 'REQUIRED METHODS',    $_collect->('required_method')               ],
        [ 'ATTRIBUTES',          $_collect->('attr')                          ],

        [ 'BEFORE METHOD MODIFIERS', $_collect->('before') ],
        [ 'AROUND METHOD MODIFIERS', $_collect->('around') ],
        [ 'AFTER METHOD MODIFIERS',  $_collect->('after')  ],

        [ 'METHODS',          $_collect->('method')     ],
        [ 'PRIVATE METHODS',  $_collect->('pvt_method') ],
        [ 'FUNCTIONS',        $_collect->('func')       ],
        [ 'TYPES',            $_collect->('type')       ],
        [ 'TEST FUNCTIONS',   $_collect->('test')       ],

        $_exp2->('Leftovers'),

        [ '@RSRCHBOY/postlude', $_exp->('Region'), { region_name => 'postlude' } ],

        $_exp2->('SeeAlso'),
        $_exp2->('Bugs'),

        [ 'RSRCHBOY::Authors', $_exp->('RSRCHBOY::Authors'), { feed_me => 0 } ],
        $_exp2->('Contributors'),
        $_exp2->('Legal'),

        [ '@RSRCHBOY/List',      $_exp->('-Transformer'), { transformer => 'List' } ],
        [ '@RSRCHBOY/SingleEncoding', $_exp->('-SingleEncoding'), {} ],
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
