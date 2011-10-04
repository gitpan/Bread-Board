package Bread::Board::Service::WithClass;
BEGIN {
  $Bread::Board::Service::WithClass::AUTHORITY = 'cpan:STEVAN';
}
{
  $Bread::Board::Service::WithClass::VERSION = '0.22';
}
use Moose::Role;

use Bread::Board::Types;

with 'Bread::Board::Service';

has 'class' => (
    is        => 'rw',
    isa       => 'Str',
    predicate => 'has_class',
);

before 'get' => sub {
    my $self = shift;
    Class::MOP::load_class($self->class)
        if $self->has_class;
};

no Moose::Role; 1;



=pod

=head1 NAME

Bread::Board::Service::WithClass

=head1 VERSION

version 0.22

=head1 DESCRIPTION

=head1 METHODS

=over 4

=item B<class>

=item B<get>

=back

=head1 BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 AUTHOR

Stevan Little E<lt>stevan@iinteractive.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2007-2011 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Stevan Little <stevan@iinteractive.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

