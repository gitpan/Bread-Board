package Bread::Board::GraphViz::App;
BEGIN {
  $Bread::Board::GraphViz::App::AUTHORITY = 'cpan:STEVAN';
}
BEGIN {
  $Bread::Board::GraphViz::App::VERSION = '0.24';
}
use Moose;
# ABSTRACT: display a L<Bread::Board>'s dependency graph

use Bread::Board::GraphViz;

with 'MooseX::Runnable';

sub run {
    my ($self, @code) = @_;
    my $board = eval( 'no strict; '. join ' ', @code );
    die if $@;

    if(!blessed $board || !$board->isa('Bread::Board::Container')){
        print {*STDERR} "That code did not evaluate to a Bread::Board::Container.\n";
        return 1;
    }

    my $g = Bread::Board::GraphViz->new;
    $g->add_container($board);
    print $g->graph->as_debug;

    return 0;
}

__PACKAGE__->meta->make_immutable;

no Moose; 1;



=pod

=head1 NAME

Bread::Board::GraphViz::App - display a L<Bread::Board>'s dependency graph

=head1 VERSION

version 0.24

=head1 SYNOPSIS

See L<visualize-breadboard.pl>.

=head1 AUTHOR (actual)

Jonathan Rockway - C<< <jrockway@cpan.org> >>

=head1 BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 AUTHOR

Stevan Little <stevan@iinteractive.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

