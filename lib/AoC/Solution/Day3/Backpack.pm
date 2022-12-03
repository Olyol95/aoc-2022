package AoC::Solution::Day3::Backpack;

use Modern::Perl;

use List::MoreUtils qw(uniq);
use Moo;

has items => (
    is       => 'ro',
    required => 1,
);

sub compartments {
    my $self = shift;

    my @items = @{ $self->items };
    return (
        AoC::Solution::Day3::Backpack->new(
            items => [ splice(@items, 0, @items / 2) ],
        ),
        AoC::Solution::Day3::Backpack->new(
            items => [ @items ],
        ),
    );
}

sub contains {
    my ($self, $item) = @_;

    return (grep { $_ eq $item } @{ $self->items }) ? 1 : 0;
}

sub unique_items {
    my $self = shift;

    return [ uniq @{ $self->items } ];
}

1;
