use Test::Most;
use WebService::Auth0::UA;
use Devel::Dwarn;

ok my $lwp = WebService::Auth0::UA->create('LWP');

done_testing;


