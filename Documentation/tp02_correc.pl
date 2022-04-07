/* TP2 - PROLOG*/

/* prem(L, X) */

prem([X|_], X).

/*
?- prem([a,b,c], E).
E = a.

?- prem([], E).     
false.
*/


/* rest(L1, L2) */

rest([_|X], X).

/*
?- rest([a,b,c], E).
E = [b, c].
*/

/* der(L, X) */

der([E], E).
der([_|E], L) :- der(E, L).

/*
?- der([a,b,c], E). 
E = c ;
false.
*/

/* elem(L, X) */

elem([X|_], X).
elem([_|L], X) :- elem(L, X).

/*
?- elem([a,b,c], E).
E = a ;
E = b ;
E = c ;
false.
*/


/* longueur(L, N) */

longueur([], 0).
longueur([_|Y], N) :- 
    longueur(Y, M), 
    N is M+1.
    
/*
?- longueur([a,b,c], N).
N = 3.
*/

/* nieme(N, X, Y) */

nieme(1, [X|_], X).
nieme(N, [_|T], Z) :- 
    nieme(N1, T, Z), 
    N is N1 + 1.

/*
?- nieme(N, [a, b, c], b).
N = 2 ;
false.
*/

/* concat(L1, L2, L3) */

concat([], L, L).
concat([H|T], L, [H|Z]) :- concat(T, L, Z).

/*
?- concat([a, b, c], [c, d, e, f], L).
L = [a, b, c, c, d, e, f].

?- concat([a, b, c], L, [a, b, c, d, e]).
L = [d, e].
*/

/* palindrome(L) */

palindrome([]).
palindrome([_]).
palindrome([X|Z]) :- 
    append(Y, [X], Z), 
    palindrome(Y).

/*
?- palindrome([a, b, c, d]).
false.

?- palindrome([a, b, c, d, c, b, a]).
true .
*/

/* rang_pair(X, Y) */

rang_pair([], []).
rang_pair([_], []).
rang_pair([_,Y|L], [Y|T]) :- rang_pair(L, T).

/* 
?- rang_pair([a, b, c, d, c, b, a], L).
L = [b, d, b] ;
false.
*/

/* remplace(X1, X2, L1, L2) */

remplace(_, _, [], []).
remplace(X1, X2, [X1|L1], [X2|L2]) :- 
    remplace(X1, X2, L1, L2).
remplace(X1, X2, [X|L1], [X|L2]) :- 
    X \= X1, 
    remplace(X1, X2, L1, L2).

/*
?- remplace(b, f, [a, b, c, d], L).
L = [a, f, c, d] ;
false.
*/

/* somme(L, R) */

somme([], 0).
somme([X|L], N) :- 
    somme(L, N1), 
    N is X + N1.

/* 
?- somme([1, 8, 3, 5], N). somme([1, 8, 3, 5], N).
N = 17.
*/

/* partage(L, X, L1, L2) */

partage([], _, [], []).
partage([Y|L], X, [Y|L1], L2) :- 
    Y<X, 
    partage(L, X, L1, L2).
partage([Y|L], X, L1, [Y|L2]) :- 
    Y>=X, 
    partage(L, X, L1, L2).

/*
?- partage([1, 12, 15, 2, 8], 10, L1, L2).
L1 = [1, 2, 8],
L2 = [12, 15] ;
false.
*/

/* compte(X, L, N) */

compte(_, [], 0).
compte(X, [X|L], N) :-
    compte(X, L, N1),
    N is N1+1.
compte(X, [Y|L], N) :- 
    X \= Y,
    compte(X, L, N).

/*
?- compte(a, [b, a, c, a, a, d, a, e], N).
N = 4 ;
false.

?- compte(f, [b, a, c, a, a, d, a, e], N).
N = 0 .
*/


