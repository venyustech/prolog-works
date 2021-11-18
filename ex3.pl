/***************************************************************************
 *   ex3.pl                                   Version 20180412.201738      *
 *                                                                         *
 *   Jogo de Logica - Revista Coquetel                                     *
 *   Copyright (C) 2018         by Catarina Fernandez Bastos               *
 *                                 Gardenia Georgia Barbosa De Siqueira    * 
 *                                 Brenno Kayo do Nascimento Mateus        *
 ***************************************************************************
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License.        *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************
 *   To contact the author, please write to:                               *
 *   Catarina Fernandez Bastos                                             *
 *   Email: catifeernandez@gmail.com                                       *
 *   Webpage: http://poli.upe.br/                                          *
 *   Phone: +55 (81) 9706-9634                                             *
 *   ********************************************************************  *
 *   Gardenia Georgia Barbosa De Siqueira                                  *
 *   Email: gardenia.georgia.b.s@gmail.com                                 *
 *   Webpage: http://poli.upe.br/                                          *
 *   Phone: +55 (81) 9785-0393                                             *
 *   ********************************************************************  *
 *   Brenno Kayo do Nascimento Mateus                                      *
 *   Email: brenno.knm@gmail.com                                           *
 *   Webpage: http://poli.upe.br/                                          *
 *   Phone: +55 (81) 9505-3360                                             *
 ***************************************************************************
/*
 * @file ex3.pl
 * @ingroup GroupUnique
 * @brief Jogo de Logica - Revista Coquetel
 * @details A simple example of PROLOG source documented with doxygen.
 *
 * @version 20180412.201738
 * @date 2018-04-12
 * @author Ruben Carlo Benante <<rcb@beco.cc>>
 * @par Webpage
 * <<a href="http://www.beco.cc">www.beco.cc</a>>
 * @copyright (c) 2017 GNU GPL v2
 * @note This program is free software: you can redistribute it
 * and/or modify it under the terms of the
 * GNU General Public License as published by
 * the Free Software Foundation version 2 of the License.
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with this program.
 * If not, write to the Free Software Foundation, Inc.,
 * 59 Temple Place - Suite 330, Boston, MA. 02111-1307, USA.
 * Or read it online at <<http://www.gnu.org/licenses/>>.
 *
 * @todo Now that you have the template, hands on! Programme!
 * @warning Be carefull not to lose your mind in small things.
 * @bug This file right now does nothing usefull.
 *
 */ 

/* Files, dynamic clauses, modules, etc. */
/*
 * @ingroup GroupUnique
 * @brief Defining dynamic clauses
 * @param[in] A List of clauses
 * @retval TRUE on success.
 * @retval FALSE on fail.
*/

:- dynamic([verbosecounter/1]).

/* 
 * regra1a: Osmar Pediu a pizza da Palermo. 
 * regra1b: A pizza de presunto não veio da pizzaria Dominique.
 * regra2a: A pizza escolhida por Nick custou RS 2,00 a menos do que a pizza suprema.
 * regra2b: A pizza suprema não veio da pizzaria Dominique.
 *
 * regra3 : A pissa do Gustavo custou menos do que a pizza de calabresa.
 *
 * regra4a: Breno não pediu a pizza suprema.
 * regra4b: A pizza do restaurante Sicília custou RS2,00 a menos do que a pizza da pizzaria vespa.
 * regra4c: Zeca não pediu da pizzaria Vespa.
 *
 * regra5a: Zeca não pediu a pizza de pepperoni.
 * regra5b: A pizza de Zeca não custou RS 16,00.
 * regra5c: A pizza de Zeca não veio da pizzaria Nápoles.
 *
 * regra6a: A pizza de quatro queijos custa mais do que a pizza de calabresa.
 * regra6b: Nick não escolheu a pizza de calabresa
 * regra6c: Pizza de quatro queijos custou menos do que a de Zeca.
 */

%Fatos:
 
irmao(breno).
irmao(gustavo).
irmao(nick).
irmao(osmar).
irmao(zeca).
pizza(calabresa).
pizza(pepperoni).
pizza(presunto).
pizza(quatroqueijos).
pizza(suprema).
pizzaria(dominique).
pizzaria(napoles).
pizzaria(palermo).
pizzaria(sicilia).
pizzaria(vespa).
preco(12).
preco(13).
preco(14).
preco(15).
preco(16).

