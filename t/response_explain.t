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

    is( $request->stylesheet(), 'http://www.example.com/style.xsl', 
        'stylesheet()' );

    my $response = SRU::Response->newFromRequest( $request );
    isa_ok( $response, 'SRU::Response::Explain' );
    is( $response->type(), 'explain', 'type()' );

    $response->record(
        SRU::Response::Record->new(
            recordSchema => 'http://explain.z3950.org/dtd/2.0/',
            recordData   => '<foo>bar</foo>'
        )
    );
    my $xml = $response->asXML();
    like( $xml, qr{\Q<?xml-stylesheet type='text/xsl' href="http://www.example.com/style.xsl" ?>\E}, 'found stylsheet in XML' ); 

    ok( wellFormedXML($xml), "asXML()" );
}

MISSING_VERSION: {
    my $url = 'http://myserver.com/myurl?operation=explain&recordPacking=xml&stylesheet=http://www.example.com/style.xsl&extraRequestData=123';

    my $request = SRU::Request->newFromURI( $url );
    isa_ok( $request, 'SRU::Request::Explain' );

    my $response = SRU::Response->newFromRequest( $request );
    isa_ok( $response, 'SRU::Response::Explain' );

    $response->record(
        SRU::Response::Record->new(
            recordSchema => 'http://explain.z3950.org/dtd/2.0/',
            recordData   => '<foo>bar</foo>'
        )
    );

    my $xml = $response->asXML();

    my $diagnostics = $response->diagnostics();
    is( @$diagnostics, 1, 'found 1 diagnostic' );

    is( $diagnostics->[0]->details(), 'version', 'missing version diagnostic' );
    ok( wellFormedXML($xml), "asXML()" );
    print $xml;
}

