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

done_testing;
