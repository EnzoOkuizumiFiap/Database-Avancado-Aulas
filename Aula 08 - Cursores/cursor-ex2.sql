begin
    for x in (select nome from funcionarios) loop
        dbms_output.put_line('Nome do Funcionário Cadastrado é ' || x.nome);
    end loop;
end;