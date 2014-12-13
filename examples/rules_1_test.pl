% -*- Prolog -*-
:- load_files(rules_1).

:- begin_tests(rules_1).
test(just_ok) :-
    submit_rule(submit(label('Any-Label-Name', ok(_)))).
:- end_tests(rules_1).
