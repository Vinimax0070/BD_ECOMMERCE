1. Quantos clientes únicos existem na base de dados?
SELECT COUNT(DISTINCT idClient) AS total_clients FROM Client;

2.Qual é o TOP 5 produtos mais vendido e qual o TOP 5 menos vendido?
--top5 mais vendido 
SELECT 
    P.idProduct,
    P.name,
    P.price,
    P.sku,
    COUNT(RPO.Product_idProduct) AS quantity_sells
FROM 
    Product AS P
INNER JOIN 
    Relation_product_order AS RPO 
ON 
    P.idProduct = RPO.Product_idProduct
GROUP BY 
    P.idProduct, P.name, P.price, P.sku
ORDER BY 
    quantity_sells DESC
LIMIT 5;
--top5 menos vendido
SELECT 
    P.idProduct,
    P.name,
    P.price,
    P.sku,
    COUNT(RPO.Product_idProduct) AS quantity_sells
FROM 
    Product AS P
INNER JOIN 
    Relation_product_order AS RPO 
ON 
    P.idProduct = RPO.Product_idProduct
GROUP BY 
    P.idProduct, P.name, P.price, P.sku
ORDER BY 
    quantity_sells ASC
LIMIT 5;


3.Qual é o valor total de vendas agrupados por mes,ano e total até o momento?
SELECT 
    EXTRACT(MONTH FROM OE.ORDER_DATE) AS MONTH,
    EXTRACT(YEAR FROM OE.ORDER_DATE) AS YEAR,
    OE.STATUS,
    P.SKU,
    OE.QUANTITY,
    P.price,
    
    (OE.QUANTITY * P.price) AS total_financial  -- Total financeiro para cada produto no pedido
FROM 
    ORDER_ECOMMERCE OE
INNER JOIN 
    Relation_product_order RPO ON RPO.Order_idOrder = OE.idOrder  -- Relacionando pedidos e produtos
INNER JOIN 
    Product P ON RPO.Product_idProduct = P.idProduct  -- Relacionando produtos
GROUP BY
    EXTRACT(MONTH FROM OE.ORDER_DATE),  -- Agrupando por mês
    EXTRACT(YEAR FROM OE.ORDER_DATE),   -- Agrupando por ano
    OE.STATUS, 
    OE.QUANTITY,
    P.price
ORDER BY
    YEAR, MONTH, OE.STATUS, OE.QUANTITY
LIMIT 0, 1000;


4.Quantidade de pedidos por cliente, quero saber o mes e ano também desses pedidos?
SELECT 
    C.f_name AS CLIENT_NAME,  -- Nome do cliente
    OE.STATUS,
    EXTRACT(MONTH FROM OE.ORDER_DATE) AS MONTH,  -- Mês do pedido
    EXTRACT(YEAR FROM OE.ORDER_DATE) AS YEAR,  -- Ano do pedido
    COUNT(OE.idOrder) AS total_pedidos  -- Quantidade de pedidos por cliente, mês e ano
FROM 
    ORDER_ECOMMERCE AS OE
INNER JOIN 
    Client AS C ON OE.idClient = C.idClient  -- Junção entre pedidos e clientes
WHERE 
	STATUS = 'Completed'
GROUP BY 
    C.f_name,  -- Agrupando por nome do cliente
    EXTRACT(MONTH FROM OE.ORDER_DATE),  -- Agrupando por mês
    EXTRACT(YEAR FROM OE.ORDER_DATE)   -- Agrupando por ano
ORDER BY 
    YEAR DESC, MONTH DESC, total_pedidos DESC;  -- Ordenando por ano, mês e quantidade de pedidos


5.Quantos pedidos foram realizados em cada mês?
SELECT 
	EXTRACT(MONTH FROM ORDER_DATE) AS MONTH,
	COUNT(oe.idOrder) AS TOTAL_ORDER
FROM 
	ORDER_ECOMMERCE as oe
GROUP BY
	MONTH  
ORDER BY 
	TOTAL_ORDER

	
6.Qual é a média de quantidade de produtos por pedido?

SELECT 
    ROUND(AVG(OE.QUANTITY), 2) AS QUANTITY_MEDIA  -- Média geral da quantidade de produtos por pedido
FROM 
    ORDER_ECOMMERCE OE;


7. Quais produtos estão com o estoque abaixo de um limite crítico (ex: menos de 10 unidades)?
--Analisar a situação do estoque por completo
SELECT
	Product_idProduct AS ID_PRODUCT,
	QUANTITY,
	CASE 
		WHEN CAST(QUANTITY AS DECIMAL(10, 2)) <= 10 THEN 'Critical stock'
		WHEN CAST(QUANTITY AS DECIMAL(10, 2)) BETWEEN 11 AND 40 THEN 'Observation'
		ELSE 'Normal'
	END AS STOCK_SITUATION
FROM 
	PRODUCT_HAS_STOCK
GROUP BY
	QUANTITY
ORDER BY 
	QUANTITY ASC;

