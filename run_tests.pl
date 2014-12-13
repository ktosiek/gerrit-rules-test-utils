% -*- Prolog -*-

load_tests :-
    load_files(gerrit_test_utils_tests, []),

    expand_file_name('examples/*_test.pl', ExampleTests),
    display(ExampleTests),
    load_files(ExampleTests, []).

main :- (load_tests, run_tests, halt(0)) ; halt(1).
