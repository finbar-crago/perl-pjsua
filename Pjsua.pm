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


sub new {
    my ($class, $args) = @_;
    my $self = {
        host => $args->{host},
        user => $args->{user},
        pass => $args->{pass},
        port => $args->{port} || '5060',
    };
    start();
    $self->{acc} = add_account_xs($self->{host}, $self->{user}, $self->{pass});
    return bless $self, $class;
}

sub call {
    my ($self, $extn) = @_;
    my $uri = 'sip:'.$extn.'@'.$self->{host};
    return call_xs($self->{acc}, $uri);
}


1;

__END__
# Below is the stub of documentation for your module. You better
# edit it
