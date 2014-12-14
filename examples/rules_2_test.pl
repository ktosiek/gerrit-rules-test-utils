% -*- Prolog -*-
% This one doesn't even look at the commit, so with_commit isn't needed.
:- module(rules_2_test, []).
:- load_files(rules_2).

:- begin_tests(rules_2).
test(categories) :-
    submit_rule(Restrictions),
    Restrictions =.. [submit | Labels],
    Labels = [label('Code-Review', ok(_)),
              label('Verified', ok(_))].
:- end_tests(rules_2).
