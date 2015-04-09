use Test::Modern;
use t::lib::Harness qw(ss);
plan skip_all => 'SIFT_SCIENCE_API_KEY not in ENV' unless defined ss();

my $id = 1;
my %garbage = (garbage => 'asdf12345');

subtest 'General Event Method Testing' => sub {
    my @events = qw/
        add_item_to_cart
        create_account
        create_order
        remove_item_from_cart
        update_account
    /;
    for my $test (
        [{}                                 ,'"%s"'                    ],
        [{ session_id   => 1 }              ,'"%s" with param'         ],
        [{'$user_email' => 'email@live.com'},'"%s" with $ prefix param'],
    ) {
        my ($params, $message) = @$test;
        for my $event (@events) {
            my $res = ss->$event($id, %$params);
            is $res->{error_message} => 'OK',
                sprintf $message, $event or diag explain $res;
        }
    }

    for my $event (@events) {
        ok exception { ss->$event($id, %garbage ) },
            "\"$event\" failed with garbage data";
    }
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
