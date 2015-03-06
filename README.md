# NAME

Types::Email - Type constraints for email addresses and messages

# VERSION

Version 0.0001, released 2015-03-06.

# SYNOPSIS

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

# DESCRIPTION

This module provides email address and message type constraints and coercions for [Type::Tiny](https://metacpan.org/pod/Type::Tiny) compatible object systems via [Email::Valid](https://metacpan.org/pod/Email::Valid) and [Email::Abstract](https://metacpan.org/pod/Email::Abstract).

# ACKNOWLEDGEMENTS

This is pretty much a port of [MooseX::Types::Email](https://metacpan.org/pod/MooseX::Types::Email).

# SEE ALSO

- [MooseX::Types::Email](https://metacpan.org/pod/MooseX::Types::Email)
- [MooX::Types::MooseLike::Email](https://metacpan.org/pod/MooX::Types::MooseLike::Email)
- [Email::Valid](https://metacpan.org/pod/Email::Valid)
- [Email::Abstract](https://metacpan.org/pod/Email::Abstract)

# SOURCE

[https://github.com/Csson/p5-Types-Email](https://github.com/Csson/p5-Types-Email)

# HOMEPAGE

[https://metacpan.org/release/Types-Email](https://metacpan.org/release/Types-Email)

# AUTHOR

Erik Carlsson <info@code301.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Erik Carlsson <info@code301.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
