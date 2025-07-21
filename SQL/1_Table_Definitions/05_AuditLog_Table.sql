CREATE TABLE AuditLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    ActionPerformed VARCHAR(100),
    PerformedBy VARCHAR(50),
    Details VARCHAR(255),
    ActionTime DATETIME DEFAULT GETDATE()
);
