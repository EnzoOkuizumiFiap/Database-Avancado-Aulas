--Enviando no banco de dados
call prd_insert_pais(87, 'Holanda');

begin
    prd_insert_pais(88, 'Itália');
end;

execute prd_insert_pais(89, 'Japão');

exec prd_insert_pais(90, 'China');