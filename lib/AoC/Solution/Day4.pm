package AoC::Solution::Day4;

use Modern::Perl;

use Moo;

use AoC::Solution::Day4::Pair;
use AoC::Solution::Day4::Assignment;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $total = grep {
        $_->has_contained_assignment
    } @{ $self->input };

    return $total;
}

sub part_2 {
    my $self = shift;

    my $total = grep {
        $_->has_overlapping_assignment
    } @{ $self->input };

    return $total;
}

sub _parse_input {
    my $self = shift;

    my @input;
    foreach my $line (split(/\n/, $self->input)) {
        my @pair = split(/,/, $line);
        push @input, AoC::Solution::Day4::Pair->new(
            left  => $self->_parse_pair($pair[0]),
            right => $self->_parse_pair($pair[1]),
        );
    }
    return \@input;
}

sub _parse_pair {
    my ($self, $input) = @_;

    my @bounds = split(/-/, $input);
    return AoC::Solution::Day4::Assignment->new(
        start => $bounds[0],
        end   => $bounds[1],
    );
}

1;
