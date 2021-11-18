/* ************************************************************************ *
*    Soma Vogais, 2018 VERSION                                             *
*    BRIEF_DESCRIPTION                                                     *
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

%fatos
vogal(a).
vogal(e).
vogal(i).
vogal(o).
vogal(u).

%retorna 1 ou 0 caso seja vogal ou nao:
somalista(X,1):-
    vogal(X),
    !.
somalista(_,0).

%recursão que soma de acordo com o tipo de letra
contavogal([],0).
contavogal([H|T],N):-
    contavogal(T,N1),
    somalista(H,N2),
    N is N1+N2.
