package AoC::Solution::Day10;

use Modern::Perl;

use Moo;

use AoC::Solution::Day10::CPU;
use AoC::Solution::Day10::Instruction::AddX;
use AoC::Solution::Day10::Instruction::NoOp;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $cpu = AoC::Solution::Day10::CPU->new(
        instructions => $self->input,
    );

    my $sum = 0;
    while ($cpu->is_running) {
        my $cycle = $cpu->cycle + 1;
        if ($cycle == 20 || ($cycle - 20) % 40 == 0) {
            $sum += $cycle * $cpu->register;
        }
        $cpu->tick;
    }

    return $sum;
}

sub part_2 {
    my $self = shift;

    my $cpu = AoC::Solution::Day10::CPU->new(
        instructions => $self->input,
    );

    my @image;
    while ($cpu->is_running) {
        my $y_pos = int ($cpu->cycle / 40);
        my $x_pos = $cpu->cycle % 40;
        my $pixel = ($cpu->register >= $x_pos - 1 && $cpu->register <= $x_pos + 1)
            ? '#'
            : '.';
        push @{ $image[$y_pos] }, $pixel;
        $cpu->tick;
    }

    return "\n" . join("\n", map { join('', @{ $_ }) } @image);
}

sub _parse_input {
    my $self = shift;

    my @instructions;
    foreach my $line (split(/\n/, $self->input)) {
        if ($line =~ /addx (.+)/) {
            push @instructions, AoC::Solution::Day10::Instruction::AddX->new(
                value => $1,
            );
        }
        else {
            push @instructions, AoC::Solution::Day10::Instruction::NoOp->new;
        }
    }

    return \@instructions;
}

1;
