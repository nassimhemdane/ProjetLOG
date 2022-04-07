/***** L'enigme d'Einstein *****/
/*****  CORRECTION *****/
/************************************/
/***** Base de connaissances *****/

%Définition des couleurs
couleur(rouge).
couleur(bleu).
couleur(jaune).
couleur(blanc).
couleur(vert).


%Définition des sports
sport(football).
sport(baseball).
sport(volley).
sport(hockey).
sport(tennis).

%Définition des nationalités
nationalite(anglais).
nationalite(suedois).
nationalite(danois).
nationalite(norvegien).
nationalite(allemand).

%Définition des boissons
boisson(the).
boisson(eau).
boisson(cafe).
boisson(lait).
boisson(biere).

%Définition des animaux
animal(chien).
animal(chat).
animal(oiseau).
animal(cheval).
animal(poisson).

/* Prédicats lc, ln, lb, la, lp */

%On définit les contraintes sur les variables aussitôt que possible
lc([C1, C2, C3, C4, C5]) :- 
    couleur(C1), 
    couleur(C2), 
    dif(C1, C2), 
    couleur(C3), 
    dif(C1, C3), 
    dif(C2, C3), 
    couleur(C4), 
    dif(C1, C4), 
    dif(C2, C4), 
    dif(C3, C4), 
    couleur(C5), 
    dif(C1, C5), 
    dif(C2, C5), 
    dif(C3, C5), 
    dif(C4, C5).

/*
?- lc(L).
L = [rouge, bleu, jaune, blanc, vert] ;
L = [rouge, bleu, jaune, vert, blanc] ;
L = [rouge, bleu, blanc, jaune, vert] ;
L = [rouge, bleu, blanc, vert, jaune] ;
L = [rouge, bleu, vert, jaune, blanc] ;
L = [rouge, bleu, vert, blanc, jaune] ;
L = [rouge, jaune, bleu, blanc, vert] ;
L = [rouge, jaune, bleu, vert, blanc]
...
*/

ln([N1, N2, N3, N4, N5]) :- 
    nationalite(N1), 
    nationalite(N2), 
    dif(N1, N2), 
    nationalite(N3), 
    dif(N1, N3), 
    dif(N2, N3), 
    nationalite(N4), 
    dif(N1, N4), 
    dif(N2, N4), 
    dif(N3, N4), 
    nationalite(N5), 
    dif(N1, N5), 
    dif(N2, N5), 
    dif(N3, N5), 
    dif(N4, N5).

/*
?- ln(L).
L = [anglais, suedois, danois, norvegien, allemand] ;
L = [anglais, suedois, danois, allemand, norvegien] ;
L = [anglais, suedois, norvegien, danois, allemand] ;
L = [anglais, suedois, norvegien, allemand, danois] ;
L = [anglais, suedois, allemand, danois, norvegien] ;
L = [anglais, suedois, allemand, norvegien, danois] ;
L = [anglais, danois, suedois, norvegien, allemand] ;
L = [anglais, danois, suedois, allemand, norvegien] .
...
*/

lb([B1, B2, B3, B4, B5]) :- 
    boisson(B1), 
    boisson(B2), 
    dif(B1, B2), 
    boisson(B3), 
    dif(B1, B3), 
    dif(B2, B3), 
    boisson(B4), 
    dif(B1, B4), 
    dif(B2, B4), 
    dif(B3, B4), 
    boisson(B5), 
    dif(B1, B5), 
    dif(B2, B5), 
    dif(B3, B5), 
    dif(B4, B5).

/*
?- lb(L).
L = [the, eau, cafe, lait, biere] ;
L = [the, eau, cafe, biere, lait] ;
L = [the, eau, lait, cafe, biere] ;
L = [the, eau, lait, biere, cafe] ;
L = [the, eau, biere, cafe, lait] ;
L = [the, eau, biere, lait, cafe] ;
L = [the, cafe, eau, lait, biere] ;
L = [the, cafe, eau, biere, lait] ;
L = [the, cafe, lait, eau, biere] .
...
*/

la([A1, A2, A3, A4, A5]) :- 
    animal(A1), 
    animal(A2), 
    dif(A1, A2), 
    animal(A3), 
    dif(A1, A3), 
    dif(A2, A3), 
    animal(A4), 
    dif(A1, A4), 
    dif(A2, A4), 
    dif(A3, A4), 
    animal(A5), 
    dif(A1, A5), 
    dif(A2, A5), 
    dif(A3, A5), 
    dif(A4, A5).

/*
?- la(L).
L = [chien, chat, oiseau, cheval, poisson] ;
L = [chien, chat, oiseau, poisson, cheval] ;
L = [chien, chat, cheval, oiseau, poisson] ;
L = [chien, chat, cheval, poisson, oiseau] ;
L = [chien, chat, poisson, oiseau, cheval] ;
L = [chien, chat, poisson, cheval, oiseau] ;
L = [chien, oiseau, chat, cheval, poisson] ;
L = [chien, oiseau, chat, poisson, cheval] ;
L = [chien, oiseau, cheval, chat, poisson] .
...
*/


