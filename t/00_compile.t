use strict;
use Test::More tests => 2;

BEGIN { use_ok 'Log::Minimal::File' }
can_ok 'Log::Minimal::File', qw/guard/;