---Filtrando apenas os produtos que estao 
SELECT
	Product_idProduct AS ID_PRODUCT,
	QUANTITY,
	CASE 
		WHEN CAST(QUANTITY AS DECIMAL(10, 2)) <= 10 THEN 'Critical stock'
		WHEN CAST(QUANTITY AS DECIMAL(10, 2)) BETWEEN 11 AND 40 THEN 'Observation'
		ELSE 'Normal'
	END AS STOCK_SITUATION
FROM 
	PRODUCT_HAS_STOCK
WHERE
	QUANTITY <=10
GROUP BY
	QUANTITY
ORDER BY 
	QUANTITY ASC;


8.Qual é a receita gerada por cada categoria de produto?
--Aqui demonstro a receita com base em categoria e cada produto individualmente
SELECT 
    P.CATEGORY,
    P.PRICE,
    OE.QUANTITY,
    (OE.QUANTITY * P.PRICE) AS VALUE_TOTAL
FROM 
    PRODUCT P 
INNER JOIN 
    RELATION_PRODUCT_ORDER RPO ON RPO.PRODUCT_IDPRODUCT = P.IDPRODUCT
INNER JOIN 
    order_ecommerce OE ON RPO.ORDER_IDORDER = OE.IDORDER
ORDER BY 
    CATEGORY;

 --aqui eu ja agrupo e pego o montante financeiro total por categoria sem especificar o preço de cada produto
 SELECT 
    P.CATEGORY,
    COUNT(DISTINCT P.IDPRODUCT) AS NUM_PRODUCTS,
    SUM(OE.QUANTITY * P.PRICE) AS CATEGORY_TOTAL
FROM 
    PRODUCT P 
INNER JOIN 
    RELATION_PRODUCT_ORDER RPO ON RPO.PRODUCT_IDPRODUCT = P.IDPRODUCT
INNER JOIN 
    order_ecommerce OE ON RPO.ORDER_IDORDER = OE.IDORDER
GROUP BY 
    P.CATEGORY
ORDER BY 
    CATEGORY;



9. Qual foi o pedido de maior valor já realizado?
SELECT
	OE.idOrder,
	OE.QUANTITY,
	OE.ORDER_DATE,
	MAX(OE.TOTAL_AMOUNT) AS MAX_ORDER_VALUE,
	C.idClient
FROM 
	ORDER_ECOMMERCE AS OE
INNER JOIN 
	CLIENT C ON OE.idClient = C.idClient
ORDER BY
	OE.TOTAL_AMOUNT DESC


	
10.Qual fornecedor fornece o maior número de produtos?
SELECT 
    s.name AS supplier_name,
    COUNT(p.Product_idProduct) AS product_count
FROM 
    Supplier s
JOIN 
    Providing_a_Product p ON s.idSupplier = p.Supplier_idSupplier
GROUP BY 
    s.idSupplier
ORDER BY 
    product_count DESC
LIMIT 1;



11.Quantos clientes ainda estão ativos (coluna is_active)?
SELECT 
	COUNT(*) AS ACT_DES_CLIENT,
    CASE 
		WHEN IS_ACTIVE = '0' THEN 'Disable'
        WHEN IS_ACTIVE = '1' THEN 'Active'
	END AS STATUS_CLIENT
FROM 
	CLIENT
GROUP BY 
	IS_ACTIVE;



12.Qual cidade tem a maior concentração de clientes?
SELECT 
	COUNT(*) AS TOTAL_CLIENT,
    CITY
FROM 
	CLIENT
group by 
	CITY
ORDER BY
	TOTAL_CLIENT DESC;



13.Quais são os status mais comuns dos pedidos (ex: "Entregue", "Pendente")?
-- CASO ISSO FOSSE PARA UM APRENDIZADO DE MAQUINA TERIAMOS QUE SUBSTITUIR 
--'IN TRANSIT' E 'DELIVERED' POR 1,2
SELECT 
	COUNT(*) AS TOTAL_DELIVERY,
	CASE 
		WHEN STATUS = 'In Transit' THEN 1
		WHEN STATUS = 'Delivered' THEN 2
	END STATUS;
FROM 
	DELIVERY
GROUP BY
	STATUS;

-------------OU-------------------------

SELECT 
	COUNT(*) AS TOTAL_DELIVERY,
	STATUS 
FROM 
	DELIVERY 
GROUP BY 
	STATUS
ORDER BY 
	TOTAL_DELIVERY;


14.Qual é a média de tempo entre o pedido e a entrega?
SELECT 
    AVG(TIMESTAMPDIFF(DAY, OE.order_date, D.created_at)) AS avg_delivery_time_days
FROM 
    order_ecommerce OE
INNER JOIN 
    Delivery D ON OE.idOrder = D.idOrder;



15.Qual é o volume total de vendas por cliente?
SELECT 
    C.f_name,
    C.l_name,
    SUM(OE.total_amount) AS total_spent
FROM 
    Client C
INNER JOIN 
    order_ecommerce OE ON C.idClient = OE.idClient
GROUP BY 
    C.idClient
ORDER BY 
    total_spent DESC;


