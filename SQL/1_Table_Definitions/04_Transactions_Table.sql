CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY IDENTITY(1,1),
    AccountID INT,
    TransactionType VARCHAR(20) CHECK (TransactionType IN ('Deposit', 'Withdraw', 'Transfer-In', 'Transfer-Out')),
    Amount DECIMAL(18,2) CHECK (Amount > 0),
    TransactionDate DATETIME DEFAULT GETDATE(),
    ReferenceAccountID INT NULL, -- Used in Transfers
    Description VARCHAR(255),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);
