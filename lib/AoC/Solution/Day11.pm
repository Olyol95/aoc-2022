package AoC::Solution::Day11;

use Modern::Perl;

use List::Util qw(product);
use Moo;

use AoC::Solution::Day11::Monkey;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    return $self->_calculate_monkey_business(
        20, sub {
            my $worry = shift;
            return int($worry / 3);
        }
    );
}

sub part_2 {
    my $self = shift;

    my $lcm = product map { $_->divisor } @{ $self->_monkeys };

    return $self->_calculate_monkey_business(
        10000, sub {
            my $worry = shift;
            return $worry % $lcm;
        }
    );
}

sub _calculate_monkey_business {
    my ($self, $rounds, $mutator) = @_;

    my $monkeys = $self->_monkeys;

    my %inspections;
    for (1..$rounds) {
        foreach my $monkey (@$monkeys) {
            while (@{ $monkey->items }) {
                my $worry = shift @{ $monkey->items };
                $worry = $monkey->operation->($worry);
                $worry = $mutator->($worry);
                if ($worry % $monkey->divisor == 0) {
                    push @{ $monkeys->[$monkey->pass_branch]->items }, $worry;
                }
                else {
                    push @{ $monkeys->[$monkey->fail_branch]->items }, $worry;
                }
                $inspections{$monkey->id}++;
            }
        }
    }

    my @sorted = sort { $b <=> $a } values %inspections;

    return $sorted[0] * $sorted[1];
}

sub _parse_input {
    my $self = shift;

    return $self->input;
}

sub _monkeys {
    my $self = shift;

    my @monkeys;

    my @config = split(/\n\n/, $self->input);
    foreach my $conf (@config) {
        my %args;
        if ($conf =~ /Monkey (\d+):/) {
            $args{id} = $1;
        }
        if ($conf =~ /Starting items: ([\d\s,]+)/) {
            $args{items} = [ split(/, /, $1) ];
        }
        if ($conf =~ /Operation: new = old ([+*]) (\d+)/) {
            my $value = $2;
            if ($1 eq '+') {
                $args{operation} = sub {
                    my $worry = shift;
                    return $worry + $value;
                };
            }
            else {
                $args{operation} = sub {
                    my $worry = shift;
                    return $worry * $value;
                };
            }
        }
        if ($conf =~ /Operation: new = old [*] old/) {
            $args{operation} = sub {
                my $worry = shift;
                return $worry * $worry;
            };
        }
        if ($conf =~ /Test: divisible by (\d+)/) {
            my $value = $1;
            $args{divisor} = $1;
        }
        if ($conf =~ /If true: throw to monkey (\d+)/) {
            $args{pass_branch} = $1;
        }
        if ($conf =~ /If false: throw to monkey (\d+)/) {
            $args{fail_branch} = $1;
        }
        $monkeys[$args{id}] = AoC::Solution::Day11::Monkey->new(%args);
    }

    return \@monkeys;
}

1;
