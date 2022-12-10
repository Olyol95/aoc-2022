package AoC::Solution::Day10::Instruction;

use Modern::Perl;

use Moo::Role;

has required_cycles => (
    is       => 'rw',
    required => 1,
);

requires 'apply';

1;
