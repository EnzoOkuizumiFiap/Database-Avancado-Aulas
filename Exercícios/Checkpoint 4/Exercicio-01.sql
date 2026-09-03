/*
Crie a ESPECIFICAÇÃO do package pkg_pedidos contendo os seguintes elementos:
    a) Constante c_desconto_maximo do tipo NUMBER com valor 50.
    b) Variável pública g_ultimo_pedido_processado do tipo NUMBER.
    c) Exceção pública pedido_nao_encontrado.
    d) Exceção pública cliente_inativo.
    e) Procedure buscar_pedido(p_cod_pedido IN NUMBER).
    f) Function calcular_total_pedido(p_cod_pedido IN NUMBER) RETURN NUMBER.
    g) Procedure cancelar_pedido(p_cod_pedido IN NUMBER, p_motivo IN VARCHAR2).
*/

create or replace PACKAGE pkg_pedidos as
    const c_desconto_maximo NUMBER;
    V_g_ultimo_pedido_processado NUMBER;
    pedido_nao_encontrado EXCEPTION;
    cliente_inativo EXCEPTION;
    
    Procedure buscar_pedido(p_cod_pedido IN NUMBER);
    Function calcular_total_pedido(p_cod_pedido IN NUMBER) RETURN NUMBER;
    Procedure cancelar_pedido(p_cod_pedido IN NUMBER, p_motivo IN VARCHAR2);
    
end pkg_pedidos;


CREATE OR REPLACE PACKAGE BODY pkg_pedidos AS

    PROCEDURE buscar_pedido(p_cod_pedido IN NUMBER) IS BEGIN
        NULL;
    END buscar_pedido;

    FUNCTION calcular_total_pedido(p_cod_pedido IN NUMBER) RETURN NUMBER IS v_total NUMBER;
    BEGIN
        RETURN v_total;
    END calcular_total_pedido;

    PROCEDURE cancelar_pedido(p_cod_pedido IN NUMBER, p_motivo IN VARCHAR2) IS BEGIN
        NULL;
    END cancelar_pedido;
    
END pkg_pedidos;
