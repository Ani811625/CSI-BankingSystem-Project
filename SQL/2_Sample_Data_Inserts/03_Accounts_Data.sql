DECLARE @i INT = 1;
WHILE @i <= 200
BEGIN
    INSERT INTO Accounts (CustomerID, BranchID, AccountType, Balance)
    VALUES (
        1000 + ABS(CHECKSUM(NEWID())) % 50,         -- 1000 to 1049
        1 + ABS(CHECKSUM(NEWID())) % 10,            -- BranchID 1 to 10
        CASE ABS(CHECKSUM(NEWID())) % 3
            WHEN 0 THEN 'Savings'
            WHEN 1 THEN 'Current'
            ELSE 'Salary'
        END,
        CAST(RAND() * 100000 AS DECIMAL(18,2))     -- Balance from 0 to 1 lakh
    );

    SET @i = @i + 1;
END

SELECT * FROM Accounts;