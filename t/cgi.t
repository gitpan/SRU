use strict;
use warnings;
use Test::More qw( no_plan );

## newFromCGI request factory
## we use a mock CGI object since we don't really have a CGI 
## environment.

my $cgi = CGI->new();
isa_ok( $cgi, 'CGI', 'CGI mock object' );

use_ok( 'SRU::Request' );

ok( ! $SRU::Error, 'no error' );
my $request = SRU::Request->newFromCGI( $cgi );

ok( ! $SRU::Error, 'no error' );
isa_ok( $request, 'SRU::Request::Explain' );

## mock CGI object
package CGI;

sub new { return bless {}, 'CGI' }
sub url { return 'http://www.example.com/cgi-bin/sru.cgi?operation=explain&version=1.1'; }

1;
