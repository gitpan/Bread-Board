package Bread::Board::Service::WithDependencies;
BEGIN {
  $Bread::Board::Service::WithDependencies::AUTHORITY = 'cpan:STEVAN';
}
$Bread::Board::Service::WithDependencies::VERSION = '0.32';
use Moose::Role;

use Try::Tiny;

use Bread::Board::Types;
use Bread::Board::Service::Deferred;
use Bread::Board::Service::Deferred::Thunk;

with 'Bread::Board::Service';

has 'dependencies' => (
    traits    => [ 'Hash', 'Clone' ],
    is        => 'rw',
    isa       => 'Bread::Board::Service::Dependencies',
    lazy      => 1,
    coerce    => 1,
    default   => sub { +{} },
    trigger   => sub {
        my $self = shift;
        $_->parent($self) foreach values %{$self->dependencies};
    },
    handles  => {
        'add_dependency'       => 'set',
        'get_dependency'       => 'get',
        'has_dependency'       => 'exists',
        'has_dependencies'     => 'count',
        'get_all_dependencies' => 'kv',
    }
);

around 'init_params' => sub {
    my $next = shift;
    my $self = shift;
    +{ %{ $self->$next() }, $self->resolve_dependencies }
};

after 'get' => sub { (shift)->clear_params };

sub resolve_dependencies {
    my $self = shift;
    my %deps;
    if ($self->has_dependencies) {
        foreach my $dep ($self->get_all_dependencies) {
            my ($key, $dependency) = @$dep;

            my $service = $dependency->service;

            # NOTE:
            # this is what checks for
            # circular dependencies
            if ($service->is_locked) {

                confess "You cannot defer a parameterized service"
                    if $service->does('Bread::Board::Service::WithParameters')
                    && $service->has_parameters;

                $deps{$key} = Bread::Board::Service::Deferred->new(service => $service);
            }
            else {
                # since we can't pass in parameters here,
                # we return a deferred thunk and you can do
                # with it what you will.
                if (
                    $service->does('Bread::Board::Service::WithParameters')
                    &&
                    $service->has_required_parameters
                    &&
                    (not $service->has_parameter_defaults)
                    &&
                    (not $dependency->has_service_params)
                   ) {
                    $deps{$key} = Bread::Board::Service::Deferred::Thunk->new(
                        thunk => sub {
                            my %params = @_;
                            $service->lock;
                            return try { $service->get( %params ) }
                               finally { $service->unlock }
                                 catch { die $_ }
                        }
                    );
                }
                else {
                    $service->lock;
                    try {
                        $deps{$key} = $dependency->has_service_params
                            ? $service->get( %{ $dependency->service_params })
                            : $service->get;
                    } finally {
                        $service->unlock
                    } catch {
                        die $_
                    };
                }
            }
        }
    }
    return %deps;
}

no Moose::Role; 1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Bread::Board::Service::WithDependencies

=head1 VERSION

version 0.32

=head1 DESCRIPTION

=head1 METHODS

=over 4

=item B<init_params>

=item B<resolve_dependencies>

=item B<dependencies>

=item B<add_dependency>

=item B<get_dependency>

=item B<has_dependency>

=item B<has_dependencies>

=item B<get_all_dependencies>

=back

=head1 BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 AUTHOR

Stevan Little <stevan@iinteractive.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
