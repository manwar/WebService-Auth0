package WebService::Auth0::Management::Users;

use Moo;
extends 'WebService::Auth0::Management::Base';

sub path_suffix { 'users' }

sub search {
  my ($self, @params) = @_;
  die "Can't search without query (maybe use 'get_all'?)" unless @params;
  return $self->GET($self->uri_for(\@params));
}

sub get_all {
  my ($self) = @_;
  return $self->GET($self->uri_for());
}

sub get {
  my ($self, $user_id) = @_;
  return $self->GET($self->uri_for($user_id))
}

sub update {
  my ($self, $user_id, $data) = @_;
  return $self->PATCH(
    $self->uri_for($user_id), 
    'content-type' => 'application/json',
    Content => $self->encode_json($data) );
}

sub update_user_metadata {
  my ($self, $user_id, $data) = @_;
  return $self->update($user_id, +{user_metadata=>$data});
}

sub update_app_metadata {
  my ($self, $user_id, $data) = @_;
  return $self->update($user_id, +{app_metadata=>$data});
}

sub create {
  my ($self, $data) = @_;
  return $self->POST(
    $self->uri_for(), 
    'content-type' => 'application/json',
    Content => $self->encode_json($data) );
}

sub delete {
  my ($self, $user_id) = @_;
  return $self->DELETE($self->uri_for($user_id))
}

sub delete {
  my ($self, $user_id) = @_;
  return $self->DELETE($self->uri_for())
}

sub link_account {
  my ($self, $user_id, $data) = @_;
  return $self->POST(
    $self->uri_for($user_id), 
    'content-type' => 'application/json',
    Content => $self->encode_json($data) );
}

sub unlink_account {
  my ($self, $user_id, $provider, $identity_id) = @_;
  my $uri = $self->uri_for($user_id,'identities', $provider, $identity_id);
  return $self->DELETE($uri);
}

=head1 NAME

WebService::Auth0::Management::Users - Users management API

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

This class defines the following methods:

=head2 search

=head2 get

=head1 SEE ALSO
 
L<WebService::Auth0>, L<https://auth0.com>.

=head1 AUTHOR
 
    See L<WebService::Auth0>
  
=head1 COPYRIGHT & LICENSE
 
    See L<WebService::Auth0>

=cut

1;
