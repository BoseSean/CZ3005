%% male(jerry).
%% male(stuart).
%% male(warren).
%% male(peter).
%% female(kather).
%% female(maryalice).
%% female(ann).
%% brother(jerry,stuart).
%% brother(jerry,kather).
%% brother(peter, warren).
%% sister(ann, maryalice).
%% sister(kather,jerry).
%% parent_of(warren,jerry).
%% parent_of(maryalice,jerry).



:- use_module(library(tabling)).
:- table parent_of/2.
:- discontiguous 'parent_of tabled'/2.


brother(peter, warren).
brother(jerry,kather).
brother(jerry,stuart).
male(stuart).
male(peter).
male(warren).
male(jerry).
female(kather).
female(ann).
female(maryalice).
sister(kather,jerry).
sister(ann, maryalice).
parent_of(maryalice,jerry).
parent_of(warren,jerry).

parent_of(X,Y):-
    parent_of(X,Z),
    sibling(Y,Z).


father(X, Y) :-         % X is father of Y
    parent_of(X, Y),    % X is parent of Y and
    male(X).            % X is male

mother(X, Y) :-         % X is mother of Y
    parent_of(X, Y),    % X is parent of Y and
    female(X).          % X is female

son(X, Y) :-            % X is son of Y
    parent_of(Y, X),    % Y is parent of X and
    male(X).            % X is male

daughter(X, Y) :-       % X is daughter of Y
    parent_of(Y, X),    % Y is parent of X and
    female(X).          % X is female

grandfather(X, Y) :-    % X is grandfather of Y
    father(X, Z),       % X is father of Z and
    parent_of(Z, Y).    % Z is parent of Y

sibling(X, Y) :-        % X is sibling of Y
    brother(X, Y);      % X is brother of Y or
    brother(Y, X);      % Y is brother of X or
    sister(X, Y);       % X is sister of Y or
    sister(Y, X).       % Y is sister of X

spouse(X,Y):-           % X is spouse of Y
    parent_of(X,A),     % X is parent of A and 
    male(X),            % X is male and
    parent_of(Y,A),     % Y is parent of A and 
    female(Y).          % Y is female

uncle(X, Y):-           % X is uncle of Y
    parent_of(P,Y),     % P is parent of Y and
    (brother(P,X);      % P is brother of X or
    brother(X,P)),      % X is brother of P and
    not(parent_of(X,Y)),% X is not parent of Y
    male(X).            % X is male

aunt(X, Y):-            % X is aunt of Y
    parent_of(P,Y),     % P is parent of Y and
    (sister(P,X);       % P is sister of X or
    sister(X,P)),       % X is sister of P and
    not(parent_of(X,Y)),% X is not parent of Y
    female(X).          % X is female

cousin(X, Y) :-         % X is cousin of Y
    parent_of(P1, X),   % P1 is parent of X and
    parent_of(P2, Y),   % P2 is parent of Y and
    sibling(P1, P2).    % P1 P2 are sibling