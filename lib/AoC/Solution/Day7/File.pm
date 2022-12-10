package AoC::Solution::Day7::File;

use Modern::Perl;

use Moo;

has parent => (
    is => 'rw',
);

has children => (
    is      => 'ro',
    default => sub { [] },
);

has name => (
    is       => 'ro',
    required => 1,
);

has size => (
    is      => 'ro',
    default => 0,
);

sub has_children {
    my $self = shift;

    return @{ $self->children } > 0;
}

sub get_child {
    my ($self, $name) = @_;

    foreach my $child (@{ $self->children }) {
        return $child if $child->name eq $name;
    }

    return;
}

sub add_child {
    my ($self, $child) = @_;

    $child->parent($self);

    push @{ $self->children }, $child;
}

sub total_size {
    my $self = shift;

    my $size = $self->size;

    foreach my $child (@{ $self->children }) {
        $size += $child->total_size;
    }

    return $size;
}

1;
