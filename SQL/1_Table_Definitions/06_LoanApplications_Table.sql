CREATE TABLE LoanApplications (
    LoanID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    AccountID INT,
    LoanType VARCHAR(30) CHECK (LoanType IN ('Home', 'Education', 'Personal')),
    AmountRequested DECIMAL(18,2),
    DurationMonths INT,
    InterestRate DECIMAL(5,2),
    Status VARCHAR(20) DEFAULT 'Pending',
    AppliedOn DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);
