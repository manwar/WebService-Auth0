package WebService::Auth0::Management::Template;

use Moo;

extends 'WebService::Auth0::Management::Base';
with 'WebService::Auth0::Management::Role::All',
  'WebService::Auth0::Management::Role::Search',
  'WebService::Auth0::Management::Role::Create',
  'WebService::Auth0::Management::Role::Get',
  'WebService::Auth0::Management::Role::Update',
  'WebService::Auth0::Management::Role::Delete'; # You might not need all of these

sub path_suffix { 'template' }  # You need to override this

=head1 NAME

WebService::Auth0::Management::Template - Example Template for writing endpoints

=head1 SYNOPSIS

    NA

=head1 DESCRIPTION

    You can copy this template for making new management endpoints to help
    you get rolling faster.

=head1 METHODS

This class defines the following methods:

=head2 all

=head2 search (\%params)

=head2 create (\%params)

=head2 get ($id)

=head2 delete ($id)

=head2 update ($id, \%params)

=head1 SEE ALSO
 
L<WebService::Auth0>, L<WebService::Auth0::Management::Base>,
L<WebService::Auth0::Management::Role::All>,
L<WebService::Auth0::Management::Role::Search>,
L<WebService::Auth0::Management::Role::Create>,
L<WebService::Auth0::Management::Role::Get>,
L<WebService::Auth0::Management::Role::Update>,
L<WebService::Auth0::Management::Role::Delete>,
L<https://auth0.com>.

=head1 AUTHOR
 
    See L<WebService::Auth0>
  
=head1 COPYRIGHT & LICENSE
 
    See L<WebService::Auth0>

=cut

1;
