SELECT * FROM customer;
SELECT * FROM vehicle;
SELECT * FROM request;
SELECT * FROM part;

SELECT * FROM vehicle WHERE make LIKE "H%";
SELECT * FROM request WHERE awaitReview = 'Vehicle in maintenance';
SELECT * FROM customer WHERE idCustomer = 1;

-- average order value:
SELECT AVG(s.priceSo) AS AverageOrderValue
FROM service_order s;

-- total orders by status:
SELECT statusSo, COUNT(*) AS TotalOrders
FROM service_order
GROUP BY statusSo;

-- number of orders pending review:
SELECT COUNT(*) AS OrdersPendingReview
FROM request
WHERE awaitReview = 'Vehicle under evaluation';

-- total orders per customer:
SELECT c.firstName, c.lastName, COUNT(r.idRequest) AS TotalOrders
FROM customer c
LEFT JOIN request r ON c.idCustomer = r.idRequestCustomer
GROUP BY c.idCustomer;

-- sort customers by last name in alphabetical order:
SELECT * FROM customer
ORDER BY lastName;

-- sort service orders by status and price in ascending order:
SELECT * FROM service_order
ORDER BY statusSo, priceSo;

-- find customers with more than one vehicle:
SELECT idCustomer, firstName, lastName, COUNT(*) AS VehicleCount
FROM customer
JOIN vehicle ON customer.idCustomer = vehicle.idVehicleCustomer
GROUP BY idCustomer
HAVING VehicleCount > 1;

-- join customers and vehicles to see vehicle information for each customer:
SELECT c.firstName, c.lastName, v.licensePlate, v.make, v.model
FROM customer AS c
JOIN vehicle AS v ON c.idCustomer = v.idVehicleCustomer;