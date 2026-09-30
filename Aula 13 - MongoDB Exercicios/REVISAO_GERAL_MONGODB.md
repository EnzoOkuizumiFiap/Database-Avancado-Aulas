# 🍃 Guia Definitivo e Revisão Completa: MongoDB & Aggregation Framework
> **Disciplina:** Mastering Relational and Non-Relational Database — FIAP  
> **Conteúdo:** Fundamentos NoSQL, CRUD Completo, Operadores Avançados, Aggregation Pipeline, Índices & Resolução Detalhada dos 30 Exercícios da Aula 13  
> **Autor:** Enzo Okuizumi (RM 561432) — Turma 2TDSPG  

---

## 📑 Sumário Interativo
1. [Módulo 1: Fundamentos NoSQL, Arquitetura BSON e Modelagem](#1-módulo-1-fundamentos-nosql-arquitetura-bson-e-modelagem)
   - [1.1 Paradigma Relacional (SQL) vs Document Store (MongoDB)](#11-paradigma-relacional-sql-vs-document-store-mongodb)
   - [1.2 Estrutura BSON e Anatomia do `ObjectId`](#12-estrutura-bson-e-anatomia-do-objectid)
   - [1.3 Estratégias de Modelagem: Embutir (Embed) vs Referenciar (Reference)](#13-estratégias-de-modelagem-embutir-embed-vs-referenciar-reference)
   - [1.4 Notação de Ponto (Dot Notation)](#14-notação-de-ponto-dot-notation)
2. [Módulo 2: Configuração de Ambiente, Carga de Dados e CLI](#2-módulo-2-configuração-de-ambiente-carga-de-dados-e-cli)
   - [2.1 Utilitário `mongoimport`](#21-utilitário-mongoimport)
   - [2.2 Comandos Fundamentais do `mongosh`](#22-comandos-fundamentais-do-mongosh)
3. [Módulo 3: Operações CRUD em Detalhes](#3-módulo-3-operações-crud-em-detalhes)
   - [3.1 Create (Inserção de Documentos)](#31-create-inserção-de-documentos)
   - [3.2 Read (Consultas com `find` e Projeções)](#32-read-consultas-com-find-e-projeções)
   - [3.3 Update (Modificações Atômicas e Pipeline de Atualização)](#33-update-modificações-atômicas-e-pipeline-de-atualização)
   - [3.4 Delete (Remoção Segura e Auditoria Prévia)](#34-delete-remoção-segura-e-auditoria-prévia)
4. [Módulo 4: Operadores de Comparação, Lógicos, Elementos e Arrays](#4-módulo-4-operadores-de-comparação-lógicos-elementos-e-arrays)
   - [4.1 Operadores de Comparação](#41-operadores-de-comparação)
   - [4.2 Operadores Lógicos e Conjunção](#42-operadores-lógicos-e-conjunção)
   - [4.3 Expressões Regulares (`$regex`)](#43-expressões-regulares-regex)
   - [4.4 Operadores de Verificação de Schema e Arrays (`$exists`, `$type`, `$elemMatch`, `$size`)](#44-operadores-de-verificação-de-schema-e-arrays-exists-type-elemmatch-size)
5. [Módulo 5: Cursores, Ordenação, Paginação e Limites](#5-módulo-5-cursores-ordenação-paginação-e-limites)
   - [5.1 Modificadores de Cursor: `.sort()`, `.skip()`, `.limit()`](#51-modificadores-de-cursor-sort-skip-limit)
   - [5.2 Regra de Ouro da Ordem de Avaliação no Motor](#52-regra-de-ouro-da-ordem-de-avaliação-no-motor)
6. [Módulo 6: Aggregation Framework (Mergulho Profundo)](#6-módulo-6-aggregation-framework-mergulho-profundo)
   - [6.1 Conceito de Pipeline de Transformação](#61-conceito-de-pipeline-de-transformação)
   - [6.2 Tabela de Equivalência SQL vs Aggregation Pipeline](#62-tabela-de-equivalência-sql-vs-aggregation-pipeline)
   - [6.3 Estágios Estruturais (`$match`, `$group`, `$project`, `$unwind`, `$lookup`, `$count`)](#63-estágios-estruturais-match-group-project-unwind-lookup-count)
   - [6.4 Acumuladores e Operadores de Expressão](#64-acumuladores-e-operadores-de-expressão)
7. [Módulo 7: Otimização de Performance, Índices e a Regra ESR](#7-módulo-7-otimização-de-performance-índices-e-a-regra-esr)
   - [7.1 Como Funcionam os Índices B-Tree](#71-como-funcionam-os-índices-b-tree)
   - [7.2 A Regra ESR (Equality, Sort, Range)](#72-a-regra-esr-equality-sort-range)
   - [7.3 Auditoria com `.explain("executionStats")`](#73-auditoria-com-explainexecutionstats)
8. [Módulo 8: Resolução Completa dos 30 Exercícios da Aula 13](#8-módulo-8-resolução-completa-dos-30-exercícios-da-aula-13)
   - [Exercícios 1 a 6 (Filtros Simples, Projeção, Agregações Iniciais, Sort)](#exercícios-1-a-6)
   - [Exercícios 7 a 12 (Updates, Deletes, Regex e Datas)](#exercícios-7-a-12)
   - [Exercícios 13 a 18 (Lookup, Índices, Agrupamentos Compostos, Updates Avançados)](#exercícios-13-a-18)
   - [Exercícios 19 a 24 (Operadores de Conjunto, Lógica, Distinct e Projeções Calculadas)](#exercícios-19-a-24)
   - [Exercícios 25 a 30 (Pipelines Analíticos, $unwind, Índices Compostos e Inserções Lote)](#exercícios-25-a-30)
9. [Módulo 9: Cheat Sheet / Cola Rápida para Prova](#9-módulo-9-cheat-sheet--cola-rápida-para-prova)

---

# 1. Módulo 1: Fundamentos NoSQL, Arquitetura BSON e Modelagem

## 1.1 Paradigma Relacional (SQL) vs Document Store (MongoDB)

O MongoDB é um banco de dados NoSQL classificado como **Document Store** (banco orientado a documentos). Enquanto os bancos relacionais trabalham com tabelas rígidas baseadas na álgebra relacional de Codd, o MongoDB trabalha com documentos flexíveis e autocontidos.

| Conceito Relacional (SQL) | Conceito MongoDB (NoSQL) | Descrição / Analogia |
| :--- | :--- | :--- |
| **Database** (Banco de Dados) | **Database** | Contêiner lógico isolado para os dados. |
| **Table** (Tabela) | **Collection** (Coleção) | Conjunto de documentos. Não impõe um esquema rígido obrigatório. |
| **Row / Tuple** (Linha / Registro) | **Document** (Documento BSON) | Registro individual estruturado em pares de chave/valor. |
| **Column** (Coluna) | **Field** (Campo / Atributo) | Propriedade de um documento. Pode variar entre documentos da mesma coleção. |
| **Primary Key** (`PK`) | **Field `_id`** (Chave Primária) | Identificador exclusivo obrigatório gerado automaticamente (`ObjectId`). |
| **Foreign Key** (`FK`) / **JOIN** | **Embedding** ou **`$lookup`** | Relações podem ser embutidas no documento ou referenciadas via `_id`. |
| **Index** (Índice B-Tree) | **Index** (Índice B-Tree) | Estrutura auxiliar em memória para acelerar consultas. |

---

## 1.2 Estrutura BSON e Anatomia do `ObjectId`

Os documentos no MongoDB são armazenados fisicamente no formato **BSON** (*Binary JSON*). 

### Por que BSON em vez de JSON puro?
- **JSON puro** suporta apenas tipos primitivos limitados: *string*, *number*, *boolean*, *array*, *object* e *null*. Ele não diferencia inteiros de pontos flutuantes, nem suporta nativamente tipos de data precisos ou buffers binários.
- **BSON** é uma extensão binária que inclui:
  - `ObjectId`
  - `Date` (ISODate de 64 bits com precisão de milissegundos)
  - `Int32`, `Int64` e `Decimal128` (alta precisão para finanças)
  - `Binary Data` (para armazenar hashes, UUIDs ou arquivos pequenos)

### Anatomia do `ObjectId` (12 Bytes / 24 Caracteres Hexadecimais)
Quando um documento é inserido sem o campo `_id`, o MongoDB gera automaticamente um identificador único de 12 bytes:

```text
 0                   4                7          9            12  (Bytes)
+--------------------+----------------+----------+--------------+
| 4 bytes Timestamp  | 5 bytes Rand   | 2 bytes  | 3 bytes      |
| (Segundos Unix)    | (ID Processo/  | Process  | Contador     |
|                    | Máquina)       | ID       | Incremental  |
+--------------------+----------------+----------+--------------+
```
> **Vantagem oculta do `ObjectId`:** Como os primeiros 4 bytes contêm o timestamp Unix da criação, é possível extrair a data e hora exata de inserção do documento usando `ObjectId("...").getTimestamp()`, sem necessidade de um campo `data_criacao` extra.

---

## 1.3 Estratégias de Modelagem: Embutir (Embed) vs Referenciar (Reference)

Na modelagem NoSQL, o lema principal é: **"Dados que são acessados juntos devem ser armazenados juntos"**.

```text
┌────────────────────────────────────────────────────────────────────────┐
│                   ESTRATÉGIAS DE MODELAGEM NO MONGODB                  │
├────────────────────────────────────┬───────────────────────────────────┤
│        EMBUTIR (EMBEDDING)         │     REFERENCIAR (REFERENCING)     │
├────────────────────────────────────┼───────────────────────────────────┤
│ • Documentos/Arrays aninhados      │ • Guarda o ID de outra coleção    │
│   diretamente no mesmo documento.  │   (ex: CUSTOMER_ID -> clientes).  │
│                                    │                                   │
│ • Casos de Uso Típicos:            │ • Casos de Uso Típicos:           │
│   - Relacionamento 1:1             │   - Relacionamento 1:N infinito   │
│   - Relacionamento 1:N com poucos  │     (cresce continuamente)        │
│     filhos (ex: itens de pedido).  │   - Relacionamento N:N            │
│                                    │                                   │
│ • Vantagens:                       │ • Vantagens:                      │
│   - Leitura atômica super rápida   │   - Evita dados duplicados        │
│   - 1 única operação de I/O em     │   - Documentos menores e limpos   │
│     disco (sem necessidade de JOIN)│   - Flexibilidade de escrita      │
│                                    │                                   │
│ • Pontos de Atenção:               │ • Pontos de Atenção:              │
│   - Limite máximo rígido de 16 MB  │   - Exige múltiplas consultas ou  │
│     por documento BSON.            │     o uso do estágio $lookup.     │
└────────────────────────────────────┴───────────────────────────────────┘

                    [EXEMPLO VISUAL DOS DOCUMENTOS]

    MODO EMBUTIDO (EMBEDDED)            MODO REFERENCIADO (REFERENCE)
    ────────────────────────            ─────────────────────────────
    Coleção: pedidos                    Coleção: pedidos
    {                                   {
      _id: 10100,                         _id: 10100,
      SALES: 3000,                        SALES: 3000,
      productDetails: [                   CUSTOMER_ID: 1  ───┐
        {                               }                    │ Aponta para:
          nome: "Harley Davidson",                           ▼
          codigo: "S10_1678"            Coleção: clientes
        }                               {
      ]                                   _id: 1,
    }                                     nome: "Atelier Graphique"
                                        }
```

### Exemplo Prático (Aula 13):
- **Embutido:** No Exercício 18, adicionamos o array `productDetails` diretamente no pedido. Isso é ideal porque as informações descritivas do produto pertencem àquele contexto de entrega.
- **Referenciado:** A coleção `pedidos` possui o campo `CUSTOMER_ID: 1` apontando para a coleção `clientes` onde `customer_id: 1`. Para unificá-los, usamos a junção `$lookup` (Exercício 13).

---

## 1.4 Notação de Ponto (Dot Notation)

A **Dot Notation** permite navegar recursivamente por subdocumentos aninhados e arrays. Sempre que referenciar um caminho composto, **as aspas são obrigatórias**:

1. **Acessando Subdocumentos:**
   ```javascript
   // Exemplo: Buscar produto cuja RAM em especificações seja "8GB"
   db.produtos.find({ "especificacoes.memoriaRAM": "8GB" })
   ```
2. **Acessando Campos dentro de Arrays de Objetos:**
   ```javascript
   // Exemplo: Filtrar pedidos onde algum item de productDetails tenha certo código
   db.pedidos.find({ "productDetails.product_code": "S18_1342" })
   ```
3. **Acessando Índice Específico de um Array:**
   ```javascript
   // Exemplo: Verificar o status do primeiro item do histórico
   db.pedidos.find({ "historico.0.status": "Separado" })
   ```

---

# 2. Módulo 2: Configuração de Ambiente, Carga de Dados e CLI

## 2.1 Utilitário `mongoimport`

O utilitário `mongoimport` é um executável de linha de comando que roda **fora do mongosh**, diretamente no terminal do Sistema Operacional (PowerShell, Bash ou CMD). Ele é utilizado para popular bases a partir de arquivos JSON, CSV ou TSV.

### Sintaxe Padrão de Importação:
```powershell
# Importação da coleção de pedidos:
mongoimport --db loja --collection pedidos --file dados_pedidos.json --jsonArray

# Importação da coleção de clientes:
mongoimport --db loja --collection clientes --file clientes.json --jsonArray
```

### Explicação dos Parâmetros:
- `--db loja`: Define o banco de dados alvo. Se o banco não existir, será criado.
- `--collection pedidos`: Define a coleção de destino.
- `--file dados_pedidos.json`: O caminho do arquivo contendo os dados.
- `--jsonArray`: Informa que o arquivo JSON possui uma lista de documentos delimitada por colchetes `[ {...}, {...} ]`. Sem essa flag, o utilitário espera que cada documento esteja em uma linha individual (*NDJSON*).
- `--drop` *(Opcional)*: Remove a coleção anterior antes de importar os novos dados, garantindo que a base inicie limpa.

---

## 2.2 Comandos Fundamentais do `mongosh`

O `mongosh` (*MongoDB Shell*) é a interface REPL interativa moderna para administração e consultas.

```javascript
// Listar todos os bancos existentes no cluster
show dbs

// Trocar para um banco (ou criar um novo sob demanda - lazy creation)
use loja

// Listar coleções existentes no banco ativo
show collections

// Criar explicitamente uma coleção (opcional, pois a criação é implícita no 1º insert)
db.createCollection("produtos")

// Checagem de volumetria (contagem real de documentos)
db.pedidos.countDocuments()   // Deve retornar 35 no dataset original
db.clientes.countDocuments()  // Deve retornar 30 no dataset original

// Limpar a tela do console
cls
```

---

# 3. Módulo 3: Operações CRUD em Detalhes

## 3.1 Create (Inserção de Documentos)

### 1. `insertOne(documento)`
Insere um único documento. Se o campo `_id` não for informado, o driver cria um `ObjectId`.
```javascript
// Exemplo Aula 12: Inserindo um celular
db.eletronicos.insertOne({
  Tipo: "celular",
  Marca: "Samsung",
  Valor: 5000,
  Memoria: "16GB",
  Armazenamento: 256,
  Modelo: "S24 Ultra"
});
```

### 2. `insertMany([ doc1, doc2, ... ])`
Insere múltiplos documentos de uma só vez dentro de um array. Muito mais performático que múltiplos inserts unitários devido ao menor overhead de rede (batch insert).
```javascript
// Exemplo Aula 13: Inserindo novos pedidos (Exercício 30)
db.pedidos.insertMany([
  {
    ORDERNUMBER: 10201,
    QUANTITYORDERED: 25,
    PRICEEACH: 80,
    SALES: 2000,
    STATUS: "In Process",
    ORDERDATE: "2005-11-02",
    PRODUCTLINE: "Trucks",
    PRODUCTCODE: "S18_1342",
    CUSTOMER_ID: 2,
    CONTACTLASTNAME: "Silva",
    CITY: "São Paulo",
    COUNTRY: "Brazil"
  },
  {
    ORDERNUMBER: 10202,
    QUANTITYORDERED: 15,
    PRICEEACH: 120,
    SALES: 1800,
    STATUS: "Shipped",
    ORDERDATE: "2005-11-03",
    PRODUCTLINE: "Motorcycles",
    PRODUCTCODE: "S10_1678",
    CUSTOMER_ID: 3,
    CONTACTLASTNAME: "Martins",
    CITY: "Lisbon",
    COUNTRY: "Portugal"
  }
]);
```

---

## 3.2 Read (Consultas com `find` e Projeções)

A assinatura do método de busca é:
```javascript
db.colecao.find(filtro, projecao)
```
- **Filtro (1º argumento):** Especifica quais documentos devem ser retornados (equivalente à cláusula `WHERE`). Passar `{}` significa "retorne todos".
- **Projeção (2º argumento):** Especifica quais campos devem vir no resultado (equivalente à lista do `SELECT`).

### Regras Vitais de Projeção:
1. `1` inclui o campo, `0` exclui o campo.
2. Não é permitido misturar inclusão (`1`) e exclusão (`0`) na mesma projeção, **com exceção exclusiva do campo `_id`**.
3. O campo `_id` vem incluído por padrão. Para removê-lo, passe explicitamente `_id: 0`.

```javascript
// CORRETO: Incluir apenas nome, preço e omitir _id
db.produtos.find({}, { _id: 0, nome: 1, preco: 1 })

// CORRETO: Retornar todos os campos do documento, exceto o estoque
db.produtos.find({}, { estoque: 0 })

// ERRO SINTÁTICO: Misturar 1 e 0 para campos normais
db.produtos.find({}, { nome: 1, preco: 0 }) // Dispara CommandFailedException!
```

---

## 3.3 Update (Modificações Atômicas e Pipeline de Atualização)

> [!CAUTION]
> **Nunca execute atualizações sem operadores atômicos como `$set`!**  
> Em versões clássicas do MongoDB, rodar `db.colecao.update({ id: 1 }, { status: "OK" })` substituía o documento inteiro por apenas `{ _id: ..., status: "OK" }`, apagando todos os outros campos!

### Operadores de Atualização Mais Cobrados em Avaliações:
- `$set`: Atribui um novo valor a um campo ou cria o campo caso ele não exista.
- `$unset`: Remove completamente um campo do documento (`{ $unset: { TotalCost: "" } }`).
- `$inc`: Incrementa ou decrementa numericamente um valor (`{ $inc: { estoque: -1, acessos: 1 } }`).
- `$push`: Adiciona um elemento ao final de um array.
- `$addToSet`: Adiciona um elemento ao array **somente se ele ainda não estiver presente** (evita duplicatas).
- `$pull`: Remove todos os elementos de um array que correspondam a um filtro.
- `$currentDate`: Registra a data/hora corrente do servidor no campo indicado.

### Atualização com Pipeline de Agregação (Recurso Avançado)
Quando envolvemos o segundo argumento do `updateMany` em colchetes `[ ... ]`, estamos ativando o **Pipeline de Atualização**. Isso permite usar o valor de outros campos do próprio documento para calcular o novo atributo!

```javascript
// Exercício 17: Criando o campo TotalCost a partir da multiplicação de outros dois campos
db.pedidos.updateMany(
  {},
  [
    {
      $set: {
        TotalCost: { $multiply: ["$QUANTITYORDERED", "$PRICEEACH"] }
      }
    }
  ]
);
```

---

## 3.4 Delete (Remoção Segura e Auditoria Prévia)

A remoção de dados no MongoDB é irreversível. Por isso, a boa prática profissional e acadêmica preconiza uma auditoria prévia com `countDocuments`:

```javascript
// PASSO 1: Auditar quantos documentos serão afetados antes da deleção
db.pedidos.countDocuments({ COUNTRY: "USA" }) // Exemplo: Retorna 5

// PASSO 2: Executar a deleção dos registros em lote
db.pedidos.deleteMany({ COUNTRY: "USA" })

// PASSO 3: Validar se a remoção foi concluída com sucesso
db.pedidos.countDocuments({ COUNTRY: "USA" }) // Deve retornar rigorosamente 0
```

---

# 4. Módulo 4: Operadores de Comparação, Lógicos, Elementos e Arrays

## 4.1 Operadores de Comparação

Todos os operadores de expressão e consulta no MongoDB iniciam com o caractere cifrão `$`.

| Operador | Significado | Exemplo no mongosh | Equivalente SQL |
| :---: | :--- | :--- | :---: |
| `$eq` | Equal (Igual a) | `db.pedidos.find({ STATUS: { $eq: "Shipped" } })` | `=` |
| `$ne` | Not Equal (Diferente de) | `db.pedidos.find({ STATUS: { $ne: "Cancelled" } })` | `<>` ou `!=` |
| `$gt` | Greater Than (Maior que) | `db.pedidos.find({ SALES: { $gt: 5000 } })` | `>` |
| `$gte` | Greater Than or Equal (Maior ou igual a) | `db.pedidos.find({ QUANTITYORDERED: { $gte: 20 } })`| `>=` |
| `$lt` | Less Than (Menor que) | `db.pedidos.find({ PRICEEACH: { $lt: 50 } })` | `<` |
| `$lte` | Less Than or Equal (Menor ou igual a) | `db.pedidos.find({ PRICEEACH: { $lte: 100 } })` | `<=` |
| `$in` | In (Pertence a uma lista de valores) | `db.pedidos.find({ COUNTRY: { $in: ["France", "Italy"] } })` | `IN (...)` |
| `$nin` | Not In (Não pertence à lista) | `db.pedidos.find({ STATUS: { $nin: ["Shipped", "Cancelled"] } })` | `NOT IN (...)` |

---

## 4.2 Operadores Lógicos e Conjunção

### AND Implícito vs `$and` Explícito:
Por padrão, todas as chaves separadas por vírgula em um objeto JSON de filtro são unidas por uma lógica **AND** implícita:
```javascript
// AND Implícito (forma mais elegante e idiomática):
db.pedidos.find({
  QUANTITYORDERED: { $gte: 20, $lte: 40 },
  COUNTRY: { $ne: "USA" }
})

// AND Explícito (necessário quando filtramos o mesmo operador em múltiplas expressões complexas):
db.pedidos.find({
  $and: [
    { QUANTITYORDERED: { $gte: 20, $lte: 40 } },
    { COUNTRY: { $ne: "USA" } }
  ]
})
```

### O Operador `$or`:
O operador `$or` recebe obrigatoriamente um **array de critérios**. O documento será selecionado se qualquer uma das condições for satisfeita:
```javascript
// Exemplo: Pedidos com vendas gigantes (> 8000) OU feitos pelo cliente VIP 4
db.pedidos.find({
  $or: [
    { SALES: { $gt: 8000 } },
    { CUSTOMER_ID: 4 }
  ]
})
```

---

## 4.3 Expressões Regulares (`$regex`)

O operador `$regex` permite efetuar buscas textuais flexíveis baseadas em expressões regulares (PCRE).

- **Busca por Substring (Contém):**
  ```javascript
  // Procura "Young" em qualquer posição de CONTACTLASTNAME (case-insensitive)
  db.pedidos.find({ CONTACTLASTNAME: { $regex: "Young", $options: "i" } })
  ```
- **Âncora de Início de Linha (`^`):**
  ```javascript
  // Procura cidades que COMEÇAM com a letra "P" (ex: Paris, Porto, Pretoria)
  db.pedidos.find({ CITY: { $regex: "^P", $options: "i" } })
  ```
- **Âncora de Fim de Linha (`$`):**
  ```javascript
  // Procura cidades que TERMINAM com "burg"
  db.pedidos.find({ CITY: { $regex: "burg$", $options: "i" } })
  ```

---

## 4.4 Operadores de Verificação de Schema e Arrays (`$exists`, `$type`, `$elemMatch`, `$size`)

Em um banco sem esquema rígido, é comum haver documentos com estruturas heterogêneas:

- **`$exists`**: Verifica se o campo existe no documento.
  ```javascript
  // Retorna apenas pedidos que possuem o campo TotalCost
  db.pedidos.find({ TotalCost: { $exists: true } })
  ```
- **`$type`**: Valida o tipo BSON do campo (ex: `"double"`, `"string"`, `"array"`, `"int"`).
  ```javascript
  // Localiza pedidos onde SALES foi gravado como número decimal (double)
  db.pedidos.find({ SALES: { $type: "double" } })
  ```
- **`$all`**: Exige que o array contenha todos os elementos passados, sem importar a ordem.
  ```javascript
  db.pedidos.find({ tags: { $all: ["urgente", "prioritario"] } })
  ```
- **`$elemMatch`**: Exige que **um único elemento do array satisfaça todos os critérios simultaneamente**. Essencial para arrays de objetos.
  ```javascript
  db.pedidos.find({
    productDetails: {
      $elemMatch: { product_code: "S18_1342", product_name: "Truck Model" }
    }
  })
  ```
- **`distinct`**: Extrai uma lista com os valores únicos de um campo.
  ```javascript
  // Retorna um array com os nomes únicos de todas as linhas de produto
  db.pedidos.distinct("PRODUCTLINE")
  ```

---

# 5. Módulo 5: Cursores, Ordenação, Paginação e Limites

## 5.1 Modificadores de Cursor: `.sort()`, `.skip()`, `.limit()`

Quando invocamos `db.colecao.find()`, o MongoDB não devolve imediatamente todos os dados de uma vez; ele devolve um **cursor** iterável. Esse cursor aceita encadeamento de métodos:

1. **`.sort({ campo: 1 | -1 })`**:
   - `1`: Ordenação Crescente (Ascendente, A-Z, 0-9).
   - `-1`: Ordenação Decrescente (Descendente, Z-A, 9-0).
2. **`.limit(n)`**: Restringe o número máximo de documentos devolvidos.
3. **`.skip(n)`**: Pula/ignora os primeiros `n` documentos encontrados.

```javascript
// Exemplo: 5 maiores pedidos por valor de venda
db.pedidos.find().sort({ SALES: -1 }).limit(5)
```

---

## 5.2 Regra de Ouro da Ordem de Avaliação no Motor

Não importa em que ordem você escreva `.limit()`, `.skip()` ou `.sort()` no seu código JavaScript, **o MongoDB sempre processa na seguinte ordem interna**:

```text
┌────────────────┐      ┌────────────────┐      ┌────────────────┐      ┌────────────────┐
│   1. FILTRO    │      │  2. ORDENAÇÃO  │      │    3. SALTO    │      │  4. RESTRIÇÃO  │
│   .find(...)   │ ───> │   .sort(...)   │ ───> │   .skip(...)   │ ───> │  .limit(...)   │
│                │      │                │      │                │      │                │
│ Seleciona os   │      │ Ordena via     │      │ Pula os        │      │ Retém apenas o │
│ documentos     │      │ índice ou RAM  │      │ primeiros N    │      │ teto máximo    │
│ elegíveis      │      │ (1 ou -1)      │      │ documentos     │      │ de documentos  │
└────────────────┘      └────────────────┘      └────────────────┘      └────────────────┘
```

### Implementação de Paginação Real:
Para paginar dados em uma interface web com tamanho de página `T` e página atual `P` (iniciando em 1):

```text
Fórmula de Cálculo:
  skip  = (P - 1) * T
  limit = T
```

```javascript
// Página 1 (primeiros 10 registros de alto valor):
db.pedidos.find({ SALES: { $gt: 3000 } }).sort({ SALES: -1 }).limit(10)

// Página 2 (pula os 10 primeiros e pega os próximos 10):
db.pedidos.find({ SALES: { $gt: 3000 } }).sort({ SALES: -1 }).skip(10).limit(10)
```

---

# 6. Módulo 6: Aggregation Framework (Mergulho Profundo)

## 6.1 Conceito de Pipeline de Transformação

O **Aggregation Framework** é o mecanismo analítico mais poderoso do MongoDB. Ele funciona como uma **esteira de produção industrial (pipeline)**:

```text
                    ESTEIRA ANALÍTICA DO AGGREGATION PIPELINE
                    ═════════════════════════════════════════

                 ┌─────────────────────────────────────────┐
                 │       Coleção de Origem ('pedidos')     │
                 │        (Ex: 35 documentos brutos)       │
                 └────────────────────┬────────────────────┘
                                      │
                                      ▼
                 ┌─────────────────────────────────────────┐
                 │          ESTÁGIO 1: $match              │
                 │   Filtra os dados de entrada            │
                 │   Ex: { STATUS: "Shipped" }             │
                 └────────────────────┬────────────────────┘
                                      │ (Passam apenas documentos válidos)
                                      ▼
                 ┌─────────────────────────────────────────┐
                 │          ESTÁGIO 2: $group              │
                 │   Agrupa por chave e totaliza valores   │
                 │   Ex: _id: "$COUNTRY", total: {$sum...} │
                 └────────────────────┬────────────────────┘
                                      │ (Gera documentos consolidados)
                                      ▼
                 ┌─────────────────────────────────────────┐
                 │          ESTÁGIO 3: $sort               │
                 │   Ordena o fluxo de saída               │
                 │   Ex: { total: -1 } (maior para menor)  │
                 └────────────────────┬────────────────────┘
                                      │
                                      ▼
                 ┌─────────────────────────────────────────┐
                 │          ESTÁGIO 4: $limit              │
                 │   Restringe o volume de saída           │
                 │   Ex: 3 (pega o top 3 do ranking)       │
                 └────────────────────┬────────────────────┘
                                      │
                                      ▼
                 ┌─────────────────────────────────────────┐
                 │         ESTÁGIO 5: $project             │
                 │   Modifica e limpa os campos finais     │
                 │   Ex: { _id: 0, pais: "$_id", total: 1 }│
                 └────────────────────┬────────────────────┘
                                      │
                                      ▼
                 ┌─────────────────────────────────────────┐
                 │             RESULTADO FINAL             │
                 │        (Dados prontos para consumo)     │
                 └─────────────────────────────────────────┘
```

Cada estágio recebe como entrada a saída gerada pelo estágio imediatamente anterior.

---

## 6.2 Tabela de Equivalência SQL vs Aggregation Pipeline

| Cláusula SQL Relacional | Estágio Aggregation MongoDB | Função Principal |
| :--- | :--- | :--- |
| `WHERE` / `HAVING` | **`$match`** | Filtra os documentos com base em critérios. |
| `GROUP BY` | **`$group`** | Agrupa documentos pela chave informada em `_id`. |
| `SELECT` (campos / aliases) | **`$project`** | Projeta, renomeia e cria novos atributos calculados. |
| `ORDER BY` | **`$sort`** | Ordena os documentos (`1` asc, `-1` desc). |
| `LIMIT` | **`$limit`** | Restringe a contagem máxima de documentos na esteira. |
| `OFFSET` | **`$skip`** | Descarta os primeiros documentos da esteira. |
| `LEFT OUTER JOIN` | **`$lookup`** | Realiza junção com outra coleção no mesmo banco. |
| `COUNT(*)` | **`$count`** | Contabiliza o volume de documentos que cruzaram o estágio. |
| *(Explosão de Arrays)* | **`$unwind`** | Decompõe um array em múltiplos documentos unitários. |

---

## 6.3 Estágios Estruturais (`$match`, `$group`, `$project`, `$unwind`, `$lookup`, `$count`)

### 1. `$group` e a chave `_id`:
O campo `_id` dentro do `$group` define o **critério de agregação**:
- **Consolidação Global (Todos num só):** `_id: null`
  ```javascript
  // Exercício 3: Total geral de vendas em 2003
  db.pedidos.aggregate([
    { $match: { ORDERDATE: { $gte: "2003-01-01", $lte: "2003-12-31" } } },
    { $group: { _id: null, totalVendas: { $sum: "$SALES" } } }
  ])
  ```
- **Agrupamento por Campo Simples:** `_id: "$NOME_DO_CAMPO"` *(Não esquecer o prefixo `$`!)*
  ```javascript
  // Exercício 4: Total de vendas por país
  db.pedidos.aggregate([
    { $group: { _id: "$COUNTRY", totalVendas: { $sum: "$SALES" } } }
  ])
  ```
- **Agrupamento por Chave Composta:** `_id: { chave1: "$CAMPO1", chave2: "$CAMPO2" }`
  ```javascript
  // Exercício 15: Total de vendas por combinação de País e Status
  db.pedidos.aggregate([
    {
      $group: {
        _id: { pais: "$COUNTRY", status: "$STATUS" },
        totalVendas: { $sum: "$SALES" }
      }
    }
  ])
  ```

### 2. `$lookup` (Junção entre Coleções):
Executa uma junção relacional unilateral (Left Outer Join).
- `from`: A coleção estrangeira que será consultada.
- `localField`: O campo na coleção base (atual).
- `foreignField`: O campo correspondente na coleção estrangeira.
- `as`: O nome do novo campo do tipo array que armazenará os documentos correspondentes.

```text
                         FUNCIONAMENTO DO ESTÁGIO $lookup
                         ════════════════════════════════

   Coleção 'pedidos' (Origem)                      Coleção 'clientes' (Estrangeira)
   ┌───────────────────────────────┐               ┌───────────────────────────────┐
   │ ORDERNUMBER: 10100            │               │ customer_id: 1                │
   │ SALES: 3000.00                │               │ customer_name: "Atelier G."   │
   │ CUSTOMER_ID: 1  ──────────────┼──────────────>│ contact_first: "Carine"       │
   └───────────────┬───────────────┘               └───────────────────────────────┘
                   │
                   │ (MongoDB executa a junção e embute o resultado em um array)
                   ▼
   Documento Intermediário gerado pelo $lookup:
   ┌────────────────────────────────────────────────────────────────────────┐
   │ ORDERNUMBER: 10100                                                     │
   │ SALES: 3000.00                                                         │
   │ CUSTOMER_ID: 1                                                         │
   │ cliente: [                                                             │
   │   { customer_id: 1, customer_name: "Atelier G.", contact_first: "..." }│
   │ ]                                                                      │
   └────────────────────────────────────────────────────────────────────────┘
                   │
                   │ (Após aplicar $unwind: "$cliente" + $project)
                   ▼
   Documento Final Limpo e Achatado:
   ┌────────────────────────────────────────────────────────────────────────┐
   │ ORDERNUMBER: 10100, SALES: 3000.00, customer_name: "Atelier G."        │
   └────────────────────────────────────────────────────────────────────────┘
```

```javascript
// Exercício 13: Juntar cada pedido ao seu respectivo cliente
db.pedidos.aggregate([
  {
    $lookup: {
      from: "clientes",
      localField: "CUSTOMER_ID",
      foreignField: "customer_id",
      as: "cliente"
    }
  },
  { $unwind: "$cliente" }, // Achata o array de 1 posição para objeto direto
  {
    $project: {
      _id: 0,
      ORDERNUMBER: 1,
      SALES: 1,
      customer_name: "$cliente.customer_name"
    }
  }
])
```

### 3. `$unwind` (Descompactação de Arrays):
Se um documento possui um array com 3 itens, o `$unwind` quebra esse documento em **3 documentos idênticos**, cada um contendo exatamente 1 item do array. É o oposto de agrupar.

---

## 6.4 Acumuladores e Operadores de Expressão

### Acumuladores de Grupo (Usados exclusivamente no `$group`):
- `$sum`: Soma valores (`{ $sum: "$SALES" }`) ou conta documentos (`{ $sum: 1 }`).
- `$avg`: Calcula a média aritmética (`{ $avg: "$PRICEEACH" }`).
- `$min` e `$max`: Identificam o menor e o maior valor dentro do grupo.
- `$addToSet`: Coleta elementos únicos para dentro de um novo array (elimina repetições).
- `$push`: Coleta todos os elementos para um array (preserva duplicatas e ordem).

### Operadores de Expressão (Usados no `$project` ou `$set`):
- `$multiply`: Multiplicação (`{ $multiply: ["$SALES", 0.10] }`).
- `$divide`: Divisão (`{ $divide: ["$SALES", 1000] }`).
- `$round`: Arredondamento numérico (`{ $round: ["$precoMedio", 2] }`).
- `$size`: Retorna o tamanho (comprimento) de um array (`{ $size: "$paises" }`).

---

# 7. Módulo 7: Otimização de Performance, Índices e a Regra ESR

## 7.1 Como Funcionam os Índices B-Tree

Por padrão, sem índices, o MongoDB executa um **`COLLSCAN`** (*Collection Scan*): ele lê fisicamente todos os blocos de disco da coleção da primeira à última linha para verificar quem atende ao filtro.

Ao criar um índice com `createIndex()`, o MongoDB monta uma árvore balanceada (**B-Tree**) em memória:
- **`IXSCAN`** (*Index Scan*): O motor percorre a árvore B-Tree em tempo logarítmico O(log N), encontrando os ponteiros dos documentos diretamente.
- **`FETCH`**: O motor vai até o disco buscar os dados dos campos que não estavam presentes no índice.
- **`Covered Query`** (*Consulta Coberta*): Quando todos os campos do filtro e da projeção já fazem parte do próprio índice, a fase `FETCH` é eliminada (Zero leituras de disco adicionais).

```text
                    COMPARATIVO DE EXECUÇÃO: COLLSCAN vs IXSCAN
                    ═══════════════════════════════════════════

   [1] SEM ÍNDICE: COLLSCAN (Collection Scan) - LENTO / CUSTOSO
   ────────────────────────────────────────────────────────────────────────
   O motor precisa ler documento por documento direto do disco rígido:

   Disco: [Doc 1] ──> [Doc 2] ──> [Doc 3] ──> ... ──> [Doc 50.000]
   Auditoria: 50.000 documentos lidos em disco para achar 2 resultados.
   Resultado: Alto I/O de disco, CPU elevada, lentidão na resposta.


   [2] COM ÍNDICE B-TREE: IXSCAN (Index Scan) - CIRÚRGICO / RÁPIDO
   ────────────────────────────────────────────────────────────────────────
   O motor navega na árvore balanceada em memória RAM em tempo O(log N):

                       [ Chave: STATUS ]
                        /             \
             ["Cancelled"]           ["Shipped"]
                                      /        \
                             [SALES < 3000]   [SALES >= 3000] ──┐
                                                                │ Ponteiro direto
   Disco Rígido:                                                ▼
   Busca cirúrgica apenas no documento desejado: ──────────> [Doc 10103]
   Auditoria: 1 chave examinada para devolver 1 documento (Proporção ideal 1:1).
```

```javascript
// Criar índice simples no campo ORDERNUMBER
db.pedidos.createIndex({ ORDERNUMBER: 1 })

// Criar índice único (rejeita duplicatas)
db.pedidos.createIndex({ ORDERNUMBER: 1 }, { unique: true })

// Listar índices existentes na coleção
db.pedidos.getIndexes()
```

---

## 7.2 A Regra ESR (Equality, Sort, Range)

Para projetar **índices compostos** de alta performance com múltiplos campos, a MongoDB University estabelece a regra canônica **ESR**:

1. **E - Equality (Igualdade):** Campos que serão filtrados com valores exatos vêm **em primeiro lugar** no índice (ex: `{ STATUS: "Shipped" }`).
2. **S - Sort (Ordenação):** Campos usados para ordenar os resultados vêm **no meio** do índice (ex: `sort({ SALES: -1 })`). Isso evita ordenações custosas na memória RAM (*blocking in-memory sort*).
3. **R - Range (Intervalo):** Campos filtrados com operadores de intervalo (`$gt`, `$lt`, `$gte`, `$lte`) vêm **por último** (ex: `{ ORDERDATE: { $gte: "2004-01-01" } }`).

### Exemplo Perfeito aplicando a Regra ESR:
```javascript
// Criando o índice seguindo estritamente E -> S -> R:
db.pedidos.createIndex({ STATUS: 1, SALES: -1, ORDERDATE: 1 })
```

---

## 7.3 Auditoria com `.explain("executionStats")`

Para verificar o plano de execução e o custo de uma query:
```javascript
db.pedidos.find({ STATUS: "Shipped" })
  .sort({ SALES: -1 })
  .explain("executionStats")
```

### O que observar no relatório do `explain`:
1. `winningPlan.inputStage.stage`:
   - Se for **`IXSCAN`**, o índice foi utilizado com sucesso! 🎉
   - Se for **`COLLSCAN`**, o banco fez varredura sequencial completa em disco (alerta de performance). ⚠️
2. `totalDocsExamined` vs `nReturned`:
   - Em consultas otimizadas, a proporção ideal é **1 : 1** (examinou 10 documentos para devolver exatamente 10). Se examinou 10.000 para devolver 2, o índice está ausente ou mal dimensionado.

---

# 8. Módulo 8: Resolução Completa dos 30 Exercícios da Aula 13

Abaixo está o gabarito comentado e aprofundado dos 30 exercícios oficiais da Aula 13, baseado no dataset das coleções `pedidos` e `clientes`.

---

## Exercícios 1 a 6

### Exercício 1 — find() com condição ($gt)
- **Enunciado:** *Recupere todos os pedidos onde `QUANTITYORDERED` seja maior que 50.*
- **Conceito & Por Que Usar:** O operador relacional `$gt` (*greater than*) filtra valores estritamente maiores que o limite especificado.
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.find({ QUANTITYORDERED: { $gt: 50 } })
  ```
- **Variações & Alternativas:** Caso queira exibir apenas alguns campos para conferência no terminal:
  ```javascript
  db.pedidos.find({ QUANTITYORDERED: { $gt: 50 } }, { ORDERNUMBER: 1, QUANTITYORDERED: 1, _id: 0 })
  ```
- **Pontos de Atenção:** O enunciado pediu para recuperar os *pedidos* (documentos completos). A menos que projeção seja explicitamente solicitada, a query padrão deve retornar o documento inteiro.

---

### Exercício 2 — Projeção
- **Enunciado:** *Retorne apenas os campos `ORDERNUMBER`, `SALES` e `STATUS` para todos os documentos.*
- **Conceito & Por Que Usar:** Projeção reduz o tráfego de rede e uso de CPU trazendo apenas os atributos de interesse. O primeiro parâmetro `{}` seleciona todos os registros; o segundo define os campos desejados com valor `1` e suprime o `_id` com `0`.
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.find({}, { ORDERNUMBER: 1, SALES: 1, STATUS: 1, _id: 0 })
  ```
- **Pontos de Atenção:** Se você esquecer de passar `_id: 0`, ele virá acompanhando o resultado por comportamento padrão do MongoDB.

---

### Exercício 3 — Agregação com $sum
- **Enunciado:** *Calcule o total de `SALES` para todos os pedidos feitos em 2003. (Dica: use `$match` com um intervalo de datas antes do `$group`.)*
- **Conceito & Por Que Usar:** Em pipelines de agregação analítica, primeiro reduzimos a massa de dados com `$match` (filtro no início da esteira) e em seguida agrupamos todos os registros com `_id: null` aplicando o acumulador `$sum` sobre a variável `"$SALES"`.
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.aggregate([
    {
      $match: {
        ORDERDATE: { $gte: "2003-01-01", $lte: "2003-12-31" }
      }
    },
    {
      $group: {
        _id: null,
        totalVendas2003: { $sum: "$SALES" }
      }
    }
  ])
  ```
- **Pontos de Atenção:** Atribua um nome semântico coerente ao campo de saída (como `totalVendas2003` ou `totalSales`). Chamar de `totalUnidades` é um erro semântico comum copiado de outros exemplos, já que `SALES` representa moeda e não volume de itens.

---

### Exercício 4 — Agrupamento por campo
- **Enunciado:** *Agrupe os pedidos por `COUNTRY` e obtenha o total de `SALES` para cada país.*
- **Conceito & Por Que Usar:** Para agrupar por uma coluna categórica, passamos a referência do campo precedida de cifrão (`_id: "$COUNTRY"`). O MongoDB criará uma partição para cada país único existente na base.
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.aggregate([
    {
      $group: {
        _id: "$COUNTRY",
        totalSales: { $sum: "$SALES" }
      }
    }
  ])
  ```
- **Variações:** Adicionar ordenação decrescente por faturamento melhora a leitura analítica:
  ```javascript
  db.pedidos.aggregate([
    { $group: { _id: "$COUNTRY", totalSales: { $sum: "$SALES" } } },
    { $sort: { totalSales: -1 } }
  ])
  ```

---

### Exercício 5 — $avg (média)
- **Enunciado:** *Encontre a média de `SALES` para todos os pedidos.*
- **Conceito & Por Que Usar:** O acumulador `$avg` computa a média aritmética dos valores do campo numérico dentro do grupo. Como a meta é a média global de todos os pedidos, usamos `_id: null`.
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.aggregate([
    {
      $group: {
        _id: null,
        mediaVendas: { $avg: "$SALES" }
      }
    }
  ])
  ```
- **Variação com Arredondamento Elegante:**
  ```javascript
  db.pedidos.aggregate([
    { $group: { _id: null, mediaVendas: { $avg: "$SALES" } } },
    { $project: { _id: 0, mediaFormatada: { $round: ["$mediaVendas", 2] } } }
  ])
  ```

---

### Exercício 6 — $sort (ordenação)
- **Enunciado:** *Recupere todos os pedidos ordenados por `SALES` em ordem decrescente.*
- **Conceito & Por Que Usar:** O método `.sort()` encadeado no cursor organiza os documentos de saída. O valor `-1` indica ordem descendente (do maior para o menor).
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.find().sort({ SALES: -1 })
  ```
- **Pontos de Atenção:** Não adicione projeção manual se o enunciado solicitou "recupere todos os pedidos". Os campos de cabeçalho, datas e IDs são necessários para compor o documento completo.

---

## Exercícios 7 a 12

### Exercício 7 — updateOne
- **Enunciado:** *Atualize o `STATUS` do pedido `ORDERNUMBER = 10107` para `"Delivered"`.*
- **Conceito & Por Que Usar:** `updateOne` localiza o primeiro documento que satisfaz o filtro de busca e altera apenas as propriedades definidas no operador `$set`, mantendo todos os outros atributos intactos.
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.updateOne(
    { ORDERNUMBER: 10107 },
    { $set: { STATUS: "Delivered" } }
  )
  ```
- **Comando de Verificação:**
  ```javascript
  db.pedidos.find({ ORDERNUMBER: 10107 })
  ```

---

### Exercício 8 — updateMany
- **Enunciado:** *Atualize o `STATUS` para `"Processing"` em todos os pedidos onde `QUANTITYORDERED < 30`.*
- **Conceito & Por Que Usar:** `updateMany` aplica a mutação a todos os documentos que casam com a condição relacional `$lt` (*less than*).
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.updateMany(
    { QUANTITYORDERED: { $lt: 30 } },
    { $set: { STATUS: "Processing" } }
  )
  ```
- **Pontos de Atenção:** Na base inicial, exatamente 9 documentos atendem a este critério.

---

### Exercício 9 — deleteMany
- **Enunciado:** *Elimine todos os pedidos onde `COUNTRY` seja `"USA"`. Antes de executar, faça um `countDocuments` para saber quantos serão apagados.*
- **Conceito & Por Que Usar:** Remoção em lote irreversível. Seguir sempre a tríade de segurança: auditar, remover e validar.
- **Sintaxe Recomendada:**
  ```javascript
  // 1. Auditoria prévia (deve retornar 5)
  db.pedidos.countDocuments({ COUNTRY: "USA" })

  // 2. Execução da deleção
  db.pedidos.deleteMany({ COUNTRY: "USA" })

  // 3. Validação posterior (deve retornar 0)
  db.pedidos.countDocuments({ COUNTRY: "USA" })
  ```
- **⚠️ IMPACTO CRÍTICO DESTE EXERCÍCIO:** A coleção começou com 35 documentos. Após este exercício, restam **30 documentos** na coleção ativa! Isso terá impacto direto no Exercício 30!

---

### Exercício 10 — Busca por texto simples com $regex
- **Enunciado:** *Encontre todos os pedidos com um `CONTACTLASTNAME` que contenha `"Young"`.*
- **Conceito & Por Que Usar:** A expressão regular sem delimitadores de início/fim funciona como um operador `LIKE '%Young%'` do SQL. A opção `$options: "i"` torna a busca imune a diferenças de caixa (*case-insensitive*).
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.find({ CONTACTLASTNAME: { $regex: "Young", $options: "i" } })
  ```

---

### Exercício 11 — Expressão regular com âncora
- **Enunciado:** *Encontre todos os pedidos em que a `CITY` comece pela letra `"P"` usando uma expressão regular.*
- **Conceito & Por Que Usar:** O caractere circunflexo `^` representa uma âncora que força o casamento estritamente no primeiro caractere da cadeia de texto.
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.find({ CITY: { $regex: "^P", $options: "i" } })
  ```
- **Cidades Casadas no Dataset:** Paris, Porto, Philadelphia, Pretoria, Peoria.

---

### Exercício 12 — Intervalo de datas
- **Enunciado:** *Recupere todos os pedidos feitos entre 01/07/2003 e 31/12/2003.*
- **Conceito & Por Que Usar:** Como as datas estão serializadas em formato ISO 8601 (`YYYY-MM-DD`), a comparação lexicográfica funciona perfeitamente com `$gte` e `$lte` no mesmo campo.
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.find({
    ORDERDATE: { $gte: "2003-07-01", $lte: "2003-12-31" }
  })
  ```

---

## Exercícios 13 a 18

### Exercício 13 — $lookup (junção entre coleções)
- **Enunciado:** *Use `$lookup` para juntar pedidos com clientes e devolver `ORDERNUMBER`, `SALES` e o `customer_name` correspondente (dica: use `$unwind` + `$project` depois do `$lookup`).*
- **Conceito & Por Que Usar:** Realiza a correspondência entre a chave `CUSTOMER_ID` de pedidos e `customer_id` de clientes. O `$lookup` gera um array; o `$unwind` descompacta o array para permitir acesso direto via notação `"$cliente.customer_name"`.
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.aggregate([
    {
      $lookup: {
        from: "clientes",
        localField: "CUSTOMER_ID",
        foreignField: "customer_id",
        as: "cliente"
      }
    },
    { $unwind: "$cliente" },
    {
      $project: {
        _id: 0,
        ORDERNUMBER: 1,
        SALES: 1,
        customer_name: "$cliente.customer_name"
      }
    }
  ])
  ```

---

### Exercício 14 — Criar índice
- **Enunciado:** *Crie um índice no campo `ORDERNUMBER` para acelerar as pesquisas por número de pedido e depois liste os índices existentes.*
- **Conceito & Por Que Usar:** Transforma buscas por chave primária de negócio de `COLLSCAN` para `IXSCAN`.
- **Sintaxe Recomendada:**
  ```javascript
  // Criar o índice
  db.pedidos.createIndex({ ORDERNUMBER: 1 })

  // Listar os índices existentes
  db.pedidos.getIndexes()
  ```
- **Saída Esperada no `getIndexes()`:** Exibição do índice padrão `_id_` e do novo índice criado `ORDERNUMBER_1`.

---

### Exercício 15 — Agrupamento por múltiplos campos
- **Enunciado:** *Agrupe os pedidos por `COUNTRY` e `STATUS`, calculando o total de `SALES` para cada combinação.*
- **Conceito & Por Que Usar:** Quando o `_id` do `$group` recebe um subdocumento `{ country: "$COUNTRY", status: "$STATUS" }`, o MongoDB cria uma chave composta multidimensional.
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.aggregate([
    {
      $group: {
        _id: {
          country: "$COUNTRY",
          status: "$STATUS"
        },
        totalSales: { $sum: "$SALES" }
      }
    }
  ])
  ```

---

### Exercício 16 — Paginação ($skip + $limit)
- **Enunciado:** *Recupere os primeiros 10 pedidos com `SALES > 3000`, ordenados por `SALES` em ordem decrescente.*
- **Conceito & Por Que Usar:** Demonstra a recuperação da primeira página de dados filtrada e ordenada.
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.find({ SALES: { $gt: 3000 } })
    .sort({ SALES: -1 })
    .limit(10)
  ```
- **Variação (Segunda página):** Caso fosse a página 2, encadearia `.skip(10).limit(10)`.

---

### Exercício 17 — Adicionar campo calculado ($set com $multiply)
- **Enunciado:** *Adicione o campo `TotalCost` a cada documento, com o produto de `QUANTITYORDERED` e `PRICEEACH`. Depois faça um `find()` para confirmar.*
- **Conceito & Por Que Usar:** Atualização com pipeline `[ ... ]` para executar computações matemáticas com operadores agregados como `$multiply`.
- **Sintaxe Recomendada:**
  ```javascript
  // 1. Atualizar todos os documentos calculando o custo total
  db.pedidos.updateMany(
    {},
    [
      {
        $set: {
          TotalCost: { $multiply: ["$QUANTITYORDERED", "$PRICEEACH"] }
        }
      }
    ]
  )

  // 2. Consulta de confirmação
  db.pedidos.find({}, { ORDERNUMBER: 1, QUANTITYORDERED: 1, PRICEEACH: 1, TotalCost: 1, _id: 0 }).limit(5)
  ```

---

### Exercício 18 — Adicionar array aninhado
- **Enunciado:** *Adicione um array `productDetails` a todos os pedidos com `PRODUCTCODE = "S18_1342"` contendo `product_name`, `product_code` e `product_description` para a linha "Trucks".*
- **Conceito & Por Que Usar:** Ilustra a capacidade NoSQL de aninhar arrays de documentos ricos (*embedded documents*).
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.updateMany(
    { PRODUCTCODE: "S18_1342" },
    {
      $set: {
        productDetails: [
          {
            product_name: "Truck Model",
            product_code: "S18_1342",
            product_description: "Linha de produtos Trucks"
          }
        ]
      }
    }
  )
  ```

---

## Exercícios 19 a 24

### Exercício 19 — $in e $nin
- **Enunciado:** *Devolva os pedidos com `STATUS` que não seja `"Shipped"` nem `"Cancelled"` (use `$nin`).*
- **Conceito & Por Que Usar:** O operador `$nin` (*not in*) recebe um array de valores desqualificadores. Documentos cujo valor do campo coincidir com qualquer item da lista são descartados.
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.find({
    STATUS: { $nin: ["Shipped", "Cancelled"] }
  })
  ```
- **Status Retornados:** Pedidos com status `"Processing"` e `"On Hold"`.

---

### Exercício 20 — $and e $or
- **Enunciado:** *Encontre pedidos com `QUANTITYORDERED` entre 20 e 40 e com `COUNTRY` diferente de `"USA"`.*
- **Conceito & Por Que Usar:** Demonstra a aplicação de múltiplas condições simultâneas de intervalo e desigualdade.
- **Sintaxe Recomendada (Forma Explícita com `$and`):**
  ```javascript
  db.pedidos.find({
    $and: [
      { QUANTITYORDERED: { $gte: 20, $lte: 40 } },
      { COUNTRY: { $ne: "USA" } }
    ]
  })
  ```
- **Sintaxe Alternativa (Forma Implícita Idiomática):**
  ```javascript
  db.pedidos.find({
    QUANTITYORDERED: { $gte: 20, $lte: 40 },
    COUNTRY: { $ne: "USA" }
  })
  ```

---

### Exercício 21 — $exists
- **Enunciado:** *Após o exercício 17, execute uma query que devolva apenas documentos que já tenham o campo `TotalCost`.*
- **Conceito & Por Que Usar:** Valida a presença de uma propriedade no schema flexível.
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.find({ TotalCost: { $exists: true } })
  ```

---

### Exercício 22 — distinct
- **Enunciado:** *Liste todas as linhas de produto (`PRODUCTLINE`) únicas presentes na coleção.*
- **Conceito & Por Que Usar:** Devolve diretamente um array em memória com os valores distintos sem necessidade de pipeline de agregação.
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.distinct("PRODUCTLINE")
  ```
- **Retorno Esperado:** `[ "Classic Cars", "Motorcycles", "Planes", "Ships", "Trucks", "Vintage Cars" ]` (6 categorias).

---

### Exercício 23 — $min e $max
- **Enunciado:** *Para cada `PRODUCTLINE`, obtenha o preço unitário mínimo e o máximo (`PRICEEACH`).*
- **Conceito & Por Que Usar:** Agrupa por categoria e usa acumuladores extremos para encontrar os limites de faixa de preço.
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.aggregate([
    {
      $group: {
        _id: "$PRODUCTLINE",
        precoMinimo: { $min: "$PRICEEACH" },
        precoMaximo: { $max: "$PRICEEACH" }
      }
    },
    {
      $project: {
        _id: 0,
        PRODUCTLINE: "$_id",
        precoMinimo: 1,
        precoMaximo: 1
      }
    }
  ])
  ```

---

### Exercício 24 — $project com campos calculados
- **Enunciado:** *Use `$project` para devolver `ORDERNUMBER`, `COUNTRY` e um novo campo `descontoSugerido` igual a 10% de `SALES`.*
- **Conceito & Por Que Usar:** O operador `$multiply` calcula expressões matemáticas diretamente no estágio de projeção sem persistir no banco.
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.aggregate([
    {
      $project: {
        _id: 0,
        ORDERNUMBER: 1,
        COUNTRY: 1,
        descontoSugerido: { $multiply: ["$SALES", 0.10] }
      }
    }
  ])
  ```

---

## Exercícios 25 a 30

### Exercício 25 — $count
- **Enunciado:** *Conte quantos pedidos têm `SALES` superior à média global de `SALES`. (Dica: use `$group` para calcular a média num pipeline separado, ou faça em duas queries.)*
- **Conceito & Por Que Usar:** Demonstra a resolução analítica em duas fases:
  1. Descobrir o valor de corte (média global).
  2. Filtrar e quantificar os registros acima desse patamar usando o estágio `$count`.
- **Sintaxe Recomendada:**
  ```javascript
  // PASSO 1: Obter o valor da média global
  db.pedidos.aggregate([
    { $group: { _id: null, mediaGlobal: { $avg: "$SALES" } } }
  ])
  // Valor obtido na base ativa pós-Ex 9: aproximadamente 3673.68

  // PASSO 2: Contar documentos acima dessa média
  db.pedidos.aggregate([
    { $match: { SALES: { $gt: 3673.68 } } },
    { $count: "pedidosAcimaDaMedia" }
  ])
  ```

---

### Exercício 26 — $unwind
- **Enunciado:** *Depois do exercício 18, use `$unwind` para "achatar" o array `productDetails` e listar `ORDERNUMBER` e `productDetails.product_name` para cada linha.*
- **Conceito & Por Que Usar:** O `$unwind` expande os elementos do array gerando documentos unitários, permitindo acessar propriedades internas via dot notation no `$project`.
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.aggregate([
    { $unwind: "$productDetails" },
    {
      $project: {
        _id: 0,
        ORDERNUMBER: 1,
        "productDetails.product_name": 1
      }
    }
  ])
  ```

---

### Exercício 27 — Aggregation de várias etapas
- **Enunciado:** *Construa um pipeline que devolva a linha de produto (`PRODUCTLINE`) com a maior receita total, considerando apenas pedidos de 2004.*
- **Conceito & Por Que Usar:** Encadeamento de 5 estágios: `$match` (filtra ano) $\to$ `$group` (soma receita por linha) $\to$ `$sort` (ordem decrescente) $\to$ `$limit: 1` (pega apenas o primeiro lugar) $\to$ `$project` (formata a saída).
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.aggregate([
    // 1. Filtrar pedidos cujo ano de pedido inicie com '2004'
    { $match: { ORDERDATE: { $regex: "^2004" } } },
    // 2. Agrupar somando as vendas por linha de produto
    {
      $group: {
        _id: "$PRODUCTLINE",
        receitaTotal: { $sum: "$SALES" }
      }
    },
    // 3. Ordenar do maior para o menor faturamento
    { $sort: { receitaTotal: -1 } },
    // 4. Selecionar exclusivamente o líder
    { $limit: 1 },
    // 5. Renomear e formatar a exibição
    {
      $project: {
        _id: 0,
        PRODUCTLINE: "$_id",
        receitaTotal: 1
      }
    }
  ])
  ```

---

### Exercício 28 — $addToSet e contagem de únicos
- **Enunciado:** *Para cada `PRODUCTLINE`, conte quantos países distintos compraram esse produto.*
- **Conceito & Por Que Usar:** O operador `$addToSet` agrupa os países garantindo que nomes duplicados não entrem no array. Em seguida, o estágio `$project` usa a expressão `$size` para contar o número de elementos únicos acumulados.
- **Sintaxe Recomendada:**
  ```javascript
  db.pedidos.aggregate([
    {
      $group: {
        _id: "$PRODUCTLINE",
        paisesDistintos: { $addToSet: "$COUNTRY" }
      }
    },
    {
      $project: {
        _id: 0,
        PRODUCTLINE: "$_id",
        totalPaisesDistintos: { $size: "$paisesDistintos" }
      }
    }
  ])
  ```

---

### Exercício 29 — Índice composto
- **Enunciado:** *Crie um índice composto por `STATUS` (crescente) e `SALES` (decrescente) e execute uma query que o utilize. Confirme com `.explain("executionStats")` que o índice foi usado.*
- **Conceito & Por Que Usar:** Índices compostos atendem consultas combinadas de filtro exato e ordenação rápida sem overhead.
- **Sintaxe Recomendada:**
  ```javascript
  // 1. Criar o índice composto
  db.pedidos.createIndex({ STATUS: 1, SALES: -1 })

  // 2. Executar a consulta com auditoria de execução
  db.pedidos.find({ STATUS: "Shipped" })
    .sort({ SALES: -1 })
    .explain("executionStats")
  ```
- **Auditoria Esperada:** O relatório de saída deve exibir `winningPlan.inputStage.stage = "IXSCAN"`.

---

### Exercício 30 — insertOne e insertMany
- **Enunciado:** *Insira três novos pedidos com `ORDERNUMBER` 10201, 10202 e 10203 usando `insertMany`. Depois, execute `countDocuments()` para confirmar que ficaram 38 documentos.*
- **Conceito & Por Que Usar:** Demonstra inserção múltipla em lote.

#### ⚠️ A Grande Pegadinha da Contagem Final (33 vs 38 Documentos):
- O roteiro original assumiu matematicamente: `35 (iniciais) + 3 (novos) = 38`.
- **Porém**, no **Exercício 9**, foram apagados 5 documentos dos Estados Unidos (`COUNTRY: "USA"`).
- Logo, na base real em execução sequencial: `35 - 5 + 3 = 33 documentos`.

Se o professor ou validador exigir estritamente a marcação de 38 documentos, basta reimportar a coleção no terminal com `--drop` antes de rodar a inserção:
```powershell
mongoimport --db loja --collection pedidos --file dados_pedidos.json --jsonArray --drop
```

**Sintaxe da Inserção:**
```javascript
db.pedidos.insertMany([
  {
    ORDERNUMBER: 10201,
    QUANTITYORDERED: 25,
    PRICEEACH: 80,
    SALES: 2000,
    STATUS: "In Process",
    ORDERDATE: "2005-11-02",
    PRODUCTLINE: "Trucks",
    PRODUCTCODE: "S18_1342",
    CUSTOMER_ID: 2,
    CONTACTLASTNAME: "Silva",
    CITY: "São Paulo",
    COUNTRY: "Brazil"
  },
  {
    ORDERNUMBER: 10202,
    QUANTITYORDERED: 15,
    PRICEEACH: 120,
    SALES: 1800,
    STATUS: "Shipped",
    ORDERDATE: "2005-11-03",
    PRODUCTLINE: "Motorcycles",
    PRODUCTCODE: "S10_1678",
    CUSTOMER_ID: 3,
    CONTACTLASTNAME: "Martins",
    CITY: "Lisbon",
    COUNTRY: "Portugal"
  },
  {
    ORDERNUMBER: 10203,
    QUANTITYORDERED: 50,
    PRICEEACH: 60,
    SALES: 3000,
    STATUS: "Cancelled",
    ORDERDATE: "2005-11-04",
    PRODUCTLINE: "Classic Cars",
    PRODUCTCODE: "S24_2000",
    CUSTOMER_ID: 4,
    CONTACTLASTNAME: "Fernandez",
    CITY: "Madrid",
    COUNTRY: "Spain"
  }
]);

// Validação final de contagem
db.pedidos.countDocuments()
```

---

# 9. Módulo 9: Cheat Sheet / Cola Rápida para Prova

## 📌 Guia de Operadores em Uma Página

### Operadores de Comparação & Busca
```javascript
{ campo: { $eq: valor } }    // Igual ( = )
{ campo: { $ne: valor } }    // Diferente ( != )
{ campo: { $gt: 50 } }       // Maior que ( > )
{ campo: { $gte: 50 } }      // Maior ou igual ( >= )
{ campo: { $lt: 100 } }      // Menor que ( < )
{ campo: { $lte: 100 } }     // Menor ou igual ( <= )
{ campo: { $in: [1, 2, 3] } }// Está na lista (IN)
{ campo: { $nin: ["A", "B"] } // Não está na lista (NOT IN)
{ campo: { $regex: "^P", $options: "i" } } // Expressão regular (Começa com P)
{ campo: { $exists: true } } // Campo existe no documento
```

### Operadores Lógicos
```javascript
{ $and: [ { cond1 }, { cond2 } ] } // E lógico explícito
{ $or:  [ { cond1 }, { cond2 } ] } // OU lógico
{ $not: { $gt: 50 } }              // NÃO lógico
```

### Operadores de Atualização (`update`)
```javascript
{ $set: { status: "OK" } }         // Define ou altera valor
{ $unset: { temporario: "" } }     // Remove o campo
{ $inc: { estoque: -1, cliques: 1} // Incrementa/decrementa
{ $push: { tags: "promo" } }       // Adiciona ao array (permite duplicados)
{ $addToSet: { tags: "promo" } }   // Adiciona ao array se não existir
{ $pull: { tags: "antigo" } }      // Remove do array
```

### Estágios do Aggregation Pipeline
```javascript
db.colecao.aggregate([
  { $match:   { status: "A" } },                 // Filtra (WHERE)
  { $group:   { _id: "$categoria", total: { $sum: "$preco" } } }, // Agrupa (GROUP BY)
  { $sort:    { total: -1 } },                   // Ordena (ORDER BY)
  { $skip:    10 },                              // Pula (OFFSET)
  { $limit:   5 },                               // Limita (LIMIT)
  { $project: { _id: 0, categoria: "$_id", total: 1 } }, // Formata (SELECT)
  { $unwind:  "$arrayDeItens" },                 // Descompacta array
  { $lookup:  { from: "outraCol", localField: "x", foreignField: "y", as: "dest" } } // JOIN
])
```

### Acumuladores de Agrupamento
```javascript
{ $sum: "$campo" }   // Soma dos valores
{ $sum: 1 }          // Contagem de documentos
{ $avg: "$campo" }   // Média aritmética
{ $min: "$campo" }   // Menor valor
{ $max: "$campo" }   // Maior valor
{ $addToSet: "$c" }  // Array de valores únicos do grupo
```

---

## 💡 Dicas de Sobrevivência para Avaliações Práticas

1. **Esqueceu o `$`?** Em queries de `$group` ou `$project`, se você está se referindo ao **valor de um campo existente**, é obrigatório colocar `"$"` na frente (ex: `"$SALES"`). Se esquecer, o MongoDB interpretará como uma string literal fixa `"SALES"`.
2. **Projeções no `find`:** Lembre-se de que `{ nome: 1, preco: 1 }` **ainda traz o `_id`**. Para escondê-lo, adicione obrigatoriamente `_id: 0`.
3. **Array em `updateMany`:** Se precisar calcular um campo novo usando dados de outro campo existente (como no Ex 17), envolva a atualização em colchetes `[ { $set: { novo: { $multiply: ["$a", "$b"] } } } ]`.
4. **Verificação de Performance:** Sempre que a questão pedir para "provar que o índice foi usado", adicione `.explain("executionStats")` e mencione o estágio **`IXSCAN`**.
