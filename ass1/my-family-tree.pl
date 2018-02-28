:- use_module(library(tabling)).
:- table parent_of/2.
:- discontiguous 'parent_of tabled'/2.

male(gf1).
male(u1).
male(u2).
male(u3).
male(yourself).
male(gs2).
male(gs3).

female(gm1).
female(a1).
female(a2).
female(a3).
female(gd1).
female(gd2).

brother(u1, u2).
brother(u2, u1).
brother(u2, u3).
brother(u3, u2).
brother(u1, u3).
brother(u3, u1).
brother(u1, a1).
brother(u1, a2).
brother(u1, a3).
brother(u2, a1).
brother(u2, a2).
brother(u2, a3).
brother(u3, a1).
brother(u3, a2).
brother(u3, a3).
brother(yourself, gs2).
brother(gs2, gs2).
brother(yourself, gd1).
brother(gs2, gd1).
brother(gs3, gd2).


sister(a1, a2).
sister(a2, a1).
sister(a2, a3).
sister(a3, a2).
sister(a1, a3).
sister(a3, a1).
sister(a1, u1).
sister(a1, u2).
sister(a1, u3).
sister(a2, u1).
sister(a2, u2).
sister(a2, u3).
sister(a3, u1).
sister(a3, u2).
sister(a3, u3).
sister(gd1, yourself).
sister(gd1, gs2).
sister(gd2, gs3).


parent_of(gf1, u1).
parent_of(gf1, u2).
parent_of(gf1, u3).
parent_of(gf1, a1).
parent_of(gf1, a2).
parent_of(gf1, a3).
parent_of(gm1, u1).
parent_of(gm1, u2).
parent_of(gm1, u3).
parent_of(gm1, a1).
parent_of(gm1, a2).
parent_of(gm1, a3).
parent_of(u1, yourself).
parent_of(a1, yourself).
parent_of(u1, gs2).
parent_of(a1, gs2).
parent_of(u1, gd1).
parent_of(a1, gd1).
parent_of(u2, gs3).
parent_of(u2, gd2).
parent_of(a2, gs3).
parent_of(a2, gd2).

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