
1.Select top 5 * from Employees

2.Select Distinct Category from Products

3.Select * from Products 
Where Price > 100

4.Select * from Customers
Where FirstName Like 'A%'

5.Select * from Products
Order by Price Asc

6. Select * from Employees
Where Salary >= 60000 and Department = 'HR'

7.Select ISNULL (Email, 'noemail@example.com') Email from Employees

8.Select * from Products
Where Price Between 50 and 100

9.Select Distinct Category, ProductName from Products

10.Select Distinct Category, ProductName from Products
Order by Productname desc

11.Select top 10 * from Products
Order by Price desc

12.Select * ,Coalesce (FirstName, LastName) from Employees

13.Select Distinct Category, Price from Products

14.Select * from Employees
Where Age between 30 and 40 or Department='Marketing'

15.Select * from Employees
Order by Salary Desc
Offset 10 rows Fetch next 10 rows only;

16.Select * from Products
Where Price <= 1000 and Stock > 50
Order by Stock asc

17.Select * from Products
Where ProductName Like '%e%'

18.Select * from Employees
Where In ('HR', 'IT', 'Finance')

19.Select * from Customers
Order by City asc, PostalCode desc

20.Select top 5 * from Products
Order by SalesAmount desc

21.SELECT 
    FirstName,
    LastName,
    FirstName + ' ' + LastName AS FullName
FROM Employees;

22.Select Distinct Category, Productname, Price from Products
Where Price > 50

23. Select * From Products
Where Price < 0.10 * (Select AVG(Price) from Products)

24.Select * from Employees
Where Age < 30 and Department = 'HR' or Department = 'IT'

25.Select * from Customers
Where Email Like '%@gmail.com'

26.Select * from Employees
Where Salary > All (Select Salary from Employees Where Department = 'Sales')

27.SELECT *
FROM Orders
WHERE OrderDate BETWEEN 
      DATEADD(DAY, -180, (SELECT MAX(OrderDate) FROM Orders))
      AND (SELECT MAX(OrderDate) FROM Orders);






