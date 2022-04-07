/* TP1 - PROLOG*/

homme(albert).
homme(jean).
homme(paul).
homme(bertrand).
homme(louis).
homme(benoit).

femme(germaine).
femme(christiane).
femme(simone).
femme(marie).
femme(sophie).

parent(albert, jean).
parent(germaine, jean).

parent(jean, paul).
parent(christiane, paul).

parent(jean, simone).
parent(christiane, simone).

parent(paul, bertrand).
parent(marie, bertrand).

parent(paul, sophie).
parent(marie, sophie).

parent(louis, benoit).
parent(simone, benoit).

/* EXERCICE 1 */

/* 1. Est-ce que Paul est un homme ? 

?- homme(paul).
true.

*/

/* 2. Est-ce que Benoit est une femme ?

?- femme(benoit).
false.

*/

/* 3. Qui est une femme ?

?- femme(X).
X = germaine ;
X = christiane ;
X = simone ;
X = marie ;
X = sophie.

*/

/* 4. Est-ce que Marie est un parent de Sophie ? 

?- parent(marie, sophie).
true.

*/

/* 5. Quels sont les parents de Jean ?

?- parent(X, jean).
X = albert ;
X = germaine ;
false.


*/

/* 6. Quels sont les enfants de Paul ?

?- parent(paul, X).
X = bertrand ;
X = sophie.

*/

/* 7. Quels hommes sont parent ?

?- homme(X), parent(X, _).
X = albert ;
X = jean ;
X = jean ;
X = paul ;
X = paul ;
X = louis ;
false.

*/

/* EXERCICE 2 */

/* 1. fils(X, Y) */

fils(X, Y) :- 
    homme(X), 
    parent(Y, X).

/*
?- fils(X, albert).
X = jean ;
false.
*/


/* 2. soeur(X, Y) */

soeur(X, Y) :- 
    femme(X),
    parent(Z, X), 
    parent(Z, Y),
    parent(W, X),
    parent(W, Y),
    W \= Z,
    X \= Y.

/*
?- soeur(X, Y).
X = simone,
Y = paul ;
X = simone,
Y = paul ;
X = sophie,
Y = bertrand ;
X = sophie,
Y = bertrand ;
false.
*/

/* 3. grand_mere(X, Y) */

grand_mere(X, Y) :-
    femme(X),
    parent(X, Z), 
    parent(Z, Y).

/*
?- grand_mere(X, Y).
X = germaine,
Y = paul ;
X = germaine,
Y = simone ;
X = christiane,
Y = bertrand ;
X = christiane,
Y = sophie ;
X = christiane,
Y = benoit ;
false.
*/

/* 4. tante(X, Y) */

tante(X, Y) :- 
    soeur(X, Z),
    parent(Z, Y).

/*
?- tante(X, Y).
X = simone,
Y = bertrand ;
X = simone,
Y = sophie ;
X = simone,
Y = bertrand ;
X = simone,
Y = sophie ;
false.
*/

/* EXERCICE 3 */

/* Formalisez le problème */

voleur(pierre).

aime(marie, vin).
aime(pierre, X) :- aime(X, vin).

vole(X, Y) :- 
    voleur(X), 
    aime(X, Y).

/*  Expliquez qui vole quoi 

?- vole(X, Y).
X = pierre,
Y = marie ;
false.

Pierre vole Marie
*/

