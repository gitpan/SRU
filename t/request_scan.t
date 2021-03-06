use strict;
use warnings;
use Test::More qw( no_plan );
use URI;

use_ok( "SRU::Request" );
use_ok( "SRU::Request::Scan" );
my $url = 'http://myserver.com/myurl?operation=scan&version=1.1&scanClause=%2fdc.title%3d%22cat%22&responsePosition=3&maximumTerms=50&stylesheet=http://myserver.com/myStyle';

CONSTRUCTOR: {
    my $request = SRU::Request::Scan->new(
        base                => 'http://myserver.com/myurl',
        version             => '1.1',
        scanClause          => '/dc.title="cat"',
        responsePosition    => 3,
        maximumTerms        => 50,
        stylesheet          => 'http://myserver.com/myStyle' );
    isa_ok( $request, 'SRU::Request::Scan' );
    is( $request->base(), 'http://myserver.com/myurl', 'base()' );
    is( $request->scanClause(), '/dc.title="cat"', 'scanClause()' );
    is( $request->responsePosition(), 3, 'responsePosition()' );
    is( $request->maximumTerms(), 50, 'maximumTerms()' );
    is( $request->stylesheet(), 'http://myserver.com/myStyle', 'stylesheet()' );
}

FROM_URI: {
    my $uri = URI->new( $url );
    my $request = SRU::Request->newFromURI( $uri );
    isa_ok( $request, 'SRU::Request::Scan' );
    is( $request->base(), 'http://myserver.com/myurl', 'base()' );
    is( $request->scanClause(), '/dc.title="cat"', 'scanClause()' );
    is( $request->responsePosition(), 3, 'responsePosition()' );
    is( $request->maximumTerms(), 50, 'maximumTerms()' );
    is( $request->stylesheet(), 'http://myserver.com/myStyle', 'stylesheet()' );
}

FROM_STRING: {
    my $request = SRU::Request->newFromURI( $url );
    isa_ok( $request, 'SRU::Request::Scan' );
    is( $request->base(), 'http://myserver.com/myurl', 'base()' );
    is( $request->scanClause(), '/dc.title="cat"', 'scanClause()' );
    is( $request->responsePosition(), 3, 'responsePosition()' );
    is( $request->maximumTerms(), 50, 'maximumTerms()' );
    is( $request->stylesheet(), 'http://myserver.com/myStyle', 'stylesheet()' );
}

NO_BASE: {
    ok( ! $SRU::Error, '$SRU::Error undefined' );
    my $request = SRU::Request::Scan->new();
    ok( ! $request, '$request undefined' );
    is( $SRU::Error, 'missing base parameter', 'base error' );
    $SRU::Error = undef;
}

