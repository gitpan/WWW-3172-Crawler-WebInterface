use Test::More tests => 4;
use strict;
use warnings;

# the order is important
our $crawler;
BEGIN {
    require WWW::3172::Crawler;
    require Test::Mock::LWP::Dispatch;
    $crawler = WWW::3172::Crawler->new(
        ua      => LWP::UserAgent->new,
        host    => 'http://127.0.0.1',
    );
}

use WWW::3172::Crawler::WebInterface ($crawler);
use Dancer::Test;

route_exists [GET => '/'], 'a route handler is defined for /';
response_status_is ['GET' => '/'], 200, 'response status is 200 for /';

route_exists [POST => '/submit_crawl'], 'a route exists for /submit_crawl';
my $res = dancer_response 'POST' => '/submit_crawl', { params => { 'crawl.url' => 'http://127.0.0.1', 'crawl.max' => 1 } };
is $res->{status}, 200, 'response status is 200 for /submit_crawl';

