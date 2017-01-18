use Test::Most;
use WebService::Auth0::UA;
use WebService::Auth0::Management::DeviceCredentials;

plan skip_all => 'Missing AUTH0_DOMAIN and AUTH0_TOKEN'
 unless $ENV{AUTH0_DOMAIN} and $ENV{AUTH0_TOKEN};

ok my $ua = WebService::Auth0::UA->create;
ok my $dcreds = WebService::Auth0::Management::DeviceCredentials->new(
  ua => $ua,
  domain => $ENV{AUTH0_DOMAIN},
  token => '' );

use Devel::Dwarn;

{
  ok my $f = $dcreds->all();
  ok my ($data) = $f->catch(sub {
    fail "Don't expect an error here and now";
    Dwarn @_;
  })->get;

  Dwarn $data;

  is @$data, 0, 'correct number of not founds';
}

done_testing;
