/* ************************************************************************ *
*    HARRY POTTER,2018 VERSION                                             *
*    Esse programa soluciona o enigma das porcoes de HarryPortter e a      *
*    pedra filosofal.                                                      *
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

%%regra1:voce sempre encontrará um veneno a esquerda do vinho,
%regra2:Sao diferentes as garrafas das extremidades, mas se voce quiser avançar nenhuma eh sua amiga.
%regra3a:temos tamanhos diferentes
%regra3b:Nem anã nem giganta leva a morte no bojo
%rega4:são gemeas a segunda à esquerda e a segunda à direita

%(garrafaA,garrafaB,garrafaC,garrafaD,garrafaE,garrafaF,garrafaG),
goal:-
    permutation([veneno,veneno,veneno,vinho,vinho,ida,voltar],L1),
    regra1(L1),
    regra2(L1),
    regra4(L1),
    write("A ordem das garrafas do Enigma das Porcoes no Livro de Harry Potter e a Pedra Filosofal, eh: "),
    writeln(L1),
    !.


%%%%%5%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%regra1:voce sempre encontrará um veneno a esquerda do vinho.
regra1([veneno,vinho,veneno,veneno,vinho,_,_]).
regra1([veneno,vinho,_,veneno,veneno,vinho,_]).
regra1([veneno,vinho,_,_,veneno,veneno,vinho]).
regra1([_,_,veneno,vinho,veneno,vinho,_]). 
regra1([_,_,veneno,vinho,_,veneno,vinho]).
regra1([_,_,veneno,vinho,veneno,vinho,_]).
regra1([veneno,veneno,vinho,veneno,vinho,_,_]).
regra1([vinho,veneno,vinho,_,veneno,vinho,_]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%regra2:Sao diferentes as garrafas das extremidades, mas se voce quiser avançar nenhuma eh sua amiga.
regra2([veneno,_,_,_,_,_,vinho]).
regra2([veneno,_,_,_,_,_,voltar]).

regra2([vinho,_,_,_,_,_,veneno]).
regra2([vinho,_,_,_,_,_,voltar]).

regra2([voltar,_,_,_,_,_,veneno]).
regra2([voltar,_,_,_,_,_,vinho]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%regra3a:temos tamanhos diferentes
%regra3b:Nem anã nem giganta leva a morte no bojo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%rega4:são gemeas a segunda à esquerda e a segunda à direita

regra4([_,veneno,_,_,_,veneno,_]).

regra4([_,vinho,_,_,_,vinho,_]).
