% -*- Prolog -*-
:- load_files([rules]).

:- begin_tests(gerrit).
:- use_module(gerrit_test_utils).
test(pass_ok) :-
    gerrit_test_utils:with_commit(
        submit_filter([label('Verified', ok(X))],
                      [label('Verified', ok(X))])).

test(override_reject) :-
    gerrit_test_utils:with_commit(
        [label('Verified', -1, user(1)),
         label('Verified', +1, user(2))],

        submit_filter([label('Verified', reject(X))], [L])),

    assertion(L == label('Verified', may(user(2)))).

:- end_tests(gerrit).

:- begin_tests(positive_labels).

test(no_positives, fail) :-
    gerrit_test_utils:with_commit(
        [label('CR', -1, user(1))],

        positive_labels(_, _)).

test(positive_and_negative) :-
    gerrit_test_utils:with_commit(
        [label('Verified', -1, user(1)),
         label('Verified', +1, user(2))],

        positive_labels('Verified', U)),

    assertion(U == user(2)).

:- end_tests(positive_labels).

:- run_tests.
