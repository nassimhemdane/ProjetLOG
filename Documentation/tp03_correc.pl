/* TP3 - PROLOG - CORRECTION*/

/************************************/


/* prefixe(P, L) */

prefixe([], _).
prefixe([X|L], [X|M]) :- prefixe(L, M).

/*
?- prefixe(P, [a, b, c, d]).
P = [] ;
P = [a] ;
P = [a, b] ;
P = [a, b, c] ;
P = [a, b, c, d] ;
false.
*/

/* suffixe(S, L) */

suffixe(L, L).
suffixe(S, [_|L]) :- suffixe(S, L).

/*
?- suffixe(S, [a, b, c, d]).
S = [a, b, c, d] ;
S = [b, c, d] ;
S = [c, d] ;
S = [d] ;
S = [] ;
false.
*/

/* ajouter_fin(X, L, R) */

ajouter_fin(X, [], [X]).
ajouter_fin(X, [Y|L], [Y|R]) :- ajouter_fin(X, L, R).

/*
?- ajouter_fin(e, [a, b, c], R).
R = [a, b, c, e] ;
false.

?- ajouter_fin(X, [a, b, c], [a, b, c, d]).
X = d ;
false.

?- ajouter_fin(d, L, [a, b, c, d]).
L = [a, b, c] ;
false.
*/

/* Autre correction possible */

ajouter_fin2(X, L, R) :- append(L, [X], R).

/* prefixe(P, L) */

prefixe([], _).
prefixe([X|L], [X|M]) :- prefixe(L, M).

/*
?- prefixe(P, [a, b, c, d]).
P = [] ;
P = [a] ;
P = [a, b] ;
P = [a, b, c] ;
P = [a, b, c, d] ;
false.
*/


/* sousliste(S, L) */

sousliste([], _).
sousliste([X|S], [X|L]) :-
    sousliste(S, L).
sousliste([X|S], [_|L]) :-
    sousliste([X|S], L).

/*
?- sousliste([b, d], [a, b, c, d]).
true ;
false.

?- sousliste([b, e], [a, b, c, d]).
false.

?- ?- sousliste(X, [a, b, c, d]).
X = [] ;
X = [a] ;
X = [a, b] ;
X = [a, b, c] ;
X = [a, b, c, d] ;
X = [a, b, d] ;
X = [a, c] ;
X = [a, c, d] ;
X = [a, d] ;
X = [b] ;
X = [b, c] ;
X = [b, c, d] ;
X = [b, d] ;
X = [c] ;
X = [c, d] ;
X = [d] ;
false.
*/

/* sousliste_cons(S, L) */

sousliste_cons([], _).
sousliste_cons([X|L], [X|M]) :-
    prefixe(L, M).
sousliste_cons([X|S], [_|M]) :-
    sousliste_cons([X|S], M).

/*
?- sousliste_cons([b, c, d], [a, b, c, d]).
true .

?- sousliste_cons([b, d], [a, b, c, d]).
false.

?- sousliste_cons(X, [a, b, c, d]).
X = [] ;
X = [a] ;
X = [a, b] ;
X = [a, b, c] ;
X = [a, b, c, d] ;
X = [b] ;
X = [b, c] ;
X = [b, c, d] ;
X = [c] ;
X = [c, d] ;
X = [d] ;
false.
*/

/* extraire(X, L1, L2) */

extraire(_, [], []).
extraire(X, [X|L], L1) :- extraire(X, L, L1).
extraire(X, [Y|L1], [Y|L2]) :- 
    X\=Y,
    extraire(X, L1, L2).

/*
?- extraire(3, [3, 5, 3, 4, 3, 2, 1], L).
L = [5, 4, 2, 1] ;
false.
*/

/* pgcd(X, Y, Z) */

pgcd(X, X, X).
pgcd(X, Y, Z) :- 
    X < Y,
    YS is Y-X,
    pgcd(X, YS, Z).
pgcd(X, Y, Z) :-
    Y < X,
    pgcd(Y, X, Z).

/*
?- pgcd(12, 16, Z).
Z = 4 ;
false.

?- pgcd(12, 20, Z).
Z = 4 ;
false.

?- pgcd(25, 5, Z).
Z = 5 ;
false.

?- pgcd(27, 7, Z).
Z = 1 ;
false.
*/