%Inferencia:
goal :-
    tudodiferente(Breno,BrePizza,BrePizzaria,BrePreco,Gustavo, GusPizza,GusPizzaria,GusPreco,Nick,NiPizza,NiPizzaria,NiPreco,Osmar,OsPizza,OsPizzaria,OsPreco,Zeca,ZePizza,ZePizzaria,ZePreco),
    tab(Breno,BrePizza,BrePizzaria,BrePreco,Gustavo,GusPizza,GusPizzaria,GusPreco,Nick,NiPizza,NiPizzaria,NiPreco,Osmar,OsPizza,OsPizzaria,OsPreco,Zeca,ZePizza,ZePizzaria,ZePreco),
    writeln('\nResultado'),
    writef('%w %w %w %w\n',[Breno,BrePizza,BrePizzaria,BrePreco]),
    writef('%w %w %w %w\n',[Gustavo,GusPizza,GusPizzaria,GusPreco]),
    writef('%w %w %w %w\n',[Nick,NiPizza,NiPizzaria,NiPreco]),
    writef('%w %w %w %w\n',[Osmar,OsPizza,OsPizzaria,OsPreco]),
    writef('%w %w %w %w\n',[Zeca,ZePizza,ZePizzaria,ZePreco]).

%Testa uma solução para todas as regras:                                    

    tab(Breno,BrePizza,BrePizzaria,BrePreco,Gustavo,GusPizza,GusPizzaria,GusPreco,Nick,NiPizza,NiPizzaria,NiPreco,Osmar,OsPizza,OsPizzaria,OsPreco,Zeca,ZePizza,ZePizzaria,ZePreco):-
    
        regra1a(Breno,BrePizza,BrePizzaria,BrePreco,Gustavo,GusPizza,GusPizzaria,GusPreco,Nick,NiPizza,NiPizzaria,NiPreco,Osmar,OsPizza,OsPizzaria,OsPreco,Zeca,ZePizza,ZePizzaria,ZePreco),

        regra1b(Breno,BrePizza,BrePizzaria,BrePreco,Gustavo,GusPizza,GusPizzaria,GusPreco,Nick,NiPizza,NiPizzaria,NiPreco,Osmar,OsPizza,OsPizzaria,OsPreco,Zeca,ZePizza,ZePizzaria,ZePreco),

        regra2a(Breno,BrePizza,BrePizzaria,BrePreco,Gustavo,GusPizza,GusPizzaria,GusPreco,Nick,NiPizza,NiPizzaria,NiPreco,Osmar,OsPizza,OsPizzaria,OsPreco,Zeca,ZePizza,ZePizzaria,ZePreco),

        regra2b(Breno,BrePizza,BrePizzaria,BrePreco,Gustavo,GusPizza,GusPizzaria,GusPreco,Nick,NiPizza,NiPizzaria,NiPreco,Osmar,OsPizza,OsPizzaria,OsPreco,Zeca,ZePizza,ZePizzaria,ZePreco),

        regra3(Breno,BrePizza,BrePizzaria,BrePreco,Gustavo,GusPizza,GusPizzaria,GusPreco,Nick,NiPizza,NiPizzaria,NiPreco,Osmar,OsPizza,OsPizzaria,OsPreco,Zeca,ZePizza,ZePizzaria,ZePreco),

        regra4a(Breno,BrePizza,BrePizzaria,BrePreco,Gustavo,GusPizza,GusPizzaria,GusPreco,Nick,NiPizza,NiPizzaria,NiPreco,Osmar,OsPizza,OsPizzaria,OsPreco,Zeca,ZePizza,ZePizzaria,ZePreco),

        regra4b(Breno,BrePizza,BrePizzaria,BrePreco,Gustavo,GusPizza,GusPizzaria,GusPreco,Nick,NiPizza,NiPizzaria,NiPreco,Osmar,OsPizza,OsPizzaria,OsPreco,Zeca,ZePizza,ZePizzaria,ZePreco),

        regra4c(Breno,BrePizza,BrePizzaria,BrePreco,Gustavo,GusPizza,GusPizzaria,GusPreco,Nick,NiPizza,NiPizzaria,NiPreco,Osmar,OsPizza,OsPizzaria,OsPreco,Zeca,ZePizza,ZePizzaria,ZePreco),

        regra5a(Breno,BrePizza,BrePizzaria,BrePreco,Gustavo,GusPizza,GusPizzaria,GusPreco,Nick,NiPizza,NiPizzaria,NiPreco,Osmar,OsPizza,OsPizzaria,OsPreco,Zeca,ZePizza,ZePizzaria,ZePreco),

        regra5b(Breno,BrePizza,BrePizzaria,BrePreco,Gustavo,GusPizza,GusPizzaria,GusPreco,Nick,NiPizza,NiPizzaria,NiPreco,Osmar,OsPizza,OsPizzaria,OsPreco,Zeca,ZePizza,ZePizzaria,ZePreco),

        regra5c(Breno,BrePizza,BrePizzaria,BrePreco,Gustavo,GusPizza,GusPizzaria,GusPreco,Nick,NiPizza,NiPizzaria,NiPreco,Osmar,OsPizza,OsPizzaria,OsPreco,Zeca,ZePizza,ZePizzaria,ZePreco),

        regra6a(Breno,BrePizza,BrePizzaria,BrePreco,Gustavo,GusPizza,GusPizzaria,GusPreco,Nick,NiPizza,NiPizzaria,NiPreco,Osmar,OsPizza,OsPizzaria,OsPreco,Zeca,ZePizza,ZePizzaria,ZePreco),

        regra6b(Breno,BrePizza,BrePizzaria,BrePreco,Gustavo,GusPizza,GusPizzaria,GusPreco,Nick,NiPizza,NiPizzaria,NiPreco,Osmar,OsPizza,OsPizzaria,OsPreco,Zeca,ZePizza,ZePizzaria,ZePreco),

        regra6c(Breno,BrePizza,BrePizzaria,BrePreco,Gustavo,GusPizza,GusPizzaria,GusPreco,Nick,NiPizza,NiPizzaria,NiPreco,Osmar,OsPizza,OsPizzaria,OsPreco,Zeca,ZePizza,ZePizzaria,ZePreco).


