package SRU::Request;

use strict;
use warnings;
use URI;
use SRU::Request::Explain;
use SRU::Request::SearchRetrieve;
use SRU::Request::Scan;
use SRU::Utils qw( error );

=head1 NAME

SRU::Request - Factories for creating SRU request objects. 

=head1 SYNOPSIS

    use SRU::Request;
    my $request = SRU::Request->newFromURI( $uri );

=head1 DESCRIPTION

SRU::Request allows you to create the appropriate SRU request object
from a URI object. This allows you to pass in a URI and get back 
one of SRU::Request::Explain, SRU::Request::Scan or 
SRU::Request::SearchRetrieve depending on the type of URI that is passed 
in. See the docs for those classes for more information about what
they contain.

=head1 METHODS

=head2 newFromURI()

makeRequest() is a factory method which you pass a complete SRU url. 
makeRequest() will return an appropriate object for the type of request being 
conducted:

=over 4

=item * SRU::Request::Explain

=item * SRU::Request::Scan

=item * SRU::Request::SearchRetrieve

=back

If the request is not formatted properly the call will return undef. 
The error encountered should be available in $SRU::Error.

=cut

sub newFromURI {
    my ($class,$uri) = @_;

    ## be nice and try to turn a string into a URI if necessary
    if ( ! UNIVERSAL::isa( $uri, 'URI' ) ) { $uri = URI->new($uri); }
    return error( "invalid uri: $uri" ) if ! UNIVERSAL::isa( $uri, 'URI' ); 

    my $base      = $uri->scheme . '://' . $uri->host() . $uri->path();
    my %query     = $uri->query_form();
    my $operation = $query{operation} || 'explain';

    my $request;
    if ( $operation eq 'scan' ) { 
        $request = SRU::Request::Scan->new( base => $base, %query );
    } elsif ( $operation eq 'searchRetrieve' ) {
        $request = SRU::Request::SearchRetrieve->new( base => $base, %query );
    } elsif ( $operation eq 'explain' ) {
        $request = SRU::Request::Explain->new( base => $base, %query );
    }

    return $request;
}

=head2 newFromCGI()

A factory method for creating a request object from a CGI object.

    my $cgi = CGI->new();
    my $request = SRU::Request->newFromCGI( $cgi );

=cut

sub newFromCGI {
    my ($class,$cgi) = @_;

    ## We want either an actual CGI object, or at least an object that gives us url()
    return error( "invalid CGI object" ) unless UNIVERSAL::isa( $cgi, 'CGI' ) or $cgi->can( 'url' );
    return $class->newFromURI( $cgi->url );
}

1;
