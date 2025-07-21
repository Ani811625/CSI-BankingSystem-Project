CREATE VIEW LoanStatisticsView AS
SELECT 
    LoanType,
    COUNT(*) AS TotalApplications,
    AVG(AmountRequested) AS AvgLoanAmount,
    AVG(InterestRate) AS AvgInterestRate
FROM LoanApplications
GROUP BY LoanType;
