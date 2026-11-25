-- ============================================================
-- PESQUISA: 5 SITUAÇÕES EM QUE USAR VIEW É MELHOR QUE STORED PROCEDURE
-- Regra prática: se o objetivo é apenas LER dados (sem parâmetros,
-- sem lógica de controle, sem gravação), uma VIEW é mais simples,
-- pode ser usada dentro de outros SELECTs (JOIN, WHERE, ORDER BY)
-- e é consumida como se fosse uma tabela.
-- Uma procedure não pode ser usada no FROM de um SELECT.
-- ============================================================
USE loja_tech;

-- ------------------------------------------------------------
-- CENÁRIO 1: Catálogo de produtos para a vitrine do site
-- Por que view? Consulta fixa, sem parâmetros. O front-end (ou
-- qualquer BI) faz SELECT ... WHERE categoria = '...' livremente,
-- coisa que uma procedure não permite.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_catalogo_produtos AS
SELECT p.id_produto,
       p.nome       AS produto,
       c.nome       AS categoria,
       p.preco,
       p.estoque
FROM produtos p
INNER JOIN categorias c ON c.id_categoria = p.id_categoria
WHERE p.ativo = TRUE
  AND c.ativo = TRUE;

-- Uso: SELECT * FROM vw_catalogo_produtos WHERE categoria = 'Monitores' ORDER BY preco;


-- ------------------------------------------------------------
-- CENÁRIO 2: Alerta de estoque crítico para a logística
-- Por que view? É um "painel" que sempre reflete o estado atual.
-- Basta consultar; a regra (estoque <= mínimo) fica num só lugar.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_estoque_critico AS
SELECT p.id_produto,
       p.nome AS produto,
       p.estoque,
       p.estoque_minimo,
       (p.estoque_minimo - p.estoque) AS falta_para_minimo
FROM produtos p
WHERE p.ativo = TRUE
  AND p.estoque <= p.estoque_minimo;

-- Uso: SELECT * FROM vw_estoque_critico;


-- ------------------------------------------------------------
-- CENÁRIO 3: Dados de clientes para o atendimento SEM expor dados sensíveis
-- Por que view? Segurança por coluna: o atendente recebe SELECT na
-- view, mas não na tabela clientes (CPF e data de nascimento ficam ocultos).
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_clientes_atendimento AS
SELECT id_cliente,
       nome,
       email,
       telefone
FROM clientes
WHERE ativo = TRUE;

-- Uso: GRANT SELECT ON loja_tech.vw_clientes_atendimento TO 'atendente'@'localhost';


-- ------------------------------------------------------------
-- CENÁRIO 4: Pedidos detalhados (cliente + itens + produto)
-- Por que view? Esconde um JOIN de 4 tabelas. Equipes de suporte e
-- relatórios reutilizam sem reescrever o JOIN e podem filtrar por
-- qualquer coluna (status, cliente, data).
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_pedidos_detalhados AS
SELECT pe.id_pedido,
       pe.data_pedido,
       pe.status,
       c.nome       AS cliente,
       pr.nome      AS produto,
       ip.quantidade,
       ip.preco_unitario,
       ip.subtotal
FROM pedidos pe
INNER JOIN clientes     c  ON c.id_cliente  = pe.id_cliente
INNER JOIN itens_pedido ip ON ip.id_pedido  = pe.id_pedido
INNER JOIN produtos     pr ON pr.id_produto = ip.id_produto;

-- Uso: SELECT * FROM vw_pedidos_detalhados WHERE cliente = 'Ana Silva';


-- ------------------------------------------------------------
-- CENÁRIO 5: Vendas por categoria para dashboards de BI (Power BI, Metabase...)
-- Por que view? Ferramentas de BI enxergam views como tabelas e
-- não sabem chamar procedures facilmente. Um agregado pronto
-- simplifica gráficos e mantém um único cálculo de "venda válida".
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_vendas_por_categoria AS
SELECT c.nome                AS categoria,
       SUM(ip.quantidade)    AS unidades_vendidas,
       SUM(ip.subtotal)      AS receita
FROM itens_pedido ip
INNER JOIN pedidos    pe ON pe.id_pedido    = ip.id_pedido
INNER JOIN produtos   pr ON pr.id_produto   = ip.id_produto
INNER JOIN categorias c  ON c.id_categoria  = pr.id_categoria
WHERE pe.status <> 'cancelado'
GROUP BY c.id_categoria, c.nome;

-- Uso: SELECT * FROM vw_vendas_por_categoria ORDER BY receita DESC;