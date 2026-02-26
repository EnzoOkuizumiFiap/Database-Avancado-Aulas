SET SERVEROUTPUT ON; --Informar para IDE que estou trabalhando , que quero que mostre todos os valores. Executar uma vez e depois não executar mais

--Depois de executar o SERVEROUTPUT, executa somente do DECLARE para baixo
DECLARE 
    v_nome varchar2(30);
    idade number := 18;
    
    --Vendo sobre operações aritméticas
    produto varchar2(30) := 'Televisão';
    qtd number := 2;
    valor number := 1200;
    parcelas number := 10;
    
    --Exercício de Conversão reais para doláres
    dolar number := 5.13;
    valorReais number := &valor;
    valorDolares number := 0;
    
    --Exercício Compra de Carro Parcelado
    valorCarro number := &valor;
    entrada number;
    parcelas number := 10;
    qrdparcelas number := 10;
    valorFinanciado number;
    
BEGIN

    v_nome := 'Enzo';
    dbms_output.put_line('O nome informado é : ' || v_nome);
    dbms_output.put_line('A idade informada é : ' || idade);
    
    --Operações aritméticas
    valor := valor * qtd;
    parcelas := valor / parcelas;
    
    dbms_output.put_line('Qual o produto comprado: ' || produto);
    dbms_output.put_line('Quantas Unidades Comprei : ' || qtd);
    dbms_output.put_line('Qual o valor unitário : R$' || valor);
    dbms_output.put_line('Valor de cada Parcelas : R$' || parcelas);
    
    --Exercício de Conversão reais para doláres
    valorDolares := valorReais / dolar;
    dbms_output.put_line('Valor doláres em: R$' || ROUND(valorDolares, 2));
    
    --Exercício Compra de Carro Parcelado
    dbms_output.put_line('Valor Carro a vista: R$' || valorCarro);
    entrada := valorCarro * 0.20;
    
    dbms_output.put_line('Valor Entrada: R$' || entrada);
    parcelas := ((valorCarro * 1.20) / parcelas) * 1.01;
    
    dbms_output.put_line('Valor Carro: R$' || valorCadaParcela);
    valorFinanciado := (parcelas * qtdparcelas) + entrada;
    
    dbms_output.put_line('Valor Total do Carro Financiado: R$' || valorFinanciado);
    
END;
