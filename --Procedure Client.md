--Procedure Client
DELIMITER $$

CREATE PROCEDURE InsertFictitiousClients()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 1000 DO
        INSERT INTO Client (f_name, l_name, birth_date, nickname, city, is_active)
        VALUES (
            CONCAT('FirstName', i),                            -- Nome fictício
            CONCAT('LastName', i),                             -- Sobrenome fictício
            DATE_ADD('1980-01-01', INTERVAL RAND()*15000 DAY), -- Data de nascimento aleatória
            CONCAT('Nickname', i),                             -- Apelido fictício
            CONCAT('City', FLOOR(RAND()*100)),                 -- Cidade fictícia
            IF(RAND() > 0.9, 0, 1)                             -- Aleatoriamente ativo/inativo
        );
        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;

CALL InsertFictitiousClients(); -->chamando a procedure


--Procedure Product
DELIMITER $$

CREATE PROCEDURE InsertFictitiousProducts()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 1000 DO
        INSERT INTO Product (name, price, sku, description, category, is_active)
        VALUES (
            CONCAT('Product', i),                 -- Nome fictício do produto
            ROUND(1 + RAND()*1000, 2),            -- Preço aleatório entre 1 e 1000
            CONCAT('SKU', FLOOR(RAND()*100000)),  -- SKU fictício
            CONCAT('Description of Product ', i), -- Descrição fictícia
            CONCAT('Category', FLOOR(RAND()*10)),-- Categoria fictícia
            IF(RAND() > 0.8, 0, 1)                -- Aleatoriamente ativo/inativo
        );
        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;

CALL InsertFictitiousProducts();

--Procedure Order
DELIMITER $$

CREATE PROCEDURE InsertFictitiousOrders()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 1000 DO
        INSERT INTO `Order` (quantity, order_date, status, total_amount, idClient)
        VALUES (
            FLOOR(1 + RAND()*10),                     -- Quantidade aleatória entre 1 e 10
            DATE_ADD('2022-01-01', INTERVAL RAND()*700 DAY), -- Data de pedido aleatória
            IF(RAND() > 0.8, 'CANCELLED', 'COMPLETED'), -- Status fictício
            ROUND(50 + RAND()*500, 2),                -- Valor total aleatório
            FLOOR(1 + RAND()*1000)                    -- Cliente aleatório
        );
        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;


CALL InsertFictitiousOrders();