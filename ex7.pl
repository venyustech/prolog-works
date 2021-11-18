/* ************************************************************************ *
*    SOMATORIO, VERSION                                                    *
*    Este programa soma lista                                              *
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

somatorio(Lista,S):- somatorio(Lista,0,S).
somatorio([],Ac,Ac).
somatorio([H|T],Ac,S):-
    NAc is Ac+H,
    somatorio(T,NAc,S).
