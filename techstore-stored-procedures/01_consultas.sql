-- ============================================================
-- PARTE 1: 10 DESAFIOS DE CONSULTAS SQL (nível muito fácil)
-- Banco: loja_tech (TechStore)
-- ============================================================
USE loja_tech;

-- 1. Listagem básica de clientes (nome e e-mail)
SELECT nome, email
FROM clientes;

-- 2. Produtos que custam menos de R$ 500,00
SELECT nome, preco
FROM produtos
WHERE preco < 500.00;

-- 3. Pedidos pendentes (todas as colunas)
SELECT *
FROM pedidos
WHERE status = 'pendente';

-- 4. Catálogo ordenado do mais caro para o mais barato
SELECT nome, preco
FROM produtos
ORDER BY preco DESC;

-- 5. Busca textual parcial: produtos com "Monitor" no nome
SELECT id_produto, nome, preco
FROM produtos
WHERE nome LIKE '%Monitor%';

-- 6. Periféricos (categoria 3) com mais de 40 unidades em estoque
SELECT nome, estoque
FROM produtos
WHERE id_categoria = 3
  AND estoque > 40;

-- 7. Total de clientes cadastrados
SELECT COUNT(*) AS total_clientes
FROM clientes;

-- 8. Faturamento bruto (soma de todos os pedidos)
SELECT SUM(valor_total) AS faturamento_bruto
FROM pedidos;

-- 9. INNER JOIN: produto + nome da categoria
SELECT p.nome AS produto,
       c.nome AS categoria
FROM produtos p
INNER JOIN categorias c ON c.id_categoria = p.id_categoria;

-- 10. INNER JOIN com filtro: pedidos da cliente Ana Silva
SELECT pe.id_pedido,
       pe.status,
       pe.valor_total
FROM pedidos pe
INNER JOIN clientes c ON c.id_cliente = pe.id_cliente
WHERE c.nome = 'Ana Silva';