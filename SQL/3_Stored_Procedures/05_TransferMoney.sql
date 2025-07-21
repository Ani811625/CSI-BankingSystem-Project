CREATE OR ALTER PROCEDURE TransferMoney
    @FromAccount INT,
    @ToAccount INT,
    @Amount DECIMAL(18,2),
    @Description VARCHAR(255) = NULL
AS
BEGIN
    BEGIN TRANSACTION;

    DECLARE @FromBalance DECIMAL(18,2);

    -- Validate accounts
    IF NOT EXISTS (SELECT 1 FROM Accounts WHERE AccountID = @FromAccount)
        OR NOT EXISTS (SELECT 1 FROM Accounts WHERE AccountID = @ToAccount)
    BEGIN
        RAISERROR('Invalid account ID(s).', 16, 1);
        ROLLBACK;
        RETURN;
    END

    -- Prevent transfer to self
    IF @FromAccount = @ToAccount
    BEGIN
        RAISERROR('Cannot transfer to the same account.', 16, 1);
        ROLLBACK;
        RETURN;
    END

    -- Check if either account is frozen
    IF EXISTS (
        SELECT 1 FROM Accounts 
        WHERE AccountID IN (@FromAccount, @ToAccount) AND Status = 'Frozen'
    )
    BEGIN
        RAISERROR('Transfer failed: One or both accounts are frozen.', 16, 1);
        ROLLBACK;
        RETURN;
    END

    -- Validate balance
    SELECT @FromBalance = Balance FROM Accounts WHERE AccountID = @FromAccount;

    IF @FromBalance < @Amount OR @Amount <= 0
    BEGIN
        RAISERROR('Insufficient balance or invalid amount.', 16, 1);
        ROLLBACK;
        RETURN;
    END

    -- Perform transfer
    UPDATE Accounts SET Balance = Balance - @Amount WHERE AccountID = @FromAccount;
    UPDATE Accounts SET Balance = Balance + @Amount WHERE AccountID = @ToAccount;

    -- Insert transactions
    INSERT INTO Transactions (AccountID, TransactionType, Amount, ReferenceAccountID, Description)
    VALUES (@FromAccount, 'Transfer-Out', @Amount, @ToAccount, @Description),
           (@ToAccount, 'Transfer-In', @Amount, @FromAccount, @Description);

    -- Log transfer
    INSERT INTO AuditLog (ActionPerformed, PerformedBy, Details)
    VALUES ('Transfer', SYSTEM_USER, CONCAT('From: ', @FromAccount, ' To: ', @ToAccount, ' Amount: ', @Amount));

    COMMIT;
END;
