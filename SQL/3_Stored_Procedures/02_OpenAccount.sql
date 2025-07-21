CREATE PROCEDURE OpenAccount
    @CustomerID INT,
    @BranchID INT,
    @AccountType VARCHAR(20)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
    BEGIN
        RAISERROR('Invalid Customer ID.', 16, 1);
        RETURN;
    END

    INSERT INTO Accounts (CustomerID, BranchID, AccountType)
    VALUES (@CustomerID, @BranchID, @AccountType);

    INSERT INTO AuditLog (ActionPerformed, PerformedBy, Details)
    VALUES ('Account Opened', SYSTEM_USER, CONCAT('CustomerID: ', @CustomerID));
END
