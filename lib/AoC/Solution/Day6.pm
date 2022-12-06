package AoC::Solution::Day6;

use Modern::Perl;

use Moo;

with 'AoC::Solution';

# This is more exciting if you solve it with the following regex:
#
# /(\w)(?!\1)(\w)(?!(?:\1|\2))(\w)(?!(?:\1|\2|\3))(\w)(?!(?:\1|\2|\3|\4))/
sub part_1 {
    my $self = shift;

    return $self->_find_marker(
        $self->input->[0],
        4,
    );
}

# Unfortunately, the regex gets a bit unweildy here, though I was
# tempted to write a method to generate it for us...
sub part_2 {
    my $self = shift;

    return $self->_find_marker(
        $self->input->[0],
        14,
    );
}

sub _find_marker {
    my ($self, $signal, $marker_length) = @_;

    my $offset = $marker_length - 1;
    for (my $idx = $offset; $idx <= length $signal; $idx++) {
        my %chars = map {
            $_ => 1
        } split(//, substr($signal, $idx - $offset, $marker_length));
        return $idx + 1 if keys %chars == $marker_length;
    }

    return;
}

1;
