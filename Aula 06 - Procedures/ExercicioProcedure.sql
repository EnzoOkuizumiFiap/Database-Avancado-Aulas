select * from pais;

create or replace procedure prd_delete_pais (p_id pais.cod_pais%TYPE) as
begin 
    dbms_output.put_line( p_id || ' e ' || p_pais );
    delete from pais where cod_pais = p_id;
    commit;
end prd_delete_pais;

--Apagando do banco de dados
call prd_delete_pais(90);

--Apagando a procedure
drop procedure prd_delete_pais;