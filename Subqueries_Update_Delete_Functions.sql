SELECT DISTINCT CategoryName
FROM Categories c 
WHERE CategoryID IN (SELECT CategoryID FROM Products)
ORDER BY CategoryName
	 
SELECT ProductName,ListPrice
FROM Products
WHERE ListPrice>(SELECT AVG(ListPrice) FROM Products)
ORDER BY ListPrice Desc;
	 
SELECT CategoryName
FROM Categories c
WHERE NOT EXISTS(SELECT CategoryID FROM Products p WHERE p.CategoryID=c.CategoryID) 
	 



	SELECT EmailAddress, oi.OrderID, (SUM(ItemPrice) - SUM(DiscountAmount)) * SUM(Quantity) AS OrderTotal
FROM Customers c INNER JOIN Orders o
	ON c.CustomerID = o.CustomerID
	INNER JOIN OrderItems oi
	ON o.OrderID = oi.OrderID
GROUP BY EmailAddress, oi.OrderID

SELECT EmailAddress, MAX(OrderTotal) AS MaxTotal
FROM (
	SELECT EmailAddress, oi.OrderID, (SUM(ItemPrice) - SUM(DiscountAmount)) * SUM(Quantity) AS OrderTotal
	FROM Customers c INNER JOIN Orders o
		ON c.CustomerID = o.CustomerID
		INNER JOIN OrderItems oi
		ON o.OrderID = oi.OrderID
	GROUP BY EmailAddress, oi.OrderID) AS sub
GROUP BY EmailAddress;

	 


SELECT ProductName, DiscountPercent
FROM Products
WHERE DiscountPercent IN (
	SELECT DiscountPercent
	FROM Products
	GROUP BY DiscountPercent
	HAVING COUNT(DiscountPercent) = 1
	)
ORDER BY ProductName;
	 


SELECT EmailAddress, OrderID, OrderDate
FROM Customers INNER JOIN Orders o1 ON
	Customers.CustomerID = o1.CustomerID
WHERE o1.OrderDate = (
	SELECT MIN(o2.OrderDate)
	FROM Orders o2
	WHERE o1.CustomerID = o2.CustomerID
	);
	 



USE MyGuitarShop;
INSERT INTO Products (CategoryID, ProductCode, ProductName, Description, ListPrice, DiscountPercent, DateAdded)
	VALUES (4, 'dgx_640', 'Yamaha DGX 640 88-Key Digital Piano', 'Long description to come.', 799.99, 0, CURRENT_TIMESTAMP);


USE MyGuitarShop;
UPDATE Products 
SET DiscountPercent=35
   WHERE ProductCode='dgx_640'

	 
	PART A:

USE MyGuitarShop;
DELETE FROM Categories 
WHERE CategoryID=4

 	PART B:

USE MyGuitarShop;
DELETE FROM Products 
WHERE ProductID=11
 

SELECT OrderDate, YEAR(OrderDate) AS OrderYear,
	DAY(OrderDate) As OrderDay, DATEADD(day, 30, OrderDate) As OrderDay30
FROM Orders
	 

