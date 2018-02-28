p(a).                              /* #1 */  
p(X) :- q(X), r(X).                /* #2 */  
p(X) :- u(X).                      /* #3 */  
 
q(X) :- s(X).                      /* #4 */  


r(a).                              /* #5 */  
r(b).                              /* #6 */  


s(a).                              /* #7 */  
s(b).                              /* #8 */  
s(c).                              /* #9 */  
 
u(d).                              /* #10 */  


%% p(X, f(Y), a) = p(a, f(a), Y).
%% p(X, f(Y), a) = p(a, f(b), Y).
%% p(X, f(Y), a) = p(Z, f(b), a).
%% p(X, f(Y), a) = p(Z, f(b), a), X = d.
%% X=f(X). 
%% X=f(X), X=a.
%% unify_with_occurs_check(X,f(X

consult('family.pl').
edit('family.pl').
reconsult('family.pl').
['family.pl','p.pl'].