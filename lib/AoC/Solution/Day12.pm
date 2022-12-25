package AoC::Solution::Day12;

use Modern::Perl;
use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    return $self->_find_route(
        [ $self->input->{start} ],
        $self->input->{end},
    );
}

sub part_2 {
    my $self = shift;

    my @starts;

    for (my $y = 0; $y < @{ $self->input->{map} }; $y++) {
        for (my $x = 0; $x < @{ $self->input->{map}->[$y] }; $x++) {
            if ($self->_height_at($x, $y) == ord('a')) {
                push @starts, [$x, $y];
            }
        }
    }

    return $self->_find_route(\@starts, $self->input->{end});
}

sub _find_route {
    my ($self, $starts, $end) = @_;

    my @routes = map { { pos => $_, length => 0 } } @$starts;

    my %visited;
    while (@routes) {
        my $route = shift @routes;
        my $pos = $route->{pos};

        my $key = "$pos->[0],$pos->[1]";
        next if $visited{$key};

        $visited{$key} = 1;

        return $route->{length} if $self->_is_end(@$pos);

        my $current_height = $self->_height_at(@$pos);

        for (my $dy = -1; $dy <= 1; $dy++) {
            for (my $dx = -1; $dx <= 1; $dx++) {
                next if $dy == $dx == 0;
                next if abs($dx) == abs($dy) == 1;

                my @move = ($pos->[0] + $dx, $pos->[1] + $dy);
                my $move_height = $self->_height_at(@move);
                next unless $move_height;

                if ($move_height <= $current_height + 1) {
                    push @routes, {
                        pos    => \@move,
                        length => $route->{length} + 1,
                    },
                }
            }
        }
    }
}

sub _height_at {
    my ($self, $x, $y) = @_;

    my $map = $self->input->{map};

    return unless $y >= 0 && $y < @$map
        && $x >= 0 && $x < @{ $map->[$y] };

    return $map->[$y]->[$x];
}

sub _is_end {
    my ($self, $x, $y) = @_;

    return $x == $self->input->{end}->[0]
        && $y == $self->input->{end}->[1];
}

sub _parse_input {
    my $self = shift;

    my $input = {
        map => [
            map {
                [ map { ord($_) } split(//, $_) ]
            } split(/\n/, $self->input)
        ],
    };

    for (my $y = 0; $y < @{ $input->{map} }; $y++) {
        for (my $x = 0; $x < @{ $input->{map}->[$y] }; $x++) {
            my $height = $input->{map}->[$y]->[$x];
            if ($height == ord('S')) {
                $input->{start} = [$x, $y];
                $input->{map}->[$y]->[$x] = ord('a');
            }
            elsif ($height == ord('E')) {
                $input->{end} = [$x, $y];
                $input->{map}->[$y]->[$x] = ord('z');
            }
        }
    }

    return $input;
}

1;
