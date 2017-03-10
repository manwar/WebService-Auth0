use warnings;
use strict;
use WebService::Auth0::UA;
use WebService::Auth0::Authentication;
use Plack::Request;
use JSON::PP;

my $ua = WebService::Auth0::UA->create;
my $login = WebService::Auth0::Authentication->new(
  ua => $ua,
  domain => 'jjn1056.auth0.com',
  client_secret => 'z6b4FiMxHJtua1_3yO9zDIvQBBM_xWAZeYZOj2e5z5x5uA-_egHjZBOpDUoR54BI',
  client_id => '1zKhEBtDdR24mWPGs4pKOTtks4nlaHLF' );

my $app = sub {
  my $env = shift;
  if($env->{PATH_INFO} eq '/auth0/callback') {
    my $req = Plack::Request->new($env);
    my $future = $login->get_token({
      code=>$req->param('code'),
      grant_type=>'authorization_code',
      redirect_uri=>'http://localhost:5000/auth0/callback'
    });
    my ($token) = $future->catch(sub {
      die "Don't expect and error here and now";
    })->get;

    {
      my $future = $login->userinfo({
        access_token => $token->{access_token}
      });
      my ($user_info) = $future->catch(sub {
        die "Don't expect and error here and now";
      })->get;
      return [
        200,
        ['Content-Type' => 'application/json'],
        [encode_json ($user_info)]
      ];
    }
  } else {
    my $future = $login->authorize({
      redirect_uri=>'http://localhost:5000/auth0/callback',
      connection=>'google-oauth2',
      response_type=>'code'});

    my ($location) = $future->catch(sub {
      die "Don't expect and error here and now";
    })->get;

    if($location) {
      return [
        302,
        ['Location' => $location],
        ["Redirecting to $location"]
      ];
    } else {
      return [
        200,
        ['Content-Type' => 'text/plain'],
        ['Hello World']
      ];
    }
  }
};


