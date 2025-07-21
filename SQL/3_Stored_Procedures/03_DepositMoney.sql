CREATE OR ALTER PROCEDURE DepositMoney
    @AccountID INT,
    @Amount DECIMAL(18,2),
    @Description VARCHAR(255) = NULL
AS
BEGIN
    -- Check if account exists and is not frozen
    IF NOT EXISTS (
        SELECT 1 FROM Accounts WHERE AccountID = @AccountID
    )
    BEGIN
        RAISERROR('Invalid account ID.', 16, 1);
        RETURN;
    END

    IF EXISTS (
        SELECT 1 FROM Accounts WHERE AccountID = @AccountID AND Status = 'Frozen'
    )
    BEGIN
        RAISERROR('Cannot deposit: Account is frozen.', 16, 1);
        RETURN;
    END

    IF @Amount <= 0
    BEGIN
        RAISERROR('Deposit amount must be positive.', 16, 1);
        RETURN;
    END

    UPDATE Accounts SET Balance = Balance + @Amount WHERE AccountID = @AccountID;

    INSERT INTO Transactions (AccountID, TransactionType, Amount, Description)
    VALUES (@AccountID, 'Deposit', @Amount, @Description);

    INSERT INTO AuditLog (ActionPerformed, PerformedBy, Details)
    VALUES ('Deposit', SYSTEM_USER, CONCAT('AccountID: ', @AccountID, ', Amount: ', @Amount));
END;
