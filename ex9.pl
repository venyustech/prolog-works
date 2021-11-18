/* ************************************************************************ *
*    Abre Cofre, 2018 VERSION                                              *
*    Este programa irá descobrir a senha de um cofre                       *
*                                                                          *
*    Copyright (C) 2018 by Gardenia Georgia Barbosa de Siqueira            *
*                                                                          *
*    This program is free software; you can redistribute it and/or modify  *
*    it under the terms of the GNU General Public License as published by  *
*    the Free Software Foundation; either version 2 of the License, or     *
*    (at your option) any later version.                                   *
*                                                                          *
*    This program is distributed in the hope that it will be useful,       *
*    but WITHOUT ANY WARRANTY; without even the implied warranty of        *
*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
*    GNU General Public License for more details.                          *
*                                                                          *
*    You should have received a copy of the GNU General Public License     *
*    along with this program; if not, write to the                         *
*    Free Software Foundation, Inc.,                                       *
*    59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
*                                                                          *
*    To contact the author, please write to:                               *
*    Gardenia Georgia Barbosa de Siqueira <gardenia.georgia.b.s@gmail.com> *
*    Webpage: http://www.upe.com                                           *
*    Phone: +55 (81) 99785-0393                                            *
* ************************************************************************ *
* 
*/
/*
* *****************************************************************************************
*    Dados do problema:                                                                   *
*    Encontre uma seguencia de 4 digitos de 1 a 9, que permite abrir um cofre, sendo que: *
*    1- o primeiro numero eh maior que o terceiro;                                        *
*    2- o primeiro numero eh meno que o segundo,                                          *
*    3- o quarto numero eh igual a soma do terceiro com o segundo,                        *
*    4- o primeiro numero eh impar,                                                       *
*    5- o primeiro numero eh igual ao terceiro + 1,                                       *
*    6- o segundo numero e o 7.                                                           *
* *****************************************************************************************
*/

numero([1,2,3,4,5,6,7,8,9]).

gerar(L):-
    numero(N),
    gera_linha(N,L).
gera_linha(L,[N1,N2,N3,N4]):-
    select(N1,L,L1),
    select(N2,L1,L2),
    select(N3,L2,L3),
    select(N4,L3,_).
testar([N1,7,N3,N4]):-
    N1<7,
    N1>N3,
    N4 is N3+7,
    N1 is N3+1,
    1 is N1 mod 2.
enigma(L) :- gerar(L), testar(L).

