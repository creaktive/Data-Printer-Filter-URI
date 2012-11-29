package Data::Printer::Filter::URI;
# ABSTRACT: pretty-printing URI objects

use strict;
use utf8;
use warnings qw(all);

use Data::Printer::Filter;
use Term::ANSIColor;

# VERSION

=head1 SYNOPSIS

# In your program:

    use Data::Printer filters => {
        -external => [ 'URI' ],
    };

# or, in your C<.dataprinter> file:

    {
        filters => {
            -external => [ 'URI' ],
        },
    };

# You can also setup color and display details:

    use Data::Printer {
        filters => {
            -external   => [ 'URI' ],
        }, color => {
            uri_scheme  => 'bright_green',
            uri_host    => 'bold',
        },
    };

=head1 DESCRIPTION

This is a filter plugin for L<Data::Printer>.
It filters through several L<URI> manipulation classes and displays the L<URI> as a fancy string.

=head2 Parsed Protocols

=for :list
* data
* file
* ftp
* gopher
* http
* https
* ldap
* ldapi
* ldaps
* mailto
* mms
* news
* nntp
* pop
* rlogin
* rsync
* rtsp
* rtspu
* scp (if L<URI::scp> is present)
* sftp (if L<URI::sftp> is present)
* sip
* sips
* snews
* ssh
* telnet
* tn3270
* urn

L<Mojo::URL> is also supported.

=cut

our @schemes = qw(
    URL
    data
    file
    ftp
    gopher
    http
    https
    ldap
    ldapi
    ldaps
    mailto
    mms
    news
    nntp
    pop
    rlogin
    rsync
    rtsp
    rtspu
    sip
    sips
    snews
    ssh
    telnet
    tn3270
    urn
    urn::oid
);

filter $_ => sub {
    my ($obj, $p) = @_;

    my $str = qq($obj);

    $str =~ s{^
        \b
        @{[$obj->scheme]}
        \b
    }{
        colored(
            $obj->scheme,
            exists($p->{color}{uri_scheme})
                ? $p->{color}{uri_scheme}
                : q(bright_green)
        )
    }ex if defined $obj->scheme;

    $str =~ s{
        \b
        \Q@{[$obj->host]}\E
        \b
    }{
        colored(
            $obj->host,
            exists($p->{color}{uri_host})
                ? $p->{color}{uri_host}
                : q(bold)
        )
    }ex if $obj->can(q(host))
        and defined $obj->host;

    return $str;
} for qw(Mojo::URL), map +qq(URI::$_), @schemes, qw(
    scp
    sftp
    urn::isbn
    urn::uuid
);

1;