%Pega um de cada, fixa as variaveis numa possivel solucao com tudo diferente:

    tudodiferente(Breno,BrePizza,BrePizzaria,BrePreco,Gustavo,GusPizza,GusPizzaria,GusPreco,Nick,NiPizza,NiPizzaria,NiPreco,Osmar,OsPizza,OsPizzaria,OsPreco,Zeca,ZePizza,ZePizzaria,ZePreco) :-

        irmao(Breno),
        irmao(Gustavo),
        not(Breno=Gustavo),
        irmao(Nick),
        not(Nick=Breno),
        not(Nick=Gustavo),
        irmao(Osmar),
        not(Osmar=Breno),
        not(Osmar=Gustavo),
        not(Osmar=Nick),
        irmao(Zeca),
        not(Zeca=Breno),
        not(Zeca=Gustavo),
        not(Zeca=Nick),
        not(Zeca=Osmar),

        pizza(BrePizza),
        pizza(GusPizza),
        not(BrePizza=GusPizza),
        pizza(NiPizza),
        not(NiPizza=BrePizza),
        not(NiPizza=GusPizza),
        pizza(OsPizza),
        not(OsPizza=BrePizza),
        not(OsPizza=GusPizza),
        not(OsPizza=NiPizza),
        pizza(ZePizza),
        not(ZePizza=BrePizza),
        not(ZePizza=GusPizza),
        not(ZePizza=NiPizza),
        not(ZePizza=OsPizza),

        pizzaria(BrePizzaria),
        pizzaria(GusPizzaria),
        not(BrePizzaria=GusPizzaria),
        pizzaria(NiPizzaria),
        not(NiPizzaria=BrePizzaria),
        not(NiPizzaria=GusPizzaria),
        pizzaria(OsPizzaria),
        not(OsPizzaria=BrePizzaria),
        not(OsPizzaria=GusPizzaria),
        not(OsPizzaria=NiPizzaria),
        pizzaria(ZePizzaria),
        not(ZePizzaria=BrePizzaria),
        not(ZePizzaria=GusPizzaria),
        not(ZePizzaria=NiPizzaria),
        not(ZePizzaria=OsPizzaria),

        preco(BrePreco),
        preco(GusPreco),
        not(BrePreco=GusPreco),
        preco(NiPreco),
        not(NiPreco=BrePreco),
        not(NiPreco=GusPreco),
        preco(OsPreco),
        not(OsPreco=BrePreco),
        not(OsPreco=GusPreco),
        not(OsPreco=NiPreco),
        preco(ZePreco),
        not(ZePreco=BrePreco),
        not(ZePreco=GusPreco),
        not(ZePreco=NiPreco),
        not(ZePreco=OsPreco).
 
%ordem:(nome,pizza,pizzaria,preço),regra:(breno,_,_,_,gustavo,_,_,_,nick,_,_,_,osmar,_,_,_,zeca,_,_,_,).
%regra1b: Osmar Pediu a pizza da Palermo. 
 regra1a(_,_,_,_,_,_,_,_,_,_,_,_,osmar,_,palermo,_,_,_,_,_).

%ordem:(nome,pizza,pizzaria,preço),regra:(breno,_,_,_,gustavo,_,_,_,nick,_,_,_,osmar,_,_,_,zeca,_,_,_,).
%regra1b: A pizza de presunto não veio da pizzaria Dominique.
regra1b(_,presunto,_,_,_,_,dominique,_,_,_,_,_,_,_,_,_,_,_,_,_).
regra1b(_,presunto,_,_,_,_,_,_,_,_,dominique,_,_,_,_,_,_,_,_,_).
regra1b(_,presunto,_,_,_,_,_,_,_,_,_,_,_,_,dominique,_,_,_,_,_).
regra1b(_,presunto,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,dominique,_).

