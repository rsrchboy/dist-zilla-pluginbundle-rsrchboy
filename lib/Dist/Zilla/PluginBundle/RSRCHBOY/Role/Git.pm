package Dist::Zilla::PluginBundle::RSRCHBOY::Role::Git;

# ABSTRACT: A helper role for Git::Raw operations

use Moose::Role;
use namespace::autoclean;
use MooseX::AttributeShortcuts 0.023;

use autobox::Core;
use Git::Raw 0.32;
use File::Slurp 'slurp';

with 'MooseX::RelatedClasses' => {
    namespace        => 'Git::Raw',
    all_in_namespace => 1,
    private          => 1,
};

=attr repo

A L<Git::Raw::Repository> object referring to the current, working repository.

=cut

has repo => (
    is              => 'lazy',
    isa_instance_of => 'Git::Raw::Repository',
    builder         => sub { Git::Raw::Repository->open('.') },
    handles         => [ qw{ head index } ],
);

=method has_file_in_head($filename)

Given a file / path name, check to see if it exists in the current HEAD. Note
that we only test existence, not if the file is dirty, or differs in the
index, etc.

C<$filename> may be a string or anything capable of being stringified (e.g. a
L<Path::Class> or L<Path::Tiny> object).

=cut

sub has_file_in_head { shift->repo->head->target->tree->entry_bypath(q{} . shift) ? 1 : 0 }

!!42;
__END__
