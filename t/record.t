use strict;
use warnings;
use Test::More qw( no_plan );
use SRU::Utils::XMLTest;

use_ok( 'SRU::Response::Record' );

BAD_CONSTRUCT: {

    ## missing recordSchema and recordData
    my $r = SRU::Response::Record->new();
    ok( ! $r, 'constructor returned undef on missing param' );
    is( $SRU::Error, 'must supply recordSchema in call to new()', 'error msg' );

    ## missing recordData
    $r = SRU::Response::Record->new( 
        recordSchema => 'info:srw/schema/1/dc-v1.1' );
    ok( ! $r, 'constructor returned undef on missing param' );
    is( $SRU::Error, 'must supply recordData in call to new()', 'error msg' );
}

OK_CONSTRUCT: {

    my $xml = "<title>Huckleberry Finn</title>";
    my $r = SRU::Response::Record->new(
        recordSchema    => 'info:srw/schema/1/dc-v1.1',
        recordData      => $xml
    );

    isa_ok( $r, 'SRU::Response::Record' );
    is( $r->recordData(), $xml, 'recordData()' );
    is( $r->recordSchema(), 'info:srw/schema/1/dc-v1.1', 'recordSchema()' );
    is( $r->recordPacking(), 'xml', 'default recordPacking is xml' );
    
    $xml = $r->asXML();
    ok( wellFormedXML($xml), 'asXML() well formed' );
    
}

