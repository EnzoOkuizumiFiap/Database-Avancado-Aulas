create or replace function fn_calcular(num_1 number, num_2 number)
    return number is v_resultado number;
begin
    v_resultado := num_1 + num_2;
    return v_resultado;
end;


select fn_calcular(45, 5) from dual;