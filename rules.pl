% -*- Prolog -*-
submit_filter(In, In).

positive_labels(Category, User) :-
    gerrit:commit_label(label(Category, Score), User),
    Score >= 1.
