package WebService::Auth0;

use Moo;
use URI;
use Module::Runtime qw(use_module);
use HTTP::Request::Common;
use Params::Validate;

our $VERSION = '0.001';

has timeout => (is=>'ro', required=>1, default=>10);

has ua_handler_class => (
  is=>'ro',
  required=>1,
  default=>'WebService::Auth0::UA::LWP');

has ua_handler_options => (
  is=>'ro',
  required=>1,
  default=>sub { +{} });

has ua => (
  is=>'bare',
  init_arg=>undef,
  lazy=>1,
  required=>1,
  handles=>['request'],
  default=>sub {
    use_module($_[0]->ua_handler_class)->new(
      timeout=>$_[0]->timeout,
      %{$_[0]->ua_handler_options});
  });

has domain => (
  is=>'ro',
  required=>1 );

has client_id => (is=>'ro', predicate=>'has_client_id');
has client_secret => (is=>'ro', predicate=>'has_client_secret');

sub auth {
  my $self = shift;
  my %args = $_[0] ? ((ref($_[0])||'') eq 'HASH' ? %$_[0] : @_) : ();

  %args = (
    ua => $self->ua,
    domain => $self->domain,
    client_id => $self->client_id,
    %args,
  );

  $args{client_secret} = $self->client_secret
    if $self->has_client_secret;

  return use_module('WebService::Auth0::Authentication')
    ->new(%args);
}



=head1 NAME


        ua => $ua,
      domain => $ENV{AUTH0_DOMAIN},
      client_id => $ENV{AUTH0_CLIENT_ID} 
WebService::Auth0 - Access the Auth0 API

=head1 SYNOPSIS

    use WebService::Auth0;
    my $auth0 = WebService::Auth0->new(
      domain => 'my-domain',
      client_id => 'my-client_id',
      client_secret => 'my-client_secrete');

    $auth0->...

=head1 DESCRIPTION

Prototype for a web service client for L<https://auth0.com>.  This is probably
going to change a lot as I learn how it actually works.  I wrote this
primarily as I was doing L<Catalyst::Authentication::Credential::Auth0>
since it seemed silly to stick web service client stuff directly into
the Catalyst authorization credential class.  Hopefully this will
eventually evolve into a true stand alone distribution.  If you use this
directly please be aware I reserve the right to change it from release
to release as needed.

=head1 METHODS

This class defines the following methods:

=head1 SEE ALSO
 
L<https://auth0.com>.

=head1 AUTHOR
 
    John Napiorkowski L<email:jjnapiork@cpan.org>
  
=head1 COPYRIGHT & LICENSE
 
Copyright 2017, John Napiorkowski L<email:jjnapiork@cpan.org>
 
This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;
