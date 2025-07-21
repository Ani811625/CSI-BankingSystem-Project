-- Create a new account for a customer with no transactions
DECLARE @CustomerID INT = (SELECT TOP 1 CustomerID FROM Customers ORDER BY NEWID());

EXEC OpenAccount @CustomerID = @CustomerID, @BranchID = 1, @AccountType = 'Savings';

-- Get the new AccountID
DECLARE @NewAccID INT = SCOPE_IDENTITY();

-- Try viewing transaction history
EXEC ViewTransactionHistory @AccountID = @NewAccID;
