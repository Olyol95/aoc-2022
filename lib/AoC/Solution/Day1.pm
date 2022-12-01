package AoC::Solution::Day1;

use Modern::Perl;

use List::Util qw(sum);
use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    return $self->input->[0];
}

sub part_2 {
    my $self = shift;

    return sum(@{ $self->input }[0..2]);
}

sub _parse_input {
    my $self = shift;

    my @elves;

    my $sum = 0;
    foreach my $calories (split(/\n/, $self->input)) {
        if ($calories eq '') {
            push @elves, $sum;
            $sum = 0;
        }
        else {
            $sum += $calories;
        }
    }
    push @elves, $sum;

    return [ sort { $b <=> $a } @elves ];
}

1;