regra1b(_,_,dominique,_,_,presunto,_,_,_,_,_,_,_,_,_,_,_,_,_,_).
regra1b(_,_,_,_,_,presunto,_,_,_,_,dominique,_,_,_,_,_,_,_,_,_).
regra1b(_,_,_,_,_,presunto,_,_,_,_,_,_,_,_,dominique,_,_,_,_,_).
regra1b(_,_,_,_,_,presunto,_,_,_,_,_,_,_,_,_,_,_,_,dominique,_).

regra1b(_,_,dominique,_,_,_,_,_,_,presunto,_,_,_,_,_,_,_,_,_,_).
regra1b(_,_,_,_,_,_,dominique,_,_,presunto,_,_,_,_,_,_,_,_,_,_).
regra1b(_,_,_,_,_,_,_,_,_,presunto,_,_,_,_,dominique,_,_,_,_,_).
regra1b(_,_,_,_,_,_,_,_,_,presunto,_,_,_,_,_,_,_,_,dominique,_).

regra1b(_,_,dominique,_,_,_,_,_,_,_,_,_,_,presunto,_,_,_,_,_,_).
regra1b(_,_,_,_,_,_,dominique,_,_,_,_,_,_,presunto,_,_,_,_,_,_).
regra1b(_,_,_,_,_,_,_,_,_,_,dominique,_,_,presunto,_,_,_,_,_,_).
regra1b(_,_,_,_,_,_,_,_,_,_,_,_,_,presunto,_,_,_,_,dominique,_).

regra1b(_,_,dominique,_,_,_,_,_,_,_,_,_,_,_,_,_,_,presunto,_,_).
regra1b(_,_,_,_,_,_,dominique,_,_,_,_,_,_,_,_,_,_,presunto,_,_).
regra1b(_,_,_,_,_,_,_,_,_,_,dominique,_,_,_,_,_,_,presunto,_,_).
regra1b(_,_,_,_,_,_,_,_,_,_,_,_,_,_,dominique,_,_,presunto,_,_).
 
%ordem:(nome,pizza,pizzaria,preço),regra:(breno,_,_,_,gustavo,_,_,_,nick,_,_,_,osmar,_,_,_,zeca,_,_,_,).
%regra2a: A pizza escolhida por Nick custou RS 2,00 a menos do que a pizza suprema.
regra2a(_,suprema,_,Custo2,_,_,_,_,nick,_,_,Custo1,_,_,_,_,_,_,_,_):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    % (Custo1+2)=Custo2.
regra2a(_,_,_,_,_,suprema,_,Custo2,nick,_,_,Custo1,_,_,_,_,_,_,_,_):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.
regra2a(_,_,_,_,_,_,_,_,nick,_,_,Custo1,_,suprema,_,Custo2,_,_,_,_):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.
regra2a(_,_,_,_,_,_,_,_,nick,_,_,Custo1,_,_,_,_,_,suprema,_,Custo2):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.
 
%ordem:(nome,pizza,pizzaria,preço),regra:(breno,_,_,_,gustavo,_,_,_,nick,_,_,_,osmar,_,_,_,zeca,_,_,_,).
%regra2b: A pizza suprema não veio da pizzaria Dominique.
regra2b(_,suprema,_,_,_,_,dominique,_,_,_,_,_,_,_,_,_,_,_,_,_).
regra2b(_,suprema,_,_,_,_,_,_,_,_,dominique,_,_,_,_,_,_,_,_,_).
regra2b(_,suprema,_,_,_,_,_,_,_,_,_,_,_,_,dominique,_,_,_,_,_).
regra2b(_,suprema,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,dominique,_).

regra2b(_,_,dominique,_,_,suprema,_,_,_,_,_,_,_,_,_,_,_,_,_,_).
regra2b(_,_,_,_,_,suprema,_,_,_,_,dominique,_,_,_,_,_,_,_,_,_).
regra2b(_,_,_,_,_,suprema,_,_,_,_,_,_,_,_,dominique,_,_,_,_,_).
regra2b(_,_,_,_,_,suprema,_,_,_,_,_,_,_,_,_,_,_,_,dominique,_).

regra2b(_,_,dominique,_,_,_,_,_,_,suprema,_,_,_,_,_,_,_,_,_,_).
regra2b(_,_,_,_,_,_,dominique,_,_,suprema,_,_,_,_,_,_,_,_,_,_).
regra2b(_,_,_,_,_,_,_,_,_,suprema,_,_,_,_,dominique,_,_,_,_,_).
regra2b(_,_,_,_,_,_,_,_,_,suprema,_,_,_,_,_,_,_,_,dominique,_).

