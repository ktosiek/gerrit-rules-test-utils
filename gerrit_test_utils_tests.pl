% -*- Prolog -*-

:- use_module(gerrit_test_utils).

:- begin_tests(with_facts).
test(return_fact) :-
    with_facts([a:a(1)], a:a(X)),
    assertion(X == 1).

test(multiple_facts) :-
    with_facts([a:a(1), a:a(2)],
               findall(Y, a:a(Y), Ys)),
    assertion(Ys == [1, 2]),
    \+ a:a(1), \+ a:a(2).

:- end_tests(with_facts).

:- begin_tests(with_commit).
test(commit_label) :-
    with_commit(
            [label('Verified', -1, user(10))
            ],
            gerrit:commit_label(label('Verified', -1), user(10))).
:- end_tests(with_commit).

:- begin_tests(term_is_undefined).
test(is_defined, [fail]) :-
    with_facts([a:a(1)],
               gerrit_test_utils:term_is_undefined(a:a(1))).

test(is_not_defined) :-
               gerrit_test_utils:term_is_undefined(a:a(1)).
:- end_tests(term_is_undefined).
