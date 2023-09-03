USE shop;

INSERT INTO customer (idCustomer, firstName, lastName, CPF, phone, address) VALUES
			(1, 'Harry', 'Potter', 12345678901, 11222223333, 'Privet Drive'),
            (2, 'Hermione', 'Granger', 12345678902, 22333334444, 'Flourish & Blotts' ),
            (3, 'Ron', 'Weasley', 12345678903, 33444445555, 'Diagon Alley' ),
            (4, 'Luna', 'Lovegood', 12345678904, 44555556666, 'Shell Cottage' ),
            (5, 'Severus', 'Snape', 12345678905, 55666667777, 'Grimmauld Place');
            
INSERT INTO vehicle (idVehicle, idVehicleCustomer, licensePlate, make, model, color, VIN) VALUES
			(1, 1, 'ABC1234', 'Hippogriff', 'Buckbeak', 'Grey', 11112222 ),
            (2, 2, 'DEF5678', 'Elf', 'Winky', 'Brown', 22223333),
            (3, 3, 'GHI9101', 'Rat', 'Scabbers', 'Orange', 33334444),
            (4, 4, 'JKL2345', 'Goblin', 'Griphook', 'Blue', 44445555 ),
            (5, 5, 'MNO6789', 'Snake', 'Nagini', 'Black', 55556666);
            
INSERT INTO request (idRequest, awaitReview) VALUES
			(1, 'Vehicle in maintenance'),
            (2, 'Vehicle under evaluation'),
            (3, 'Vehicle in maintenance'),
            (4, 'Vehicle under evaluation'),
            (5, 'Vehicle in maintenance');
            
INSERT INTO part (idPart, pricePart) VALUES
			(7, '$1000'),
            (14, '$2000'),
            (21, '$3000'),
            (28, '$4000'),
            (35, '$5000');
            
INSERT INTO service_order (idService_Order, soNumber, priceSo, statusSo) VALUES
			(111, 111222, 300, 'Pending'),
            (222, 333444, 600, 'In Progress'),
            (333, 555666, 900, 'Ready for Pickup'),
            (444, 777888, 1200, 'Pending'),
            (555, 999000, 1500, 'In Progress');
            
INSERT INTO payment (idPayment, paymentType) VALUES
			(1, 'PIX'),
            (2, 'Debit'),
            (3, 'Credit'),
            (4, 'Cash');

INSERT INTO employee (idEmployee, employeeName, codeEmployee, expertise) VALUES
			(101, 'Rowena Ravenclaw', 11111, 'Engine'),
            (102, 'Helga Hufflepuff', 22222, 'Paint'),
            (103, 'Godric Gryffindor', 33333, 'Brake'),
            (104, 'Salazar Slytherin', 44444, 'Suspension');
            
INSERT INTO shop (idShop, rating, employee) VALUES
			(1, '4', 'Rowena Ravenclaw'),
            (2, '4', 'Helga Hufflepuff'),
            (3, '5', 'Godric Gryffindor'),
            (4, '5', 'Salazar Slytherin'),
            (5, '5', 'Salazar Slytherin');