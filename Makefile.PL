use ExtUtils::MakeMaker;
use strict;
use warnings;

## create the Makefile
WriteMakefile(
    'NAME'		=> 'SRU',
    'DISTNAME'		=> 'SRU',
    'ABSTRACT'		=> 'Search and Retrieve URL Service',
    'VERSION_FROM'	=> 'lib/SRU/Request.pm', 
    'PMLIBDIRS'		=> [ qw( lib/ ) ],
    'AUTHOR'		=> 'Ed Summers <ehs@pobox.com>',
    'PREREQ_PM'		=> { 
                            'XML::LibXML'       => '',
                            'URI'               => '',
                            'Class::Accessor'   => '',
			   },
);
