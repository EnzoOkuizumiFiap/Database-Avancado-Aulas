select * from estado;

create or replace procedure prd_update_estado (
    p_cod estado.cod_estado%TYPE, 
    p_nom estado.nom_estado%TYPE
) as
begin
    update estado set nom_estado = p_nom where cod_estado = p_cod;
    commit;
end prd_update_estado;

--Apagando a procedure
drop procedure prd_update_estado;

--Atualizando do banco de dados
call prd_update_estado(1, 'Acre2');