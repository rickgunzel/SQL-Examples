Use MyGuitarShop;
GO
CREATE INDEX zipcode
ON Addresses(ZipCode);
	 
IF EXISTS(SELECT name FROM sys.databases
     WHERE name = 'MyWebDB')
     DROP DATABASE MyWebDB;
GO

CREATE DATABASE MyWebDB;
GO

USE MyWebDB;

CREATE TABLE Users(
	UserId int not null,
	EmailAddress varchar(50),
	FirstName varchar(50),
	LastName varchar(50)
	CONSTRAINT userId_pk PRIMARY KEY(UserId)
);
	

CREATE TABLE Products(
	ProductId int not null,
	Product varchar(75)
	CONSTRAINT productId_pk PRIMARY KEY(ProductId)
);
CREATE INDEX products
ON Products(Product);


CREATE TABLE Downloads(
	DownloadId int not null,
	UserId int not null,
	DownloadDate date,
	FileName varchar(75),
	ProductId int not null
	CONSTRAINT downloadId_pk PRIMARY KEY(DownloadId),
	CONSTRAINT userId_fk FOREIGN KEY(UserId) REFERENCES Users(UserID),
	CONSTRAINT productId_fk FOREIGN KEY (ProductId)REFERENCES Products(ProductID)
);

CREATE INDEX fileName
ON Downloads(FileName);



USE MyWebDB;

INSERT INTO Users (UserId,EmailAddress,FirstName,LastName) VALUES
(1,'johnsmith@gmail.com','John','Smith'),
(2,'janedoe@yahoo.com','Jane','Doe');

INSERT INTO Products (ProductId,Product) VALUES
(1,'Local Music Vol 1'),
(2,'Local Music Vol 2');

INSERT INTO Downloads(DownloadId,UserID,DownloadDate,FileName,ProductId) VALUES
(1,1,getDate(),'pedals_are_falling.mp3',2),
(2,2,getDate(),'turn_signal.mp3',1),
(3,2,getDate(),'one_horse_town.mp3',2);

SELECT EmailAddress,FirstName,LastName,DownloadDate,FileName,Product
FROM Users u JOIN Downloads d
ON u.UserID= d.UserID
JOIN Products p
ON d.ProductID=p.productID
ORDER BY EmailAddress desc, Product asc;


USE MyWebDB;

ALTER TABLE PRODUCTS
ADD Price DECIMAL(3,2)NOT NULL DEFAULT 9.99,
DateTime DATETIME NOT NULL DEFAULT GETDATE();

	 

USE MyWebDB;

ALTER TABLE Users
ALTER COLUMN FirstName varchar(20) NOT NULL;

UPDATE Users
Set FirstName= null;

UPDATE Users
Set FirstName= 'JohnathonTaylerWrights';

	 

CREATE VIEW CustomerAddresses as
SELECT c.CustomerID, c.EmailAddress, c.LastName, c.FirstName,
sa.Line1 AS ShipLine1, sa.Line2 AS ShipLine2, sa.City AS ShipCity, sa.State AS ShipState, sa.ZipCode AS ShipZip,
ba.Line1 AS BillLine1, ba.Line2 AS BillLine2, ba.City AS BillCity, ba.State AS BillState, ba.ZipCode AS BillZip
from Customers c
       LEFT JOIN Addresses ba
               on ba.AddressID=c.BillingAddressID
       LEFT JOIN Addresses sa
               on sa.AddressID=c.ShippingAddressID

 

CREATE VIEW OrderItemProducts as
SELECT o.OrderID,p.ProductName, o.OrderDate,o.TaxAmount,o.ShipDate,oi.ItemPrice, oi.DiscountAmount,
(SUM(oi.ItemPrice) - SUM(oi.DiscountAmount))as FinalPrice,oi.Quantity,
(SUM(oi.ItemPrice) - SUM(oi.DiscountAmount)) * SUM(oi.Quantity) AS ItemTotal
FROM Orders o
       LEFT JOIN OrderItems oi
               on o.OrderID=oi.OrderID
		LEFT JOIN Products p
				on oi.ProductID=p.ProductID
GROUP BY o.OrderID,o.OrderDate, o.TaxAmount,o.shipDate,oi.ItemPrice, oi.DiscountAmount,oi.Quantity,p.productName

	 

CREATE VIEW ProductSummary as
SELECT ProductName, COUNT(ProductName) AS OrderCount, SUM(ItemTotal)as ItemTotal
FROM OrderItemProducts 
GROUP BY ProductName;
	 

SELECT TOP (5) ProductName,ItemTotal FROM ProductSummary Order by ItemTotal desc
	 

