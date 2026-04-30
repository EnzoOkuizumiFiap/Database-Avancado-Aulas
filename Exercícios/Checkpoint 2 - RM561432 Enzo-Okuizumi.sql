Set serveroutput on;

-- Exercício 1 — Função fn_status_cliente
CREATE OR REPLACE FUNCTION fn_status_cliente(p_cod_cliente IN NUMBER) RETURN CHAR IS
    v_sta VARCHAR2(20); v_ret CHAR(1);
BEGIN
    SELECT DISTINCT c.sta_ativo INTO v_sta FROM cliente c JOIN endereco_cliente e ON c.cod_cliente = e.cod_cliente WHERE c.cod_cliente = p_cod_cliente;
    
    IF UPPER(v_sta) IN ('S', 'A', 'ATIVO', '1', 'SIM') THEN v_ret := 'S';
    ELSIF UPPER(v_sta) IN ('N', 'I', 'INATIVO', '0', 'NAO') THEN v_ret := 'N';
    ELSE DBMS_OUTPUT.PUT_LINE('Alerta: Status não mapeado encontrado: ' || v_sta); v_ret := 'N'; END IF;
    
    RETURN v_ret;
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Cliente ' || p_cod_cliente || ' não existe ou não possui endereço.'); RETURN NULL;
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM); RETURN NULL;
END fn_status_cliente;
/

-- Exercício 2 — Função fn_total_compras_cliente
CREATE OR REPLACE FUNCTION fn_total_compras_cliente(p_cod_cliente IN NUMBER, p_ano IN NUMBER) RETURN NUMBER IS
    v_tot NUMBER := 0; v_ex NUMBER;
BEGIN
    SELECT 1 INTO v_ex FROM cliente WHERE cod_cliente = p_cod_cliente;
    SELECT NVL(SUM(ip.qtd_item * ip.val_unitario_item - NVL(ip.val_desconto_item, 0)), 0) INTO v_tot
    FROM pedido p JOIN item_pedido ip ON p.cod_pedido = ip.cod_pedido
    WHERE p.cod_cliente = p_cod_cliente AND p.dat_cancelamento IS NULL AND EXTRACT(YEAR FROM p.dat_pedido) = p_ano AND ip.qtd_item > 0;
    
    RETURN v_tot;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20011, 'Cliente inexistente: ' || p_cod_cliente);
END fn_total_compras_cliente;
/

-- Exercício 3 — Procedure prc_auditoria_cliente_anual
CREATE OR REPLACE PROCEDURE prc_auditoria_cliente_anual (p_cod_cliente IN NUMBER, p_ano IN NUMBER) IS
    v_nom_cliente cliente.nom_cliente%TYPE; v_tip_pessoa cliente.tip_pessoa%TYPE;
    v_qtd_pedidos NUMBER; v_gravado NUMBER; v_real NUMBER; v_dif NUMBER; v_perc NUMBER; v_class VARCHAR2(10);
BEGIN
    -- Busca os dados do cliente e o valor gravado (Corrigido o GROUP BY aqui)
    SELECT c.nom_cliente, c.tip_pessoa, COUNT(p.cod_pedido), NVL(SUM(p.val_total_pedido), 0)
      INTO v_nom_cliente, v_tip_pessoa, v_qtd_pedidos, v_gravado
      FROM cliente c JOIN pedido p ON c.cod_cliente = p.cod_cliente
     WHERE c.cod_cliente = p_cod_cliente AND p.dat_cancelamento IS NULL AND EXTRACT(YEAR FROM p.dat_pedido) = p_ano
     GROUP BY c.nom_cliente, c.tip_pessoa;

    -- Tenta buscar o valor real usando a função do Exercicio 2
    BEGIN
        v_real := fn_total_compras_cliente(p_cod_cliente, p_ano);
    EXCEPTION
        WHEN OTHERS THEN IF SQLCODE = -20011 THEN DBMS_OUTPUT.PUT_LINE('ERRO NA FUNCAO - abortando auditoria'); RETURN; ELSE RAISE; END IF;
    END;

    -- Cálculos de divergência
    v_dif := v_real - v_gravado;
    IF v_gravado > 0 THEN v_perc := (ABS(v_dif) / v_gravado) * 100; ELSE v_perc := 0; END IF;

    -- Classificação conforme regras da prova
    IF ABS(v_dif) < 0.01 THEN v_class := 'OK'; ELSIF ABS(v_dif) <= 50 THEN v_class := 'BAIXA'; ELSIF ABS(v_dif) <= 500 THEN v_class := 'ALTA'; ELSE v_class := 'CRITICA'; END IF;

    -- Saída via DBMS_OUTPUT
    DBMS_OUTPUT.PUT_LINE('=== AUDITORIA CLIENTE ' || p_cod_cliente || ' - ANO ' || p_ano || ' ===');
    DBMS_OUTPUT.PUT_LINE('Cliente .........: ' || p_cod_cliente || ' - ' || v_nom_cliente);
    DBMS_OUTPUT.PUT_LINE('Tipo Pessoa .....: ' || v_tip_pessoa);
    DBMS_OUTPUT.PUT_LINE('Qtd Pedidos .....: ' || v_qtd_pedidos);
    DBMS_OUTPUT.PUT_LINE('Valor gravado ...: R$ ' || v_gravado);
    DBMS_OUTPUT.PUT_LINE('Valor real ......: R$ ' || v_real);
    DBMS_OUTPUT.PUT_LINE('Divergencia R$ ..: ' || v_dif);
    DBMS_OUTPUT.PUT_LINE('Divergencia % ...: ' || ROUND(v_perc, 2) || '%');
    DBMS_OUTPUT.PUT_LINE('Classificacao ...: ' || v_class);

EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Cliente ' || p_cod_cliente || ' sem pedidos no ano ' || p_ano);
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END prc_auditoria_cliente_anual;
/

-- Exercício 4 — Procedure prc_clientes_cidade
-- Exercício 4 — Procedure prc_clientes_cidade
CREATE OR REPLACE PROCEDURE prc_clientes_cidade(p_cod_cidade IN NUMBER) IS
    v_nom cidade.nom_cidade%TYPE; v_est cidade.cod_estado%TYPE; v_qtd NUMBER := 0; v_sta CHAR(1);
    CURSOR c_cli IS SELECT c.cod_cliente, c.nom_cliente, e.des_bairro FROM cliente c JOIN (SELECT cod_cliente, cod_cidade, des_bairro, ROW_NUMBER() OVER (PARTITION BY cod_cliente ORDER BY dat_cadastro DESC) as rn FROM endereco_cliente) e ON c.cod_cliente = e.cod_cliente AND e.rn = 1 JOIN cidade cid ON e.cod_cidade = cid.cod_cidade WHERE cid.cod_cidade = p_cod_cidade ORDER BY c.nom_cliente;
BEGIN
    BEGIN 
        SELECT nom_cidade, cod_estado INTO v_nom, v_est FROM cidade WHERE cod_cidade = p_cod_cidade;
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20012, 'Cidade ' || p_cod_cidade || ' nao cadastrada'); 
    END;

    DBMS_OUTPUT.PUT_LINE('=== CLIENTES NA CIDADE ' || p_cod_cidade || ' - ' || v_nom || '/' || v_est || ' ===');

    FOR r_cli IN c_cli LOOP
        v_sta := fn_status_cliente(r_cli.cod_cliente);
        IF v_sta = 'S' THEN DBMS_OUTPUT.PUT_LINE(r_cli.cod_cliente || ' - ' || r_cli.nom_cliente || ' .... ' || r_cli.des_bairro); v_qtd := v_qtd + 1; END IF;
    END LOOP;

    IF v_qtd = 0 THEN DBMS_OUTPUT.PUT_LINE('Nenhum cliente ativo nesta cidade.');
    ELSE DBMS_OUTPUT.PUT_LINE('Total de clientes ativos listados: ' || v_qtd); END IF;

EXCEPTION
    WHEN OTHERS THEN IF SQLCODE = -20012 THEN RAISE; ELSE DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM); END IF;
END prc_clientes_cidade;
/

-- Exercício 5 — Procedure prc_ranking_cliente_anual
CREATE OR REPLACE PROCEDURE prc_ranking_cliente_anual(p_ano IN NUMBER) IS
    v_tot_g NUMBER := 0; v_pos NUMBER := 1; v_has_ped BOOLEAN := FALSE;
    CURSOR c_rank IS SELECT cod_cliente, nom_cliente, qtd_pedidos, total_real FROM (SELECT c.cod_cliente, c.nom_cliente, COUNT(p.cod_pedido) as qtd_pedidos, fn_total_compras_cliente(c.cod_cliente, p_ano) as total_real FROM cliente c JOIN pedido p ON c.cod_cliente = p.cod_cliente WHERE p.dat_cancelamento IS NULL AND EXTRACT(YEAR FROM p.dat_pedido) = p_ano GROUP BY c.cod_cliente, c.nom_cliente) ORDER BY total_real DESC;
BEGIN
    IF p_ano < 2000 OR p_ano > 2100 THEN RAISE_APPLICATION_ERROR(-20013, 'Parametro invalido: ano=' || p_ano); END IF;

    DBMS_OUTPUT.PUT_LINE('=== RANKING CLIENTES ' || p_ano || ' ===');

    FOR r IN c_rank LOOP
        v_has_ped := TRUE;
        DBMS_OUTPUT.PUT_LINE(v_pos || 'o) ' || r.cod_cliente || ' - ' || r.nom_cliente || ' | ' || r.qtd_pedidos || ' pedidos | R$ ' || r.total_real);
        v_tot_g := v_tot_g + r.total_real; v_pos := v_pos + 1;
    END LOOP;

    IF NOT v_has_ped THEN DBMS_OUTPUT.PUT_LINE('Nenhuma compra em ' || p_ano || '.');
    ELSE DBMS_OUTPUT.PUT_LINE('Total geral comprado no ano: R$ ' || v_tot_g); END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
    WHEN OTHERS THEN IF SQLCODE = -20013 THEN RAISE; ELSE DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM); END IF;
END prc_ranking_cliente_anual;
/
 
 -- Testando
SET SERVEROUTPUT ON SIZE UNLIMITED;

-- fn_status_cliente
SELECT cod_cliente, sta_ativo, fn_status_cliente(cod_cliente) ret FROM cliente WHERE ROWNUM <= 10;

-- fn_total_compras_cliente
SELECT 1 cod, fn_total_compras_cliente(1, 2025) FROM dual;

SELECT 1 cod, fn_total_compras_cliente(1, 1999)          FROM dual;
SELECT 999999999 cod, fn_total_compras_cliente(999999999, 2025)  FROM dual;

-- procedures
BEGIN prc_auditoria_cliente_anual(1, 2025); 
END;
/

BEGIN prc_clientes_cidade(1);
END;
/

BEGIN prc_ranking_cliente_anual(2025);
END;
/
 