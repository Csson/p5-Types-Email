use 5.008001;
use strict;
use warnings;

package Types::Email;

# VERSION
# ABSTRACT: Short intro

use Type::Library -base, -declare qw/EmailAddress EmailMessage EmailAddresses EmailMessages/;
use Type::Utils;
use Types::Standard qw/Object Str ArrayRef/;

use Email::Valid;
use Email::Abstract;

declare EmailAddress,
    as Str,
    where { Email::Valid->address($_) },
    message { 'Must be a valid email address' };

declare EmailAddresses,
    as ArrayRef[EmailAddress],
    message { 'Must be an arrayref of valid email addresses' };

coerce EmailAddresses,
    from Str,
    via { [ $_ ] };


declare EmailMessage,
    as Object,
    where { Email::Abstract->new($_) },
    message { 'Must be something Email::Abstract recognizes' };

declare EmailMessages,
    as ArrayRef[Object],
    where { not grep { not Email::Abstract->new($_) } @$_ },
    message { 'Must be an arrayref of something Email::Abstract recognizes' };

coerce EmailMessage,
    as Object,
    via { Email::Abstract->new($_) };
    
1;


__END__

=pod

=head1 SYNOPSIS

    use Types::Email;

=head1 DESCRIPTION

Types::Email is ...

=head1 SEE ALSO

=cut
