package SRU::Request::Explain;

use strict;
use warnings;
use base qw( Class::Accessor SRU::Request );
use SRU::Utils qw( error );

=head1 NAME

SRU::Request::Explain

=head1 SYNOPSIS

    ## creating a new request
    my $request = SRU::Request::Explain->new( 
        base=>'http://www.example.com/sru' );

=head1 DESCRIPTION

SRU::Request::Explain is a class for representing SRU 'explain' requests. 
Explain requests essentially ask the server to describe its services.

=head1 METHODS

=head2 new()

The constructor, which you must pass the parameter base and the optional 
parameters: version, recordPacking, stylesheet, and extraRequestData parameters.

    my $request = SRU::Request::Explain->new( 
        base        => 'http://www.example.com/sru', 
        version     => '1.1',
        stylesheet  => 'http://www.example.com/styles/mystyle.xslt'
    );

Normally you'll probably want to use the factory SRU::Response::newFromURI
to create requests, instead of calling new() yourself.

=cut

sub new {
    my ($class,%args) = @_;
    return error( "missing base parameter" ) if ! exists( $args{base} );
    return SRU::Request::Explain->SUPER::new( \%args );
}

=head2 base()

Returns the base location of the SRU service.

=head2 version()

=head2 recordPacking()

=head2 stylesheet()

=head2 extraRequestData()

=cut

SRU::Request::Explain->mk_accessors( qw( 
    base
    version
    recordPacking
    stylesheet
    extraRequestData
) );

=head2 asXML()

=cut

sub asXML {
    my $self = shift;
    ## XXX: need to implement this
    return '';
}

1;
