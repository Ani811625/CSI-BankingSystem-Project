CREATE TABLE AccountFreezeRecords (
    FreezeID INT PRIMARY KEY IDENTITY(1,1),
    AccountID INT,
    Reason VARCHAR(255),
    FrozenOn DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);
