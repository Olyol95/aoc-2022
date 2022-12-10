package AoC::Solution::Day10::CPU;

use Modern::Perl;

use Moo;

has register => (
    is      => 'rw',
    default => 1,
);

has cycle => (
    is      => 'rw',
    default => 0,
);

has instructions => (
    is      => 'rw',
    default => sub { [] },
);

has _instr => (
    is      => 'rw',
    default => 0,
);

has _remaining_cycles => (
    is => 'rw',
);

sub BUILD {
    my $self = shift;

    $self->_remaining_cycles(
        $self->_current_instruction->required_cycles,
    );
}

sub is_running {
    my $self = shift;

    return $self->_instr < @{ $self->instructions };
}

sub tick {
    my $self = shift;

    my $instruction = $self->_current_instruction;

    $self->_remaining_cycles(
        $self->_remaining_cycles - 1
    );

    unless ($self->_remaining_cycles) {
        $instruction->apply($self);
        $self->_advance;
    }

    $self->cycle($self->cycle + 1);
}

sub _current_instruction {
    my $self = shift;

    return $self->instructions->[$self->_instr];
}

sub _advance {
    my $self = shift;

    $self->_instr(
        $self->_instr + 1
    );

    if ($self->is_running) {
        $self->_remaining_cycles(
            $self->_current_instruction->required_cycles
        );
    }
}

1;
