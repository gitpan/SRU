use strict;
use warnings;
use Test::More tests => 6; 
use CGI;

## flag to CGI::Application so that run() returns output
## rather than printing it.
$ENV{ CGI_APP_RETURN_ONLY } = 1;

INHERITANCE: {
    my $app = MyApp->new();
    isa_ok( $app, 'MyApp' );
    isa_ok( $app, 'CGI::Application' );
}

DEFAULT_RESPONSE: {
    my $app = MyApp->new();
    $app->query( CGI->new() );
    like( $app->run(), qr/<explainResponse>/, 'got default explain response' );
}

EXPLAIN: {
    my $app = MyApp->new();
    $app->query( CGI->new( 'operation=explain' ) );
    like( $app->run(), qr/<explainResponse>/, 'got explain response' );
}

SCAN: {
    my $app = MyApp->new();
    $app->query( CGI->new( 'operation=scan&version=1' ) );
    like( $app->run(), qr/<scanResponse>/, 'got scan response' );
}

SEARCH_RETRIEVE: {
    my $app = MyApp->new();
    $app->query( CGI->new( 'operation=searchRetrieve&version=1' ) );
    like( $app->run(), qr/<searchRetrieveResponse>/,    
        'got searchRetrieve response' );
}

############################
## a harmless SRU::App subclass 

package MyApp;

use base qw( SRU::Application );

sub explain {
}

sub searchRetrieve {
}

sub scan {
}

1;

