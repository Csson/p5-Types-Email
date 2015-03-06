use strict;
use warnings;

use Test::More;
use Test::Deep;
use if $ENV{'AUTHOR_TESTING'}, 'Test::Warnings';

use Types::Email qw/EmailAddress EmailAddresses EmailMessage EmailMessages/;


subtest EmailAddress => sub {

    ok EmailAddress->check('x@example.com'), 'x@example.com is a valid email address';

    ok EmailAddress->check("someone\@example.com\n"), 'someone@example.com\n is a valid email address';

    like EmailAddress->validate('something-else'), qr{Must be a valid}, q{validation fails correctly for 'something-else'};

};

subtest EmailAddresses => sub {

    ok EmailAddresses->check([ 'one@example.com', 'two@example.com' ]), 'Correct list of email addresses';

    cmp_deeply EmailAddresses->coerce('another@example.com'), ['another@example.com'], 'Coerced an email address into a list of addresses';

    like EmailAddresses->validate(['info@example.com', 'not-info']), qr{Must be an arrayref of valid}, 'Validation fails, not everything is an email address';

};

my $message = <<'MESSAGE';
From: one@example.com
To: two@example.com
Subject: Is a valid
Date: Thu Dec 31 23:59:59 2020

Hi!
MESSAGE

subtest EmailMessage => sub {

    ok EmailMessage->check(Email::Simple->new($message)), 'Example email is ok';

    like EmailMessage->validate($message), qr{Must be something Email::Abstract}, 'Validation fails as it should';

};

subtest EmailMessages => sub {

    ok EmailMessages->check([ Email::Simple->new($message) ]), 'Example email is ok as a list of emails';

    like EmailMessages->validate([ $message ]), qr{Must be an arrayref of something Email::Abstract}, 'Validation fails for the list as it should';

};

done_testing;
