% -*- Prolog -*-
% This module provides utils for unit testing Gerrit submit_filter/submit_rule.
% The most interesting part is with_commit/2 which let's you run a goal inside a temporary gerrit-like environment.

:- module(gerrit_test_utils, [
              with_commit/1,
              with_commit/2,
              with_facts/2]).
:- license(lgpl).

:- meta_predicate with_facts(+, 0).
with_facts([], Goal) :- Goal, !.
with_facts([Term | Ts], Goal) :-
    % Sanity check - make sure Term is not defined
    assertion(term_is_undefined(Term)),

    setup_call_cleanup(
        assert(Term),
        with_facts(Ts, Goal),
        retract(Term)
    ).

:- meta_predicate with_facts(0).
term_is_undefined(Module:Term) :-
    Term =.. [Head | Params],
    length(Params, Arity),
    \+ (current_predicate(Module:Head/Arity), Module:Term).


:- meta_predicate with_commit(0).
with_commit(Goal) :- with_commit([], Goal).
:- meta_predicate with_commit(+, 0).
with_commit(Commit, Goal) :-
    maplist(commit_property_to_fact, Commit, Facts),
    with_facts(Facts, Goal).

commit_property_to_fact(label(Label, Review, User),
                        gerrit:commit_label(label(Label, Review), User)).
