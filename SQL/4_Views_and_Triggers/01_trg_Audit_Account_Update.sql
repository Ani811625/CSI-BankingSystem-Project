CREATE TRIGGER trg_Audit_Account_Update
ON Accounts
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditLog (ActionPerformed, PerformedBy, Details)
    SELECT 
        'Account Updated', 
        SYSTEM_USER, 
        CONCAT('AccountID: ', i.AccountID, ', Old Balance: ', d.Balance, ', New Balance: ', i.Balance)
    FROM inserted i
    JOIN deleted d ON i.AccountID = d.AccountID;
END
