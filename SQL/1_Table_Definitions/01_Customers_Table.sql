CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1000,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) CHECK (LEN(Phone) BETWEEN 10 AND 15),
    DateOfBirth DATE,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F', 'O')),
    Address VARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE()
);
