package SRU::Request::Scan;

use strict;
use warnings;
use base qw( Class::Accessor SRU::Request );
use UNIVERSAL qw( isa );
use SRU::Utils qw( error );

=head1 NAME

SRU::Request::Scan - class for representing scan SRU requests

=head1 SYNOPSIS

    ## creating a new request
    my $request = SRU::Request::Scan->new();

=head1 DESCRIPTION

SRU::Request::Scan is a class for representing SRU 'scan' requests. 

=head1 METHODS

=head2 new()

The constructor, which you can pass the parameters: base, version, scanClause
responsePosition, maximumTerms, stylesheet, extraRequestData.

    my $request = SRU::Request::Explain->new( 
        base        => 'http://www.example.com/sru',
        version     => '1.1',
        scanClause  => 'horses',
    );

=cut

sub new {
    my ($class,%args) = @_;
    return error( "missing base parameter" ) if ! exists( $args{base} );
    return $class->SUPER::new( \%args );
}

=head2 base()

=head2 version()

=head2 scanClause()

=head2 responsePosition()

=head2 maximumTerms()

=head2 stylesheet()

=head2 extraRequestData()

=cut

SRU::Request::Scan->mk_accessors( qw( 
    base
    version
    scanClause
    responsePosition
    maximumTerms
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
