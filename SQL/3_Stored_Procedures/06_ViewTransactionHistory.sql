CREATE PROCEDURE ViewTransactionHistory
    @AccountID INT
AS
BEGIN
    SELECT TOP 100 TransactionID, TransactionType, Amount, TransactionDate, ReferenceAccountID, Description
    FROM Transactions
    WHERE AccountID = @AccountID
    ORDER BY TransactionDate DESC;
END
