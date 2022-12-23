package AoC::Solution::Day11::Monkey;

use Modern::Perl;

use Moo;

has id => (
    is       => 'ro',
    required => 1,
);

has items => (
    is      => 'ro',
    default => sub { [] },
);

has operation => (
    is       => 'ro',
    required => 1,
);

has divisor => (
    is       => 'ro',
    required => 1,
);

has pass_branch => (
    is       => 'ro',
    required => 1,
);

has fail_branch => (
    is       => 'ro',
    required => 1,
);

1;
