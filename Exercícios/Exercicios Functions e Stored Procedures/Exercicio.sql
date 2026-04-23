SET SERVEROUTPUT ON;
-- Atividade 1
CREATE OR REPLACE FUNCTION FN_TOTAL_PEDIDOS_CLIENTE(
    p_cod_cliente IN CLIENTE.COD_CLIENTE%TYPE
) RETURN NUMBER IS
    v_total       NUMBER := 0;
    v_existe      NUMBER := 0;
    e_cliente_nao_encontrado EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO v_existe
    FROM CLIENTE
    WHERE COD_CLIENTE = p_cod_cliente;

    IF v_existe = 0 THEN
        RAISE e_cliente_nao_encontrado;
    END IF;

    SELECT NVL(SUM(VAL_TOTAL_PEDIDO), 0) INTO v_total
    FROM PEDIDO
    WHERE COD_CLIENTE = p_cod_cliente;

    RETURN v_total;

EXCEPTION
    WHEN e_cliente_nao_encontrado THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Cliente ' || p_cod_cliente || ' não encontrado.');
        RETURN -1;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || SQLERRM);
        RETURN -1;
END;
/

-- Atividade 2
CREATE OR REPLACE FUNCTION FN_ESTOQUE_DISPONIVEL(
    p_cod_produto IN PRODUTO.COD_PRODUTO%TYPE
) RETURN NUMBER IS
    v_quantidade  NUMBER := 0;
    v_existe      NUMBER := 0;
    e_produto_invalido EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO v_existe
    FROM PRODUTO
    WHERE COD_PRODUTO = p_cod_produto
      AND STA_ATIVO = 'S';

    IF v_existe = 0 THEN
        RAISE e_produto_invalido;
    END IF;

    SELECT NVL(SUM(QTD_PRODUTO), 0) INTO v_quantidade
    FROM ESTOQUE_PRODUTO
    WHERE COD_PRODUTO = p_cod_produto;

    RETURN v_quantidade;

EXCEPTION
    WHEN e_produto_invalido THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Produto ' || p_cod_produto || ' não encontrado ou inativo.');
        RETURN -1;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || SQLERRM);
        RETURN -1;
END;
/

-- Atividade 3
CREATE OR REPLACE PROCEDURE PRC_DETALHES_PEDIDO(
    p_cod_pedido IN PEDIDO.COD_PEDIDO%TYPE
) IS
    CURSOR c_pedido IS
        SELECT P.COD_PEDIDO,
               P.DAT_PEDIDO,
               P.VAL_TOTAL_PEDIDO,
               C.NOM_CLIENTE,
               NVL(V.NOM_VENDEDOR,    'Não informado') AS NOM_VENDEDOR,
               NVL(E.DES_ENDERECO,    'Não informado') AS DES_ENDERECO,
               NVL(E.NUM_ENDERECO,    'Não informado') AS NUM_ENDERECO,
               NVL(E.DES_BAIRRO,      'Não informado') AS DES_BAIRRO,
               NVL(TO_CHAR(E.COD_CIDADE), 'Não informado') AS COD_CIDADE
        FROM PEDIDO P
        INNER JOIN CLIENTE C         ON P.COD_CLIENTE          = C.COD_CLIENTE
        LEFT JOIN  VENDEDOR V        ON P.COD_VENDEDOR          = V.COD_VENDEDOR
        LEFT JOIN  ENDERECO_CLIENTE E ON P.SEQ_ENDERECO_CLIENTE = E.SEQ_ENDERECO_CLIENTE
        WHERE P.COD_PEDIDO = p_cod_pedido;

    v_reg         c_pedido%ROWTYPE;
    e_pedido_nao_encontrado EXCEPTION;
