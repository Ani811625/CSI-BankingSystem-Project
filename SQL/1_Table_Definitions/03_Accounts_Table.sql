CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY IDENTITY(5000,1),
    CustomerID INT,
    BranchID INT,
    AccountType VARCHAR(20) CHECK (AccountType IN ('Savings', 'Current', 'Salary')),
    Balance DECIMAL(18,2) DEFAULT 0.00 CHECK (Balance >= 0),
    Status VARCHAR(20) DEFAULT 'Active' CHECK (Status IN ('Active', 'Frozen', 'Closed')),
    OpenedOn DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);
