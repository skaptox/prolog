%Clientes%

cliente(johan).
cliente(juan).
cliente(gustavo).
cliente(oscar).

%Tipos linea de credito%

linea_de_credito(15).
linea_de_credito(30).

%Clientes con linea de creditos activas%

linea_credito_activa(johan).

realizo_compra_mes_1(johan).
realizo_compra_mes_1(juan).
realizo_compra_mes_1(oscar).


realizo_compra_mes_2(johan).
realizo_compra_mes_2(juan).
realizo_compra_mes_2(gustavo).

realizo_compra_mes_3(johan).
realizo_compra_mes_3(juan).


%Regla1%
%Un cliente solo puede tener aprobada una línea de crédito%
tiene_aprobada_linea_credito(C) :-
    cliente(C), linea_credito_activa(C).

%Regla2%
%La solicitud de una línea de crédito aplica solo a 
%clientes que tengan por lo menos una compra en cada uno de los 
%últimos 3 meses 
%
tiene_compras_ultimos_3_meses(C) :-
    realizo_compra_mes_1(C),realizo_compra_mes_2(C),realizo_compra_mes_3(C).

%Regla3%
%Existen dos tipos de linea de credito, de 15 o 30 dias%
linea_de_credito_valida(LC) :-
    linea_de_credito(LC).

%Regla4%
%Un cliente con línea de crédito aprobada debe pagar 
%sus pedidos antes del límite de días aprobado en su línea de crédito%


%Regla5%
%Si el cliente tiene en los últimos tres meses un tiempo de pago
% promedio de sus pedidos menor a 2 días, se le aprueba una línea 
% de crédito de 30 días por un monto no mayor que 2 veces al promedio 
% de los pedidos en el mismo lapso evaluado
%

menor_que(X,Y) :-
	X < Y.

mayor_que(X,Y) :-
	X > Y.

aprobar_linea_credito_30(TPP,PP) :-
    menor_que(TPP, 2) ->  LC is PP*2, writeln("Aprovada linea de credito 30 dias por "),writeln(LC).

aprobar_linea_credito_15(TPP,PP) :-
    menor_que(TPP, 5) ->  LC is PP*1.2, writeln("Aprovada linea de credito 15 dias por "),writeln(LC).
    

%Regla6%
%Si el cliente tiene en los últimos tres meses un tiempo de pago 
%promedio de sus pedidos menor a 5 días y mayor a 2 días, se le 
%aprueba una línea de crédito de 15 días por un monto no mayor que 
%1,2 veces al promedio de los pedidos en el mismo lapso evaluado


aprobar_linea_credito(C,TPP,PP) :-
	(cliente(C),
        \+tiene_aprobada_linea_credito(C),
        tiene_compras_ultimos_3_meses(C)) 
    -> (aprobar_linea_credito_30(TPP,PP);aprobar_linea_credito_15(TPP,PP)).