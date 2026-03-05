SET SERVEROUTPUT ON;

DECLARE 

    --Exercício 04
    valorcarro number := &valor;
    valorentrada number := 0.2;
    valorfinanciado number;
    
    parcela6x number;
    valorfinanciado6 number;
    
    parcela12x number;
    valorfinanciado12 number;
    
    parcela18x number;
    valorfinanciado18 number;
    
    escolhaparcela number := &parcela;

    
BEGIN
    
    dbms_output.put_line('Valor do Carro R$: ' || valorcarro);
    
    valorentrada := valorcarro * valorentrada;
    dbms_output.put_line('Valor da Entrada R$: ' || valorentrada);
    valorfinanciado := valorcarro - valorentrada;
    dbms_output.put_line('Valor Financiado R$: ' || valorfinanciado);
    
    
    /*Parcela 6x*/
    parcela6x := valorfinanciado * 1.10;
    valorfinanciado6 := parcela6x + valorentrada;
    dbms_output.put_line('Valor das Parcela em 6x R$: ' || round(parcela6x/6, 2));
    dbms_output.put_line('Valor Total Financiado em 6x R$: ' || valorfinanciado6);
    
    /*Parcela 12x*/
    parcela12x := valorfinanciado * 1.15;
    valorfinanciado12 := parcela12x + valorentrada;
    dbms_output.put_line('Valor das Parcela em 12x R$: ' || round(parcela12x/12, 2));
    dbms_output.put_line('Valor Total Financiado em 12x R$: ' || valorfinanciado12);
    
    /*Parcela 18x*/
    parcela18x := valorfinanciado * 1.20;
    valorfinanciado18 := parcela18x + valorentrada;
    dbms_output.put_line('Valor das Parcela em 18x R$: ' || round(parcela18x/18, 2));
    dbms_output.put_line('Valor Total Financiado em 18x R$: ' || valorfinanciado18);
    
    dbms_output.put_line('========================================');
    
    /*Usando If, elsif e else*/
    if escolhaparcela = 6 then
        dbms_output.put_line('Valor das Parcela em 6x R$: ' || round(valorfinanciado * 1.10/6, 2));
        dbms_output.put_line('Valor Total Financiado em 6x R$: ' || round((valorfinanciado * 1.10/6) + valorentrada, 2));
    elsif escolhaparcela = 12 then
        dbms_output.put_line('Valor das Parcela em 12x R$: ' || round(valorfinanciado * 1.15/12, 2));
        dbms_output.put_line('Valor Total Financiado em 12x R$: ' || round((valorfinanciado * 1.15/12) + valorentrada, 2));
    elsif escolhaparcela = 18 then
        dbms_output.put_line('Valor das Parcela em 18x R$: ' || round(valorfinanciado * 1.20/18, 2));
        dbms_output.put_line('Valor Total Financiado em 18x R$: ' || round((valorfinanciado * 1.20/18) + valorentrada, 2));
    else
        dbms_output.put_line('Valor da Parcela Incorreto!!!!!!!!!');
    end if;
    
END;

