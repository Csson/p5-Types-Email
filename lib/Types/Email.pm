use 5.008001;
use strict;
use warnings;

package Types::Email;

# VERSION
# ABSTRACT: Type constraints for email addresses and messages

use Type::Library -base, -declare => qw/EmailAddress EmailMessage EmailAddresses EmailMessages/;
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
    from Object,
    via { Email::Abstract->new($_) };

1;

__END__

=pod

=head1 SYNOPSIS

    package My::Class;

    use Moose;
    use Types::Email qw/EmailAddress EmailAddresses EmailMessage EmailMessages/;

    has email => (
        is => 'ro',
        isa => EmailAddress,
    );
    has message => (
        is => 'ro',
        isa => EmailMessage,
        coerce => 1,
    );
    has emails => (
        is => 'ro',
        isa => EmailAddresses,
        coerce => 1,
    );
    has messages => (
        is => 'ro',
        isa => EmailMessages,
    );

=head1 DESCRIPTION

This module provides email address and message type constraints and coercions for L<Type::Tiny> compatible object systems via L<Email::Valid> and L<Email::Abstract>.

=head1 ACKNOWLEDGEMENTS

This is pretty much a port of L<MooseX::Types::Email>.

=head1 SEE ALSO

=for :list
* L<MooseX::Types::Email>
* L<MooX::Types::MooseLike::Email>
* L<Email::Valid>
* L<Email::Abstract>

=cut
