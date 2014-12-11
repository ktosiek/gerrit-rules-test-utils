% -*- Prolog -*-
:- load_files([rules]).

retract_gerrit :-
    abolish_if_exists(gerrit:commit_label/2).

abolish_if_exists(Pred) :- current_predicate(Pred), abolish(Pred), !.
abolish_if_exists(Pred).

:- begin_tests(gerrit).
test(pass_ok) :-
    retract_gerrit,
    submit_filter([label('Verified', ok(X))],
                  [label('Verified', ok(X))]).

test(override_reject) :-
    retract_gerrit,
    assert(gerrit:commit_label(label('Verified', -1), user(1))),
    assert(gerrit:commit_label(label('Verified', +1), user(2))),

    submit_filter([label('Verified', reject(X))],
                  [L]),

    assertion(L == label('Verified', ok(user(2)))).

:- end_tests(gerrit).

:- begin_tests(positive_labels).

test(no_positives, fail) :-
    retract_gerrit,
    assert(gerrit:commit_label(label('CR', -1), user(1))),
    positive_labels(_, _).

test(positive_and_negative) :-
    retract_gerrit,
    assert(gerrit:commit_label(label('Verified', -1), user(1))),
    assert(gerrit:commit_label(label('Verified', +1), user(2))),

    positive_labels('Verified', U),

    assertion(U == user(2)).

:- end_tests(positive_labels).

:- run_tests.
