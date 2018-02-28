offspring(prince, charles).
offspring(princess, ann).
offspring(prince, andrew).
offspring(prince, edward).

older(charles, ann).
older(ann, andrew).
older(andrew, edward).

male(A):- offspring(prince,A).
female(A):- offspring(princess,A).

is_older(X, Y):- older(X, Y).
is_older(A, B):- older(A, X),is_older(X, B).

in_order(X, Y) :- offspring(prince, X), offspring(princess, Y).
in_order(X, Y) :- offspring(prince, X), offspring(prince, Y), is_older(X, Y).
in_order(X, Y) :- offspring(princess, X), offspring(princess, Y), is_older(X, Y).


insert_sort(X, Y) :- insert_sort_helper(X, [], Y).
insert_sort_helper([], Acc, Acc).
insert_sort_helper([H|T], Acc, Y) :- insert(H, Acc, NewAcc), insert_sort_helper(T, NewAcc, Y).

insert(X, [], [X]).
insert(X, [Y|T], [X, Y|T]) :- in_order(X, Y).
insert(X, [Y|T], [Y|NewT]) :- not(in_order(X, Y)), insert(X, T, NewT).

successionList(SuccessionList):- 
    findall(Y,offspring(_,Y),OffspringList),insert_sort(OffspringList,SuccessionList).