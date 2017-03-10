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
  client_secret => $ENV{AUTH0_SECRET},
  client_id => $ENV{AUTH0_CLIENT_ID} );

my $app = sub {
  my $req = Plack::Request->new(shift);
  if($req->path_info eq '/auth0/callback') {
    my ($user_info) = $login->get_token({
      code=>$req->param('code'),
      grant_type=>'authorization_code',
      redirect_uri=>'http://localhost:5000/auth0/callback'
    })->catch(sub {
      die "Don't expect and error here and now";
    })->then(sub {
      my $token = shift;
      my $future = $login->userinfo({
        access_token => $token->{access_token},
      })->catch(sub {
        die "Don't expect and error here and now";
      });
    })->get;
    return [
      200,
      ['Content-Type' => 'application/json'],
      [encode_json ($user_info)]
    ];
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


