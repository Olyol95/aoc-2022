package AoC::Solution::Day8;

use Modern::Perl;

use List::Util qw(max);
use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $visible = 0;
    for (my $y = 0; $y <= $self->_y_max; $y++) {
        for (my $x = 0; $x <= $self->_x_max; $x++) {
            $visible++ if $self->_is_visible($x, $y);
        }
    }

    return $visible;
}

sub part_2 {
    my $self = shift;

    my @scores;
    for (my $y = 0; $y <= $self->_y_max; $y++) {
        for (my $x = 0; $x < $self->_x_max; $x++) {
            push @scores, $self->_scenic_score($x, $y);
        }
    }

    return max(@scores);
}

sub _is_visible {
    my ($self, $x, $y) = @_;

    return $self->_is_edge($x, $y)
        || $self->_is_visible_north($x, $y)
        || $self->_is_visible_south($x, $y)
        || $self->_is_visible_west($x, $y)
        || $self->_is_visible_east($x, $y);
}

sub _scenic_score {
    my ($self, $x, $y) = @_;

    return $self->_north_visibility($x, $y)
        * $self->_south_visibility($x, $y)
        * $self->_west_visibility($x, $y)
        * $self->_east_visibility($x, $y);
}

sub _is_edge {
    my ($self, $x, $y) = @_;

    return $x == 0
        || $y == 0
        || $x == $self->_x_max
        || $y == $self->_y_max;
}

sub _is_visible_north {
    my ($self, $x, $y) = @_;

    return $self->_north_visibility($x, $y) == $y
        && $self->_height($x, 0) < $self->_height($x, $y);
}

sub _north_visibility {
    my ($self, $x, $y) = @_;

    my $height = $self->_height($x, $y);

    my $y_max = $y;

    for (my $dy = 1; $dy <= $y_max; $dy++) {
        return $dy if $self->_height($x, $y - $dy) >= $height;
    }

    return $y_max;
}

sub _is_visible_south {
    my ($self, $x, $y) = @_;

    return $self->_south_visibility($x, $y) == $self->_y_max - $y
        && $self->_height($x, $self->_y_max) < $self->_height($x, $y);
}

sub _south_visibility {
    my ($self, $x, $y) = @_;

    my $height = $self->_height($x, $y);

    my $y_max = $self->_y_max - $y;

    for (my $dy = 1; $dy <= $y_max; $dy++) {
        return $dy if $self->_height($x, $y + $dy) >= $height;
    }

    return $y_max;
}

sub _is_visible_west {
    my ($self, $x, $y) = @_;

    return $self->_west_visibility($x, $y) == $x
        && $self->_height(0, $y) < $self->_height($x, $y);
}

sub _west_visibility {
    my ($self, $x, $y) = @_;

    my $height = $self->_height($x, $y);

    my $x_max = $x;

    for (my $dx = 1; $dx <= $x_max; $dx++) {
        return $dx if $self->_height($x - $dx, $y) >= $height;
    }

    return $x_max;
}

sub _is_visible_east {
    my ($self, $x, $y) = @_;

    return $self->_east_visibility($x, $y) == $self->_x_max - $x
        && $self->_height($self->_x_max, $y) < $self->_height($x, $y);
}

sub _east_visibility {
    my ($self, $x, $y) = @_;

    my $height = $self->_height($x, $y);

    my $x_max = $self->_x_max - $x;

    for (my $dx = 1; $dx <= $x_max; $dx++) {
        return $dx if $self->_height($x + $dx, $y) >= $height;
    }

    return $x_max;
}

sub _height {
    my ($self, $x, $y) = @_;

    return $self->input->[$y]->[$x];
}

sub _y_max {
    my $self = shift;

    state $y_max = scalar @{ $self->input } - 1;

    return $y_max;
}

sub _x_max {
    my $self = shift;

    state $x_max = scalar @{ $self->input->[0] } - 1;

    return $x_max;
}

sub _parse_input {
    my $self = shift;

    return [ map { [ split(//, $_) ] } split(/\n/, $self->input) ];
}

1;
