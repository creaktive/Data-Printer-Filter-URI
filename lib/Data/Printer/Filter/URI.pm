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
            uri         => 'bright_yellow',
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
    my $color = $p->{color}{uri};
    return colored('"' . $obj->as_string . '"', $color // 'bright_yellow');
} for @schemes;

1;
