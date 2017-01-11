use Test::Most;
use WebService::Auth0;
use Devel::Dwarn;

ok my $auth0 = WebService::Auth0->new(
  domain => $ENV{AUTH0_DOMAIN},
  client_id => $ENV{AUTH0_CLIENT_ID},
  client_secret => $ENV{AUTH0_CLIENT_SECRET},
);

{
  ok my $f = $auth0->login_social(
    redirect_uri=>'http://localhost:5000/auth0/callback',
    connection=>'google-oauth2',
    response_type=>'code');

  my ($location) = $f->catch(sub {
    use Devel::Dwarn; Dwarn @_;
    fail "Don't expect and error here and now";
  })->get;
  warn $location;
}

{
  ok my $f = $auth0->authorize_code_grant(
    redirect_uri=>'http://localhost:5000/auth0/callback',
    audience=>'facebook.com',
    response_type=>'code');

  my ($location, $res) = $f->catch(sub {
    fail "Don't expect and error here and now";
  })->get;
  warn $location;
  Dwarn $res;
}

done_testing;

__END__

AUTH0_CLIENT_SECRET=z6b4FiMxHJtua1_3yO9zDIvQBBM_xWAZeYZOj2e5z5x5uA-_egHjZBOpDUoR54BI AUTH0_CLIENT_ID=1zKhEBtDdR24mWPGs4pKOTtks4nlaHLF AUTH0_DOMAIN=jjn1056.auth0.com
