/* set serveroutput on; */            

declare
    /* 1 - Movimentações de estoque de um determinado produto */
    v_cod_produto NUMBER := 1;
    v_total NUMBER;
    
    /* 2 - FOR para calcular a média dos valores totais do cliente */
    v_cliente_id NUMBER := 37;
    v_soma number := 0;
    v_quantidade number := 0;
    v_media number;
    
    /* 3 - Produtos compostos ativos */
    v_lista varchar2(4000) := '';
    
    /* 4 - Calcular total de movimentações de um determinado produto do estoque */
    v_cod_produto2 number := 1;
    v_total2 number;
    
    /* 6 - Infos de pedidos e clientes relacionados usando RIGHT JOIN*/
    v_contador NUMBER := 0;
    
    /* 7 - Média valores totais de pedidos de um cliente + infos cliente usando INNER JOIN  */
    v_cliente NUMBER := 1;
    
begin
    /* 1 - Movimentação de estoque de um determinado produto */
    select SUM(qtd_movimentacao_estoque) into v_total from movimento_estoque where cod_produto = v_cod_produto;
    dbms_output.put_line('1 - Movimentação Estoque');
    dbms_output.put_line('Total de movimentações do produto ' || v_cod_produto || ' é ' || v_total || ' movimentações.');
    
    dbms_output.new_line;
    
    /* 2 - FOR para calcular a média dos valores totais do cliente */
    for registro in (select val_total_pedido from historico_pedido where cod_cliente = v_cliente_id) loop
        v_soma := v_soma + registro.val_total_pedido;
        v_quantidade := v_quantidade + 1;
    end loop;
    v_media := v_soma / v_quantidade;
    
    dbms_output.put_line('2 - FOR para calcular a média dos valores totais do cliente');
    dbms_output.put_line('Média dos pedidos: ' || round(v_media, 2));
    
    dbms_output.new_line;
    
    /* 3 - Produtos compostos ativos */
    dbms_output.put_line('3 - Produtos compostos ativos');
    for produtos in (select cod_produto from produto_composto where sta_ativo = 'S' order by cod_produto) loop
        IF v_lista IS NULL OR v_lista = '' THEN
            v_lista := produtos.cod_produto;
        ELSE
            v_lista := v_lista || ', ' || produtos.cod_produto;
        END IF;
    end loop;
    
    dbms_output.put_line('Está ativo?: S Produtos compostos: ' || v_lista);
    
    /*Testes: select * from produto_composto order by sta_ativo; */
    
    dbms_output.new_line;
    
    /* 4 - Calcular total de movimentações de um determinado produto do estoque */
    select SUM(me.qtd_movimentacao_estoque) into v_total2 
        from tipo_movimento_estoque tme INNER JOIN  movimento_estoque me on tme.cod_tipo_movimento_estoque = me.cod_tipo_movimento_estoque
    where me.cod_produto = v_cod_produto2;  
    dbms_output.put_line('4 - Calcular total de movimentações de um determinado produto do estoque');
    dbms_output.put_line('Total de movimentações com o produto ' || v_cod_produto2 || ' é ' || v_total2 || ' movimentações.');
    
    dbms_output.new_line;
    
    /* 5 - Exibir produtos compostos + suas infos de estoque usando LEFT JOIN */
    dbms_output.put_line('5 - Exibir produtos compostos + suas infos de estoque usando LEFT JOIN');
    for produtos in (select prod_comp.cod_produto,
            SUM(estoq_prod.qtd_produto) as total_estoque
        from produto_composto prod_comp LEFT JOIN estoque_produto estoq_prod 
            on prod_comp.cod_produto = estoq_prod.cod_produto
        group by prod_comp.cod_produto) loop
        
        dbms_output.put_line('Produto código: ' || produtos.cod_produto || ' Estoque: ' || produtos.total_estoque);
    end loop;
    
    /* Testes: SELECT prod_comp.cod_produto, prod_comp.cod_produto_relacionado, estoq_prod.cod_estoque,estoq_prod.qtd_produto  from produto_composto prod_comp INNER JOIN estoque_produto estoq_prod on prod_comp.cod_produto_relacionado = estoq_prod.cod_produto; */
    
    dbms_output.new_line;
    
    /* 6 - Infos de pedidos e clientes relacionados usando RIGHT JOIN */
    dbms_output.put_line('6 - Infos de pedidos e clientes relacionados usando RIGHT JOIN');
    for info in (select cliente.nom_cliente, cliente.cod_cliente, cliente.num_cpf_cnpj, cliente.tip_pessoa, pedido.cod_pedido, pedido.dat_pedido, pedido.dat_entrega, pedido.val_total_pedido, pedido.status from pedido RIGHT JOIN cliente ON pedido.cod_cliente = cliente.cod_cliente) loop 
        v_contador := v_contador + 1;
        EXIT WHEN v_contador > 10;
        
        dbms_output.put_line(
            'Cód. Cliente: ' || info.cod_cliente ||
            ' | Nome: ' || info.nom_cliente ||
            ' | Tipo: ' || info.tip_pessoa ||
            ' | Pedido: ' || info.cod_pedido || 
            ' | Data Pedido: ' || info.dat_pedido ||
            ' | Data Entrega: ' || info.dat_entrega ||
            ' | Valor Total: ' || info.val_total_pedido ||
            ' | Status: ' || info.status ||
            ' | CPF/CNPJ: ' ||info.num_cpf_cnpj
        );
    end loop;
    
    /*Testes: select cliente.cod_cliente, cliente.num_cpf_cnpj, cliente.tip_pessoa, pedido.cod_pedido, pedido.dat_pedido, pedido.dat_entrega, pedido.val_total_pedido, pedido.status from cliente cliente RIGHT JOIN pedido pedido on pedido.cod_cliente = cliente.cod_cliente;*/
    
    dbms_output.new_line;
    
    /* 7 - Média valores totais de pedidos de um cliente + infos cliente usando INNER JOIN */
    dbms_output.put_line('7 - Média valores totais de pedidos de um cliente + infos cliente usando INNER JOIN ');
    for m_cliente in (select cliente.cod_cliente, cliente.nom_cliente, cliente.tip_pessoa, cliente.num_cpf_cnpj, cliente.dat_cadastro , AVG(pedido.val_total_pedido) AS media_valor, SUM(pedido.val_total_pedido) AS total_valor from cliente INNER JOIN pedido on cliente.cod_cliente = pedido.cod_cliente where cliente.cod_cliente = v_cliente group by cliente.cod_cliente, cliente.nom_cliente, cliente.tip_pessoa, cliente.num_cpf_cnpj, cliente.dat_cadastro) loop
        dbms_output.put_line(
            'Cliente ID: ' || m_cliente.cod_cliente || 
            ' | Nome: ' || m_cliente.nom_cliente ||
            ' | Tipo: ' || m_cliente.tip_pessoa ||
            ' | CPF/CNPJ: ' || m_cliente.num_cpf_cnpj ||
            ' | Data Cadastro: ' || m_cliente.dat_cadastro ||
            ' | Média de Gastos: R$' || round(m_cliente.media_valor, 2) ||
            ' | Total Gastos: R$' || round(m_cliente.total_valor, 2)
        );
        end loop;
    
    /*Testes: select cliente.cod_cliente, cliente.nom_cliente, cliente.tip_pessoa, cliente.num_cpf_cnpj, cliente.dat_cadastro, pedido.val_total_pedido, pedido.val_total_pedido from cliente cliente INNER JOIN pedido pedido on cliente.cod_cliente = pedido.cod_cliente where cliente.cod_cliente = 1;*/
end;


