use strict;
use warnings;
use Test::More qw( no_plan );
use URI;

use_ok( 'SRU::Request::Explain' );

my $url = 'http://myserver.com/myurl?operation=explain&version=1.0&recordPacking=xml&stylesheet=http://www.example.com/style.xsl&extraRequestData=123';

CONSTRUCTOR: {
    my $request = SRU::Request::Explain->new(
        base            => 'http://myserver.com/myurl',
        version         => '1.0',
        recordPacking   => 'xml',
        stylesheet      => 'http://www.example.com/style.xsl' );
    is( $request->version(), '1.0', 'version()' );
    is( $request->recordPacking(), 'xml', 'recordPacking()' );
    is( $request->stylesheet(), 'http://www.example.com/style.xsl',
        'stylesheet()');
    is( $request->base(), 'http://myserver.com/myurl', 'base()' );
}

FROM_URI: {
    my $uri = URI->new( $url );
    my $request = SRU::Request->newFromURI( $uri );
    is( $request->version(), '1.0', 'version()' );
    is( $request->recordPacking(), 'xml', 'recordPacking()' );
    is( $request->stylesheet(), 'http://www.example.com/style.xsl',
        'stylesheet()');
    is( $request->base(), 'http://myserver.com/myurl', 'base()' );
}

FROM_STRING: {
    my $request = SRU::Request->newFromURI( $url );
    is( $request->version(), '1.0', 'version()' );
    is( $request->recordPacking(), 'xml', 'recordPacking()' );
    is( $request->stylesheet(), 'http://www.example.com/style.xsl',
        'stylesheet()');
    is( $request->base(), 'http://myserver.com/myurl', 'base()' );
}

NO_BASE: {
    ok( ! $SRU::Error, '$SRU::Error not populated' );
    my $request = SRU::Request::Explain->new();
    ok( ! $request, 'new() returned undef' );
    is( $SRU::Error, 'missing base parameter', 'base error' );
}