ls([S1, S2, S3, S4, S5]) :- 
    sport(S1), 
    sport(S2), 
    dif(S1, S2), 
    sport(S3), 
    dif(S1, S3), 
    dif(S2, S3), 
    sport(S4), 
    dif(S1, S4), 
    dif(S2, S4), 
    dif(S3, S4), 
    sport(S5), 
    dif(S1, S5), 
    dif(S2, S5), 
    dif(S3, S5), 
    dif(S4, S5).

/*
?- ls(L).
L = [football, baseball, volley, hockey, tennis] ;
L = [football, baseball, volley, tennis, hockey] ;
L = [football, baseball, hockey, volley, tennis] ;
L = [football, baseball, hockey, tennis, volley] ;
L = [football, baseball, tennis, volley, hockey] ;
L = [football, baseball, tennis, hockey, volley] ;
L = [football, volley, baseball, hockey, tennis] ;
L = [football, volley, baseball, tennis, hockey] ;
L = [football, volley, hockey, baseball, tennis] ;
L = [football, volley, hockey, tennis, baseball] ;
L = [football, volley, tennis, baseball, hockey] .
...
*/


/* Prédicat meme_maison */


meme_maison(X, [X|_], Y, [Y|_]). %Vrai si X et Y sont tous deux en première position de la liste
meme_maison(X, [Z|L1], Y, [T|L2]) :- 
    dif(X, Z),  %Sinon, on vérifie que les premiers éléments de chaque liste ne sont ni X ni Y
    dif(Y, T), 
    meme_maison(X, L1, Y, L2). %Et on rappelle la fonction récursivement sur le reste des listes

/*
?- meme_maison(chien, [chat, chien, cheval], X, [football, baseball, volley]).
X = baseball ;
false.
*/

/* Prédicat maison_a_cote */

maison_a_cote(X, [X|_], Y, [Z,Y|_]) :- dif(Y, Z). %X est à gauche de Y
maison_a_cote(X, [Z,X|_], Y, [Y|_]) :- dif(X, Z). %X est à droite de Y
maison_a_cote(X, [Z|L1], Y, [T|L2]) :- 
    dif(X, Z), 
    dif(Y, T), 
    maison_a_cote(X, L1, Y, L2). % ni X ni Y ne sont les premiers éléments de leurs listes respectives

/*
?- maison_a_cote(chien, [chat, chien, cheval], X, [football, baseball, volley]).
X = football ;
X = volley ;
false.
*/

/* Prédicat maison_a_gauche */

maison_a_gauche(X, Y, [X,Y|_]). %X est le premier élément de la liste, Y le second
maison_a_gauche(X, Y, [Z|L]) :- 
    dif(X, Z), 
    maison_a_gauche(X, Y, L). %Sinon, on appelle récursivement
 
/*
?- maison_a_gauche(chien, X, [chat, chien, cheval]).
X = cheval ;
false.

?- maison_a_gauche(X, chien, [chat, chien, cheval]).
X = chat ;
false.

*/

/* Prédicat poisson */

poisson(C, N, B, A, S, Poisson) :-  %on définit les contraintes aussitôt que possible pour gagner en efficacité.
    ln(N), 
    meme_maison(m1, [m1, m2, m3, m4, m5], norvegien, N), %fait 9
    lc(C),
    maison_a_gauche(vert, blanc, C), %fait 4
    maison_a_cote(norvegien, N, bleu, C), %fait 14
    meme_maison(anglais, N, rouge, C), %fait 1
    la(A),
    meme_maison(suedois, N, chien, A), %fait 2
    meme_maison(poisson, A, Poisson, N), %question
    ls(S),
    meme_maison(football, S, oiseau, A), %fait 6
    meme_maison(jaune, C, baseball, S), %fait 7
    maison_a_cote(volley, S, chat, A), %fait 10
    maison_a_cote(cheval, A, baseball, S), %fait 11
    meme_maison(allemand, N, hockey, S), %fait 13
    lb(B),
    meme_maison(danois, N, the, B), %fait 3
    meme_maison(vert, C, cafe, B), %fait 5
    meme_maison(m3, [m1, m2, m3, m4, m5], lait, B), %fait 8
    meme_maison(tennis, S, biere, B), %fait 12
    maison_a_cote(volley, S, eau, B). %fait 15
 
/*
?- poisson(C, N, B, A, S, Poisson).
C = [jaune, bleu, rouge, vert, blanc],
N = [norvegien, danois, anglais, allemand, suedois],
B = [eau, the, lait, cafe, biere],
A = [chat, cheval, oiseau, poisson, chien],
S = [baseball, volley, football, hockey, tennis],
Poisson = allemand ;
false.
*/