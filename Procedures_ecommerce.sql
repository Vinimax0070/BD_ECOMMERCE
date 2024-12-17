--Procedure para inserir cerca de 500 clientes

DELIMITER $$

CREATE PROCEDURE InsertClients(IN num_clients INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    WHILE i < num_clients DO
        INSERT INTO Client (f_name, l_name, birth_date, nickname, city)
        VALUES (
            CONCAT('Name_', FLOOR(RAND() * 1000)),
            CONCAT('Surname_', FLOOR(RAND() * 1000)),
            DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 10000) DAY),
            CONCAT('User_', FLOOR(RAND() * 1000)),
            CONCAT('City_', FLOOR(RAND() * 100))
        );
        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;


CALL InsertClients(500)


--Procedure para inserir Produtos
DELIMITER $$

CREATE PROCEDURE InsertProducts(IN num_products INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    WHILE i < num_products DO
        INSERT INTO Product (name, price, sku, description, category)
        VALUES (
            CONCAT('Product_', i),
            ROUND(RAND() * 1000 + 1, 2),
            CONCAT('SKU_', FLOOR(RAND() * 1000000)), -- Maior intervalo
            CONCAT('Description for product_', i),
            CONCAT('Category_', FLOOR(RAND() * 10))
        );
        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;

CALL InsertProducts(500);

--Procedure para Stock
DELIMITER $$

CREATE PROCEDURE InsertStock(IN num_stocks INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    WHILE i < num_stocks DO
        INSERT INTO Stock (warehouse_location, last_restock_date)
        VALUES (
            CONCAT('Warehouse_', i), -- Nome único para warehouse_location
            NOW() - INTERVAL FLOOR(RAND() * 365) DAY -- Data aleatória nos últimos 365 dias
        );
        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;

CALL InsertStock(500);

--Procedure para Orders
DELIMITER $$

CREATE PROCEDURE InsertOrders(IN num_orders INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE max_client_id INT;

    -- Obtém o maior idClient disponível para associar os pedidos
    SELECT MAX(idClient) INTO max_client_id FROM Client;

    WHILE i < num_orders DO
        INSERT INTO `Order` (quantity, order_date, status, total_amount, idClient)
        VALUES (
            FLOOR(RAND() * 10) + 1, -- quantity: de 1 a 10
            CURDATE() - INTERVAL FLOOR(RAND() * 30) DAY, -- Datas nos últimos 30 dias
            IF(RAND() > 0.5, 'Completed', 'Pending'), -- status: 'Completed' ou 'Pending'
            ROUND(RAND() * 1000 + 50, 2), -- total_amount: entre 50 e 1050
            FLOOR(RAND() * max_client_id) + 1 -- idClient aleatório válido
        );
        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;


CALL InsertOrders(500);


--Procedure para market_place
DELIMITER $$

CREATE PROCEDURE InsertMarketplaceSellers(IN num_sellers INT)
BEGIN
    DECLARE i INT DEFAULT 0;

    WHILE i < num_sellers DO
        INSERT INTO Marketplace_Seller (phone_number, city)
        VALUES (
            CONCAT('555-', FLOOR(RAND() * 1000), '-', FLOOR(RAND() * 10000)), -- Número aleatório
            CONCAT('City_', FLOOR(RAND() * 100)) -- Nome aleatório de cidade
        );
        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;

CALL InsertMarketplaceSellers(500);

--Inserindo dados na tabela Relation_product_order
-- Gerar 1000 registros aleatórios de Order_idOrder e Product_idProduct
INSERT INTO Relation_product_order (Order_idOrder, Product_idProduct)
SELECT 
    o.idOrder, 
    p.idProduct
FROM 
    (SELECT idOrder FROM order_ecommerce ORDER BY RAND() LIMIT 1000) o
JOIN 
    (SELECT idProduct FROM Product ORDER BY RAND() LIMIT 1000) p
ORDER BY RAND()
LIMIT 1000;

--Inserindo dados na tabela delivery
DELIMITER $$

CREATE PROCEDURE insert_deliveries()
BEGIN
    DECLARE counter INT DEFAULT 1;

    WHILE counter <= 500 DO
        INSERT INTO Delivery (status, address_delivery, tracking, idOrder)
        VALUES 
        (
            CASE 
                WHEN counter % 2 = 0 THEN 'In Transit'
                ELSE 'Delivered'
            END,
            CONCAT('Street ', counter, ', neighborhood
 ABC, City XYZ'),
            CONCAT('TRK', LPAD(counter, 6, '0')), -- Tracking code: TRK000001, TRK000002, etc.
            FLOOR(1 + (RAND() * 500))  -- Random idOrder between 1 and 100
        );

        SET counter = counter + 1;
    END WHILE;
END$$

DELIMITER ;

CALL insert_deliveries();
