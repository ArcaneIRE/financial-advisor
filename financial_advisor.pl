% Financial Advisor

% Predicate Declarations

:- dynamic invest_in/1.
:- dynamic savings_account/1.
:- dynamic amount_saved/1.
:- dynamic dependents/1.
:- dynamic minsavings/2.
:- dynamic earnings/2.

% Investment Rules

invest_in(cyptocurrency) :-
    savings_account(X),
    X = excessive.

invest_in('paying off debt') :-
    savings_account(X),
    X = negative.

invest_in(savings) :-
    savings_account(X),
    X = inadequate.

invest_in(stocks) :-
    savings_account(X),
    X = adequate,
    income(Y),
    Y = adequate.

invest_in(combination) :-
    savings_account(X),
    X = adequate,
    income(Y),
    Y = inadequate.

savings_account(excessive) :-
    amount_saved(X),
    dependents(Y),
    maxsavings(Y, MxS),
    N = MxS + 1000000,
    X > N, !.

savings_account(adequate) :-
    amount_saved(X),
    dependents(Y),
    minsavings(Y, MS),
    X > MS, !.

savings_account(negative) :-
    amount_saved(X),
    X < 0, !.

savings_account(inadequate).

minsavings(D, S) :-
    S is 5000 * D.

maxsavings(D, S) :-
    S is 5 000 000 * D.

income(adequate) :-
    earnings(X,steady),
    dependents(Y),
    minincome(Y, MI),
    X > MI, !.

income(inadequate).

minincome(D, I) :-
    I is 15000 + D * 4000.

% Input

getSavings :-
    write('Input amount saved: '),
    read(S),
    assert(amount_saved(S)).

getDependents :-
    write('How many dependents?  '),
    read(D),
    assert(dependents(D)).

getEarnings :-
    write('Input earnings: '),
    read(S),
    write('Is steady or unsteady'),
    read(W),
    assert(earnings(S, W)).

%  go is to run the whole program, makes it easier
go :-
    getSavings,
    getDependents,
    getEarnings,
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