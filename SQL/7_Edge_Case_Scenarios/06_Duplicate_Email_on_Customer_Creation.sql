-- Try to insert a customer with existing email
EXEC CreateCustomer 
    @FirstName = 'Test', 
    @LastName = 'Duplicate', 
    @Email = 'aniruddha.sarkar@gmail.com', 
    @Phone = '9999999999',
    @DateOfBirth = '2000-01-01',
    @Gender = 'M',
    @Address = 'Burdwan';
