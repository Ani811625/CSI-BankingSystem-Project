-- Non-existent IDs
EXEC DepositMoney @AccountID = 99999, @Amount = 5000, @Description = 'Invalid Account Test';

EXEC OpenAccount @CustomerID = 88888, @BranchID = 1, @AccountType = 'Current';
