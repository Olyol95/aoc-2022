#!/usr/bin/env perl

use Modern::Perl;

use Test::More;

use AoC::Solution::Day12;

my $solution = AoC::Solution::Day12->new(
    input => join("\n", qw(
        Sabqponm
        abcryxxl
        accszExk
        acctuvwj
        abdefghi
    )),
);

is($solution->part_1, 31, 'part_1');
is($solution->part_2, 29, 'part_2');

done_testing();
