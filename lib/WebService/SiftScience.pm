package WebService::SiftScience;
use Moo;
with 'WebService::Client';

# VERSION

use Method::Signatures;

has '+base_url' => ( default => 'http://api.siftscience.com/v203' );
has api_key     => ( is => 'ro', required => 1                    );
has events_uri  => ( is => 'ro', default => '/events'             );
has score_uri   => ( is => 'ro', default => '/score'              );

around qw/put post delete/ => func ($orig, $self, $uri, $params) {
    for my $old_key (keys %$params) {
        my $new_key = (($old_key =~ /^\$/ ? '' : '$') . $old_key);
        $params->{$new_key} = delete $params->{$old_key};
    }
    return $self->$orig($uri, $params);
};

method create_order (Str $user_id, %params) {
    my $result = $self->post($self->events_uri, {
        'type'    => 'create_order',
        'api_key' => $self->api_key,
        'user_id' => $user_id,
        %params
    });
    return $result;
}

1;
