/* TP5 - PROLOG - CORRECTION*/

/************************************/

/* 1. si(P, Q, R) */

si(P, Q, _) :- 
    P, !, 
    Q.
si(_, _, R) :- R.

/*
?- si(3 = 8, X=5, X=8).
X = 8.

?- si(3 = 3, X=5, X=8).
X = 5.
*/

/* 2. tete(L, N, T) */

tete(_, 0, []) :- !.
tete([], _, []) :- !.
tete([X|L], N, [X|T]) :- 
    M is N-1,
    tete(L, M, T).

/*
?- tete([a, b, c, d, e, f], 3, T).
T = [a, b, c].

?- tete([a], 7, T).
T = [a].
*/

/* 3. queue(L, N, Q) */

queue(L, 0, L) :- !.
queue([], _, []) :- !.
queue([_|L], N, Q) :- 
    M is N-1,
    queue(L, M, Q).

/*
?- queue([a, b, c, d, e, f], 3, Q).
Q = [d, e, f].

?- queue([a, b, c, d, e, f], 7, Q).
Q = [].

?- queue([a, b, c, d, e, f], 0, Q).
Q = [a, b, c, d, e, f].
*/


/*** 4. ajouter(X, L, R) ***/

ajouter(X, L, L) :- member(X, L), !.
ajouter(X, L, [X|L]).

/*
?- ajouter(a, [b, c, d, e], L).
L = [a, b, c, d, e].

?- ajouter(d, [b, c, d, e], L).
L = [b, c, d, e].

?- ajouter(d, [], L).
L = [d].
*/

/*** 5. retirer(X, L, R) ***/

retirer(X, L, L) :- 
    not(member(X, L)), 
    !.
retirer(X, [X|L1], L2) :- !, retirer(X, L1, L2).
retirer(X, [Y|L1], [Y|L2]) :- retirer(X, L1, L2).

/*
?- retirer(d, [b, c, d, e], L).
L = [b, c, e].

?- retirer(a, [b, c, d, e], L).
L = [b, c, d, e].

?- retirer(d, [b, c, d, e, d, f], L).
L = [b, c, e, f].

?- retirer(d, [], L).
L = [].
*/

/*** 6. appartient2(X, L) ***/

appartient2(X, [X|L]) :-  
    member(X, L), 
    !.
appartient2(X, [_|L]) :- appartient2(X, L).

/*
?- appartient2(d, [b, c, d, e, f, d, g, d]).
true.

?- appartient2(d, [b, c, d, e, f, d, g]).
true.

?- appartient2(b, [b, c, d, e, f, d, g]).
false.
*/

/*** 7. oterdouble(L1, L2) ***/

oterdouble([], []) :- !.
oterdouble([X|L1], L2) :- 
    member(X, L1), !, 
    oterdouble(L1, L2).
oterdouble([X|L1], [X|L2]) :- oterdouble(L1, L2).

/*
?- oterdouble([a, b, a, a, b, c, d, d], L).
L = [a, b, c, d].

?- oterdouble([a, b, c, d], L).
L = [a, b, c, d].
*/