BEGIN
    OPEN c_pedido;
    FETCH c_pedido INTO v_reg;

    IF c_pedido%NOTFOUND THEN
        RAISE e_pedido_nao_encontrado;
    END IF;

    CLOSE c_pedido;

    DBMS_OUTPUT.PUT_LINE('=== DETALHES DO PEDIDO ===');
    DBMS_OUTPUT.PUT_LINE('Pedido    : ' || v_reg.COD_PEDIDO);
    DBMS_OUTPUT.PUT_LINE('Data      : ' || TO_CHAR(v_reg.DAT_PEDIDO, 'DD/MM/YYYY'));
    DBMS_OUTPUT.PUT_LINE('Cliente   : ' || v_reg.NOM_CLIENTE);
    DBMS_OUTPUT.PUT_LINE('Vendedor  : ' || v_reg.NOM_VENDEDOR);
    DBMS_OUTPUT.PUT_LINE('Endereço  : ' || v_reg.DES_ENDERECO || ', ' || v_reg.NUM_ENDERECO || ' - ' || v_reg.DES_BAIRRO);
    DBMS_OUTPUT.PUT_LINE('Cidade    : ' || v_reg.COD_CIDADE);
    DBMS_OUTPUT.PUT_LINE('Total     : R$ ' || TO_CHAR(v_reg.VAL_TOTAL_PEDIDO, 'FM999G990D00'));

EXCEPTION
    WHEN e_pedido_nao_encontrado THEN
        IF c_pedido%ISOPEN THEN CLOSE c_pedido; END IF;
        DBMS_OUTPUT.PUT_LINE('Erro: Pedido ' || p_cod_pedido || ' não encontrado.');
    WHEN OTHERS THEN
        IF c_pedido%ISOPEN THEN CLOSE c_pedido; END IF;
        DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || SQLERRM);
END;
/

-- Atividade 4
CREATE OR REPLACE PROCEDURE PRC_CLASSIFICAR_CLIENTE(
    p_cod_cliente IN CLIENTE.COD_CLIENTE%TYPE
) IS
    v_nom_cliente   CLIENTE.NOM_CLIENTE%TYPE;
    v_total_gasto   NUMBER := 0;
    v_qtd_pedidos   NUMBER := 0;
    v_classificacao VARCHAR2(10);
    e_cliente_nao_encontrado EXCEPTION;
BEGIN
    BEGIN
        SELECT NOM_CLIENTE INTO v_nom_cliente
        FROM CLIENTE
        WHERE COD_CLIENTE = p_cod_cliente;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE e_cliente_nao_encontrado;
    END;

    SELECT COUNT(DISTINCT P.COD_PEDIDO),
           NVL(SUM((IP.VAL_UNITARIO_ITEM - NVL(IP.VAL_DESCONTO_ITEM, 0)) * IP.QTD_ITEM), 0)
    INTO v_qtd_pedidos, v_total_gasto
    FROM PEDIDO P
    INNER JOIN ITEM_PEDIDO IP  ON P.COD_PEDIDO  = IP.COD_PEDIDO
    LEFT JOIN  PRODUTO PR      ON IP.COD_PRODUTO = PR.COD_PRODUTO
    LEFT JOIN  HISTORICO_PEDIDO HP ON P.COD_PEDIDO = HP.COD_PEDIDO
    WHERE P.COD_CLIENTE       = p_cod_cliente
      AND P.DAT_CANCELAMENTO  IS NULL;

    IF v_total_gasto >= 10000 THEN
        v_classificacao := 'OURO';
    ELSIF v_total_gasto >= 3000 THEN
        v_classificacao := 'PRATA';
    ELSE
        v_classificacao := 'BRONZE';
    END IF;

    DBMS_OUTPUT.PUT_LINE('=== CLASSIFICAÇÃO DO CLIENTE ===');
    DBMS_OUTPUT.PUT_LINE('Cliente        : ' || v_nom_cliente);
    DBMS_OUTPUT.PUT_LINE('Qtd. Pedidos   : ' || v_qtd_pedidos);
    DBMS_OUTPUT.PUT_LINE('Total Gasto    : R$ ' || TO_CHAR(v_total_gasto, 'FM999G990D00'));
    DBMS_OUTPUT.PUT_LINE('Classificação  : ' || v_classificacao);

EXCEPTION
    WHEN e_cliente_nao_encontrado THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Cliente ' || p_cod_cliente || ' não encontrado.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || SQLERRM);
END;
/

