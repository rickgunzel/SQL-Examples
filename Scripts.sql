USE MyGuitarShop;

DECLARE @MaxPrice money, @MinPrice money;
DECLARE @PercentDifference decimal(8,2);
DECLARE @ProductNameHigh varchar(60),@ProductNameLow varchar(60) ;


SET @MaxPrice=(SELECT MAX(ListPrice) FROM Products);


SELECT @MinPrice= MIN(ListPrice)
FROM Products

SET @ProductNameHigh=(SELECT ProductName FROM Products WHERE ListPrice=@MaxPrice);
SELECT @ProductNameLow= ProductName FROM Products WHERE ListPrice=@MinPrice;



SET @PercentDifference=(@MaxPrice-@MinPrice)/@MinPrice*100;

PRINT 'The product ' + @ProductNameHigh + ' is the highest priced product with a price of ' + Convert(varchar,@MaxPrice,1)+ '.';
PRINT 'The product ' + @ProductNameLow +  ' is the lowest priced product with a price of ' + Convert(varchar,@MinPrice,1)+ '.';
PRINT  @ProductNameHigh + ' is ' + CONVERT(varchar,@PercentDifference)+ '% more than ' + @ProductNameLow;

	 

USE MyGuitarShop;

DECLARE @Orders table
(OrderId int,ordered int, ShipAmount decimal(8,2), TaxAmount decimal(8,2), OrderTotal decimal(8,2)) ;


Insert @Orders
SELECT oi.OrderId, COUNT(Quantity),ShipAmount,TaxAmount, SUM(ItemPrice-DiscountAmount) * Quantity
FROM Orders o Join
OrderItems oi
ON o.OrderID=oi.OrderID

GROUP BY ShipAmount,TaxAmount,Quantity,oi.OrderID

SELECT * FROM @Orders;

	 

USE MYGuitarShop;

DECLARE @MarchSales money,@AprilSales money;


SET @MarchSales=(SELECT SUM((ItemPrice-DiscountAmount)*Quantity)
FROM Orders o JOIN OrderItems oi 
ON o.OrderId=oi.OrderID
WHERE OrderDate  > '2012/02/29'
AND OrderDate < '2012/04/01');

SELECT @AprilSales=SUM((ItemPrice-DiscountAmount)*Quantity)
FROM Orders o JOIN OrderItems oi 
ON o.OrderId=oi.OrderID
WHERE OrderDate  >'2012/03/31'
AND OrderDate <'2012/05/01';

IF @MarchSales>@AprilSales
	BEGIN
		PRINT 'March sales are greater than April sales.';
	END;
ELSE--@AprilSales>@MarchSales
	PRINT 'April sales are greater than March sales.';

	 




USE MYGuitarShop;
IF EXISTS(SELECT * FROM sys.tables)
     DROP TABLE Junk2;

CREATE TABLE Junk(
	id int 
	CONSTRAINT id_pk PRIMARY KEY(id)
);

CREATE TABLE Junk2(
	id int
	CONSTRAINT id_fk FOREIGN KEY (id) REFERENCES Junk(id)

);

	 

USE MYGuitarShop;
BEGIN TRY
IF EXISTS(SELECT * FROM sys.tables)
     DROP TABLE Junk2;

CREATE TABLE Junk(
	id int 
	CONSTRAINT id_pk PRIMARY KEY(id)
);

CREATE TABLE Junk2(
	id int
	CONSTRAINT id_fk FOREIGN KEY (id) REFERENCES Junk(id)

);
END TRY
BEGIN CATCH 
	PRINT 'Error '+ CONVERT(varchar,ERROR_NUMBER(),1)+ ':' + ERROR_MESSAGE() + ' Severity = '+CONVERT(varchar,ERROR_SEVERITY(),1);
END CATCH

	 





	
BEGIN TRY
CREATE TABLE test(
FirstName varchar(30),
LastName varchar(30),
OrderNumber int,
ItemName varchar(30),
PercentDiscount decimal(8,2),
Discount varchar(30)

);
INSERT INTO test(Discount) VALUES
('NONE'),
('LESS THAN TWENTY'),
('LESS THAN FORTY'),
('MORE THAN FORTY')


END TRY
BEGIN CATCH
	PRINT 'Error ' + CONVERT(varchar,Error_Number(),1);
END CATCH

	 

USE MyGuitarShop;

BEGIN TRY

DECLARE @ProductsHighAvg table
(ProductName varchar(30), ListPrice money) ;

DECLARE @AvgPrice money
DECLARE @ListPrice money

SELECT @AvgPrice= AVG(ListPrice) FROM Products
SELECT @ListPrice= ListPrice FROM Products WHERE ListPrice>@AvgPrice
	IF @ListPrice>=@AvgPrice
		BEGIN
		INSERT @ProductsHighAvg SELECT ProductName,ListPrice FROM Products  WHERE ListPrice >=@AvgPrice 
		SELECT * FROM @ProductsHighAvg
		END
	ELSE 
		PRINT 'There are no products with a price greater than the average price';
END TRY			
BEGIN CATCH 
	PRINT 'Error '+ CONVERT(varchar,ERROR_NUMBER(),1)+ ':' + ERROR_MESSAGE() + ' Severity = '+CONVERT(varchar,ERROR_SEVERITY(),1);
END CATCH


