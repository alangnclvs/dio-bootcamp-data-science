-- banco de dados para oficina mecânica;
-- drop database shop;
CREATE DATABASE shop;
USE shop;

CREATE TABLE customer (
	idCustomer INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(20),
    lastName VARCHAR(20),
    CPF CHAR(11) UNIQUE NOT NULL,
    phone CHAR(11),
    address VARCHAR(200)
);

ALTER TABLE customer AUTO_INCREMENT=1;

CREATE TABLE vehicle (
	idVehicle INT PRIMARY KEY AUTO_INCREMENT,
    idVehicleCustomer INT,
    licensePlate VARCHAR(45) UNIQUE NOT NULL,
    make VARCHAR(45),
    model VARCHAR(45),
    color VARCHAR(45),
    VIN VARCHAR(45),
    CONSTRAINT fk_id_customer FOREIGN KEY (idVehicleCustomer) REFERENCES customer(idCustomer)
);

ALTER TABLE vehicle AUTO_INCREMENT=1;

CREATE TABLE request (
	idRequest INT PRIMARY KEY AUTO_INCREMENT,
    idRequestCustomer INT,
    awaitReview VARCHAR(45),
    CONSTRAINT fk_pedido_customer FOREIGN KEY (idRequestCustomer) REFERENCES customer (idCustomer)
);

ALTER TABLE request AUTO_INCREMENT=1;

CREATE TABLE part (
	idPart INT PRIMARY KEY AUTO_INCREMENT,
    pricePart VARCHAR(20)
);

ALTER TABLE part AUTO_INCREMENT=1;

CREATE TABLE service_order (
	idService_Order INT PRIMARY KEY AUTO_INCREMENT,
	idSoRequest INT,
    idSoPart INT,
    soNumber VARCHAR(30),
    priceSo FLOAT,
    statusSo VARCHAR(45),
	CONSTRAINT fk_so_request FOREIGN KEY (idSoRequest) REFERENCES request (idRequest),
    CONSTRAINT fk_part FOREIGN KEY (idSoPart) REFERENCES part (idPart)
);

ALTER TABLE service_order AUTO_INCREMENT=1;

CREATE TABLE payment (
	idPayment INT PRIMARY KEY AUTO_INCREMENT,
    idPaymentSo INT,
    paymentType ENUM('PIX', 'Debit', 'Credit', 'Cash'),
    CONSTRAINT fk_payment_so FOREIGN KEY (idPaymentSo) REFERENCES service_order (idService_Order)
);

ALTER TABLE payment AUTO_INCREMENT=1;

CREATE TABLE employee (
	idEmployee INT PRIMARY KEY AUTO_INCREMENT,
    employeeName VARCHAR(60),
    codeEmployee VARCHAR(7),
    expertise VARCHAR(30)
);

ALTER TABLE employee AUTO_INCREMENT=1;

CREATE TABLE shop (
	idShop INT PRIMARY KEY AUTO_INCREMENT,
    idShopEmployee INT,
    idRequests INT,
    idShopPayment INT,
    rating FLOAT DEFAULT 0,
    employee VARCHAR(45),
    CONSTRAINT fk_shop_employee FOREIGN KEY (idShopEmployee) REFERENCES employee (idEmployee),
    CONSTRAINT fk_shop_request FOREIGN KEY (idRequests) REFERENCES request (idRequest),
    CONSTRAINT fk_shop_payment FOREIGN KEY (idShopPayment) REFERENCES payment (idPayment)
);

ALTER TABLE shop AUTO_INCREMENT=1;