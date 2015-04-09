use Test::Modern;
use t::lib::Harness qw(ss);
plan skip_all => 'SIFT_SCIENCE_API_KEY not in ENV' unless defined ss();

subtest 'Create Order' => sub {
    my $id = 1;

    for my $test (
        [{}                                 ,'Basic order'           ],
        [{ session_id   => 1 }              ,'Basic order with param'],
        [{'$user_email' => 'email@live.com'},'Basic order with $ prefix param'],
    ) {
        my ($params, $message) = @$test;
        my $res = ss->create_order($id, %$params);
        is $res->{error_message} => 'OK', $message or diag explain $res;
    }

    my $e = exception { ss->create_order($id, garbage => 'asdf12345') };
};

done_testing;
