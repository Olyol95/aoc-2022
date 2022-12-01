#!/usr/bin/env perl

use Modern::Perl;

use Test::More;

use AoC::Solution::Day1;

my $solution = AoC::Solution::Day1->new(
    input => join("\n", (
        '1000',
        '2000',
        '3000',
        '',
        '4000',
        '',
        '5000',
        '6000',
        '',
        '7000',
        '8000',
        '9000',
        '',
        '10000',
    ))
);

is($solution->part_1, 24000, 'part_1');
is($solution->part_2, 45000, 'part_2');

done_testing();
