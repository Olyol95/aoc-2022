package AoC::Solution::Day9;

use Modern::Perl;
use Moo;

use AoC::Solution::Day9::Rope;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    return $self->_unique_tail_positions(
        AoC::Solution::Day9::Rope->new(
            total_knots => 2,
        )
    );
}

sub part_2 {
    my $self = shift;

    return $self->_unique_tail_positions(
        AoC::Solution::Day9::Rope->new(
            total_knots => 10,
        )
    );
}

sub _unique_tail_positions {
    my ($self, $rope) = @_;

    foreach my $instr (@{ $self->input }) {
        my $direction = $instr->{direction};

        if ($direction eq 'U') {
            $rope->move(y => $instr->{magnitude});
        }
        elsif ($direction eq 'D') {
            $rope->move(y => -$instr->{magnitude});
        }
        elsif ($direction eq 'R') {
            $rope->move(x => $instr->{magnitude});
        }
        elsif ($direction eq 'L') {
            $rope->move(x => -$instr->{magnitude});
        }
    }

    return $rope->tail->unique_positions;
}

sub _parse_input {
    my $self = shift;

    return [
        map {
            my ($direction, $magnitude) = split(/\s/, $_);
            {
                direction => $direction,
                magnitude => $magnitude,
            }
        } split(/\n/, $self->input)
    ];
}

1;
