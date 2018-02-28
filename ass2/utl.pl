%% determine whether a list is empty
list_empty([], true).
list_empty([_|_], false).

%% determine whether a list L1 is a subset of L2
% eg. is_subset(L1, L2).
is_subset([], _).
is_subset([H|T], L):-
    member(H,L), is_subset(T,L).