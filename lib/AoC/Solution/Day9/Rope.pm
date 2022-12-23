package AoC::Solution::Day9::Rope;

use Modern::Perl;
use Moo;

use AoC::Solution::Day9::Rope::Knot;

has total_knots => (
    is       => 'ro',
    required => 1,
);

has head => (
    is      => 'ro',
    default => sub {
        AoC::Solution::Day9::Rope::Knot->new
    }
);

sub BUILD {
    my $self = shift;

    my $knot = $self->head;
    for (2 .. $self->total_knots) {
        $knot = $knot->next(
            AoC::Solution::Day9::Rope::Knot->new
        );
    }
}

sub tail {
    my $self = shift;

    my $knot = $self->head;
    while ($knot->next) {
        $knot = $knot->next;
    }

    return $knot;
}

sub move {
    my ($self, $component, $magnitude) = @_;

    for (1..abs($magnitude)) {
        $self->head->move($component, $magnitude > 0 ? 1 : -1);
    }
}

1;