regra2b(_,_,dominique,_,_,_,_,_,_,_,_,_,_,suprema,_,_,_,_,_,_).
regra2b(_,_,_,_,_,_,dominique,_,_,_,_,_,_,suprema,_,_,_,_,_,_).
regra2b(_,_,_,_,_,_,_,_,_,_,dominique,_,_,suprema,_,_,_,_,_,_).
regra2b(_,_,_,_,_,_,_,_,_,_,_,_,_,suprema,_,_,_,_,dominique,_).

regra2b(_,_,dominique,_,_,_,_,_,_,_,_,_,_,_,_,_,_,suprema,_,_).
regra2b(_,_,_,_,_,_,dominique,_,_,_,_,_,_,_,_,_,_,suprema,_,_).
regra2b(_,_,_,_,_,_,_,_,_,_,dominique,_,_,_,_,_,_,suprema,_,_).
regra2b(_,_,_,_,_,_,_,_,_,_,_,_,_,_,dominique,_,_,suprema,_,_).
 
%ordem:(nome,pizza,pizzaria,preço),regra:(breno,_,_,_,gustavo,_,_,_,nick,_,_,_,osmar,_,_,_,zeca,_,_,_,).
%regra3: A pizza do Gustavo custou menos do que a pizza de calabresa.
regra3(_,calabresa,_,Custo2,gustavo,_,_,Custo1,_,_,_,_,_,_,_,_,_,_,_,_):-
    Custo1<Custo2.
regra3(_,_,_,_,gustavo,_,_,Custo1,_,calabresa,_,Custo2,_,_,_,_,_,_,_,_):-
    Custo1<Custo2.
regra3(_,_,_,_,gustavo,_,_,Custo1,_,_,_,_,_,calabresa,_,Custo2,_,_,_,_):-
    Custo1<Custo2.
regra3(_,_,_,_,gustavo,_,_,Custo1,_,_,_,_,_,_,_,_,_,calabresa,_,Custo2):-
    Custo1<Custo2.

%ordem:(nome,pizza,pizzaria,preço),regra:(breno,_,_,_,gustavo,_,_,_,nick,_,_,_,osmar,_,_,_,zeca,_,_,_,).
%regra4a: Breno não pediu a pizza suprema.
regra4a(breno,_,_,_,_,suprema,_,_,_,_,_,_,_,_,_,_,_,_,_,_).
regra4a(breno,_,_,_,_,_,_,_,_,suprema,_,_,_,_,_,_,_,_,_,_).
regra4a(breno,_,_,_,_,_,_,_,_,_,_,_,_,suprema,_,_,_,_,_,_).
regra4a(breno,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,suprema,_,_).

%ordem:(nome,pizza,pizzaria,preço),regra:(breno,_,_,_,gustavo,_,_,_,nick,_,_,_,osmar,_,_,_,zeca,_,_,_,).
%regra4b: A pizza do restaurante Sicília custou RS2,00 a menos do que a pizza da pizzaria vespa.
regra4b(_,_,sicilia,Custo1,_,_,vespa,Custo2,_,_,_,_,_,_,_,_,_,_,_,_):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.
regra4b(_,_,sicilia,Custo1,_,_,_,_,_,_,vespa,Custo2,_,_,_,_,_,_,_,_):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.
regra4b(_,_,sicilia,Custo1,_,_,_,_,_,_,_,_,_,_,vespa,Custo2,_,_,_,_):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.
regra4b(_,_,sicilia,Custo1,_,_,_,_,_,_,_,_,_,_,_,_,_,_,vespa,Custo2):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.

regra4b(_,_,vespa,Custo2,_,_,sicilia,Custo1,_,_,_,_,_,_,_,_,_,_,_,_):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.
regra4b(_,_,_,_,_,_,sicilia,Custo1,_,_,vespa,Custo2,_,_,_,_,_,_,_,_):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.
regra4b(_,_,_,_,_,_,sicilia,Custo1,_,_,_,_,_,_,vespa,Custo2,_,_,_,_):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.
regra4b(_,_,_,_,_,_,sicilia,Custo1,_,_,_,_,_,_,_,_,_,_,vespa,Custo2):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.

regra4b(_,_,vespa,Custo2,_,_,_,_,_,_,sicilia,Custo1,_,_,_,_,_,_,_,_):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.
regra4b(_,_,_,_,_,_,vespa,Custo2,_,_,sicilia,Custo1,_,_,_,_,_,_,_,_):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.
regra4b(_,_,_,_,_,_,_,_,_,_,sicilia,Custo1,_,_,vespa,Custo2,_,_,_,_):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.
regra4b(_,_,_,_,_,_,_,_,_,_,sicilia,Custo1,_,_,_,_,_,_,vespa,Custo2):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.

