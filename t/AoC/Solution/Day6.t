#!/usr/bin/env perl

use Modern::Perl;

use Test::More;

use AoC::Solution::Day6;

my @tests = (
    {
        input  => 'mjqjpqmgbljsphdztnvjfqwrcgsmlb',
        part_1 => 7,
        part_2 => 19,
    },
    {
        input  => 'bvwbjplbgvbhsrlpgdmjqwftvncz',
        part_1 => 5,
        part_2 => 23,
    },
    {
        input  => 'nppdvjthqldpwncqszvftbrmjlhg',
        part_1 => 6,
        part_2 => 23,
    },
    {
        input  => 'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg',
        part_1 => 10,
        part_2 => 29,
    },
    {
        input  => 'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw',
        part_1 => 11,
        part_2 => 26,
    },
);

foreach my $test (@tests) {
    my $solution = AoC::Solution::Day6->new(
        input => $test->{input},
    );
    is($solution->part_1, $test->{part_1}, "part_1.$test->{input}");
    is($solution->part_2, $test->{part_2}, "part_2.$test->{input}");
}

done_testing();
