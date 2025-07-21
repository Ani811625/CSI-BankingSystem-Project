CREATE PROCEDURE CreateCustomer
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Phone VARCHAR(15),
    @DateOfBirth DATE,
    @Gender CHAR(1),
    @Address VARCHAR(255)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customers WHERE Email = @Email)
    BEGIN
        RAISERROR('Email already exists.', 16, 1);
        RETURN;
    END

    INSERT INTO Customers (FirstName, LastName, Email, Phone, DateOfBirth, Gender, Address)
    VALUES (@FirstName, @LastName, @Email, @Phone, @DateOfBirth, @Gender, @Address);

    INSERT INTO AuditLog (ActionPerformed, PerformedBy, Details)
    VALUES ('New Customer Created', SYSTEM_USER, CONCAT('Email: ', @Email));
END
