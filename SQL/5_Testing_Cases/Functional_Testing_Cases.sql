-- TEST CASE 1: Create a valid customer
EXEC CreateCustomer 
    @FirstName = 'Ritwik', 
    @LastName = 'Chatterjee', 
    @Email = 'ritwik.c@gmail.com', 
    @Phone = '9876501234', 
    @DateOfBirth = '1996-04-21',
    @Gender = 'M',
    @Address = 'Salt Lake, Kolkata';

-- TEST CASE 2: Open a new savings account for customer
EXEC OpenAccount 
    @CustomerID = 1001, 
    @BranchID = 2, 
    @AccountType = 'Savings';

-- TEST CASE 3: Deposit ?5000 to account
EXEC DepositMoney 
    @AccountID = 5001, 
    @Amount = 5000, 
    @Description = 'First deposit';

-- TEST CASE 4: Withdraw ?1000 from the same account
EXEC WithdrawMoney 
    @AccountID = 5001, 
    @Amount = 1000, 
    @Description = 'ATM withdrawal';

-- TEST CASE 5: Transfer ?1500 from one valid account to another
EXEC TransferMoney 
    @FromAccount = 5001, 
    @ToAccount = 5002, 
    @Amount = 1500, 
    @Description = 'Peer-to-peer transfer';

-- TEST CASE 6: View transaction history for an active account
EXEC ViewTransactionHistory @AccountID = 5001;

-- TEST CASE 7: Apply for a loan for valid customer and account
EXEC ApplyForLoan 
    @CustomerID = 1001, 
    @AccountID = 5001, 
    @LoanType = 'Personal', 
    @Amount = 200000, 
    @DurationMonths = 24;

-- TEST CASE 8: Generate monthly statement
EXEC GenerateMonthlyStatement @AccountID = 5001;

-- TEST CASE 9: Get analytics/summary for account
EXEC GetAccountInsights @AccountID = 5001;
