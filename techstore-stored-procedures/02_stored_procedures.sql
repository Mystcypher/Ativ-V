-- ============================================================
-- PARTE 2: 5 STORED PROCEDURES (nível muito fácil)
-- Boas práticas aplicadas: DROP IF EXISTS, DELIMITER //,
-- prefixo p_ nos parâmetros e nomes descritivos (verbo + substantivo)
-- ============================================================
USE loja_tech;

-- ------------------------------------------------------------
-- 1. listar_categorias_ativas (sem parâmetros)
-- ------------------------------------------------------------
DROP PROCEDURE IF EXISTS listar_categorias_ativas;
DELIMITER //
CREATE PROCEDURE listar_categorias_ativas()
BEGIN
    SELECT id_categoria,
           nome,
           descricao
    FROM categorias
    WHERE ativo = TRUE
    ORDER BY nome;
END //
DELIMITER ;

-- Teste:
-- CALL listar_categorias_ativas();


-- ------------------------------------------------------------
-- 2. buscar_pedidos_por_status (parâmetro IN)
-- ------------------------------------------------------------
DROP PROCEDURE IF EXISTS buscar_pedidos_por_status;
DELIMITER //
CREATE PROCEDURE buscar_pedidos_por_status(
    IN p_status VARCHAR(20)
)
BEGIN
    SELECT id_pedido,
           id_cliente,
           data_pedido,
           valor_total
    FROM pedidos
    WHERE status = p_status;
END //
DELIMITER ;

-- Testes:
-- CALL buscar_pedidos_por_status('pendente');
-- CALL buscar_pedidos_por_status('entregue');


-- ------------------------------------------------------------
-- 3. inserir_categoria (parâmetros IN - inserção)
-- ------------------------------------------------------------
DROP PROCEDURE IF EXISTS inserir_categoria;
DELIMITER //
CREATE PROCEDURE inserir_categoria(
    IN p_nome      VARCHAR(100),
    IN p_descricao TEXT
)
BEGIN
    INSERT INTO categorias (nome, descricao)
    VALUES (p_nome, p_descricao);
END //
DELIMITER ;

-- Teste:
-- CALL inserir_categoria('Acessórios', 'Cabos, capas e adaptadores');
-- SELECT * FROM categorias;


-- ------------------------------------------------------------
-- 4. atualizar_telefone_cliente (parâmetros IN - atualização)
-- ------------------------------------------------------------
DROP PROCEDURE IF EXISTS atualizar_telefone_cliente;
DELIMITER //
CREATE PROCEDURE atualizar_telefone_cliente(
    IN p_id_cliente INT,
    IN p_telefone   VARCHAR(15)
)
BEGIN
    UPDATE clientes
    SET telefone = p_telefone
    WHERE id_cliente = p_id_cliente;
END //
DELIMITER ;

-- Teste:
-- CALL atualizar_telefone_cliente(1, '11999998888');
-- SELECT id_cliente, nome, telefone FROM clientes WHERE id_cliente = 1;


-- ------------------------------------------------------------
-- 5. contar_produtos_categoria (parâmetros IN e OUT)
-- Conta todos os produtos da categoria informada.
-- (Para contar só os ativos, acrescente: AND ativo = TRUE)
-- ------------------------------------------------------------
DROP PROCEDURE IF EXISTS contar_produtos_categoria;
DELIMITER //
CREATE PROCEDURE contar_produtos_categoria(
    IN  p_id_categoria INT,
    OUT p_total        INT
)
BEGIN
    SELECT COUNT(*)
    INTO p_total
    FROM produtos
    WHERE id_categoria = p_id_categoria;
END //
DELIMITER ;

-- Teste (Periféricos = categoria 3 -> esperado: 3):
-- CALL contar_produtos_categoria(3, @total);
-- SELECT @total AS total_produtos;