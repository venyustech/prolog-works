%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Hunt The Wumpus - World Simulator                                          %
%    Copyright (C) 2012 - 2016  Ruben Carlo Benante <rcb at beco dot cc>        %
%                                                                               %
%    This program is free software; you can redistribute it and/or modify       %
%    it under the terms of the GNU General Public License as published by       %
%    the Free Software Foundation; version 2 of the License.                    %
%                                                                               %
%    This program is distributed in the hope that it will be useful,            %
%    but WITHOUT ANY WARRANTY; without even the implied warranty of             %
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              %
%    GNU General Public License for more details.                               %
%                                                                               %
%    You should have received a copy of the GNU General Public License along    %
%    with this program; if not, write to the Free Software Foundation, Inc.,    %
%    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Special thanks to:
%     - Gregory Yob
%     - Larry Holder 
%     - Walter Nauber
%
% A Prolog implementation of the Wumpus world invented by Gregory Yob (1972)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To allow an agent to run with the Wumpus Simulator you need to define:
%   init_agent : 
%       It will be called only once, at the start. Put here definitions and
%       other start code you need (asserts, retracts, and so on)
%   run_agent :
%       It will be called each turn by the simulator.
%       Input: perceptions from the world.
%       Expected output: an action for the agent to perform.
%   world_setup([Size, Type, Move, Gold, Pit, Bat, [RandS, RandA]]):
%       This is a fact. It will be consulted only once at the beginning,
%       even before init_agent. It will configure the world as you say,
%       or use a default in case of conflicts or mistakes.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lista de Percepcao: [Stench, Breeze, Glitter, Bump, Scream, Rustle]
% Traducao: [Fedor, Vento, Brilho, Trombada, Grito, Ruido]
% Acoes possiveis (abreviacoes):
% goforward (go)                - andar
% turnright (turn, turnr ou tr) - girar sentido horario
% turnleft (turnl ou tl)        - girar sentido anti-horario
% grab (gr)                     - pegar o ouro
% climb (cl)                    - sair da caverna
% shoot (sh)                    - atirar a flecha
% sit (si)                      - sentar (nao faz nada, passa a vez)
%
% Costs (Custos):
% Actions: -1 (Andar/Girar/Pegar/Sair/Atirar/Sentar)
% Die: -1000 (morrer no buraco, wumpus ou de fadiga)
% Killing the Wumpus: +1000 (matar Wumpus)
% Climbing alive with golds: +500 for each gold (sair com ouro)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To run the example, start PROLOG with (rode o exemplo iniciando o prolog com):
% swipl -s agenteXXX.pl
% then do the query (faca a consulta):
% ?- start.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% world_setup([Size, Type, Move, Gold, Pit, Bat, Adv])
%
% Size and Type: - fig62, 4
%                - grid, [2-9] (default 4)
%                - dodeca, 20
%       +--------+-----------+
%       |  Type  |    Size   |
%       +--------+-----------+
%       | fig62  | 4 (fixed) |
%       | grid   | 2 ... 9   |
%       | dodeca | 20 (fixed)|
%       +--------+-----------+
%
% Configuration:
%    1.   Size: 0,2..9,20, where: grid is [2-9] or 0 for random, dodeca is 20, fig62 is 4.
%    2.   Type: fig62, grid or dodeca
%    3.   Move: stander, walker, runner (wumpus movement)
%    4.   Gold: Integer is deterministic number, float from 0.0<G<1.0 is probabilistic
%    5.   Pits: Idem, 0 is no pits.
%    6.   Bats: Idem, 0 is no bats.
%    7.   Adv: a list with advanced configuration in the form [RandS, RandA]:
%       - RandS - yes or no, random agent start position
%       - RandA - yes or no, random agent start angle of orientation
%
% examples: 
% * default:
%      world_setup([4, grid, stander, 0.1, 0.2, 0.1, [no, no]]).
% * size 5, 1 gold, 3 pits, some bats prob. 0.1, agent randomly positioned
%      world_setup([5, grid, stander, 1, 3, 0.1, [yes]]). 
%
%   Types of Wumpus Movement
%       walker    : original: moves when it hears a shoot, or you enter its cave
%       runner    : go forward and turn left or right on bumps, maybe on pits
%       wanderer  : arbitrarily choses an action from [sit,turnleft,turnright,goforward]
%       spinner   : goforward, turnright, repeat.
%       hoarder   : go to one of the golds and sit
%       spelunker : go to a pit and sit
%       stander   : do not move (default)
%       trapper   : goes hunting agent as soon as it leaves [1,1]; goes home otherwise
%       bulldozer : hunt the agent as soon as it smells him
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% agente001.pl:
%
% Strategy: goes only forward, do not turn, do not grab gold, do not come back
% Performance: it does not go very well as you can imagine
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- use_module(wumpus, [start/0]). % agente usa modulo simulador