regra4b(_,_,vespa,Custo2,_,_,_,_,_,_,_,_,_,_,sicilia,Custo1,_,_,_,_):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.
regra4b(_,_,_,_,_,_,vespa,Custo2,_,_,_,_,_,_,sicilia,Custo1,_,_,_,_):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.
regra4b(_,_,_,_,_,_,_,_,_,_,vespa,Custo2,_,_,sicilia,Custo1,_,_,_,_):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.
regra4b(_,_,_,_,_,_,_,_,_,_,_,_,_,_,sicilia,Custo1,_,_,vespa,Custo2):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.

regra4b(_,_,vespa,Custo2,_,_,_,_,_,_,_,_,_,_,_,_,_,_,sicilia,Custo1):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.
regra4b(_,_,_,_,_,_,vespa,Custo2,_,_,_,_,_,_,_,_,_,_,sicilia,Custo1):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.
regra4b(_,_,_,_,_,_,_,_,_,_,vespa,Custo2,_,_,_,_,_,_,sicilia,Custo1):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.
regra4b(_,_,_,_,_,_,_,_,_,_,_,_,_,_,vespa,Custo2,_,_,sicilia,Custo1):-
    Custo_aux is Custo1 + 2,
    Custo2 == Custo_aux.
    %(Custo1+2)=Custo2.

%ordem:(nome,pizza,pizzaria,preço),regra:(breno,_,_,_,gustavo,_,_,_,nick,_,_,_,osmar,_,_,_,zeca,_,_,_,).
%regra4c: Zeca não pediu da pizzaria Vespa.
regra4c(_,_,vespa,_,_,_,_,_,_,_,_,_,_,_,_,_,zeca,_,_,_).
regra4c(_,_,_,_,_,_,vespa,_,_,_,_,_,_,_,_,_,zeca,_,_,_).
regra4c(_,_,_,_,_,_,_,_,_,_,vespa,_,_,_,_,_,zeca,_,_,_).
regra4c(_,_,_,_,_,_,_,_,_,_,_,_,_,_,vespa,_,zeca,_,_,_).

%ordem:(nome,pizza,pizzaria,preço),regra:(breno,_,_,_,gustavo,_,_,_,nick,_,_,_,osmar,_,_,_,zeca,_,_,_,).
%regra5a: Zeca não pediu a pizza de pepperoni.
regra5a(_,pepperoni,_,_,_,_,_,_,_,_,_,_,_,_,_,_,zeca,_,_,_).
regra5a(_,_,_,_,_,pepperoni,_,_,_,_,_,_,_,_,_,_,zeca,_,_,_).
regra5a(_,_,_,_,_,_,_,_,_,pepperoni,_,_,_,_,_,_,zeca,_,_,_).
regra5a(_,_,_,_,_,_,_,_,_,_,_,_,_,pepperoni,_,_,zeca,_,_,_).
 
%ordem:(nome,pizza,pizzaria,preço),regra:(breno,_,_,_,gustavo,_,_,_,nick,_,_,_,osmar,_,_,_,zeca,_,_,_,).
%regra5b: A pizza de Zeca não custou RS 16,00.
regra5b(_,_,_,16,_,_,_,_,_,_,_,_,_,_,_,_,zeca,_,_,_).
regra5b(_,_,_,_,_,_,_,16,_,_,_,_,_,_,_,_,zeca,_,_,_).
regra5b(_,_,_,_,_,_,_,_,_,_,_,16,_,_,_,_,zeca,_,_,_).
regra5b(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,16,zeca,_,_,_).

%ordem:(nome,pizza,pizzaria,preço),regra:(breno,_,_,_,gustavo,_,_,_,nick,_,_,_,osmar,_,_,_,zeca,_,_,_,).
%regra5c: A pizza de 16(que não é de zeca)  não veio da pizzaria Nápoles.
regra5c(_,_,Bpz,16,_,_,_,_,_,_,_,_,_,_,_,_,zeca,_,_,_):-
    not(Bpz = napoles).
regra5c(_,_,_,_,_,_,Gpz,16,_,_,_,_,_,_,_,_,zeca,_,_,_):-
    not(Gpz = napoles).
regra5c(_,_,_,_,_,_,_,_,_,_,Npz,16,_,_,_,_,zeca,_,_,_):-
    not(Npz = napoles).
regra5c(_,_,_,_,_,_,_,_,_,_,_,_,_,_,Opz,16,zeca,_,_,_):-
    not(Opz=napoles).
 
%ordem:(nome,pizza,pizzaria,preço),regra:(breno,_,_,_,gustavo,_,_,_,nick,_,_,_,osmar,_,_,_,zeca,_,_,_,).
%regra6a: A pizza de quatro queijos custa mais do que a pizza de calabresa.
regra6a(_,quatroqueijos,_,Custo1,_,calabresa,_,Custo2,_,_,_,_,_,_,_,_,_,_,_,_):-
    Custo1>Custo2.
