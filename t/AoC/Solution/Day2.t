#!/usr/bin/env perl

use Modern::Perl;

use Test::More;

use AoC::Solution::Day2;

my $solution = AoC::Solution::Day2->new(
    input => join("\n", (
        'A Y',
        'B X',
        'C Z',
    )),
);

is($solution->part_1, 15, 'part_1');
is($solution->part_2, 12, 'part_2');

done_testing();
