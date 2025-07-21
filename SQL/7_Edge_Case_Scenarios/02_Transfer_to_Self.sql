-- Get any valid AccountID
DECLARE @SameAccID INT = (SELECT TOP 1 AccountID FROM Accounts);

-- Attempt to transfer to the same account
EXEC TransferMoney 
    @FromAccount = @SameAccID, 
    @ToAccount = @SameAccID, 
    @Amount = 500,
    @Description = 'Edge Case: Transfer to Self';
