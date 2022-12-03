package AoC::Solution::Day3;

use Modern::Perl;

use List::MoreUtils qw(natatime);
use Moo;

use AoC::Solution::Day3::Backpack;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $priority_sum = 0;

    foreach my $backpack (@{ $self->input }) {
        my ($left, $right) = $backpack->compartments;
        foreach my $item (@{ $left->unique_items }) {
            $priority_sum += $self->_priority($item) if $right->contains($item);
        }
    }

    return $priority_sum;
}

sub part_2 {
    my $self = shift;

    my $priority_sum = 0;

    my $it = natatime 3, @{ $self->input };
    while (my @backpacks = $it->()) {
        my %counts;
        foreach my $backpack (@backpacks) {
            foreach my $item (@{ $backpack->unique_items }) {
                $counts{$item}++;
            }
        }
        foreach my $item (keys %counts) {
            $priority_sum += $self->_priority($item) if $counts{$item} == 3;
        }
    }

    return $priority_sum;
}

sub _priority {
    my ($self, $item) = @_;

    return $item =~ /[A-Z]/
        ? ord($item) - 38
        : ord($item) - 96;
}

sub _parse_input {
    my $self = shift;

    my @backpacks;
    foreach my $line (split(/\n/, $self->input)) {
        chomp $line;
        push @backpacks, AoC::Solution::Day3::Backpack->new(
            items => [ split(//, $line) ],
        );
    }
    return \@backpacks;
}

1;
