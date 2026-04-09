create or replace function fn_salario (id_func number)
    return number is v_salario number;
begin
    select salario into v_salario from funcionarios
    where id = id_func;
    return v_salario;
end;

select fn_salario(10) from dual;