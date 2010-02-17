#!/usr/bin/env perl

use perl5i::latest;
use Test::More;
use Test::Exception;

my @array = qw( foo bar baz );

dies_ok { @array->grep("foo")            } "Shouldn't accept scalars";
dies_ok { @array->grep([qw(boo boy)])    } "Shouldn't accept array refs";
dies_ok { @array->grep({ 'boo', 'boy' }) } "Shouldn't accept hash refs";

lives_ok { @array->grep( sub { 42 } ) } "Should accept code refs";
lives_ok { @array->grep( qr/foo/ )    } "Should accept Regexps";

is_deeply( @array->grep(qr/^ba/),       [qw( bar baz )], "Works with Regexp"     );
is_deeply( @array->grep(sub { /^ba/ }), [qw( bar baz )], "... as with Code refs" );


done_testing();
