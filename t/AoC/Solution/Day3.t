#!/usr/bin/env perl

use Modern::Perl;

use Test::More;

use AoC::Solution::Day3;

my $solution = AoC::Solution::Day3->new(
    input => join("\n", qw(
        vJrwpWtwJgWrhcsFMMfFFhFp
        jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
        PmmdzqPrVvPwwTWBwg
        wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
        ttgJtRGJQctTZtZT
        CrZsJsPPZsGzwwsLwLmpwMDw
    )),
);

is($solution->part_1, 157, 'part_1');
is($solution->part_2, 70,  'part_2');

done_testing();
