-- Create new account, add only deposits
DECLARE @DepAcc INT;
EXEC OpenAccount @CustomerID = 1000, @BranchID = 1, @AccountType = 'Salary';
SET @DepAcc = SCOPE_IDENTITY();

EXEC DepositMoney @AccountID = @DepAcc, @Amount = 8000, @Description = 'Edge Test Deposit';

EXEC GenerateMonthlyStatement @AccountID = @DepAcc;