% Versao 1.0
% Mundo: 
%    Tamanho (size) 5x5, quadrado (grid)
%    Wumpus nao anda
%    5% de chance de ouro por casa, 4 buracos e 1 morcego
%    agente inicia na casa [1,1], orientado para direita (0 graus)
%    Maximo de acoes antes de morrer de fome: Size^2x4 = 5x5x4 = 100 (media de 4 acoes por casa)
%world_setup([5, grid, stander, 0.05, 4, 1, [no, no]]).

% Versao 2.0
% Mundo: 
%    Tamanho (size) aleatorio, quadrado (grid)
%    Wumpus com andar original: quando escuta flechada ou quando se entra em sua casa
%    10% de chance de ouro por casa, 8% buracos e 6% morcego
%    agente inicia em casa aleatoria, orientado tambem aleatoriamente (use GPS)
%    Maximo de acoes antes de morrer de fome: Size^2x4 = media de 4 acoes por casa
%    ou seja, se mundo 5x5, maximo de acoes eh 5^2x4=100
%
world_setup([0, grid, walker, 0.1, 0.08, 0.06, [yes, yes]]).

% Versao 3.0
% Mundo: 
%    Tamanho (size) 20 casas, formato dodecaedro
%    Wumpus anda quando escuta flecha ou quando o agente entra em sua casa
%    5% de chance de ouro por casa, 3 buracos e 1 morcego
%    agente inicia na casa [1,1], orientado para direita (0 graus)
%    Maximo de acoes antes de morrer de fome: 100 (media de 5 acoes por casa)
%
%world_setup([20, dodeca, walker, 0.05, 3, 1, [no, no]]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Inicie aqui seu programa.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- use_module(library(lists)).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Predicados dinamicos que serao utilizados ao decorrer do codigo  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- dynamic([
objetivo/1,
posicaoAtual/1,
orientacaoAtual/1,
casas_visitadas/1,
casas_seguras/1,
casas_wumpus/1,
limite_superior/1,
limite_inferior/1,
limite_direito/1,
limite_esquerdo/1,
possuirFlechas/1,
gpsFeito/1,
posicaoInicial/1
]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Abaixo estarao os argumentos iniciais dos predicados dinamicos que serao usados 
% durante o codigo.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
objetivo(explorar).
posicaoAtual(nao).
orientacaoAtual(0).
casas_visitadas([[1,1]]).
casas_seguras([]).
casas_wumpus([]).
limite_superior(nao).
limite_direito(nao).
limite_inferior(nao).
limite_esquerdo(nao).


debug:-
    writeln('----------------------------------'),
    posicaoInicial(PosicaoInicial),
    posicaoAtual(PosicaoAtual),
    casas_seguras(ListaSeguras),
    casas_visitadas(ListaVisitadas),
    subtract(ListaSeguras,ListaVisitadas,ListaSegurasNaoVisitadas),
    casas_wumpus(ListaWumpus),
    objetivo(Objetivo),
    write('Posicao inicial: '),
    writeln(PosicaoInicial),
    write('Posicao atual: '),
    writeln(PosicaoAtual),
    write('Casas Seguras: '),
    writeln(ListaSeguras),
    write('Casas Visitadas: '),
    writeln(ListaVisitadas),
    write('Casas Seguras nao visitadas'),
    writeln(ListaSegurasNaoVisitadas),
    write('Lista Wumpus: '),
    writeln(ListaWumpus),
    write('Objetivo: '),
    writeln(Objetivo),
    writeln('----------------------------------').
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sempre acionado quando o predicado 'start' eh chamado.
% O init_agent tem uma funcao importante, a qual se da por, limpar a memoria dos 
% predicados dinamicos.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
init_agent:-
    redefinicao_dos_predicados.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Chamada do predicado 'run_agent' para gerar uma acao a cada percepcao 
% enviada pelo simulador.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run_agent(_,_):-
    posicaoAtual(Pos),
    Pos \== nao,
    adicionar_casa_atual_para_visitadas,
    fail.

run_agent(Percepcao, Acao) :- 
    debug,
    executarObjetivo(Percepcao, Acao).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sensacoes do agente
sentir_wumpus([yes|_]).
sentir_ouro([_,_,yes|_]).
sentir_perigo([_,yes|_]). %buraco
sentir_perigo([_,_,_,_,_,yes|_]).  %morcego
sentir_batida([_,_,_,yes|_]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
executaObjetivo([_,_,_,_,_,_,Coord],_) :-
    Coord = [].

executarObjetivo([_,_,_,_,_,_,[Coord|Orient]],_) :-
    retractall(posicaoInicial(_)),
    retractall(orientacaoAtual(_)),
    retractall(posicaoAtual(_)),
    assert(posicaoInicial(Coord)),
    assert(posicaoAtual(Coord)),
    assert(orientacaoAtual(Orient)),
    write('A casa atual eh: '),
    writeln(Coord),
    write('A orientacao atual eh: '),
    writeln(Orient),
    fail.%Definindo  acoes serem tomadas

executarObjetivo(Percepcao, shoot):-
    sentir_wumpus(Percepcao),
    possuirFlechas(sim),
    gastar_flechas,
    mudar_objetivo(sair),
    !.

executarObjetivo(Percepcao, grab):-
    sentir_ouro(Percepcao),
    mudar_objetivo(sair).

executarObjetivo(_,climb):-
    objetivo(sair),
    posicaoAtual([1,1]).

executarObjetivo(_,_) :-
    posicaoInicial(PosInicial),
    not(casas_seguras([PosInicial])),
    casas_seguras(Listas_casas_seguras),
    casas_visitadas(Listas_casas_visitadas),
    subtract(Listas_casas_seguras,Listas_casas_visitadas,[]),
    mudar_objetivo(sair),
    fail.

executarObjetivo(Percepcao,_) :-
    sentir_batida(Percepcao),
    retornar_para_posicao_anterior,
    define_mapa,
    remove_casa_fora,
    fail.

executarObjetivo(Percepcao,_):-
    mapear_casas(Percepcao),
    fail.

executarObjetivo(_,Acao):-
    movimentar(Acao).

mudar_objetivo(NovoObjetivo):-
    retractall(objetivo(_)),
    asserta(objetivo(NovoObjetivo)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A parte logo em seguida se da em relacao a movimentacao do agente no mapa 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
movimentar(Acao) :-
    writeln('********** Movimentar ************'),
    definicao_do_destino(Casa_destino),
    write('Destino: '),
    writeln(Casa_destino),
    definicao_da_proxima_casa(Casa_destino,Proxima_casa),
    write('Proxima Casa    '),
    writeln(Proxima_casa    ),
    escolher_movimento(Proxima_casa, Acao),
    writeln('**********    ******').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Os predicados irao ter a definicao de qual destino o agente ira tomar, depen-
% dendo da posicao atual do agente.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
definicao_do_destino([1,1]) :-
    objetivo(sair).

definicao_do_destino(Casa_destino) :-
    casas_seguras(Lista_casas_seguras),
    casas_visitadas(Lista_casas_visitadas),
    subtract(Lista_casas_seguras, Lista_casas_visitadas, Lista_casas_seguras_n_visitadas),
    Lista_casas_seguras_n_visitadas = [Casa_destino|_].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O predicado abaixo tera a funcao de definir a casa seguinte que o agente ira 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
definicao_da_proxima_casa(Casa_destino, Proxima_casa) :-
    posicaoAtual(Posicao_atual),
    casas_adjacentes(Posicao_atual, Lista_casas_adjacentes),
    casas_seguras(Lista_casas_seguras),
    subtract(Lista_casas_adjacentes, Lista_casas_seguras, Lista_casas_adjacentes_seguras),
    casa_proxima_do_destino(Lista_casas_adjacentes_seguras, Casa_destino, Proxima_casa).
definicao_da_proxima_casa(CasaDestino, ProximaCasa) :-
    posicaoAtual(PosAtual),
    casas_adjacentes(PosAtual, ListaAdjacentes),
    casas_seguras(ListaSeguras),
    subtract(ListaAdjacentes,ListaSeguras,ListaAdjacentesSeguras),
    ListaAdjacentesSeguras = [],
    casa_proxima_do_destino(ListaAdjacentes,CasaDestino,ProximaCasa).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O predicado abaixo ira definir a casa mais perto do destino o qual o agente
% seguira.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
casa_proxima_do_destino(Lista_casas_adjacentes, Casa_destino, Proxima_casa) :-
    gerar_lista_de_distancias(Lista_casas_adjacentes, Casa_destino, Lista_distancias),
    escolhe_menor_distancia(Lista_distancias, Menor_distancia),
    nth1(Indice_menor, Lista_distancias, Menor_distancia),
    nth1(Indice_menor, Lista_casas_adjacentes, Proxima_casa),
    !.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gerar lista das distancias

gerar_lista_de_distancias([],_,[]).

gerar_lista_de_distancias([PrimeiraCasa|CasasRestantes],CasaDestino,ListaDistancias) :-
    gerar_lista_de_distancias(CasasRestantes,CasaDestino,ListaDistanciasRestantes),
    distancia_entre_duas_casas(PrimeiraCasa,CasaDestino,DistanciaPrimeira),
    ListaDistancias = [DistanciaPrimeira|ListaDistanciasRestantes].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Escolhe a lista com a menor distancia
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

escolhe_menor_distancia([],8000):-
    !.

escolhe_menor_distancia([PrimDist|DistRest],Dist_menor_rest):-
    escolhe_menor_distancia(DistRest,Dist_menor_rest),
    not(PrimDist < Dist_menor_rest).

escolhe_menor_distancia([PrimDist|_], PrimDist).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%w
%predicado para mudar posicao e orientacao

escolher_movimento(ProximaCasa,goforward):-
    posicaoAtual(PosAtual),
    estaAlinhado(ProximaCasa,PosAtual),
    mudarPosicao(PosAtual),
    !.
escolher_movimento(_,turnleft):-
    orientacaoAtual(270),
    mudarOrientacao(0).

escolher_movimento(_,turnleft):-
    orientacaoAtual(Orient),
    NovaOrient is Orient + 90,
    mudarOrientacao(NovaOrient).

mudarOrientacao(NovaOrient):-
    retractall(orientacaoAtual(_)),
    asserta(orientacaoAtual(NovaOrient)),
    !.

mudarPosicao(PosicaoInicial):-
    retract(posicaoAtual(nao)),
    asserta(posicaoAtual(PosicaoInicial)),
    !.

mudarPosicao([Xant,Yant]):-
    orientacaoAtual(0),
    Xdep is Xant + 1,
    retract(posicaoAtual([Xant,Yant])),
    asserta(posicaoAtual([Xdep,Yant])).
mudarPosicao([Xant,Yant]):-
    orientacaoAtual(90),
    Ydep is Yant + 1,
    retract(posicaoAtual([Xant,Yant])),
    asserta(posicaoAtual([Xant,Ydep])).
mudarPosicao([Xant,Yant]):-
    orientacaoAtual(180),
    Xdep is Xant - 1,
    retract(posicaoAtual([Xant,Yant])),
    asserta(posicaoAtual([Xdep,Yant])).
mudarPosicao([Xant,Yant]):-
    orientacaoAtual(270),
    Ydep is Yant - 1,
    retract(posicaoAtual([Xant,Yant])),
    asserta(posicaoAtual([Xant,Ydep])).

estaAlinhado([Xprox,Yatual],[Xatual,Yatual]):-
    orientacaoAtual(0),
    Xprox > Xatual,
    !.
estaAlinhado([Xprox,Yatual],[Xatual,Yatual]):-
    orientacaoAtual(180),
    Xprox < Xatual,
    !.
estaAlinhado([Xatual,Yprox],[Xatual,Yatual]):-
    orientacaoAtual(90),
    Yprox > Yatual,
    !.
estaAlinhado([Xatual,Yprox],[Xatual,Yatual]):-
    orientacaoAtual(270),
    Yprox < Yatual.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Predicado que coloca a casa atual para visitadas

adicionar_casa_atual_para_visitadas:-
    posicaoAtual(PosAtual),
    casas_visitadas(ListasVisitadasAntiga),
    union(ListasVisitadasAntiga,[PosAtual],ListasVisitadasNova),
    retract(casas_visitadas(ListasVisitadasAntiga)),
    asserta(casas_visitadas(ListasVisitadasNova)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mapeamento: Os predicados abaixo serao responsaveis por definir casas adjacentes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mapear_casas(Percepcao):-
    mapear_seguras(Percepcao),
    mapear_wumpus(Percepcao).

mapear_seguras(Percepcao):-
    not(sentir_perigo(Percepcao)),
    not(sentir_wumpus(Percepcao)),
    posicaoAtual(Posicao_atual),
    casas_adjacentes(Posicao_atual,Lista_casas_adjacentes),
    adicionar_casas_seguras(Lista_casas_adjacentes).

mapear_seguras(_).

mapear_wumpus(Percepcao):-
    sentir_wumpus(Percepcao),
    posicaoAtual(Posicao_atual),
    casas_seguras(Lista_casas_seguras),
    casas_adjacentes(Posicao_atual, Lista_casas_adjacentes),
    subtract(Lista_casas_adjacentes, Lista_casas_seguras, Lista_casas_adjacentes_wumpus),
    adicionar_casas_wumpus(Lista_casas_adjacentes_wumpus).
mapear_wumpus(_).

adicionar_casas_seguras(Novas_casas):-
    casas_seguras(Lista_casas_antigas),
    casas_wumpus(ListaW),
    union(Lista_casas_antigas, Novas_casas, Nova_lista_casas_seguras),
    subtract(ListaW,Novas_casas,ListaWnova),
    retract(casas_wumpus(ListaW)),
    retract(casas_seguras(Lista_casas_antigas)),
    asserta(casas_wumpus(ListaWnova)),
    asserta(casas_seguras(Nova_lista_casas_seguras)).

adicionar_casas_wumpus(Novas_casas):-
    casas_wumpus(Lista_casas_antigas),
    union(Lista_casas_antigas, Novas_casas, Nova_lista_casas_wumpus),
    retract(casas_wumpus(Lista_casas_antigas)),
    asserta(casas_wumpus(Nova_lista_casas_wumpus)).

casas_adjacentes(Posicao,ListaAdjacentes):-
    adicionar_casa_superior(Posicao,[],Lista1),
    adicionar_casa_direita(Posicao,Lista1,Lista2),
    adicionar_casa_inferior(Posicao,Lista2,Lista3),
    adicionar_casa_esquerda(Posicao,Lista3,ListaAdjacentes).
adicionar_casa_superior([X,Y], ListaAntes, ListaDepois):-
    limite_superior(nao),
    Ysup is Y + 1,
    append(ListaAntes,[[X,Ysup]],ListaDepois),
    !.
adicionar_casa_superior([X,Y], ListaAntes, ListaDepois) :-
    limite_superior(LimSup),
    Ysup is Y + 1,
    Ysup =< LimSup,
    append(ListaAntes,[[X,Ysup]],ListaDepois),
    !.

adicionar_casa_direita([X,Y], ListaAntes, ListaDepois) :-
    limite_direito(nao),
    Xdir is X + 1,
    append(ListaAntes,[[Xdir,Y]],ListaDepois),
    !.
adicionar_casa_direita([X,Y], ListaAntes, ListaDepois) :-
    limite_direito(LimDir),
    Xdir is X + 1,
    Xdir =< LimDir,
    append(ListaAntes,[[Xdir,Y]],ListaDepois).
adicionar_casa_direita(_,ListaAntes,ListaAntes).

adicionar_casa_inferior([X,Y], ListaAntes, ListaDepois) :-
    limite_inferior(nao),
    Yinf is Y - 1,
    append(ListaAntes,[[X,Yinf]],ListaDepois),
    !.
adicionar_casa_inferior([X,Y], ListaAntes, ListaDepois) :-
    limite_inferior(LimInf),
    Yinf is Y - 1,
    Yinf >= LimInf,
    append(ListaAntes, [[X,Yinf]],ListaDepois).

adicionar_casa_inferior(_,ListaAntes,ListaAntes).

adicionar_casa_esquerda([X,Y], ListaAntes, ListaDepois) :-
    limite_esquerdo(nao),
    Xesq is X-1,
    append(ListaAntes, [[Xesq,Y]],ListaDepois),
    !.
adicionar_casa_esquerda([X,Y], ListaAntes, ListaDepois) :-
    limite_esquerdo(LimEsq),
    Xesq is X - 1,
    Xesq >= LimEsq,
    append(ListaAntes, [[Xesq,Y]],ListaDepois).

adicionar_casa_esquerda(_,ListaAntes,ListaAntes).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Esse predicado ira definir o limite do mapa a ser explorado
% Quando o simulador enviar a percepcao de trombada, este predicado buscara o tamanho do mapa e definira qual tamanho exato(ex:4x4,5x5..)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
define_mapa:-
    orientacaoAtual(0),
    define_limite_direito.

define_mapa:-
    orientacaoAtual(180),
    define_limite_esquerdo.

define_mapa:-
    orientacaoAtual(90),
    define_limite_superior.

define_mapa:-
    orientacaoAtual(270),
    define_limite_inferior.

define_limite_direito:-
    posicaoAtual([Limx,_]),
    retract(limite_direito(nao)),
    asserta(limite_direito(Limx)).

define_limite_esquerdo:-
    posicaoAtual([Limx,_]),
    retract(limite_esquerdo(nao)),
    asserta(limite_esquerdo(Limx)).

define_limite_superior:-
    posicaoAtual([_,Limy]),
    retract(limite_superior(nao)),
    asserta(limite_superior(Limy)).

define_limite_inferior:-
    posicaoAtual([_,Limy]),
    retract(limite_inferior(nao)),
    asserta(limite_inferior(Limy)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove Casas que estao fora do Limite do mapa
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

remove_casa_fora:-
    remove_seguras,
    remove_wumpus,
    remove_visitadas.

remove_seguras:-
    casas_seguras(Lista_seguras),
    casas_fora_do_mapa(Lista_seguras,Lista_segura_fora),
    subtract(Lista_seguras,Lista_segura_fora,Lista_segura_dentro),
    retract(casas_seguras(Lista_seguras)),
    asserta(casas_seguras(Lista_segura_dentro)).

remove_wumpus:-
    casas_wumpus(Lista_wumpus),
    casas_fora_do_mapa(Lista_wumpus,Lista_wumpus_fora),
    subtract(Lista_wumpus,Lista_wumpus_fora,Lista_wumpus_dentro),
    retract(casas_wumpus(Lista_wumpus)),
    asserta(casas_wumpus(Lista_wumpus_dentro)).

remove_visitadas:-
    casas_visitadas(Lista_visitadas),
    casas_fora_do_mapa(Lista_visitadas,Lista_visitadas_fora),
    subtract(Lista_visitadas,Lista_visitadas_fora,Lista_visitadas_dentro),
    retract(casas_visitadas(Lista_visitadas)),
    asserta(casas_seguras(Lista_visitadas_dentro)).

casas_fora_do_mapa(Lista_casas,Lista_casas_fora):-
    findall(Casa,fora_do_mapa(Casa,Lista_casas),Lista_casas_fora).

fora_do_mapa(Casa,Lista_casas):-
    member(Casa,Lista_casas),
    limite_horizontal(Casa).

fora_do_mapa(Casa,Lista_casas):-
    member(Casa,Lista_casas),
    limite_vertical(Casa).
limite_horizontal([X,_]):-
    limite_direito(Xdir),
    Xdir \== nao,
    X > Xdir.

limite_horizontal([X,_]):-
    limite_esquerdo(Xesq),
    Xesq \== nao,
    X < Xesq.

limite_vertical([_,Y]):-
    limite_superior(Ysup),
    Ysup \== nao,
    Y > Ysup.

limite_vertical([_,Y]):-
    limite_inferior(Yinf),
    Yinf \== nao,
    Y < Yinf.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O agente retorna para a posicao anterior

retornar_para_posicao_anterior :-
    orientacaoAtual(0),
    posicaoAtual([Xerrado,Y]),
    Xcerto is Xerrado - 1,
    retract(posicaoAtual([Xerrado,Y])),
    asserta(posicaoAtual([Xcerto,Y])).

retornar_para_posicao_anterior :-
    orientacaoAtual(180),
    posicaoAtual([Xerrado,Y]),
    Xcerto is Xerrado + 1,
    retract(posicaoAtual([Xerrado,Y])),
    asserta(posicaoAtual([Xcerto,Y])).

retornar_para_posicao_anterior :-
    orientacaoAtual(90),
    posicaoAtual([X,Yerrado]),
    Ycerto is Yerrado - 1,
    retract(posicaoAtual([X,Yerrado])),
    asserta(posicaoAtual([X,Ycerto])).

retornar_para_posicao_anterior :-
    orientacaoAtual(270),
    posicaoAtual([X,Yerrado]),
    Ycerto is Yerrado + 1,
    retract(posicaoAtual([X,Yerrado])),
    asserta(posicaoAtual([X,Ycerto])).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
distancia_entre_duas_casas([X1,Y1],[X2,Y2], Dist):-
    Varx is X1 - X2,
    Vary is Y1 - Y2,
    Dist is sqrt(Varx*Varx + Vary*Vary).

gastar_flechas:-
    retract(possuirFlechas(sim)),
    asserta(possuirFlechas(nao)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O predicado feito abaixo tera a funcao de limpar a memoria dos predicados uti-
% lizados dentro do codigo.
% Ele ira ser chamado pelo predicado init_agent.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
redefinicao_dos_predicados:-
    redefinir_casas_seguras,
    redefinir_casas_visitadas,
    redefinir_casas_wumpus,
    redefinir_posicaoAtual,
    redefinir_orientacaoAtual,
    redefinir_objetivo,
    redefinir_possuirFlechas,
    redefinir_limites,
    resetarGPS,
    resetarPosicaoInicial.


resetarPosicaoInicial :-
    retractall(posicaoInicial(_)),
    asserta(posicaoInicial(nao)).

resetarGPS :-
    retractall(gpsFeito(_)),
    asserta(gpsFeito(nao)).

redefinir_casas_seguras:-
    retractall(casas_seguras(_)),
    asserta(casas_seguras([[1,1]])).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O predicado abaixo tera a funcao de redefinir as casas visitadas.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
redefinir_casas_visitadas :-
    retractall(casas_visitadas(_)),
    asserta(casas_visitadas([])).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O predicado abaixo tera a funcao de redefinir as casas dos wumpus.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
redefinir_casas_wumpus :-
    retractall(casas_wumpus(_)),
    asserta(casas_wumpus([])).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O predicado abaixo tera a funcao de redefinir a posicao atual do agente.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
redefinir_posicaoAtual :-
    retractall(posicaoAtual(_)),
    asserta(posicaoAtual(nao)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O predicado abaixo tera a funcao de redefinir a orientacao atual do agente.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
redefinir_orientacaoAtual :-
    retractall(orientacaoAtual(_)),
    asserta(orientacaoAtual(0)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O predicado abaixo tera a funcao de redefinir o predicado objetivo.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
redefinir_objetivo :-
    retractall(objetivo(_)),
    asserta(objetivo(explorar)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O predicado abaixo tera a funcao de redefinir o predicado que fala se o agente
% possui ou nao flechas.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
redefinir_possuirFlechas :-
    retractall(possuirFlechas(_)),
    assert(possuirFlechas(sim)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O predicado abaixo tera a funcao de redefinir o predicado que define 
% os limites.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
redefinir_limites :-
    retractall(limite_superior(_)),
    retractall(limite_inferior(_)),
    retractall(limite_esquerdo(_)),
    retractall(limite_direito(_)),
    assert(limite_superior(nao)),
    assert(limite_inferior(nao)),
    assert(limite_esquerdo(nao)),
    assert(limite_direito(nao)).


/* ----------------------------------------------------------------------- */
/* vi: set ai et ts=4 sw=4 tw=0 wm=0 fo=croql : PL config for Vim modeline */
/* Template by Dr. Beco <rcb at beco dot cc>       Version 20150620.224740 */
