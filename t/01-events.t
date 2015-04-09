use Test::Modern;
use t::lib::Harness qw(ss);
plan skip_all => 'SIFT_SCIENCE_API_KEY not in ENV' unless defined ss();

my $id = 1;
my %garbage = (garbage => 'asdf12345');

subtest 'Create Order' => sub {
    for my $test (
        [{}                                 ,'Basic order'                    ],
        [{ session_id   => 1 }              ,'Basic order with param'         ],
        [{'$user_email' => 'email@live.com'},'Basic order with $ prefix param'],
    ) {
        my ($params, $message) = @$test;
        my $res = ss->create_order($id, %$params);
        is $res->{error_message} => 'OK', $message or diag explain $res;
    }

    ok exception { ss->create_order($id, %garbage ) },
        'Correctly failed with garbage data';
};

subtest 'Transaction' => sub {
    ok exception { ss->transaction($id) },
        'Correctly failed with missing required params';

    my %params = (
        amount        => 506790000,
        currency_code => 'USD',
    );

    my $res = ss->create_order($id, %params);
    is $res->{error_message} => 'OK',
        'Basic transaction with required params' or diag explain $res;

    $params{order_id} = 555;
    $res = ss->create_order($id, %params);
    is $res->{error_message} => 'OK',
        'Basic transaction with required and optional params'
        or diag explain $res;

    exception { ss->transaction($id, %garbage) };
};

done_testing;
