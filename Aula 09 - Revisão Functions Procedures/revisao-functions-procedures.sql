-- Procedure pode ter ou não retorno, ex: cálculos mais complexos, 
-- Function obrigatoriamente precisa ter retorno, ex: Tratamento de dado, um cálculo recorrente, um... 

CREATE OR REPLACE PROCEDURE prd_insert_alunos (p_id NUMBER, p_nome VARCHAR2, p_turma VARCHAR2, p_nota NUMBER) AS
BEGIN
    INSERT INTO alunos10 (id, name, turma, nota) 
        VALUES ( p_id, p_nome, p_turma, p_nota );
    COMMIT;
END;


-- select * from alunos10; -- Tabela vazia

// Chamando Procedures - Depende da linguagem, cada uma usa de uma forma!
call prd_insert_alunos(1, 'Enzo', 10, 10);
call prd_insert_alunos(5, 'Enzo', 10, 9);
call prd_insert_alunos(6, 'Enzo', 10, 8);


exec prd_insert_alunos(2, 'Maria', 10, 8);

execute prd_insert_alunos(3, 'João', 10, 2);

begin
    prd_insert_alunos(4, 'Milton', 10, 9);
end;



// Pegando a média via function
create function media_alunos (nome varchar2)
    return number is v_media number;
begin
    select ROUND(AVG(nota), 2) into v_media from alunos10 where name = nome;
    return v_media;
end;


// Chamando Function
select media_alunos('Enzo') from dual;




// Crie uma tabela para cadastro de funcionários que contenha os seguintes atributos:
// id, nome, departamento, salario

// Em seguida, crie uma procedure que faça INSERT nesta tabela (4 Funcionários)
// Depois crie uma função para fazer o cálculo de desconto de INSS (6% do salário de cada Funcionário)

//create table funcionarios(id number primary key, nome varchar2(30), departamento varchar2(30), salario number)

insert into funcionarios(id, nome, departamento, salario) values (1, 'Enzo', 'dept_a', 2500);
