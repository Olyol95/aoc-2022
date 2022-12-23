package AoC::Solution::Day9::Rope::Knot;

use Modern::Perl;
use Moo;

has location => (
    is      => 'ro',
    default => sub {
        {
            x => 0,
            y => 0,
        }
    },
);

has next => (
    is => 'rw',
);

has _history => (
    is      => 'ro',
    default => sub { {} },
);

sub BUILD {
    my $self = shift;

    $self->record_position;
}

sub vector_to {
    my ($self, $knot) = @_;

    my %vector;
    foreach my $component (keys %{ $self->location }) {
        $vector{$component} =
            $knot->location->{$component} - $self->location->{$component};
    }

    return \%vector;
}

sub move {
    my ($self, %vector) = @_;

    foreach my $component (keys %vector) {
        $self->location->{$component} += $vector{$component};
    }

    $self->record_position;

    return unless $self->next;

    my $delta = $self->vector_to($self->next);

    my %move;
    if (abs($delta->{x}) >= 2) {
        $move{x} = $delta->{x} > 0 ? -1 : 1;
        if ($delta->{y} != 0) {
            $move{y} = $delta->{y} > 0 ? -1 : 1;
        }
    }
    if (abs($delta->{y}) >= 2) {
        $move{y} = $delta->{y} > 0 ? -1 : 1;
        if ($delta->{x} != 0) {
            $move{x} = $delta->{x} > 0 ? -1 : 1;
        }
    }

    $self->next->move(%move);
}

sub record_position {
    my $self = shift;

    $self->_record_point($self->location);
}

sub unique_positions {
    my $self = shift;

    return scalar keys %{ $self->_history };
}

sub _record_point {
    my ($self, $point) = @_;

    my $id = join('', map { "$_:$point->{$_}" } keys %$point);

    $self->_history->{$id}++;
}

1;
