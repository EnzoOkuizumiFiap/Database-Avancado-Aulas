
-- Inserindo um dado na tabela pedido_vergs
select * from pedido_vergs;
INSERT INTO PEDIDO_VERGS (id, cod_pedido, nome_pedido) values (2, 05, 'Celular'); -- Não passamos o status do pedido

INSERT INTO PEDIDO_VERGS (id, cod_pedido, nome_pedido, status) values (3, 05, 'Celular', 'Em Transito'); -- Passamos um status para o pedido


-- Isso é um TRIGGER, é um gatilho
create or replace TRIGGER trg_pedido
    BEFORE INSERT ON pedido_vergs
    FOR EACH ROW
BEGIN
    -- Atualiza o status do pedido para "Novo" após a inserção
    IF :NEW.STATUS IS NULL THEN
        :NEW.STATUS := 'Novo Pedido';
    END IF;
    
END;

