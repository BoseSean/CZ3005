list_empty([], true).
list_empty([_|_], false).

is_subset([], L).
is_subset([H|T], L):-
    member(H,L), is_subset(T,L).