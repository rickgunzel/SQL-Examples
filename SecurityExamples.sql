-- Problem #1
USE MyGuitarShop;
GO
CREATE ROLE OrderEntry
	GO
	GRANT INSERT, UPDATE
	ON Orders
	To OrderEntry
	GO
	GRANT INSERT, UPDATE
	ON OrderItems
	TO OrderEntry
	GO
	GRANT SELECT TO OrderEntry;

-- Problem #2
USE MyGuitarShop;
CREATE LOGIN RobertHalliday WITH PASSWORD = 'HelloBob',
	DEFAULT_DATABASE = MyGuitarShop;
GO
CREATE USER RobertHalliday FOR LOGIN RobertHalliday;
ALTER ROLE OrderEntry ADD MEMBER RobertHalliday;

-- Problem #3
USE MyGuitarShop;
GO
DECLARE @FirstName varchar(100), @LastName varchar(100);
DECLARE @FullName varchar(100);
DECLARE @Command varchar(500);
DECLARE AdminList CURSOR FOR
	SELECT FirstName, LastName 
	FROM Administrators;
OPEN AdminList;
FETCH NEXT FROM AdminList
	INTO @FirstName, @LastName;
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @FullName = @FirstName + @LastName;
	SET @Command = 'CREATE LOGIN ' + @FullName + ' WITH PASSWORD = ''temp'', 
		DEFAULT_DATABASE = MyGuitarShop';
	EXEC (@Command);
	SET @Command = 'CREATE USER ' + @FullName + ' FOR LOGIN ' + @FullName;
	EXEC (@Command);
	SET @Command = 'ALTER ROLE OrderEntry ADD MEMBER ' + @FullName;
	EXEC (@Command);
	FETCH NEXT FROM AdminList
		INTO @FirstName, @LastName;
END
CLOSE AdminList;
DEALLOCATE AdminList;

-- Problem #5
USE MyGuitarShop;
GO
DECLARE @MemberName varchar(100);
DECLARE @Command varchar(1000);
DECLARE @DBRole table
(
	DbRole varchar(50),
	MemberName varchar(100),
	MemberSID varchar(100)
);
INSERT INTO @DBRole EXEC sp_helprolemember OrderEntry;
DECLARE RoleMember CURSOR FOR
	SELECT MemberName 
	FROM @DBRole;
OPEN RoleMember;
FETCH NEXT FROM RoleMember
	INTO @MemberName;
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Command = 'ALTER ROLE OrderEntry DROP MEMBER ' + @MemberName;
	EXEC (@Command);
	FETCH NEXT FROM RoleMember
		INTO @MemberName;
END
CLOSE RoleMember;
DEALLOCATE RoleMember;
DROP ROLE OrderEntry;

-- Problem #6
USE MyGuitarShop;
GO
CREATE SCHEMA Admin;
GO
ALTER SCHEMA Admin TRANSFER dbo.Addresses;
ALTER USER RobertHalliday WITH DEFAULT_SCHEMA = Admin;

GRANT SELECT, UPDATE, INSERT, DELETE, EXECUTE
ON SCHEMA :: Admin
TO RobertHalliday;

