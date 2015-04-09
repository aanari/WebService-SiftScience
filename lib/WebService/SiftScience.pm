package WebService::SiftScience;
use Moo;
with 'WebService::Client';

# VERSION

use Method::Signatures;

has '+base_url' => ( default => 'http://api.siftscience.com/v203' );
has api_key     => ( is => 'ro', required => 1                    );
has events_uri  => ( is => 'ro', default => '/events'             );
has score_uri   => ( is => 'ro', default => '/score'              );

method get_score (Str $user_id) {
    return $self->get($self->score_uri);
}

method create_event (Str $user_id, Str $type, Maybe[HashRef] $data = {}) {
    return $self->post($self->events_uri, {
        '$type'      => $type,
        '$api_key'   => $self->api_key,
        '$user_id'   => $user_id,
        ( %$data ) x!! $data,
    });
}

method create_account (Str $user_id, Maybe[HashRef] $data) {
    return $self->create_event($user_id, '$create_account', $data);
}

method update_account (Str $user_id, Maybe[HashRef] $data) {
    return $self->create_event($user_id, '$update_account', $data);
}

method create_order (Str $user_id, Maybe[HashRef] $data) {
    return $self->create_event($user_id, '$create_order', $data);
}

method transaction (Str $user_id, Maybe[HashRef] $data) {
    return $self->create_event($user_id, '$transaction', $data);
}

method link_session_to_user (Str $user_id, $data) {
    return $self->create_event($user_id, '$link_session_to_user', $data);
}

method add_item_to_cart (Str $user_id, Maybe[HashRef] $data) {
    return $self->create_event($user_id, '$add_item_to_cart', $data);
}

method remove_item_from_cart (Str $user_id, Maybe[HashRef] $data) {
    return $self->create_event($user_id, '$remove_item_from_cart', $data);
}

method submit_review (Str $user_id, Maybe[HashRef] $data) {
    return $self->create_event($user_id, '$submit_review', $data);
}

method send_message (Str $user_id, Maybe[HashRef] $data) {
    return $self->create_event($user_id, '$send_message', $data);
}

method login (Str $user_id, Maybe[HashRef] $data) {
    return $self->create_event($user_id, '$login', $data);
}

method logout (Str $user_id) {
    return $self->create_event($user_id, '$logout');
}

method custom_event (Str $user_id, Str $type, Maybe[HashRef] $data) {
    return $self->create_event($user_id, $type, $data);
}

1;
