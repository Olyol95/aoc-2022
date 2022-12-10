package AoC::Solution::Day10::Instruction::AddX;

use Modern::Perl;

use Moo;

with 'AoC::Solution::Day10::Instruction';

has value => (
    is       => 'ro',
    required => 1,
);

around BUILDARGS => sub {
    my ($orig, $class, %args) = @_;

    $args{required_cycles} = 2;

    return $class->$orig(%args);
};

sub apply {
    my ($self, $cpu) = @_;

    $cpu->register(
        $cpu->register + $self->value
    );
}

1;