regra6a(_,quatroqueijos,_,Custo1,_,_,_,_,_,calabresa,_,Custo2,_,_,_,_,_,_,_,_):-
    Custo1>Custo2.
regra6a(_,quatroqueijos,_,Custo1,_,_,_,_,_,_,_,_,_,calabresa,_,Custo2,_,_,_,_):-
    Custo1>Custo2.
regra6a(_,quatroqueijos,_,Custo1,_,_,_,_,_,_,_,_,_,_,_,_,_,calabresa,_,Custo2):-
    Custo1>Custo2.

regra6a(_,calabresa,_,Custo2,_,quatroqueijos,_,Custo1,_,_,_,_,_,_,_,_,_,_,_,_):-
    Custo1>Custo2.
regra6a(_,_,_,_,_,quatroqueijos,_,Custo1,_,calabresa,_,Custo2,_,_,_,_,_,_,_,_):-
    Custo1>Custo2.
regra6a(_,_,_,_,_,quatroqueijos,_,Custo1,_,_,_,_,_,calabresa,_,Custo2,_,_,_,_):-
    Custo1>Custo2.
regra6a(_,_,_,_,_,quatroqueijos,_,Custo1,_,_,_,_,_,_,_,_,_,calabresa,_,Custo2):-
    Custo1>Custo2.

regra6a(_,calabresa,_,Custo2,_,_,_,_,_,quatroqueijos,_,Custo1,_,_,_,_,_,_,_,_):-
    Custo1>Custo2.
regra6a(_,_,_,_,_,calabresa,_,Custo2,_,quatroqueijos,_,Custo1,_,_,_,_,_,_,_,_):-
    Custo1>Custo2.
regra6a(_,_,_,_,_,_,_,_,_,quatroqueijos,_,Custo1,_,calabresa,_,Custo2,_,_,_,_):-
    Custo1>Custo2.
regra6a(_,_,_,_,_,_,_,_,_,quatroqueijos,_,Custo1,_,_,_,_,_,calabresa,_,Custo2):-
    Custo1>Custo2.

regra6a(_,calabresa,_,Custo2,_,_,_,_,_,_,_,_,_,quatroqueijos,_,Custo1,_,_,_,_):-
    Custo1>Custo2.
regra6a(_,_,_,_,_,calabresa,_,Custo2,_,_,_,_,_,quatroqueijos,_,Custo1,_,_,_,_):-
    Custo1>Custo2.
regra6a(_,_,_,_,_,_,_,_,_,calabresa,_,Custo2,_,quatroqueijos,_,Custo1,_,_,_,_):-
    Custo1>Custo2.
regra6a(_,_,_,_,_,_,_,_,_,_,_,_,_,quatroqueijos,_,Custo1,_,calabresa,_,Custo2):-
    Custo1>Custo2.

regra6a(_,calabresa,_,Custo2,_,_,_,_,_,_,_,_,_,_,_,_,_,quatroqueijos,_,Custo1):-
    Custo1>Custo2.
regra6a(_,_,_,_,_,calabresa,_,Custo2,_,_,_,_,_,_,_,_,_,quatroqueijos,_,Custo1):-
    Custo1>Custo2.
regra6a(_,_,_,_,_,_,_,_,_,calabresa,_,Custo2,_,_,_,_,_,quatroqueijos,_,Custo1):-
    Custo1>Custo2.
regra6a(_,_,_,_,_,_,_,_,_,_,_,_,_,calabresa,_,Custo2,_,quatroqueijos,_,Custo1):-
    Custo1>Custo2.
 
%ordem:(nome,pizza,pizzaria,preço),regra:(breno,_,_,_,gustavo,_,_,_,nick,_,_,_,osmar,_,_,_,zeca,_,_,_,).
%regra6b: Nick não escolheu a pizza de calabresa
regra6b(_,calabresa,_,_,_,_,_,_,nick,_,_,_,_,_,_,_,_,_,_,_).
regra6b(_,_,_,_,_,calabresa,_,_,nick,_,_,_,_,_,_,_,_,_,_,_).
regra6b(_,_,_,_,_,_,_,_,nick,_,_,_,_,calabresa,_,_,_,_,_,_).
regra6b(_,_,_,_,_,_,_,_,nick,_,_,_,_,_,_,_,_,calabresa,_,_).

%ordem:(nome,pizza,pizzaria,preço),regra:(breno,_,_,_,gustavo,_,_,_,nick,_,_,_,osmar,_,_,_,zeca,_,_,_,).
%regra6c: Pizza de quatro queijos custou menos do que a de Zeca.
regra6c(_,quatroqueijos,_,Custo1,_,_,_,_,_,_,_,_,_,_,_,_,zeca,_,_,Custo2):-
    Custo1<Custo2.
