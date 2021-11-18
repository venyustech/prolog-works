%Arvore genealogica.
% Copyright (C) 2018 by Gardenia Georgia Barbosa de Siqueira/
% Fatos
gerou(nina, norma).
gerou(siqueira, norma).
gerou(nina, joao).
gerou(siqueira, joao).
gerou(margarida, joana).
gerou(josival, joana).
gerou(margarida, jeane).
gerou(jeane, lorena).
gerou(joao, lorena).
gerou(jeane, gardenia).
gerou(joao, gardenia).
gerou(joana, leonardo).
gerou(darlanges, leonardo).
gerou(joana, guilherme).
gerou(darlanges, guilherme).
gerou(norma, miguel).
gerou(marcos, miguel).
gerou(norma, monica).
gerou(marcos, monica).

sexo(margarida,feminino).
sexo(nina,feminino).
sexo(joana,feminino).
sexo(jeane,feminino).
sexo(norma,feminino).
sexo(lorena,feminino).
sexo(gardenia,feminino).
sexo(monica,feminino).
sexo(josival,masculino).
sexo(siqueira,masculino).
sexo(darlanges,masculino).
sexo(joao,masculino).
sexo(marcos,masculino).
sexo(guilherme,masculino).
sexo(leonardo,masculino).
sexo(miguel,masculino).

% Regras
filho(X,Y) :- 
    gerou(Y, X),
    sexo(X,masculino).
filha(X,Y) :-
    gerou(Y, X),
    sexo(X,feminino).
mae(X, Y) :-
    gerou(X, Y),
    sexo(X,feminino).
pai(X, Y) :-
    gerou(X, Y),
    sexo(X,masculino).
avoo(X, Y) :-
    gerou(X, Z),
    gerou(Z, Y),
    sexo(X,feminino).
avoa(X, Y) :-
    gerou(X, Z),
    gerou(Z, Y),
    sexo(X,masculino).
irma(X, Y) :-
    gerou(Z, X),
    gerou(Z, Y),
    X\==Y,
    sexo(X,feminino).
irmao(X,Y) :-
    gerou(Z, X),
    gerou(Z, Y),
    x\==Y,
    sexo(X,masculino).
tio(X,Y) :-
    irmao(X,Z),
    gerou(Z,Y).
tia(X,Y) :-
    irma(X,Z), 
    gerou(Z,Y).
primo(X,Y) :-
    gerou(Z, X),
    gerou(A, Y),
    gerou(K, Z),
    gerou(K, A),
    sexo(X,masculino).
prima(X,Y) :-
    gerou(Z, X),
    gerou(A, Y),
    gerou(K, Z),
    gerou(K, A),
    sexo(X, feminino).
