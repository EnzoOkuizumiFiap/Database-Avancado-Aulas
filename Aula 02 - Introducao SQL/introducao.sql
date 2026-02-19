/*aaaaaaaaaaaa, perdi o código original*/

SELECT * FROM pais;

SELECT * FROM pais
ORDER BY cod_pais;

ALTER TABLE cidade MODIFY nom_cidade VARCHAR2(50);
ALTER TABLE pedido ADD status VARCHAR2(50);

INSERT INTO pais SELECT * FROM pf1788.pais;
COMMIT;
INSERT INTO estado SELECT * FROM pf1788.estado;
COMMIT;
INSERT INTO cidade SELECT * FROM pf1788.cidade;
COMMIT;
INSERT INTO tipo_endereco SELECT * FROM pf1788.tipo_endereco;
COMMIT;
INSERT INTO cliente SELECT * FROM pf1788.cliente;
COMMIT;
INSERT INTO endereco_cliente SELECT * FROM pf1788.endereco_cliente;
COMMIT;
INSERT INTO usuario SELECT * FROM pf1788.usuario;
COMMIT;
INSERT INTO vendedor SELECT * FROM pf1788.vendedor;
COMMIT;
INSERT INTO produto SELECT * FROM pf1788.produto;
COMMIT;
INSERT INTO produto_composto SELECT * FROM pf1788.produto_composto;
COMMIT;
INSERT INTO tipo_movimento_estoque SELECT * FROM pf1788.tipo_movimento_estoque;
COMMIT;
INSERT INTO estoque SELECT * FROM pf1788.estoque;
COMMIT;
INSERT INTO estoque_produto SELECT * FROM pf1788.estoque_produto;
COMMIT;
INSERT INTO movimento_estoque SELECT * FROM pf1788.movimento_estoque;
COMMIT;
INSERT INTO cliente_vendedor SELECT * FROM pf1788.cliente_vendedor;
COMMIT;
INSERT INTO pedido SELECT * FROM pf1788.pedido;
COMMIT;
INSERT INTO historico_pedido SELECT * FROM pf1788.historico_pedido;
COMMIT;
INSERT INTO item_pedido SELECT * FROM pf1788.item_pedido;
COMMIT;


