use Test::Most;
use WebService::Auth0::UA;
use WebService::Auth0::Authentication::Login;

plan skip_all => 'Missing AUTH0_DOMAIN and AUTH0_CLIENT_ID'
 unless $ENV{AUTH0_DOMAIN} and $ENV{AUTH0_CLIENT_ID};

ok my $ua = WebService::Auth0::UA->create;
ok my $login = WebService::Auth0::Authentication::Login->new(
  ua => $ua,
  domain => $ENV{AUTH0_DOMAIN},
  client_id => $ENV{AUTH0_CLIENT_ID} );

{
  ok my $f = $login->authorize({
    redirect_uri=>'http://localhost:5000/auth0/callback',
    connection=>'google-oauth2',
    response_type=>'code'});

  my ($location) = $f->catch(sub {
    use Devel::Dwarn; Dwarn @_;
    fail "Don't expect and error here and now";
  })->get;

  ok $location;
  warn $location;
}

{
  ok my $f = $login->active_authorize({
    username => 'jjn1056@gmail.com',
    password => 'green59gorden',
    connection => 'facebook',
    grant_type => 'password'});

  my ($data) = $f->catch(sub {
    use Devel::Dwarn; Dwarn @_;
    fail "Don't expect and error here and now";
  })->get;

  use Devel::Dwarn; Dwarn $data;
}

done_testing;
