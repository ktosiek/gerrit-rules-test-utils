% -*- Prolog -*-

:- use_module(library(plunit)).

:- multifile(user:message_hook).
user:message_hook(T, error, Ls) :-
    writeln('Bailing out because of error!'),
    display(T), writeln(Ls),
    halt(128).


load_tests :-
    use_module(gerrit_test_utils_tests),

    expand_file_name('examples/*_test.pl', ExampleTests),
    use_module(ExampleTests).

main :- (load_tests, run_tests, halt(0)) ; halt(1).
