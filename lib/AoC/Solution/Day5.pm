package AoC::Solution::Day5;

use Modern::Perl;

use Moo;

with 'AoC::Solution';

has instructions => (
    is => 'lazy',
);

sub part_1 {
    my $self = shift;

    my $stacks = $self->stacks;

    foreach my $instr (@{ $self->instructions }) {
        for (1..$instr->{amount}) {
            my $crate = pop @{ $stacks->[$instr->{from}] };
            push @{ $stacks->[$instr->{to}] }, $crate;
        }
    }

    return join('', map { pop @$_ } @$stacks);
}

sub part_2 {
    my $self = shift;

    my $stacks = $self->stacks;

    foreach my $instr (@{ $self->instructions }) {
        my @crates;
        for (1..$instr->{amount}) {
            my $crate = pop @{ $stacks->[$instr->{from}] };
            unshift @crates, $crate;
        }
        push @{ $stacks->[$instr->{to}] }, @crates;
    }

    return join('', map { pop @$_ } @$stacks);
}

sub stacks {
    my $self = shift;

    my @stacks;
    foreach my $line (@{ $self->input }) {
        my $idx = 0;
        foreach my $crate ($line =~ /(\[[A-Z]\]|\s{3})\s?/g) {
            $crate =~ s/^\s+|\s+|\[|\]$//g if $crate;
            unshift @{ $stacks[$idx] }, $crate if $crate;
            $idx++;
        }
    }

    return \@stacks;
}

sub _build_instructions {
    my $self = shift;

    my @instructions;
    foreach my $line (@{ $self->input }) {
        next unless ($line =~ /move (\d+) from (\d+) to (\d+)/);
        push @instructions, {
            amount => $1,
            from   => $2 - 1,
            to     => $3 - 1,
        };
    }

    return \@instructions;
}

1;
