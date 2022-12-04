package AoC::Solution::Day4::Pair;

use Modern::Perl;

use Moo;

has left => (
    is       => 'ro',
    required => 1,
);

has right => (
    is       => 'ro',
    required => 1,
);

sub has_contained_assignment {
    my $self = shift;

    return $self->left->contains($self->right)
        || $self->right->contains($self->left);
}

sub has_overlapping_assignment {
    my $self = shift;

    return $self->left->overlaps($self->right)
        || $self->right->overlaps($self->left);
}

1;
