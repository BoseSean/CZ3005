number(five, odd).
number(one, odd).
number(two, even).
number(three, odd).
number(four, even).

greaterThan(five, four).
greaterThan(four, three).
greaterThan(three, two).
greaterThan(two, one).

even(A):- number(A, even).
odd(A):- number(A, odd).

is_larger(A,B):- greaterThan(A,B).
is_larger(A,B):- greaterThan(A,X),is_larger(X,B).

% the order considered even and odd
% which is odd before even, small before large
in_order(A,B):- odd(A), even(B).
in_order(A,B):- odd(A), odd(B), is_larger(B,A).     % smaller numbers comes first
in_order(A,B):- even(A), even(B), is_larger(B,A).   % smaller numbers comes first


% apply insertion sort on A 
insertion_sort(A,B):- sort_helper(A, [], B).
sort_helper([], OldList, OldList).
sort_helper([H|T], OldList, Result):- insert(H, OldList, NewList), sort_helper(T, NewList, Result).

% insert(A,L,Result) put A into L 
insert(A, [], [A]).
insert(A, [H|T], [A,H|T]):- in_order(A,H).
insert(A, [H|T], [H|NewList]):- not(in_order(A,H)), insert(A, T, NewList).

% Interface
oddEvenSortedList(OddEvenSortedList):- findall(A, number(A,_), Numbers), insertion_sort(Numbers, OddEvenSortedList).


%% largest(A):-
%%     not(greaterThan(_,A)).

%% largestEven(A):-
%%     even(A),
%%     not((if_larger(X,A), even(X))).

%% largestOdd(A):-
%%     odd(A),
%%     not((if_larger(X,A), odd(X))).



%% findall(OddN, number(OddN, odd), OddNums), findall(EvenN, number(EvenN, even), EvenNums), append(OddNums, EvenNums, Numbers).

    %% next(A, Next):- 
    %%     odd(A), odd(Next),
    %%     ...

%%     next(A, Next):- 
%%         even(A), even(Next),
%%         ...

%%     next(A, Next):- 
%%         odd(A), even(Next),
%%         ...


%% % how to sort the numbers in the following order:
%% % one, three, five, two, four