-- Atividade 5
CREATE OR REPLACE PROCEDURE PRC_RELATORIO_MOVIMENTACAO_PRODUTO(
    p_cod_produto IN MOVIMENTO_ESTOQUE.COD_PRODUTO%TYPE
)
IS
    CURSOR c_movimentos IS
        SELECT me.DAT_MOVIMENTO_ESTOQUE,
               p.NOM_PRODUTO,
               NVL(tme.DES_TIPO_MOVIMENTO_ESTOQUE, 'Não mapeado') AS DES_TIPO,
               NVL(tme.STA_SAIDA_ENTRADA, '?')                    AS STA_SAIDA_ENTRADA,
               me.QTD_MOVIMENTACAO_ESTOQUE
          FROM MOVIMENTO_ESTOQUE         me
         INNER JOIN PRODUTO              p   ON p.COD_PRODUTO                  = me.COD_PRODUTO
          LEFT JOIN TIPO_MOVIMENTO_ESTOQUE tme ON tme.COD_TIPO_MOVIMENTO_ESTOQUE = me.COD_TIPO_MOVIMENTO_ESTOQUE
          LEFT JOIN ESTOQUE_PRODUTO       ep  ON ep.COD_PRODUTO                 = me.COD_PRODUTO
         WHERE me.COD_PRODUTO = p_cod_produto
         ORDER BY me.DAT_MOVIMENTO_ESTOQUE;

    v_contador NUMBER := 0;
    e_sem_movimentacao EXCEPTION;
BEGIN
    DBMS_OUTPUT.PUT_LINE('===== RELATÓRIO DE MOVIMENTAÇÕES =====');

    FOR v_reg IN c_movimentos LOOP
        v_contador := v_contador + 1;

        DBMS_OUTPUT.PUT_LINE(
            TO_CHAR(v_reg.DAT_MOVIMENTO_ESTOQUE, 'DD/MM/YYYY') || ' | ' ||
            v_reg.NOM_PRODUTO       || ' | ' ||
            v_reg.DES_TIPO          || ' | ' ||
            'S/E: ' || v_reg.STA_SAIDA_ENTRADA || ' | ' ||
            'Qtd: ' || v_reg.QTD_MOVIMENTACAO_ESTOQUE
        );
    END LOOP;

    IF v_contador = 0 THEN
        RAISE e_sem_movimentacao;
    END IF;

    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total de movimentações: ' || v_contador);

EXCEPTION
    WHEN e_sem_movimentacao THEN
        DBMS_OUTPUT.PUT_LINE('AVISO: Nenhuma movimentação encontrada para o produto ' || p_cod_produto || '.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERRO inesperado: ' || SQLERRM);
END;
/

-- TESTES - Chamadas para cada exercício respectivo
SET SERVEROUTPUT ON;

-- ATIVIDADE 1: FN_TOTAL_PEDIDOS_CLIENTE
DECLARE
    v_resultado NUMBER;
BEGIN
    v_resultado := FN_TOTAL_PEDIDOS_CLIENTE(1); -- troque o 1 pelo COD_CLIENTE desejado
    DBMS_OUTPUT.PUT_LINE('=== TESTE ATIVIDADE 1 ===');
    DBMS_OUTPUT.PUT_LINE('Total de pedidos do cliente: R$ ' || v_resultado);
END;
/

-- ATIVIDADE 2: FN_ESTOQUE_DISPONIVEL
DECLARE
    v_resultado NUMBER;
BEGIN
    v_resultado := FN_ESTOQUE_DISPONIVEL(1); -- troque o 1 pelo COD_PRODUTO desejado
    DBMS_OUTPUT.PUT_LINE('=== TESTE ATIVIDADE 2 ===');
    DBMS_OUTPUT.PUT_LINE('Estoque disponível do produto: ' || v_resultado);
END;
/

-- ATIVIDADE 3: PRC_DETALHES_PEDIDO
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TESTE ATIVIDADE 3 ===');
    PRC_DETALHES_PEDIDO(130501); -- troque o 1 pelo COD_PEDIDO desejado
END;
/

-- Função - ATIVIDADE 4
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TESTE ATIVIDADE 4 ===');
    PRC_CLASSIFICAR_CLIENTE(1); 
END;
/

-- ATIVIDADE 5: PRC_RELATORIO_MOVIMENTACAO_PRODUTO
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TESTE ATIVIDADE 5 ===');
    PRC_RELATORIO_MOVIMENTACAO_PRODUTO(1); 
END;
/

 