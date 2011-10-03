use Data::Validate::URI qw(is_web_uri);

our $crawl = {
    url => {
        label       => 'URL to begin crawling:',
        error       => 'Invalid URL',
        required    => 1,
        value       => 'http://', # a hint for the user
        element     => { type => 'input_text' },
        validation  => sub {
            my ($form, $field, $params) = @_;
            $form->error($field, $field->{error}) unless is_web_uri($field->{value});
        },
        filters     => [qw(trim strip lowercase)],
    },
    max => {
        label       => 'Maximum number of pages to crawl:',
        required    => 0,
        value       => 5, # 50
        element     => { type => 'input_text' },
        validation  => sub {
            my ($form, $field, $params) = @_;
            $form->error($field, 'Cannot crawl more than 200 pages at once') unless $field->{value} < 200;
        },
        filters     => [qw(trim strip numeric)],
    },
};

