% Financial Advisor
% code to get you started

% declare predicates and their arity
% not necessary, but avoids warnings

:- dynamic invest_in/1.
:- dynamic savings_account/1.
:- dynamic amount_saved/1.
:- dynamic dependents/1.
:- dynamic minsavings/2.
:- dynamic earnings/2.


invest_in(savings) :-
	savings_account(inadequate).

% rules 6 & 7
% The next rule uses cut !. The order of the following
% 2 clauses is important. The second one only fires if 
% the first one fails. Does not allow backtracking. 
% Cut ! prevents this.

income(adequate) :- 
	earnings(X,steady),
	dependents(Y),
	minincome(Y, MI),
	X > MI, !.

income(inadequate).


	
minincome(D, I) :-
	I is 15000 + D * 4000.


getSavings :-
	write('Input savings amount '),
	read(S),
	assert(amount_saved(S)).



%  go is to run the whole program, makes it easier
go :- getSavings,
      % missing code
      invest_in(X),
      write('Advice is to invest in '), write(X), !,
      cleanInputs.

% If the first attempt at go fails, Prolog will 
% backtract and try this instead
go :-
      write('Cannot currently advise you'),
      cleanInputs.


cleanInputs :-
     retractall(amount_saved(_)).