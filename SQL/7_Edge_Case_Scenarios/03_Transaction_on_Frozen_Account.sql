-- Pick an account and freeze it first
DECLARE @FrozenAccount INT = (SELECT TOP 1 AccountID FROM Accounts WHERE Status = 'Active');

EXEC FreezeAccount @AccountID = @FrozenAccount, @Reason = 'Suspicious activity';

-- Try to deposit to this frozen account
EXEC DepositMoney @AccountID = @FrozenAccount, @Amount = 1000, @Description = 'Edge Case: Frozen Account Deposit';
