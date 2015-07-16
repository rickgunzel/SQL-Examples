--Write a script that includes two SQL statements coded as a transaction to delete the row with a customer ID of 8 from the Customers table. To do this, you must first delete all addresses for that customer from the Addresses table.
--If these statements execute successfully, commit the changes. Otherwise, roll back the changes.
USE MyGuitarShop;
BEGIN TRANSACTION
	DELETE FROM Addresses WHERE CustomerID=8
    IF @@ROWCOUNT = 0
    BEGIN
        ROLLBACK TRANSACTION
        
    END                 
    DELETE FROM Customers WHERE CustomerID = 8            
    IF @@ROWCOUNT = 0
    BEGIN
        ROLLBACK TRANSACTION
        
    END
COMMIT TRANSACTION

--Write a script that includes these statements coded as a transaction:
INSERT Orders 
VALUES (3, GETDATE(), '10.00', '0.00', NULL, 4, 
  'American Express', '378282246310005', '04/2013', 4);

SET @OrderID = @@IDENTITY;

INSERT OrderItems 
VALUES (@OrderID, 6, '415.00', '161.85', 1);

INSERT OrderItems 
VALUES (@OrderID, 1, '699.00', '209.70', 1);
Here, the @@IDENTITY variable is used to get the order ID value that’s automatically generated when the first INSERT statement inserts an order.
If these statements execute successfully, commit the changes. Otherwise, roll back the changes.
      
BEGIN TRANSACTION

BEGIN TRY
INSERT Orders 
VALUES (3, GETDATE(), '10.00', '0.00', NULL, 4, 
  'American Express', '378282246310005', '04/2013', 4);

SET @OrderID = @@IDENTITY;

INSERT OrderItems 
VALUES (@OrderID, 6, '415.00', '161.85', 1);

INSERT OrderItems 
VALUES (@OrderID, 1, '699.00', '209.70', 1);

  COMMIT TRANSACTION

END TRY

BEGIN CATCH
  RAISERROR(‘Error’, 16, 1)
  ROLLBACK TRANSACTION
END CATCH

