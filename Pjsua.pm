package Pjsua;

use strict;
use warnings;
require Exporter;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw( ) ] );
our @EXPORT_OK  = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw( );
our $VERSION = '0.01';

require XSLoader;
XSLoader::load('Pjsua', $VERSION);

1;

__END__
# Below is the stub of documentation for your module. You better
# edit it