regra6c(_,_,_,_,_,quatroqueijos,_,Custo1,_,_,_,_,_,_,_,_,zeca,_,_,Custo2):-
    Custo1<Custo2.
regra6c(_,_,_,_,_,_,_,_,_,quatroqueijos,_,Custo1,_,_,_,_,zeca,_,_,Custo2):-
    Custo1<Custo2.
regra6c(_,_,_,_,_,_,_,_,_,_,_,_,_,quatroqueijos,_,Custo1,zeca,_,_,Custo2):-
    Custo1<Custo2.
 /* ---------------------------------------------------------------------- */
/**
 * @ingroup GroupUnique
 * @brief copyright is det
 * @details Shows version and copyright information.
 * @return TRUE always.
 */
copyright :-
    writeln('exN - Version 20170412.201738'),
    writeln('Copyright (C) 2017 Ruben Carlo Benante <rcb@beco.cc>, GNU GPL version 2 <http://gnu.org/licenses/gpl.html>. This is free software: you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law. USE IT AS IT IS. The author takes no responsability to any damage this software may inflige in your data.').

/* ---------------------------------------------------------------------- */
/**
 * @ingroup GroupUnique
 * @brief verbose is det
 * @details Increases verbose level by one.
 * @return TRUE always.
 */
verbose :-
    verbosecounter(X),
    retractall(verbosecounter(_)),
    Y is X + 1,
    assert(verbosecounter(Y)).

/* ---------------------------------------------------------------------- */
/**
 * @ingroup GroupUnique
 * @brief verbose0 is det
 * @details Sets verbose level to zero.
 * @return TRUE always.
 */
verbose0 :-
    retractall(verbosecounter(_)),
    assert(verbosecounter(0)).

/* ---------------------------------------------------------------------- */
/**
 * @ingroup GroupUnique
 * @brief version is a fact
 * @details It will return the version number of program exN.
 * @param[out] A It's a string with the version number.
 * @return TRUE always.
 */
version('20170412.201738').

/* ---------------------------------------------------------------------- */
/**
 * @ingroup GroupUnique
 * @brief pai(?NomePai, ?NomeFilho) is det
 * @details O predicado pai indica quem eh o pai de determinado filho(a)
 *
 * @param[in,out] A is the father's name
 * @param[in,out] B is the son's (daughter's) name
 * @retval TRUE In pai(NomePai, NomeFilho) if NomePai is father of NomeFilho.
 * @retval FALSE otherwise.
*/
pai(joao,pedro).
pai(joao,clara).

/* ---------------------------------------------------------------------- */
/**
 * @ingroup GroupUnique
 * @brief mae(?NomeMae, ?NomeFilho) is det
 * @details O predicado mae indica quem eh a mae de determinado filho(a)
 *
 * @param[in,out] A Mother's name.
 * @param[in,out] B Son's (daughter's) name.
 * @retval TRUE In mae(NomeMae, NomeFilho) if NomeMae is mother of NomeFilho.
 * @retval FALSE otherwise.
*/
mae(maria,pedro).
mae(maria,manoel).

/* ---------------------------------------------------------------------- */
/**
 * @ingroup GroupUnique
 * @brief homem(?NomeHomem)
 * @details Indica que o nome apontado eh homem
 *
 * @param[in,out] A name of a masculine person.
 * @retval TRUE If homem(NomeHomem) is man.
 * @retval FALSE otherwise.
*/
homem(joao).
homem(pedro).
homem(manoel).

/* ---------------------------------------------------------------------- */
/**
 * @ingroup GroupUnique
 * @brief mulher(+NomeMulher)
 * @details Indica que o nome apontado eh mulher
 *
 * @param[in,out] A is a feminine person.
 * @retval TRUE If mulher(NomeMulher) is woman.
 * @retval FALSE otherwise.
*/
mulher(maria).
mulher(clara).

/* ---------------------------------------------------------------------- */
/**
 * @ingroup GroupUnique
 * @brief pais(?NomePais, ?NomeFilho)
 * @details Indica que NomePais eh o pai ou a mae do(a) NomeFilho(a)
 *
 * @param[in,out] A Father's or mother's name (parent).
 * @param[in,out] B B the son's (daughter's) name.
 * @retval TRUE In pais(NomePais, NomeFilho) if NomePais is father or mother of Nomefilho.
 * @retval FALSE otherwise.
*/
pais(X,Y) :-
    pai(X,Y).
pais(X,Y) :-
    mae(X,Y).

/* ----------------------------------------------------------------------- */
/* vi: set ai et ts=4 sw=4 tw=0 wm=0 fo=croql : PL config for Vim modeline */
/* Template by Dr. Beco <rcb at beco dot cc>       Version 20150620.224740 */

