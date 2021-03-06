use strict;
use warnings;
use Test::More qw( no_plan );
use URI;
use SRU::Utils::XMLTest qw( wellFormedXML ); 

use_ok( 'SRU::Request::Explain' );
use_ok( 'SRU::Response' );

OK: {
    my $url = 'http://myserver.com/myurl?operation=explain&version=1.0&recordPacking=xml&stylesheet=http://www.example.com/style.xsl&extraRequestData=123';

    my $request = SRU::Request->newFromURI( $url );
    isa_ok( $request, 'SRU::Request::Explain' );

    my $response = SRU::Response->newFromRequest( $request );
    isa_ok( $response, 'SRU::Response::Explain' );
    is( $response->type(), 'explain', 'type()' );

    $response->record( "<foo>bar</foo>" );
    my $xml = $response->asXML();

    ok( wellFormedXML($xml), "asXML()" );
}

MISSING_VERSION: {
    my $url = 'http://myserver.com/myurl?operation=explain&recordPacking=xml&stylesheet=http://www.example.com/style.xsl&extraRequestData=123';

    my $request = SRU::Request->newFromURI( $url );
    isa_ok( $request, 'SRU::Request::Explain' );

    my $response = SRU::Response->newFromRequest( $request );
    isa_ok( $response, 'SRU::Response::Explain' );

    $response->record( "<foo>bar</foo>" );
    my $xml = $response->asXML();

    my $diagnostics = $response->diagnostics();
    is( @$diagnostics, 1, 'found 1 diagnostic' );

    is( $diagnostics->[0]->details(), 'version', 'missing version diagnostic' );
    ok( wellFormedXML($xml), "asXML()" );
}

