CREATE PROCEDURE FreezeAccount
    @AccountID INT,
    @Reason VARCHAR(255)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Accounts WHERE AccountID = @AccountID)
    BEGIN
        RAISERROR('Account does not exist.', 16, 1);
        RETURN;
    END

    UPDATE Accounts SET Status = 'Frozen' WHERE AccountID = @AccountID;

    INSERT INTO AccountFreezeRecords (AccountID, Reason)
    VALUES (@AccountID, @Reason);

    INSERT INTO AuditLog (ActionPerformed, PerformedBy, Details)
    VALUES ('Account Frozen', SYSTEM_USER, CONCAT('AccountID: ', @AccountID, ', Reason: ', @Reason));
END
