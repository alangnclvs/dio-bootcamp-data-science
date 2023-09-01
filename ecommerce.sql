-- criação do banco de dados para o cenário de e-commerce
-- drop database ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

-- criar tabela cliente
CREATE TABLE clients(
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(10) NOT NULL,
    Minit CHAR(3),
    Lname VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    Address VARCHAR(255),
    CONSTRAINT unique_cpf_client UNIQUE (CPF)
);

ALTER TABLE clients AUTO_INCREMENT=1;

-- size = dimensão do produto
-- criar tabela produto
CREATE TABLE product(
	idProduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(255) NOT NULL,
    classification_kids BOOL DEFAULT FALSE,
    category ENUM('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
	avaliação FLOAT DEFAULT 0,
	size VARCHAR(10)
);

ALTER TABLE product AUTO_INCREMENT=1;

CREATE TABLE payments(
	idclient INT,
    idPayment INT,
    typePayment ENUM('Boleto','Cartão','Dois cartões'),
    limitAvailable FLOAT,
    PRIMARY KEY(idClient, idPayment)
);  

-- criar tabela pedido
CREATE TABLE orders(
    idOrder INT AUTO_INCREMENT PRIMARY KEY,
    idOrderCLient INT,
    orderStatus ENUM('Cancelado', 'Confirmado', 'Em processamento') NOT NULL,
	orderDescription VARCHAR(255),
    sendValue FLOAT DEFAULT 10,
    paymentCash BOOLEAN DEFAULT FALSE,
    deliveryStatus ENUM('Em andamento', 'Entregue', 'Cancelada'),
    trackerCode VARCHAR(255),
    CONSTRAINT fk_order_client FOREIGN KEY (idOrderClient) REFERENCES clients(idCLient)    
			on update cascade
);			

ALTER TABLE orders AUTO_INCREMENT=1;

DESC orders;

-- criar tabela estoque
CREATE TABLE productStorage(
	idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
    storageLocation VARCHAR(255),
    quantity INT DEFAULT 0
);

ALTER TABLE productStorage AUTO_INCREMENT=1;

-- criar tabela fornecedor
CREATE TABLE supplier(
	idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    socialName VARCHAR (255) NOT NULL,
    CNPJ CHAR(15) NOT NULL,
    contact char(11) not null,
    CONSTRAINT unique_supplier UNIQUE (CNPJ)
);

ALTER TABLE supplier AUTO_INCREMENT=1;

DESC supplier;

-- criar tabela vendedor
CREATE TABLE seller(
	idSeller INT AUTO_INCREMENT PRIMARY KEY,
    socialName VARCHAR(255) NOT NULL,
    abstName VARCHAR(255),
    CNPJ CHAR(15),
    CPF CHAR(11),
    location VARCHAR(255),
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_cnpj_seller UNIQUE (CNPJ),
    CONSTRAINT unique_cpf_seller UNIQUE (CPF)
);

ALTER TABLE seller AUTO_INCREMENT=1;

-- tabelas de relacionamentos M:N

CREATE TABLE productSeller(
	idPSeller INT,
    idPproduct INT,
    prodQuantity INT DEFAULT 1,
    PRIMARY KEY (idPseller, idPproduct),
    CONSTRAINT fk_product_seller FOREIGN KEY (idPseller) REFERENCES seller(idSeller),
    CONSTRAINT fk_product_product FOREIGN KEY (idPproduct) REFERENCES product(idProduct)
);

DESC productSeller;

CREATE TABLE productOrder(
	idPOproduct INT,
    idPOorder INT,
    poQuantity INT DEFAULT 1,
    poStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idPOproduct, idPOorder),
    CONSTRAINT fk_productorder_product FOREIGN KEY (idPOproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_productorder_order FOREIGN KEY (idPOorder) REFERENCES orders(idOrder)
);

CREATE TABLE storageLocation(
	idLproduct INT,
    idLstorage INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idLproduct, idLstorage),
    CONSTRAINT fk_storage_location_product FOREIGN KEY (idLproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_storage_location_storage FOREIGN KEY (idLstorage) REFERENCES productStorage(idProdStorage)
);

CREATE TABLE pagamentos(
    id_pagamento INT NOT NULL AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    tipo_pagamento ENUM('Cartão de crédito', 'Boleto', 'Outros'),
    data_pagamento DATETIME NOT NULL,
    valor_pagamento DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pagamento),
    CONSTRAINT fk_pagamentos_clientes FOREIGN KEY (id_cliente) REFERENCES clients (id_cliente)
);

CREATE TABLE productSupplier(
	idPsSupplier INT,
    idPsProduct INT,
    quantity INT NOT NULL,
    PRIMARY KEY (idPsSupplier, idPsProduct),
    CONSTRAINT fk_product_supplier_supplier FOREIGN KEY (idPsSupplier) REFERENCES supplier(idSupplier),
    CONSTRAINT fk_product_supplier_prodcut FOREIGN KEY (idPsProduct) REFERENCES product(idProduct)
);

DESC productSupplier;

SHOW TABLES;

SHOW DATABASES;
USE information_schema;
SHOW TABLES;
DESC referential_constraints;
SELECT * FROM referential_constraints WHERE CONSTRAINT_SCHEMA = 'ecommerce';
