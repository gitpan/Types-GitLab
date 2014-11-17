#!/usr/bin/env perl
use strictures 1;

use Test::More;

BEGIN { use_ok('Types::GitLab', '-types') }

subtest 'GitLabUsername' => sub{
    ok(
        GitLabUsername->check('aAbB09_-.'),
        'good username',
    );

    ok(
        (! GitLabUsername->check('') ),
        'bad (empty) username',
    );

    ok(
        (! GitLabUsername->check('-aAbB09_-.') ),
        'bad (invalid first character) username',
    );

    ok(
        (! GitLabUsername->check('aAbB09_-.git') ),
        'bad (ending in .git) username',
    );
};

subtest 'GitLabToken' => sub{
    ok(
        GitLabToken->check('aAzZ09bByY18cCxX27xx'),
        'good token',
    );

    ok(
        (! GitLabToken->check('aAzZ09bByY18cCxX27x') ),
        'bad (short) token',
    );

    ok(
        (! GitLabToken->check('aAzZ09bByY18cCxX27xxx') ),
        'bad (long) token',
    );

    ok(
        (! GitLabToken->check(' AzZ09bByY18cCxX27x') ),
        'bad (invalid) token',
    );
};

subtest 'GitLabAPIURI' => sub{
    ok(
        GitLabAPIURI->check( URI->new('http://git.example.com/api/v3') ),
        'good (object) value',
    );

    ok(
        GitLabAPIURI->check( GitLabAPIURI->coerce('http://git.example.com/api/v3') ),
        'good (coerced string) value',
    );

    ok(
        (! GitLabAPIURI->check( 'http://git.example.com/api/v3' ) ),
        'bad (string) value',
    );
};

subtest 'GitLabProjectID' => sub{
    ok( GitLabProjectID->check(1), 'good value' );
    ok( (! GitLabProjectID->check(0) ), 'bad (non-positive) value' );
    ok( (! GitLabProjectID->check(1.5) ), 'bad (fraction) value' );
    ok( (! GitLabProjectID->check('abc') ), 'bad (alpha) value' );
};

done_testing;
