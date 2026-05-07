
declare 
    cursor c_funcionarios is select nome from funcionarios;
    v_nome funcionarios.nome%type;
begin
    open c_funcionarios;
    loop 
        fetch c_funcionarios into v_nome;
        exit when c_funcionarios%notfound;
        dbms_output.put_line('Nome Funcionário: ' || v_nome);
    end loop;
    
    close c_funcionarios;
end;