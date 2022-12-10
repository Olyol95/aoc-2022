package AoC::Solution::Day7;

use Modern::Perl;

use Const::Fast;
use List::Util qw(sum);
use Moo;

use AoC::Solution::Day7::File;

with 'AoC::Solution';

const my $DISK_SIZE      => 70000000;
const my $SPACE_REQUIRED => 30000000;

sub part_1 {
    my $self = shift;

    my $dirs = $self->_find(
        sub {
            my $file = shift;
            return $file->has_children && $file->total_size <= 100000;
        },
        $self->input,
    );

    return sum map { $_->total_size } @$dirs;
}

sub part_2 {
    my $self = shift;

    my $space_to_free = $SPACE_REQUIRED - ($DISK_SIZE - $self->input->total_size);

    my $dirs = $self->_find(
        sub {
            my $file = shift;
            return $file->has_children && $file->total_size >= $space_to_free;
        },
        $self->input,
    );

    my @sorted = sort { $a->total_size <=> $b->total_size } @$dirs;

    return $sorted[0]->total_size;
}

sub _find {
    my ($self, $condition, $cwd) = @_;

    my @results = $condition->($cwd)
        ? ($cwd)
        : ();

    foreach my $child (@{ $cwd->children }) {
        push @results, @{ $self->_find($condition, $child) };
    }

    return \@results;
}

sub _parse_input {
    my $self = shift;

    my @input = split(/\n/, $self->input);

    my $cwd;
    while (@input) {
        my $command = shift @input;
        if ($command =~ /^\$ cd (.+)/) {
            if ($1 eq '..') {
                $cwd = $cwd->parent;
            }
            else {
                $cwd = $self->_get_or_create_child(
                    $cwd,
                    name => $1,
                );
            }
        }
        elsif ($command =~ /^\$ ls/) {
            while (@input && $input[0] !~ /^\$/) {
                my $result = shift @input;
                if ($result =~ /^dir (.+)/) {
                    $self->_get_or_create_child(
                        $cwd,
                        name => $1,
                    );
                }
                elsif ($result =~ /^(\d+) (.+)/) {
                    $self->_get_or_create_child(
                        $cwd,
                        name => $2,
                        size => $1,
                    );
                }
            }
        }
    }

    while ($cwd->parent) {
        $cwd = $cwd->parent;
    }

    return $cwd;
}

sub _get_or_create_child {
    my ($self, $cwd, %args) = @_;

    my $file = $cwd ? $cwd->get_child($args{name}) : undef;

    unless ($file) {
        $file = AoC::Solution::Day7::File->new(%args);
        $cwd->add_child($file) if $cwd;
    }

    return $file;
}

1;
