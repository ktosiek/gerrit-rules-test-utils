% -*- Prolog -*-
:- module(gerrit_test_utils, [
              with_commit/1,
              with_commit/2]).

% Some gerrit 

:- meta_predicate with_facts(+, 0).
with_facts([], Goal) :- Goal, !.
with_facts([Term | Ts], Goal) :-
    % Sanity check - make sure Term is not defined
    Term =.. [Head | Params],
    length(Params, Arity),
    assertion(
        \+ current_predicate(Head/Arity)
        ; \+ Term),

    setup_call_cleanup(
        assert(Term),
        with_facts(Ts, Goal),
        retract(Term)
    ).

:- begin_tests(with_facts).
test(return_fact) :-
    with_facts([a(1)], a(X)),
    assertion(X == 1).

test(multiple_facts) :-
    with_facts([a(1), a(2)],
               findall(Y, a(Y), Ys)),
    assertion(Ys == [1, 2]),
    \+ a(1), \+ a(2).

:- end_tests(with_facts).

:- meta_predicate with_commit(0).
with_commit(Goal) :- with_commit([], Goal).
:- meta_predicate with_commit(+, 0).
with_commit(Commit, Goal) :-
    maplist(commit_property_to_fact, Commit, Facts),
    with_facts(Facts, Goal).

commit_property_to_fact(label(Label, Review, User),
                        gerrit:commit_label(label(Label, Review), User)).


:- begin_tests(with_commit).
test(commit_label) :-
    with_commit(
            [label('Verified', -1, user(10))
            ],
            gerrit:commit_label(label('Verified', -1), user(10))).
:- end_tests(with_commit).
