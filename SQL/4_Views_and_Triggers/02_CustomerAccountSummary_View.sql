CREATE VIEW CustomerAccountSummary AS
SELECT 
    c.CustomerID,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    a.AccountID,
    a.AccountType,
    a.Balance,
    a.Status,
    b.BranchName,
    b.City
FROM Customers c
JOIN Accounts a ON c.CustomerID = a.CustomerID
JOIN Branches b ON a.BranchID = b.BranchID;
