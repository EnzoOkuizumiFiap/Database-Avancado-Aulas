select * from pais;

-- Criando ou Substituindo procedure -> Procedure salva no banco de dados
create or replace procedure prd_insert_pais (
    p_id number, 
    p_pais varchar2
) as

begin 
    dbms_output.put_line( p_id || ' e ' || p_pais );
    insert into pais values (p_id, p_pais);
    commit;
end prd_insert_pais;

--Apagando a procedure
drop procedure prd_insert_pais;
