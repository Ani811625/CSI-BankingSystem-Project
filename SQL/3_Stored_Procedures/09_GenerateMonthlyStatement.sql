CREATE PROCEDURE GenerateMonthlyStatement
    @AccountID INT
AS
BEGIN
    SELECT 
        TransactionID,
        TransactionType,
        Amount,
        FORMAT(TransactionDate, 'dd-MM-yyyy') AS TransactionDate,
        Description
    FROM Transactions
    WHERE AccountID = @AccountID
      AND TransactionDate >= DATEADD(MONTH, -1, GETDATE())
    ORDER BY TransactionDate DESC;
END
