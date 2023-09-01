-- inserção de dados e queries
USE ecommerce;

SHOW TABLES;
-- idClient, Fname, Minit, Lname, CPF, Address
INSERT INTO clients (Fname, Minit, Lname, CPF, Address) VALUES ('Maria','M','Silva', 12346789, 'Rua silva de prata 29, Carangola - Cidade das flores'),
		     ('Matheus','O','Pimentel', 987654321,'Rua Alameda 289, Centro - Cidade das flores'),
			 ('Ricardo','F','Silva', 45678913,'Avenida Alameda Vinha 1009, Centro - Cidade das flores'),
			 ('Julia','S','França', 789123456,'Rua Laranjeiras 861, Centro - Cidade das flores'),
			 ('Roberta','G','Assis', 98745631,'Avenida Koller 19, Centro - Cidade das flores'),
			 ('Isabela','M','Cruz', 654789123,'Rua alemeda das flores 28, Centro - Cidade das flores');
             
SELECT * FROM clients;
             
-- idProduct, Pname, classification_kids boolean, category('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'), avaliação, size
INSERT INTO product (Pname, classification_kids, category, avaliação, size) VALUES
							  ('Fone de ouvido',FALSE,'Eletrônico','4',NULL),
                              ('Barbie',TRUE,'Brinquedos','3',NULL),
                              ('Body Carters',TRUE,'Vestimenta','5',NULL),
                              ('Microfone SM7',FALSE,'Eletrônico','4',NULL),
                              ('Sofá retrátil',FALSE,'Móveis','3','3x57x80'),
                              ('Farinha de arroz',FALSE,'Alimentos','2',NULL),
                              ('Fire Stick Amazon',FALSE,'Eletrônico','3',NULL);
                              
SELECT * FROM product;

-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash
DELETE FROM orders WHERE idOrderClient IN  (1,2,3,4);
INSERT INTO orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) VALUES 
							 (1, DEFAULT, 'Compra via aplicativo', NULL, 1),
                             (2, DEFAULT,'Compra via aplicativo', 50, 0),
                             (3, 'Confirmado', NULL, NULL,1),
                             (4, DEFAULT, 'Compra via web site', 150, 0);	
SELECT * FROM orders;

INSERT INTO productOrder (idPOproduct,IDPOorder,poQuantity,poStatus) VALUES 
							(1,1,2,NULL),
							(2,1,1,NULL),
							(3,2,1,NULL);
                            
-- storageLocation,quantity
INSERT INTO productStorage (storageLocation,quantity) VALUES 
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10),
                            ('São Paulo',100),
                            ('São Paulo',10),
                            ('Brasília',60);
                            
-- idLproduct, idLstorage, location
INSERT INTO storageLocation (idLproduct, idLstorage, location) VALUES
						 (1,2,'RJ'),
                         (2,6,'GO');
                         
-- idSupplier, SocialName, CNPJ, contact
INSERT INTO supplier (socialName, CNPJ, contact) VALUES 
							('Almeida e filhos', 123456789123456,'21985474'),
                            ('Eletrônicos Silva',854519649143457,'21985484'),
                            ('Eletrônicos Valma', 934567893934695,'21975474');
SELECT * FROM supplier;

-- idPsSupplier, idPsProduct, quantity
INSERT INTO productSupplier (idPsSupplier, idPsProduct, quantity) VALUES
						 (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10);
                         
-- idSeller, SocialName, AbstName, CNPJ, CPF, location, contact
INSERT INTO seller (SocialName, AbstName, CNPJ, CPF, location, contact) VALUES 
						('Tech eletronics', NULL, 123456789456321, NULL, 'Rio de Janeiro', 219946287),
					    ('Botique Durgas',NULL,NULL,123456783,'Rio de Janeiro', 219567895),
						('Kids World',NULL,456789123654485,NULL,'São Paulo', 1198657484);
SELECT * FROM seller;

-- idPseller, idPproduct, prodQuantity
INSERT INTO productSeller (idPseller, idPproduct, prodQuantity) values 
						 (1,6,80),
                         (2,7,10);                         
SELECT * FROM productSeller;

SELECT count(*) FROM clients;
SELECT * FROM clients c, orders o where c.idClient = idOrderClient;

SELECT Fname,Lname, idOrder, orderStatus FROM clients c, orders o WHERE c.idClient = idOrderClient;
SELECT concat(Fname,' ',Lname) AS clients, idOrder AS Request, orderStatus AS Status FROM clients c, orders o WHERE c.idClient = idOrderClient;

INSERT INTO orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) VALUES 
							 (2, DEFAULT,'Compra via aplicativo',NULL,1);
                             
SELECT count(*) FROM clients c, orders o 
			WHERE c.idClient = idOrderClient;
            
SELECT * FROM orders;

-- recupera pedidos com produto associado:
SELECT c.idClient, Fname, count(*) AS Number_of_orders FROM clients c 
					INNER JOIN orders o ON c.idClient = o.idOrderClient
					INNER JOIN productOrder p ON  p.idPOorder = idOrder
					GROUP BY idClient;

-- recuperar quantos pedidos foram realizados pelos clientes?
SELECT c.idClient, Fname, count(*) AS Number_of_orders FROM clients c 
				INNER JOIN orders o ON c.idClient = o.idOrderClient
		GROUP BY idClient;
        
-- listar os clientes com mais de 3 pedidos:
SELECT c.idClient, Fname, COUNT(*) AS total_orders
FROM clients c
INNER JOIN orders o ON c.idClient = o.idOrderClient
GROUP BY c.idClient
HAVING COUNT(*) > 3;

-- listar os produtos com avaliação média superior a 4:
SELECT p.idProduct, Pname, AVG(avaliação) AS média_avaliação
FROM product p
GROUP BY p.idProduct
HAVING AVG(avaliação) > 4;

-- listar os pedidos com valor total superior a R$ 100:
SELECT idOrder, SUM(sendValue) AS total_value
FROM orders
GROUP BY idOrder
HAVING SUM(sendValue) > 100;

-- relação de produtos fornecedores e estoques:
SELECT p.Pname, s.SocialName, ps.quantity
FROM product p
INNER JOIN productSupplier ps ON p.idProduct = ps.idPsProduct
INNER JOIN supplier s ON s.idSupplier = ps.idPsSupplier;

-- relação de nomes dos fornecedores e nomes dos produtos:
SELECT s.SocialName, p.Pname
FROM supplier s
INNER JOIN productSupplier ps ON s.idSupplier = ps.idPsSupplier
INNER JOIN product p ON p.idProduct = ps.idPsProduct;