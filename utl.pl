list_empty([], true).
list_empty([_|_], false).

is_subset([], _).
is_subset([H|T], L):-
    member(H,L), is_subset(T,L).