package Log::Minimal::File;

use strict;
use warnings;
use IO::Handle;
use Scope::Guard;

our $VERSION = '0.01';

our $PRINT = sub {
    my ( $fh, $time, $type, $message, $trace ) = @_;
    print $fh "$time [$type] $message at $trace\n";
};

sub guard {
    my $class    = shift;
    my $filename = shift;

    my $PRE = $Log::Minimal::PRINT;
    open my $fh, '>>', $filename or die $!;
    autoflush $fh 1;

    $Log::Minimal::PRINT = sub { $PRINT->( $fh, @_ ) };

    return Scope::Guard->new(
        sub {
            $Log::Minimal::PRINT = $PRE;
            close $fh or die $!;
        }
    );
}

1;
__END__

=head1 NAME

Log::Minimal::File -

=head1 SYNOPSIS

  use Log::Minimal;
  use Log::Minimal::File;
  
  infof("foo"); # to stdout

  {
      my $guard = Log::Minimal::File->guard('/path/to/error.log');
      infof("bar"); # to your log file
  }

  infof("foobar"); # to stdout

=head1 DESCRIPTION

Log::Minimal::File is

=head1 AUTHOR

Yoshihiro Sasaki E<lt>aloelight at gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
