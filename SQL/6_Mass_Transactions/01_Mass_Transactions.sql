DECLARE @i INT = 1;
DECLARE @accID INT;
DECLARE @type VARCHAR(20);
DECLARE @amount DECIMAL(18,2);
DECLARE @randomDate DATETIME;

WHILE @i <= 3000
BEGIN
    -- Get a random AccountID between 5000 and 5199
    SET @accID = 5000 + ABS(CHECKSUM(NEWID())) % 200;

    -- Randomly choose Deposit or Withdraw
    SET @type = CASE 
        WHEN RAND() < 0.5 THEN 'Deposit'
        ELSE 'Withdraw'
    END;

    -- Generate random amount between ?100 to ?10,000
    SET @amount = ROUND(RAND() * 9900 + 100, 2);

    -- Generate random transaction date in the last 180 days (~6 months)
    SET @randomDate = DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 180), GETDATE());

    -- Perform transaction
    IF @type = 'Deposit'
    BEGIN
        -- Insert Deposit transaction with random date
        INSERT INTO Transactions (AccountID, TransactionType, Amount, TransactionDate, Description)
        VALUES (@accID, 'Deposit', @amount, @randomDate, 'Auto-Generated Deposit');

        -- Update account balance
        UPDATE Accounts SET Balance = Balance + @amount WHERE AccountID = @accID;
    END
    ELSE
    BEGIN
        -- Withdraw only if balance is sufficient
        IF EXISTS (
            SELECT 1 FROM Accounts 
            WHERE AccountID = @accID AND Balance >= @amount
        )
        BEGIN
            -- Insert Withdraw transaction with random date
            INSERT INTO Transactions (AccountID, TransactionType, Amount, TransactionDate, Description)
            VALUES (@accID, 'Withdraw', @amount, @randomDate, 'Auto-Generated Withdrawal');

            -- Deduct balance
            UPDATE Accounts SET Balance = Balance - @amount WHERE AccountID = @accID;
        END
        -- Else skip withdrawal silently
    END

    SET @i = @i + 1;
END

SELECT * FROM Transactions;