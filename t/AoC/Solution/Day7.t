#!/usr/bin/env perl

use Modern::Perl;

use Test::More;

use AoC::Solution::Day7;

my $solution = AoC::Solution::Day7->new(
    input => join("\n", (
        '$ cd /',
        '$ ls',
        'dir a',
        '14848514 b.txt',
        '8504156 c.dat',
        'dir d',
        '$ cd a',
        '$ ls',
        'dir e',
        '29116 f',
        '2557 g',
        '62596 h.lst',
        '$ cd e',
        '$ ls',
        '584 i',
        '$ cd ..',
        '$ cd ..',
        '$ cd d',
        '$ ls',
        '4060174 j',
        '8033020 d.log',
        '5626152 d.ext',
        '7214296 k',
    )),
);

is($solution->part_1, 95437, 'part_1');
is($solution->part_2, 24933642, 'part_2');

done_testing();
