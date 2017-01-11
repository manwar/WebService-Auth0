package WebService::Auth0::Management::Base;

use Moo;
use URI;
use HTTP::Request::Common ();
use JSON::MaybeXS ();

has domain => (
  is=>'ro',
  required=>1 );

has token => (
  is=>'ro',
  required=>1 );

has ua => (
  is=>'ro',
  required=>1 );

has mgmt_path_parts => (
  is=>'ro',
  required=>1,
  isa=>sub { ref($_) eq 'ARRAY' },
  default=>sub {['api', 'v2']} );

sub request {
  my ($self, $request) = @_;
  $request->push_header(Authorization => "Bearer ${\$self->token}");
  return $self->ua->request($request);
}

sub GET { shift->request(HTTP::Request::Common::GET @_) }
sub POST { shift->request(HTTP::Request::Common::POST @_) }
sub DELETE { shift->request(HTTP::Request::Common::DELETE @_) }
sub PATCH { shift->request(HTTP::Request::Common::request_type_with_data('PATCH', @_)) }

sub encode_json { shift; JSON::MaybeXS::encode_json(shift) }

sub uri_for {
  my $self = shift;
  my @query = ref($_[-1]||'') eq 'ARRAY' ? @{pop(@_)} : ();
  my $uri = URI->new("https://${\$self->domain}/");
  $uri->path_segments(@{$self->mgmt_path_parts}, $self->path_suffix, @_);
  $uri->query_form(@query) if @query;
  return $uri;
}

sub path_suffix { die "Extending class must override" }

=head1 NAME

WebService::Auth0::Management::Base - Base class for the Management API

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

This class defines the following methods:

=head2 request

=head2 GET

=head2 POST

=head2 DELETE

=head2 uri_for

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
