use strict;
use warnings;
use Test::More qw( no_plan );
use URI;

use_ok( 'SRU::Request::SearchRetrieve' );

my $url = 'http://myserver.com/myurl?operation=searchRetrieve&version=1.1&query=dc.identifier+%3d%220-8212-1623-6%22&recordSchema=dc&recordPacking=XML&stylesheet=http://myserver.com/myStyle';

CONSTRUCTOR: {
    my $request = SRU::Request::SearchRetrieve->new(
        base            => 'http://myserver.com/myurl',
        version         => '1.1',
        query           => 'dc.identifier ="0-8212-1623-6"',
        recordSchema    => 'dc',
        recordPacking   => 'XML',
        stylesheet      => 'http://myserver.com/myStyle' );
    is( $request->base(), 'http://myserver.com/myurl', 'base()' );
    is( $request->version(), '1.1', 'version()' );
    is( $request->query(), 'dc.identifier ="0-8212-1623-6"', 'query()' );
    is( $request->recordSchema(), 'dc', 'recordSchema()' );
    is( $request->recordPacking(), 'XML', 'recordPacking()' );
    is( $request->stylesheet(), 'http://myserver.com/myStyle', 'stylesheet()' );
}

FROM_URI: {
    my $uri = URI->new( $url );
    my $request = SRU::Request->newFromURI( $uri );
    isa_ok( $request, 'SRU::Request::SearchRetrieve' );
    is( $request->base(), 'http://myserver.com/myurl', 'base()' );
    is( $request->version(), '1.1', 'version()' );
    is( $request->query(), 'dc.identifier ="0-8212-1623-6"', 'query()' );
    is( $request->recordSchema(), 'dc', 'recordSchema()' );
    is( $request->recordPacking(), 'XML', 'recordPacking()' );
    is( $request->stylesheet(), 'http://myserver.com/myStyle', 'stylesheet()' );
}

FROM_STRING: {
    my $request = SRU::Request->newFromURI( $url );
    isa_ok( $request, 'SRU::Request::SearchRetrieve' );
    is( $request->base(), 'http://myserver.com/myurl', 'base()' );
    is( $request->version(), '1.1', 'version()' );
    is( $request->query(), 'dc.identifier ="0-8212-1623-6"', 'query()' );
    is( $request->recordSchema(), 'dc', 'recordSchema()' );
    is( $request->recordPacking(), 'XML', 'recordPacking()' );
    is( $request->stylesheet(), 'http://myserver.com/myStyle', 'stylesheet()' );
}

