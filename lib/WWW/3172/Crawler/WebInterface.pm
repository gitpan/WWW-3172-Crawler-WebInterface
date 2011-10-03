package WWW::3172::Crawler::WebInterface;
use strict;
use warnings;

use Dancer ':syntax';
use Dancer::Plugin::DataFu;
use WWW::3172::Crawler;
use List::UtilsBy qw(nsort_by);
use HTML::Entities qw(encode_entities);
use Data::Table;
# ABSTRACT: Provides a web frontend to WWW::3172::Crawler
our $VERSION = '0.001'; # VERSION

our $imported_crawler;
sub import {
    $imported_crawler = $_[1];
}

get '/' => sub {
    return template 'index.tt', { form => form->render('crawl', '/~doherty/crawler/submit_crawl', 'crawl.url', 'crawl.max') };
};

post '/submit_crawl' => sub {
    my $input = form;
    if ($input->validate('crawl.url', 'crawl.max')) {
        my $crawler = $imported_crawler || WWW::3172::Crawler->new(
            host    => $input->params->{'crawl.url'},
            max     => $input->params->{'crawl.max'},
        );
        my $crawl_data = $crawler->crawl;

        return template 'table.tt', {
            main_table  => _main_table($crawl_data),
            stats_table => _stats_table($crawl_data),
        };
    }
    redirect '/';
};

sub _main_table {
    my $crawl_data = shift;

    my $headers = ['URL', 'Keywords', 'Description', 'Size (bytes)', 'Speed (s)'];
    my @rows;
    while (my ($url, $data) = each %$crawl_data) {
        push @rows, [
            "<a href='$url'>" . encode_entities($url) . "</a>",
            $data->{keywords},
            $data->{description},
            $data->{size},
            sprintf("%.5f", $data->{speed}),
        ];
    }
    return Data::Table->new(\@rows, $headers, 0)->html;
}

sub _stats_table {
    my $crawl_data = shift;
    my %keywords;

    while (my ($url, $data) = each %$crawl_data) {
        my @these_keywords = split /,\s?|\s+/, ($data->{keywords} || '');
        $keywords{$_}++ for @these_keywords;
    }
    return '' if keys %keywords == 0;

    my $html = '<ul><li>';
    $html .= join '</li><li>', map { encode_entities($_) }
        nsort_by { $keywords{$_} } keys %keywords;
    $html .= '</li></ul>';

    return $html;
}

true;


__END__
=pod

=encoding utf-8

=head1 NAME

WWW::3172::Crawler::WebInterface - Provides a web frontend to WWW::3172::Crawler

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

