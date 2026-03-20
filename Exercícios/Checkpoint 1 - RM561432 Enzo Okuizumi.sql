declare
    /* 1 - IMC*/
    v_peso number(3) := &peso; -- &peso
    v_altura number(5) := &altura; -- &altura
    v_imc number;
    
    /* 2 - tabuada*/
    v_tabuada number(3) := &tabuada; -- &tabuada
    
    /* 3 - Fibonacci */
    v_contador number(2) := 1;
    v_quantidade number(3) := &fibonacci; --&fibonacci
    v_anterior number := 0;
    v_atual number := 1;
    v_proximo number;
    
    /* 4 - Pedido INNER JOIN */
    /* v_cod_pedido number(3); --&pedido
    codigo_cliente number(100);
    nome_cliente varchar(10); */

begin
    /* 1 - IMC */
    v_imc := v_peso / (v_altura * v_altura);
    
    if (v_imc < 18.5) then
        dbms_output.put_line('Abaixo do peso');
    elsif (v_imc >= 18.5 and v_imc <= 24.9) then
        dbms_output.put_line('Peso Normal');
    elsif (v_imc >= 25 and v_imc <= 29.9) then
        dbms_output.put_line('Sobrepeso');
    else
        dbms_output.put_line('Obesidade');
    end if;
    
    dbms_output.put_line('IMC: ' || round(v_imc, 2));
    
    dbms_output.new_line;
    
    /* 2 - tabuada */
    for v_contador in 1..10 loop
        dbms_output.put_line(v_contador || 'x' || v_tabuada || ' = ' || v_contador*v_tabuada);
    end loop;
    
    dbms_output.new_line;
    
    /* 3 - Fibonacci */
    while v_contador <= v_quantidade loop
        if v_quantidade <= 0 then
            dbms_output.put_line('Número Inválido! Informe um valor positivo!');
        else  
            v_proximo := v_anterior + v_atual;            
            dbms_output.put_line('Termo ' || v_contador || ': ' || v_atual);
            v_anterior := v_atual;
            v_atual := v_proximo;
        end if;

        v_contador := v_contador + 1;
    end loop;
    
    
    /* 4 - Pedido INNER JOIN */
    /* select cli.cod_cliente codigo_cliente, cli.nom_cliente, ped.cod_pedido, ped.cod_vendedor from cliente cli inner join pedido ped where cli.cod_cliente = 1; */

    /* 5 - Quantidade Clientes Sem Pedidos */
    
    /* 6 - Vendedor e Total clientes*/
    
    /* AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA, Esqueci como faz into... */
    
end;


