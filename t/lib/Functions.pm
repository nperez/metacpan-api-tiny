use strict;
use warnings;
use MetaCPAN::API::Tiny;
use Carp ();
use Exporter 5.57 'import';

our @EXPORT    = qw(exception mcpan);

my $version = $MetaCPAN::API::Tiny::VERSION || 'xx';

sub mcpan {
    return MetaCPAN::API::Tiny->new(
        ua_args => [ agent => "MetaCPAN::API::Tiny-testing/$version" ],
    );
}

sub exception (&) {
  my $code = shift;
    
    my $ret = eval {
        $code->();
        "perlamonster";
    } || do {
        if($@)
        {
            "$@";
        }
        else
        {
            my $problem = defined $@ ? 'false' : 'undef';
            Carp::confess("$problem exception caught by Test::Fatal::exception");
        }
    
    };

    return $ret eq "perlamonster" ? undef : $ret;
}

1;
