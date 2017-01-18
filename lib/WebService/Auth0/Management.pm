package WebService::Auth0::Management;

use Moo;
use Module::Runtime qw(use_module);

has domain => (
  is=>'ro',
  required=>1 );

has token => (
  is=>'ro',
  required=>1 );

has ua => (
  is=>'lazy',
  required=>1 );

  sub _build_ua {
    return use_module('WebService::Auth0::UA')->create;
  }

has mgmt_path_parts => (
  is=>'ro',
  required=>1,
  isa=>sub { ref($_) eq 'ARRAY' },
  default=>sub {['api', 'v2']} );

sub create {
  my ($self, $module, $args) = @_;
  return use_module(ref($self)."::$module")->new(
    domain => $self->domain,
    token => $self->token,
    ua => $self->ua,
    %{$args||+{}},
  );
}


=head1 NAME

WebService::Auth0::Management - Factory class for the Management API

=head1 SYNOPSIS

    my $mgmt = WebService::Auth0::Management->new(
      ua => $ua,
      domain => $ENV{AUTH0_DOMAIN},
      token => $ENV{AUTH0_TOKEN},
    );

    my $rules = $mgmt->create('Rules');
    my $future = $rules->get;

=head1 DESCRIPTION

Factory class for the various modules that make up the Management API.
I'm actually not keen on this approach but it seems like the way that
Auth0 did all the SDKs in other languages so I figured its probably
best to play to the standard.

You can also create each Management module standalone.

=head1 METHODS

This class defines the following methods:

=head2 create ($module, \%args)

    my $rules = $mgmt->create('Rules');

Create a module based on the current arguments.  You may pass in override
arguments as the second argument of this method.

=head1 ATTRIBUTES

This class defines the following attributes:

=head2 domain

=head2 token

=head2 ua

=head2 mgmt_path_parts

=head1 SEE ALSO
 
L<WebService::Auth0>, L<https://auth0.com>.

=head1 AUTHOR
 
    See L<WebService::Auth0>
  
=head1 COPYRIGHT & LICENSE
 
    See L<WebService::Auth0>

=cut

1;
