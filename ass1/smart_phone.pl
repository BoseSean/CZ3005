%SumSum, a competitor of Appy, 
%developed some nice smart phone technology called Galactica-S3,
% all of which was stolen by Stevey,
% who is a Boss. 

%rival companies. A competitor of Appy is a rival. 
%Smart phone technology is a business.


% It is unethical for a Boss to steal business from 

%1. Translate the natural language statements above describing the dealing within the Smart Phone industry in to First Order Logic, (FOL).
%2. Write these FOL statements as Prolog clauses.
%3. Using the prolog search engine, prove that Stevey is unethical. Show a trace of your proof.

company(sumSum).
company(appy).
smartPhonetTechnology(galacticaS3).
developed(galacticaS3, sumSum).
boss(stevey).
competitor(sumSum, appy).
steal(stevey, galacticaS3).
business(Tech):-smartPhonetTechnology(Tech).
rival(Comp):- competitor(Comp, appy);competitor(appy, Comp).
unethical(X):-boss(X),steal(X, Biz),business(Biz),developed(Biz, CompA),rival(CompA).
 
%% company(sumSum).
%% company(appy).
%% competitor(sumSum, appy).
%% develop(sumSum, galacticaS3).
%% smartPhoneTechnology(galacticaS3).
%% steal(stevey, galacticaS3).
%% boss(stevey).

%% unethical(X) :- boss(X), steal(X, Y), business(Y), develop(Z, Y), company(Z), rival(Z).
%% rival(X) :- company(X), competitor(X, appy).
%% business(X) :- smartPhoneTechnology(X).


    
