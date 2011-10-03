#!/usr/bin/env perl
# PODNAME: dance
# ABSTRACT: run your WWW::3172::Crawler::WebInterface application
our $VERSION = '0.001'; # VERSION
use strict;
use warnings;

use Dancer;
use WWW::3172::Crawler::WebInterface;
dance;

__END__
=pod

=encoding utf-8

=head1 NAME

dance - run your WWW::3172::Crawler::WebInterface application

=head1 VERSION

version 0.001

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit L<http://www.perl.com/CPAN/> to find a CPAN
site near you, or see L<http://search.cpan.org/dist/WWW-3172-Crawler-WebInterface/>.

The development version lives at L<http://github.com/doherty/WWW-3172-Crawler-WebInterface>
and may be cloned from L<git://github.com/doherty/WWW-3172-Crawler-WebInterface.git>.
Instead of sending patches, please fork this project using the standard
git and github infrastructure.

=head1 SOURCE

The development version is on github at L<http://github.com/doherty/WWW-3172-Crawler-WebInterface>
and may be cloned from L<git://github.com/doherty/WWW-3172-Crawler-WebInterface.git>

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<http://rt.cpan.org>.

=head1 AUTHOR

Mike Doherty <doherty@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Mike Doherty.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

