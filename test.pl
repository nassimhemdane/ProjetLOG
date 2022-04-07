plusGros('rhinocéros','cheval').
plusGros('cheval', 'chien').
plusGros('chien', 'chat').
plusGros('chat', 'hamster').

 
estPlusGros(X, Y) :-
 plusGros(X, Y).
 
estPlusGros(X, Z) :-
 plusGros(X, Y),
 estPlusGros(Y, Z).
 
 
 
phrase(_) :-
  plusGros(X, Y),
  write('Le '), write(X), write(' est plus gros que le '), write(Y), nl.
 
phrase(_) :-
  nl,
  write('Donc: '), nl.
 
phrase(_) :-
  estPlusGros(X, Y),
  \+plusGros(X, Y),  
  write('Le '), write(X), write(' est plus gros que le '), write(Y), nl.
 
 
phrases :-
  findall(X, phrase(X), _).

q(1).
p(X) :- \+ q(X).

habite(jean, belfort).
habite(lucie, paris).
habite(christian, toulouse).
habite(adeline, paris) :- fail.
habite(nicolas, paris).

printHelloWorld :-
  habite(moh,belfore),
  nl.


