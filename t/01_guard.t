use strict;
use Test::More tests => 5;
use Log::Minimal;
use Log::Minimal::File;
use File::Temp qw/tempfile/;

my ($fh, $filename) = tempfile();

my $default_called = 0;
$Log::Minimal::PRINT = sub {
    ok 1, 'default handler';
    $default_called++;
};

infof("deafult");

{
    my $guard = Log::Minimal::File->guard($filename);
    isa_ok $guard, 'Scope::Guard';
    infof("to file");
}

infof("default");
is $default_called, 2;

{
    my $guard = Log::Minimal::File->guard($filename);
    infof("to file");
}

my @line;
while (<$fh>) {
    push @line, $_;
}
is scalar @line, 2, 'append ok';
