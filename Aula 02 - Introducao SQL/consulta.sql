//Criar uma consulta em sql que traga o endereço completo do cliente com os seguintes atributos:

/*
ID Cliente
NOME CLIENTE
ENDEREÇO COMPLETO
CEP
NOME CIDADE
NOME PAIS
NOME ESTADO
E TIPO DE CLIENTE
*/

select cod_cliente, nom_cliente from cliente;

select des_endereco, num_cep from endereco_cliente;

select nom_cidade from cidade;

select nom_estado from estado;

select nom_pais from pais;

select tip_pessoa from cliente;


SELECT
    cli.nom_cliente "Nome cliente",
    cli.cod_cliente "Código Cliente",
    cli.tip_pessoa  "Tipo cliente",
    des_endereco    "Rua",
    num_endereco    "Numero",
    des_complemento "Complemento",
    num_cep         "cep",
    des_bairro      "Bairro",
    nom_cidade      "Cidade",
    nom_estado      "Estado",
    nom_pais        "País"
FROM
         endereco_cliente end
    JOIN cliente cli ON end.cod_cliente = cli.cod_cliente
    JOIN cidade  cd ON end.cod_cliente = cd.cod_cidade
    JOIN estado  es ON cd.cod_estado = es.cod_estado
    JOIN pais    ps ON es.cod_estado = ps.cod_pais;
