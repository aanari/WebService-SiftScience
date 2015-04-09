# NAME

WebService::SiftScience

# VERSION

version 0.0100

# SYNOPSIS

    use WebService::SiftScience;

    my $ss = WebService::SiftScience->new(
        api_key => 'YOUR_API_KEY_HERE',
    );

    $ss->create_account(...);

# DESCRIPTION

This module provides bindings for the
[SiftScience](https://www.siftscience.com/resources/references/) API.

[![Build Status](https://travis-ci.org/aanari/WebService-SiftScience.svg?branch=master)](https://travis-ci.org/aanari/WebService-SiftScience)

# METHODS

## new

Instantiates a new WebService::SiftScience client object.

    my $ss = WebService::SiftScience->new(
        api_key    => $api_key,
        timeout    => $retries,    # optional
        retries    => $retries,    # optional
    );

**Parameters**

- - `api_key`

    _Required_
     

    A valid SiftScience API key for your account.

- - `timeout`

    _Optional_
     

    The number of seconds to wait per request until timing out.  Defaults to `10`.

- - `retries`

    _Optional_
     

    The number of times to retry requests in cases when SiftScience returns a 5xx response.  Defaults to `0`.

## add\_item\_to\_cart

Record when a user adds an item to their shopping cart or list.

**Request:**

    add_item_to_cart('billy_jones_301', {
        '$session_id' => 'gigtleqddo84l8cm15qe4il',
        '$item'       => {
            '$item_id'       => 'B004834GQO',
            '$product_title' => 'The Slanket Blanket-Texas Tea',
            '$price'         => '39990000',
            '$currency_code' => 'USD',
            ...
        },
    });

**Response:**

    {
        error_message => 'OK',
        status        => 0,
        time          => 1428607810,
        request       => { ... }
    }

## create\_account

Capture account creation and user details.

**Request:**

    create_account('billy_jones_301', {
        '$session_id'       => 'gigtleqddo84l8cm15qe4il',
        '$user_email'       => 'bill@gmail.com',
        '$name'             => 'Bill Jones',
        '$phone'            => '1-415-555-6040',
        '$referrer_user_id' => 'janejane101',
        ...
    });

**Response:**

    {
        error_message => 'OK',
        status        => 0,
        time          => 1428607810,
        request       => { ... }
    }

## create\_order

Record when a user submits an order for products or services they intend to purchase. This API event should contain the products/services ordered, the payment instrument proposed, and user identification data.

**Request:**

    create_order('billy_jones_301', {
        '$session_id'    => 'gigtleqddo84l8cm15qe4il',
        '$order_id'      => 'ORDER-28168441',
        '$user_email'    => 'bill@gmail.com',
        '$amount'        => 506790000,
        '$currency_code' => 'USD',
        ...
    });

**Response:**

    {
        error_message => 'OK',
        status        => 0,
        time          => 1428607810,
        request       => { ... }
    }

## custom\_event

Event that you can come up with on your own, in order to capture user behavior not currently captured in Sift Science's supported set of events.

**Request:**

    custom_event('billy_jones_301', 'make_call', {
        recipient_user_id => 'marylee819',
        call_duration     => 4428,
    });

**Response:**

    {
        error_message => 'OK',
        status        => 0,
        time          => 1428607810,
        request       => { ... }
    }

## get\_score

Retrieve a Sift Score for a particular user on your site, including a list of signals that describe the reasoning behind the score, and the latest label information if the user has been labeled.

**Request:**

    get_score('billy_jones_301');

**Response:**

    {
        user_id       => 'billy_jones_301',
        score         => 0.93,
        error_message => 'OK',
        status        => 0,
        reasons       => [
            name      => 'UsersPerDevice',
            value     => 4,
            details   => {
                users => 'a, b, c, d',
            },
        ],
        latest_label => {
            is_bad  => JSON::true,
            time    => 1350201660000,
            reasons => [
                '$chargeback',
                '$spam',
            ],
            description => 'known fraudster',
        },
    }

## label\_user

Label a user as bad (or not bad).

**Request:**

    label_user('billy_jones_301', {
        '$is_bad'      => JSON::true,
        '$reasons'     => ['$chargeback'],
        '$description' => 'Freeform text describing the user or incident.',
        '$source'      => 'Payment Gateway',
        '$analyst'     => 'someone@your-site.com',
    });

**Response:**

    {
        error_message => 'OK',
        status        => 0,
        time          => 1428607810,
        request       => { ... }
    }

## link\_session\_to\_user

Associate data from a specific session to a user. Generally used only in anonymous checkout workflows.

**Request:**

    link_session_to_user('billy_jones_301', {
        '$session_id'   => 'gigtleqddo84l8cm15qe4il',
    });

**Response:**

    {
        error_message => 'OK',
        status        => 0,
        time          => 1428607810,
        request       => { ... }
    }

## login

Record when a user attempts to log in.

**Request:**

    login('billy_jones_301', {
        '$session_id'   => 'gigtleqddo84l8cm15qe4il',
        '$login_status' => '$success',
    });

**Response:**

    {
        error_message => 'OK',
        status        => 0,
        time          => 1428607810,
        request       => { ... }
    }

## logout

Record when a user logs out.

**Request:**

    logout('billy_jones_301');

**Response:**

    {
        error_message => 'OK',
        status        => 0,
        time          => 1428607810,
        request       => { ... }
    }

## transaction

Record attempts to exchange money, credit or other tokens of value. This is most commonly used to record the results of interactions with a payment gateway, e.g., recording that a credit card authorization attempt failed.

**Request:**

    transaction('billy_jones_301', {
        '$session_id'         => 'gigtleqddo84l8cm15qe4il',
        '$order_id'           => 'ORDER-28168441',
        '$user_email'         => 'bill@gmail.com',
        '$transaction_type'   => '$sale',
        '$transaction_status' => '$success',
        '$transaction_id'     => '719637215',
        '$amount'             => 506790000,
        '$currency_code'      => 'USD',
        ...
    });

**Response:**

    {
        error_message => 'OK',
        status        => 0,
        time          => 1428607810,
        request       => { ... }
    }

## remove\_item\_from\_cart

Record when a user removes an item from their shopping cart or list.

**Request:**

    remove_item_from_cart('billy_jones_301', {
        '$session_id' => 'gigtleqddo84l8cm15qe4il',
        '$item'       => {
            '$item_id'       => 'B004834GQO',
            '$product_title' => 'The Slanket Blanket-Texas Tea',
            '$price'         => '39990000',
            '$currency_code' => 'USD',
            ...
        },
    });

**Response:**

    {
        error_message => 'OK',
        status        => 0,
        time          => 1428607810,
        request       => { ... }
    }

## send\_message

Record when a user sends a message to another user i.e., the recipient.

**Request:**

    send_message('billy_jones_301', {
        '$recipient_user_id' => '512924123',
        '$subject'           => 'Subject line of the message.',
        '$content'           => 'Text content of the message.',
    });

**Response:**

    {
        error_message => 'OK',
        status        => 0,
        time          => 1428607810,
        request       => { ... }
    }

## submit\_review

Record a user-submitted review of a product or other users. e.g., a seller on your site.

**Request:**

    submit_review('billy_jones_301', {
        '$content'           => 'Text content of submitted review goes here',
        '$review_title'      => 'Title of Review Goes Here',
        '$item_id'           => 'V4C3D5R2Z6',
        '$reviewed_user_id'  => 'billy_jones_301',
        '$submission_status' => '$success',
        'rating'             => 5,
    });

**Response:**

    {
        error_message => 'OK',
        status        => 0,
        time          => 1428607810,
        request       => { ... }
    }

## unlabel\_user

Remove a label from a user programatically.

**Request:**

    unlabel_user('billy_jones_301');

**Response:**

    204 No Content

## update\_account

Record changes to the user's account information.

**Request:**

    update_account('billy_jones_301', {
        '$session_id'       => 'gigtleqddo84l8cm15qe4il',
        '$user_email'       => 'bill@gmail.com',
        '$name'             => 'Bill Jones',
        '$phone'            => '1-415-555-6040',
        '$referrer_user_id' => 'janejane101',
        '$changed_password' => JSON::true,
        ...
    });

**Response:**

    {
        error_message => 'OK',
        status        => 0,
        time          => 1428607810,
        request       => { ... }
    }

# BUGS

Please report any bugs or feature requests on the bugtracker website
https://github.com/aanari/WebService-SiftScience/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

# AUTHOR

Ali Anari <ali@anari.me>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Ali Anari.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
