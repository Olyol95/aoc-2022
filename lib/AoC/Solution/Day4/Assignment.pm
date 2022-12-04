package AoC::Solution::Day4::Assignment;

use Modern::Perl;

use Moo;

has start => (
    is       => 'ro',
    required => 1,
);

has end => (
    is       => 'ro',
    required => 1,
);

sub contains {
    my ($self, $assignment) = @_;

    return $self->start <= $assignment->start
        && $self->end >= $assignment->end;
}

sub overlaps {
    my ($self, $assignment) = @_;

    return (
        $self->start <= $assignment->start
            && $self->end >= $assignment->start
    ) || (
        $self->start <= $assignment->end
            && $self->end >= $assignment->end
    );
}

1;
