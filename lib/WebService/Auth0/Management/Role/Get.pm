package WebService::Auth0::Management::Role::Get;

use Moo::Role;

requires 'GET', 'uri_for';

sub get {
  my ($self, $id) = @_;
  return $self->GET($self->uri_for($id));
}

1;

=head1 NAME

WebService::Auth0::Management::Role::Get - Role that provides a 'get' API method

=head1 SYNOPSIS

    package WebService::Auth0::Management::Users;

    use Moo;
    extends 'WebService::Auth0::Management::Base';

    with 'WebService::Auth0::Management::Role::Get';

    sub path_suffix { 'users' }

    # Other custom methods for the Endpoint

    1;

=head1 DESCRIPTION

Helper role

=head1 METHODS

This class defines the following methods:

=head2 get ($id)

Get an item from the endpoint with the given id.

=head1 SEE ALSO
 
L<WebService::Auth0>, L<https://auth0.com>.
L<WebService::Auth0::Management::Base>

=head1 AUTHOR
 
    See L<WebService::Auth0>
  
=head1 COPYRIGHT & LICENSE
 
    See L<WebService::Auth0>

=cut

1;



