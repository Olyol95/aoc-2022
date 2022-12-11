#!/usr/bin/env perl

use Modern::Perl;

use Test::More;

use AoC::Solution::Day8;

my $solution = AoC::Solution::Day8->new(
    input => join("\n", qw(
        30373
        25512
        65332
        33549
        35390
    )),
);

is($solution->part_1, 21, 'part_1');
is($solution->part_2, 8,  'part_2');

done_testing();
