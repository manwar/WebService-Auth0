package WebService::Auth0::UA;

use Moo;
use Module::Pluggable::Object;
use Module::Runtime qw(use_module);

has 'search_extra_namespaces' => (is=>'ro');
has 'default_agent_type' => (is=>'ro', required=>1, default=>'LWP');
has 'agent_types' => (
  is=>'ro',
  init_arg=>undef,
  required=>1,
  lazy=>1,
  builder=>'_build_agent_types');
 
  sub _build_agent_types {
    my @agents = Module::Pluggable::Object->new(
      require => 1,
      search_path => [ ref($_[0]), @{$_[0]->search_extra_namespaces||[]} ],
    )->plugins;
    return \@agents;
  }

sub normalize_self { ref $_[0] ? $_[0] : $_[0]->new }
sub normalize_type { $_[1]=~m/\:\:/ ? $_[1] : ref($_[0])."::$_[1]" }
sub type_is_allowed { grep { $_ eq $_[1] } @{$_[0]->agent_types} }
sub build_type {
  my ($self, $type, %options) = @_;
  return use_module($type)->new(options=>\%options);
}

sub create {
  my $self = shift->normalize_self;
  my $type = $self->normalize_type(shift||$self->default_agent_type);
  die "'$type' is not an allowed agent type"
    unless $self->type_is_allowed($type);
  return $self->build_type($type, @_);
}

=head1 NAME

WebService::Auth0::UA - User agent factory

=head1 SYNOPSIS

For internal use

=head1 DESCRIPTION

Used to choose one of the user agent types depending on if you have an
event loop or not.

=head1 SEE ALSO
 
L<WebService::Auth0>, L<Module::Pluggable::Object>

=head1 AUTHOR
 
    See L<WebService::Auth0>
  
=head1 COPYRIGHT & LICENSE
 
    See L<WebService::Auth0>

=cut

1;
