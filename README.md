# 🛒 TechStore — Stored Procedures, Consultas e Views no MySQL

> Atividade individual da disciplina de Banco de Dados.
> Banco utilizado: **`loja_tech`** (e-commerce de tecnologia), executado no **MySQL Workbench**.

---

## 📑 Sumário

1. [Objetivo](#-objetivo)
2. [Estrutura do repositório](#-estrutura-do-repositório)
3. [Como executar](#-como-executar)
4. [Parte 1 — 10 consultas SQL](#-parte-1--10-consultas-sql)
5. [Parte 2 — 5 Stored Procedures](#-parte-2--5-stored-procedures)
6. [Parte 3 — Views vs. Stored Procedures](#-parte-3--views-vs-stored-procedures)
7. [Decisões e premissas](#-decisões-e-premissas)
8. [Referências](#-referências)
9. [Autor](#-autor)

---

## 🎯 Objetivo

Praticar a sintaxe fundamental de SQL e de **Stored Procedures** (parâmetros `IN`/`OUT`,
`DELIMITER`, boas práticas) e pesquisar **quando uma View é a ferramenta mais adequada**
do que uma procedure.

## 📁 Estrutura do repositório

```
techstore-stored-procedures/
├── 00_banco_loja_tech.sql    # Criação do banco, tabelas e carga inicial
├── 01_consultas.sql          # 10 desafios de SELECT
├── 02_stored_procedures.sql  # 5 stored procedures
├── 03_views.sql              # 5 cenários de uso de views
└── README.md
```

## ▶️ Como executar

1. Abra o MySQL Workbench.
2. Execute, **nesta ordem**:
   1. `00_banco_loja_tech.sql` (⚠️ recria o banco `loja_tech` do zero)
   2. `01_consultas.sql`
   3. `02_stored_procedures.sql`
   4. `03_views.sql`
3. Rode os comandos de teste que aparecem comentados abaixo de cada procedure/view.

---

## 🔎 Parte 1 — 10 consultas SQL

| # | Desafio | Conceito | Resultado esperado (carga inicial) |
|---|---------|----------|-------------------------------------|
| 1 | Nome e e-mail dos clientes | `SELECT` | 5 linhas |
| 2 | Produtos abaixo de R$ 500 | `WHERE` | 5 produtos (Teclado, Mouse, Headset, SSD, HD Externo) |
| 3 | Pedidos pendentes | `WHERE` | 1 pedido (id 3) |
| 4 | Catálogo do mais caro ao mais barato | `ORDER BY ... DESC` | iPhone 15 no topo |
| 5 | Produtos com "Monitor" no nome | `LIKE '%Monitor%'` | ids 8 e 9 |
| 6 | Periféricos com estoque > 40 | `WHERE ... AND` | Teclado (60) e Mouse (45) |
| 7 | Total de clientes | `COUNT(*)` | `total_clientes = 5` |
| 8 | Faturamento bruto | `SUM()` | `faturamento_bruto = 15897.40` |
| 9 | Produto + categoria | `INNER JOIN` | 11 linhas |
| 10 | Pedidos da Ana Silva | `INNER JOIN` + filtro | pedidos 1 e 4 |

📄 Código completo: [`01_consultas.sql`](01_consultas.sql)

---

## ⚙️ Parte 2 — 5 Stored Procedures

| # | Procedure | Parâmetros | O que faz |
|---|-----------|-----------|-----------|
| 1 | `listar_categorias_ativas()` | — | Lista categorias ativas em ordem alfabética |
| 2 | `buscar_pedidos_por_status(p_status)` | `IN` | Filtra pedidos pelo status informado |
| 3 | `inserir_categoria(p_nome, p_descricao)` | `IN`, `IN` | Insere uma nova categoria |
| 4 | `atualizar_telefone_cliente(p_id_cliente, p_telefone)` | `IN`, `IN` | Atualiza o telefone de um cliente |
| 5 | `contar_produtos_categoria(p_id_categoria, p_total)` | `IN`, `OUT` | Devolve a quantidade de produtos da categoria |

**Boas práticas aplicadas:** `DROP PROCEDURE IF EXISTS`, `DELIMITER //`, prefixo `p_` nos
parâmetros, nomes no padrão *verbo + substantivo* e comentários com exemplos de teste.

Exemplo de uso do parâmetro `OUT`:

```sql
CALL contar_produtos_categoria(3, @total);
SELECT @total AS total_produtos;   -- 3 (Periféricos)
```

📄 Código completo: [`02_stored_procedures.sql`](02_stored_procedures.sql)

---

## 👁️ Parte 3 — Views vs. Stored Procedures

### Diferença em uma frase
Uma **View** é uma consulta salva que se comporta como uma *tabela virtual* (somente leitura
na prática). Uma **Stored Procedure** é um *programa* salvo, que recebe parâmetros, tem lógica
de controle e pode gravar dados.

| Critério | View | Stored Procedure |
|----------|------|------------------|
| Chamada | `SELECT * FROM vw_x` | `CALL proc(...)` |
| Usada dentro de outro `SELECT` / `JOIN` | ✅ Sim | ❌ Não |
| Aceita parâmetros | ❌ Não | ✅ Sim (`IN/OUT/INOUT`) |
| Lógica (`IF`, `WHILE`, transações) | ❌ Não | ✅ Sim |
| Ideal para | Leitura, relatórios fixos, segurança por coluna | Regras de negócio, escrita, múltiplos passos |

### 5 situações em que a View é a melhor escolha

| # | View | Situação | Por que View e não Procedure? |
|---|------|----------|-------------------------------|
| 1 | `vw_catalogo_produtos` | Vitrine do site | Consulta fixa e sem parâmetros; o front-end filtra com `WHERE` livremente |
| 2 | `vw_estoque_critico` | Painel de alerta da logística | "Foto" sempre atualizada; regra do estoque mínimo centralizada |
| 3 | `vw_clientes_atendimento` | Suporte ao cliente | **Segurança por coluna**: oculta CPF e data de nascimento |
| 4 | `vw_pedidos_detalhados` | Consulta de pedidos pelo suporte | Esconde um JOIN de 4 tabelas e permite filtrar por qualquer coluna |
| 5 | `vw_vendas_por_categoria` | Dashboards de BI | Ferramentas de BI consomem views como tabelas e têm dificuldade com `CALL` |

📄 Código completo: [`03_views.sql`](03_views.sql)

### Quando continuar usando Stored Procedure?
Sempre que houver **escrita**, **transação**, **validações**, **parâmetros** ou **vários passos**,
como em `registrar_pedido` e `cancelar_pedido` vistos em aula.

---

## 📝 Decisões e premissas

- O enunciado do exercício 5 da Parte 2 estava cortado em *"...quantidade total de produtos"*.
  Considerei **todos os produtos da categoria**. Para contar apenas os ativos, basta
  acrescentar `AND ativo = TRUE` no `WHERE` (indicado em comentário no código).
- Nas views usei `CREATE OR REPLACE VIEW`, equivalente em espírito ao `DROP ... IF EXISTS` das procedures.
- Pedidos `cancelado` são desconsiderados na view de vendas por categoria.
