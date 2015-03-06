use strict;
use warnings;

use Test::More;
use if $ENV{'AUTHOR_TESTING'}, 'Test::Warnings';

use Types::Email qw/EmailAddress EmailAddresses EmailMessage EmailMessages/;


subtest EmailAddress => {

    ok EmailAddress->check('x@example.com'), 'x@example.com is a valid email address';

    ok EmailAddress->check("someone someone\@example.com\n"), 'someone@example.com\n is a valid email address';

    like EmailAddress->validate('something-else'), qr{must be a valid}, q{validation fails correctly for 'something-else'};



    done_testing;

};


done_testing;
