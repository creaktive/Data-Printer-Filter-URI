package Data::Printer::Filter::URI;
# ABSTRACT: pretty-printing URI objects

use strict;
use utf8;
use warnings 'all';

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
It filters through several L<URI> manipulation classes and displays the L<URI> as a string.

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
* sftp
* sip
* sips
* snews
* ssh
* telnet
* tn3270
* urn

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
    sftp
    sip
    sips
    snews
    ssh
    telnet
    tn3270
    urn
);

filter "URI::$_" => sub {
    my ($obj, $p) = @_;

    my $str = $obj->as_string;

    $str =~ s{^@{[$obj->scheme]}}{colored($obj->scheme, $p->{color}{uri_scheme} // 'bright_green')}e;
    $str =~ s{@{[$obj->host]}}{colored($obj->host, $p->{color}{uri_host} // 'bold')}e;

    return $str;
} for @schemes;

1;
