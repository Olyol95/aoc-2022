#!/usr/bin/env perl

use Modern::Perl;

use Test::More;

use AoC::Solution::Day5;

my $solution = AoC::Solution::Day5->new(
    input => join("\n",
        '    [D]    ',
        '[N] [C]    ',
        '[Z] [M] [P]',
        ' 1   2   3 ',
        '',
        'move 1 from 2 to 1',
        'move 3 from 1 to 3',
        'move 2 from 2 to 1',
        'move 1 from 1 to 2',
    ),
);

is($solution->part_1, 'CMZ', 'part_1');
is($solution->part_2, 'MCD', 'part_2');

done_testing();
