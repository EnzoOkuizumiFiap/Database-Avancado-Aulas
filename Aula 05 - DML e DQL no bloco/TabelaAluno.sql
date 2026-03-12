/* CRIANDO TABELA ALUNO */
create table aluno (
    ra varchar2(10) primary key,
    nome varchar2(30),
    data_cadastro date
);

/* ALTERANDO TABLEA ALUNO E ADD NOTA*/
alter table aluno add nota number;

/* TABELA NOTA */
declare 
    v_ra varchar2(30) := '&ra';
    v_nome varchar2(40) := '&nome';
    v_data date := sysdate;

begin
    insert into aluno values (v_ra, v_nome, v_data);
    commit;
end;

select * from aluno;



/* TABELA NOTA */
declare 
    v_ra varchar2(10) := '&ra';
    v_nota number := &nota;
    
begin
    update aluno set nota = v_nota where ra = v_ra;
    commit;
end;



/* DELETANDO DA TABELA ALUNO */
declare 
    v_ra varchar2(10) := '&ra';
begin
    delete from aluno where ra = v_ra;
    
    commit;
end;






