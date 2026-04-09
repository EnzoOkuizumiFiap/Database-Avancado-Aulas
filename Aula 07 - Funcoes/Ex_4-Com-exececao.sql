create or replace function fn_salario2( id_func number) 
    return number is v_salario number;
begin 
    select salario into v_salario from funcionarios where id = id_func;
    return v_salario;
exception
    when no_data_found then
        return 'Funcionário não encontrado';
end;

