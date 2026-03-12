declare 
    nomeCliente varchar2(30);
    codcliente number;
    
begin
    select nom_cliente, cod_cliente into nomeCliente, codcliente from cliente where cod_cliente = 100;
    
    dbms_output.put_line('O nome do cliente é: ' || nomeCliente || ' e codigo ' || codcliente);
end;