package AoC::Solution::Day10::Instruction::NoOp;

use Modern::Perl;

use Moo;

with 'AoC::Solution::Day10::Instruction';

around BUILDARGS => sub {
    my ($orig, $class, %args) = @_;

    $args{required_cycles} = 1;

    return $class->$orig(%args);
};

sub apply {
    my ($self, $cpu) = @_;
}

1;
