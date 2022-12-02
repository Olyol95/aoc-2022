package AoC::Solution::Day2;

use Modern::Perl;

use Moo;
use Const::Fast;

with 'AoC::Solution';

const my $ROCK     => 1;
const my $PAPER    => 2;
const my $SCISSORS => 3;

sub part_1 {
    my $self = shift;

    my $score;
    foreach my $cols (@{ $self->input }) {
        $score += $self->_score({
            them => $self->_parse_throw($cols->[0]),
            us   => $self->_parse_throw($cols->[1]),
        });
    }
    return $score;
}

sub part_2 {
    my $self = shift;

    my $score;
    foreach my $cols (@{ $self->input }) {
        my $opponent = $self->_parse_throw($cols->[0]);
        $score += $self->_score({
            them => $opponent,
            us   => $self->_throw($opponent, $cols->[1]),
        });
    }
    return $score;
}

sub _score {
    my ($self, $round) = @_;

    if ($self->_is_draw($round)) {
        return 3 + $round->{us};
    }
    if ($self->_is_win($round)) {
        return 6 + $round->{us};
    }
    return $round->{us};
}

sub _is_draw {
    my ($self, $round) = @_;

    return $round->{us} == $round->{them};
}

sub _is_win {
    my ($self, $round) = @_;

    return $round->{us} == ($round->{them} % 3) + 1;
}

sub _throw {
    my ($self, $opponent, $outcome) = @_;

    if ($self->_should_win($outcome)) {
        return ($opponent % 3) + 1;
    }

    if ($self->_should_lose($outcome)) {
        return ($opponent - 1) || 3;
    }

    return $opponent;
}

sub _should_lose {
    my ($self, $col) = @_;

    return $col eq 'X';
}

sub _should_win {
    my ($self, $col) = @_;

    return $col eq 'Z';
}

sub _parse_throw {
    my ($self, $value) = @_;

    state $mappings = {
        A => $ROCK,
        B => $PAPER,
        C => $SCISSORS,
        X => $ROCK,
        Y => $PAPER,
        Z => $SCISSORS,
    };

    return $mappings->{$value};
}

sub _parse_input {
    my $self = shift;

    return [ map {
        [ split(/\s/, $_) ]
    } split(/\n/, $self->input) ];
}

1;
