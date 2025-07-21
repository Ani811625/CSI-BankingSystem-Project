CREATE PROCEDURE ApplyForLoan
    @CustomerID INT,
    @AccountID INT,
    @LoanType VARCHAR(30),
    @Amount DECIMAL(18,2),
    @DurationMonths INT
AS
BEGIN
    DECLARE @InterestRate DECIMAL(5,2);

    -- Basic loan type interest policy
    SET @InterestRate = CASE 
        WHEN @LoanType = 'Home' THEN 7.5
        WHEN @LoanType = 'Education' THEN 5.0
        WHEN @LoanType = 'Personal' THEN 12.0
        ELSE 0
    END;

    IF @InterestRate = 0
    BEGIN
        RAISERROR('Invalid loan type.', 16, 1);
        RETURN;
    END

    INSERT INTO LoanApplications (CustomerID, AccountID, LoanType, AmountRequested, DurationMonths, InterestRate)
    VALUES (@CustomerID, @AccountID, @LoanType, @Amount, @DurationMonths, @InterestRate);

    INSERT INTO AuditLog (ActionPerformed, PerformedBy, Details)
    VALUES ('Loan Application Submitted', SYSTEM_USER, CONCAT('CustomerID: ', @CustomerID, ', Amount: ', @Amount));
END
