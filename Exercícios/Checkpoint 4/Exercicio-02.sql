/*
QUESTÃO 02 — Function: Calcular Total do Pedido (10 pontos)
    Implemente no body de pkg_pedidos a function: calcular_total_pedido(p_cod_pedido IN NUMBER) RETURN NUMBER que:
    
    a) Consulte a tabela ITEM_PEDIDO somando: (QTD_ITEM * VAL_UNITARIO_ITEM) - VAL_DESCONTO_ITEM para todos os itens do pedido informado.
    b) Retorne o total calculado.
    c) Se o pedido não possuir itens (NO_DATA_FOUND ou soma NULL), retorne 0.
    d) Atualize a coluna VAL_TOTAL_PEDIDO na tabela PEDIDO com o valor calculado antes de retornar.

*/

