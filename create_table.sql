--Adicionando a coluna is_active (TINYINT ou BOOLEAN) às tabelas Client, Product e Marketplace_Seller para ativação/desativação lógica.


ALTER TABLE Client ADD is_active TINYINT(1) DEFAULT 1;
ALTER TABLE Product ADD is_active TINYINT(1) DEFAULT 1;
ALTER TABLE Marketplace_Seller ADD is_active TINYINT(1) DEFAULT 1;


--Usar CHECK constraints para garantir que:
price > 0 na tabela Product.
quantity >= 0 em tabelas relacionadas a estoques e pedidos.

ALTER TABLE Product ADD CONSTRAINT chk_price CHECK (price > 0);
ALTER TABLE Product_has_Stock ADD CONSTRAINT chk_quantity CHECK (quantity >= 0);


-- Table: Client
CREATE TABLE Client (
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    f_name VARCHAR(45) NOT NULL,
    l_name VARCHAR(45) NOT NULL,
    birth_date DATE,
    nickname VARCHAR(45),
    city VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table: Account
CREATE TABLE Account (
    idAccount INT AUTO_INCREMENT PRIMARY KEY,
    account_type CHAR(4) NOT NULL COMMENT 'CPF or CNPJ',
    address VARCHAR(200),
    phone_number VARCHAR(15),
    f_name VARCHAR(45),
    l_name VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    idClient INT UNIQUE,
    FOREIGN KEY (idClient) REFERENCES Client(idClient) ON DELETE CASCADE
);

-- Table: Card
CREATE TABLE Card (
    idCard INT AUTO_INCREMENT PRIMARY KEY,
    cardholder_name VARCHAR(100) NOT NULL,
    expiry_date VARCHAR(7) NOT NULL COMMENT 'Format: MM/YYYY',
    card_type VARCHAR(45) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    idClient INT NOT NULL,
    FOREIGN KEY (idClient) REFERENCES Client(idClient) ON DELETE CASCADE
);

-- Table: Product
CREATE TABLE Product (
    idProduct INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    sku VARCHAR(45) UNIQUE,
    description VARCHAR(200),
    category VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table: Stock
CREATE TABLE Stock (
    idStock INT AUTO_INCREMENT PRIMARY KEY,
    warehouse_location VARCHAR(200),
    last_restock_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table: Product_has_Stock
CREATE TABLE Product_has_Stock (
    Product_idProduct INT NOT NULL,
    Stock_idStock INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (Product_idProduct, Stock_idStock),
    FOREIGN KEY (Product_idProduct) REFERENCES Product(idProduct) ON DELETE CASCADE,
    FOREIGN KEY (Stock_idStock) REFERENCES Stock(idStock) ON DELETE CASCADE
);

-- Table: Supplier
CREATE TABLE Supplier (
    idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone_number VARCHAR(15),
    address VARCHAR(200),
    city VARCHAR(100),
    state VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table: Providing_a_Product
CREATE TABLE Providing_a_Product (
    Product_idProduct INT NOT NULL,
    Supplier_idSupplier INT NOT NULL,
    PRIMARY KEY (Product_idProduct, Supplier_idSupplier),
    FOREIGN KEY (Product_idProduct) REFERENCES Product(idProduct) ON DELETE CASCADE,
    FOREIGN KEY (Supplier_idSupplier) REFERENCES Supplier(idSupplier) ON DELETE CASCADE
);

-- Table: Marketplace_Seller (renamed from Other Seller)
CREATE TABLE Marketplace_Seller (
    idMarketplaceSeller INT AUTO_INCREMENT PRIMARY KEY,
    phone_number VARCHAR(15),
    city VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table: Order
CREATE TABLE `Order` (
    idOrder INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(45),
    total_amount DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    idClient INT NOT NULL,
    FOREIGN KEY (idClient) REFERENCES Client(idClient) ON DELETE CASCADE
);

-- Table: Delivery
CREATE TABLE Delivery (
    idDelivery INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(45) NOT NULL,
    address_delivery VARCHAR(200) NOT NULL,
    tracking VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    idOrder INT NOT NULL,
    FOREIGN KEY (idOrder) REFERENCES `Order`(idOrder) ON DELETE CASCADE
);

-- Table: Tracking_Order
CREATE TABLE Tracking_Order (
    delivery_idDelivery INT NOT NULL,
    idOrder INT NOT NULL,
    PRIMARY KEY (delivery_idDelivery, idOrder),
    FOREIGN KEY (delivery_idDelivery) REFERENCES Delivery(idDelivery) ON DELETE CASCADE,
    FOREIGN KEY (idOrder) REFERENCES `Order`(idOrder) ON DELETE CASCADE
);

-- Table: Relation_product_order
CREATE TABLE Relation_product_order (
    Order_idOrder INT NOT NULL,
    Product_idProduct INT NOT NULL,
    PRIMARY KEY (Order_idOrder, Product_idProduct),
    FOREIGN KEY (Order_idOrder) REFERENCES `Order`(idOrder) ON DELETE CASCADE,
    FOREIGN KEY (Product_idProduct) REFERENCES Product(idProduct) ON DELETE CASCADE
);
