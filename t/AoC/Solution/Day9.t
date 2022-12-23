#!/usr/bin/env perl

use Modern::Perl;

use Test::More;

use AoC::Solution::Day9;

subtest part_1 => sub {
    my $solution = AoC::Solution::Day9->new(
        input => join("\n", (
            'R 4',
            'U 4',
            'L 3',
            'D 1',
            'R 4',
            'D 1',
            'L 5',
            'R 2',
        ))
    );
    is($solution->part_1, 13, 'part_1');
};

subtest part_2 => sub {
    my $solution = AoC::Solution::Day9->new(
        input => join("\n", (
            'R 5',
            'U 8',
            'L 8',
            'D 3',
            'R 17',
            'D 10',
            'L 25',
            'U 20',
        ))
    );
    is($solution->part_2, 36, 'part_2');
};

done_testing();
