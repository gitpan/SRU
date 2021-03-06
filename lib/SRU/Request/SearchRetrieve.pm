package SRU::Request::SearchRetrieve;

use strict;
use warnings;
use base qw( Class::Accessor SRU::Request );
use SRU::Utils qw( error );

=head1 NAME

SRU::Request::SearchRetrieve - represents a searchRetrieve SRU request

=head1 SYNOPSIS

    ## creating a new request
    my $request = SRU::Request::SearchRetrieve->new(
        base    => 'http://www.example.com/sru',
        version => '1.1',
        query   => 'kirk and spock' );

=head1 DESCRIPTION

=head1 METHODS

=head2 new()

The constructor which you can pass the following parameters:
version, query, startRecord, maximumRecords, recordPacking, recordSchema,
recordXPath, resultSetTTL, sortKeys, stylesheet, extraRequestData.
The version and query parameters are mandatory.

=cut

sub new {
    my ($class,%args) = @_;
    ## check required parameters.
    return error( "missing base parameter" ) if ! exists( $args{base} );
    return SRU::Request::SearchRetrieve->SUPER::new( \%args );
}

=head2 version

=head2 query

=head2 startRecord

=head2 maximumRecords

=head2 recordPacking

=head2 recordSchema

=head2 recordXPath

=head2 resultSetTTL

=head2 sortKeys

=head2 stylesheet

=head2 extraRequestData

=cut 

SRU::Request::SearchRetrieve->mk_accessors( qw( 
    base
    version
    query
    startRecord
    maximumRecords
    recordPacking
    recordSchema
    recordXPath
    resultSetTTL
    sortKeys
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
