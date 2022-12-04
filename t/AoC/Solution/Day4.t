#!/usr/bin/env perl

use Modern::Perl;

use Test::More;

use AoC::Solution::Day4;

my $solution = AoC::Solution::Day4->new(
    input => join("\n", qw(
        2-4,6-8
        2-3,4-5
        5-7,7-9
        2-8,3-7
        6-6,4-6
        2-6,4-8
    )),
);

is($solution->part_1, 2, 'part_1');
is($solution->part_2, 4, 'part_2');

done_testing();
