CREATE OR ALTER PROCEDURE WithdrawMoney
    @AccountID INT,
    @Amount DECIMAL(18,2),
    @Description VARCHAR(255) = NULL
AS
BEGIN
    DECLARE @CurrentBalance DECIMAL(18,2);

    -- Validate account existence
    IF NOT EXISTS (
        SELECT 1 FROM Accounts WHERE AccountID = @AccountID
    )
    BEGIN
        RAISERROR('Invalid account ID.', 16, 1);
        RETURN;
    END

    -- Check if frozen
    IF EXISTS (
        SELECT 1 FROM Accounts WHERE AccountID = @AccountID AND Status = 'Frozen'
    )
    BEGIN
        RAISERROR('Cannot withdraw: Account is frozen.', 16, 1);
        RETURN;
    END

    SELECT @CurrentBalance = Balance FROM Accounts WHERE AccountID = @AccountID;

    IF @Amount <= 0 OR @CurrentBalance IS NULL
    BEGIN
        RAISERROR('Invalid withdrawal request.', 16, 1);
        RETURN;
    END

    IF @CurrentBalance < @Amount
    BEGIN
        RAISERROR('Insufficient funds.', 16, 1);
        RETURN;
    END

    UPDATE Accounts SET Balance = Balance - @Amount WHERE AccountID = @AccountID;

    INSERT INTO Transactions (AccountID, TransactionType, Amount, Description)
    VALUES (@AccountID, 'Withdraw', @Amount, @Description);

    INSERT INTO AuditLog (ActionPerformed, PerformedBy, Details)
    VALUES ('Withdrawal', SYSTEM_USER, CONCAT('AccountID: ', @AccountID, ', Amount: ', @Amount));
END;
