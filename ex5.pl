/* ************************************************************************ *
*    FATORIAL, 2018  VERSION                                               *
*    Esse programa calcula o fatorial de um numero com uma variavel ligada *
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


fatorial(0,1).
fatorial(1,1)).
fatorial(N,F) :-
    N>0,
    N1 is N - 1,
    fatorial(N1,F1),
    F is N * F1.
