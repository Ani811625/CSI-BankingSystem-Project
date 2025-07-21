CREATE PROCEDURE GetAccountInsights
    @AccountID INT
AS
BEGIN
    SELECT 
        COUNT(*) AS TotalTransactions,
        SUM(CASE WHEN TransactionType = 'Deposit' THEN Amount ELSE 0 END) AS TotalDeposits,
        SUM(CASE WHEN TransactionType = 'Withdraw' THEN Amount ELSE 0 END) AS TotalWithdrawals,
        MAX(Amount) AS MaxTransaction,
        MIN(Amount) AS MinTransaction
    FROM Transactions
    WHERE AccountID = @AccountID;
END
