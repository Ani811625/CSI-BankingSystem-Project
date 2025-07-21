-- Get any AccountID with low balance
DECLARE @TestAccountID INT = (SELECT TOP 1 AccountID FROM Accounts WHERE Balance < 500);

-- Try to withdraw ?10,000 from that account
EXEC WithdrawMoney @AccountID = @TestAccountID, @Amount = 10000, @Description = 'Edge Case: Overdraft Test';
