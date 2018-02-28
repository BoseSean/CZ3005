offspring(prince, charles).
offspring(princess, ann).
offspring(prince, andrew).
offspring(prince, edward).

elder_than(charles,ann).
elder_than(ann,andrew).
elder_than(andrew,edward).

is_older(A, B):- elder_than(A, B).
is_older(A, B):- elder_than(A, X),is_older(X, B).

is_higher(A, B):- male(A),female(B).
is_higher(A, B):- ((male(A), male(B));(fmale(A), fmale(B)), is_older(A, B).



%% %% is_younger(PeopleA,PeopleB):- elder_than(PeopleB, PeopleA).
%% %% is_younger(PeopleA,PeopleB):- elder_than(PeopleA,X),is_older(X,PeopleB).


%% male(People):- offspring(prince, People).
%% female(People):- offspring(princess, People).

%% oldest(People):-
%%     elder_than(People, Next),
%%     not(elder_than(_,People)).

%% oldestMale(People):-
%%     male(People),
%%     not((if_older(X,People), male(X))).

%% oldestFemale(People):-
%%     female(People),
%%     not((if_older(X,People), female(X))).


%% precedes(X,Y):- male(X),male(Y),if_older(X,Y).
%% precedes(X,Y):- male(X),female(Y), not(oldestFemale(Y)).
%% precedes(X,Y):- female(X), female(Y),if_older(X,Y).



%% next(People, Next):- 
%%     male(People), male(Next),
%%     elder_than(People, Next).

%% next(People, Next):- 
%%     female(People), female(Next),
%%     elder_than(People, Next).

%% next(People, Next):- 
%%     male(People), female(Next),
%%     elder_than(People, Next).

