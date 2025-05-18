
1.SELECT top 5 * from Employees

2.SELECT Distinct Category from Products

3.SELECT * from Products 
Where Price > 100

4.SELECT * from Customers
Where FirstName Like 'A%'

5.SELECT * from Products
Order by Price Asc

6. SELECT * from Employees
Where Salary >= 60000 and Department = 'HR'

7.SELECT ISNULL (Email, 'noemail@example.com') Email from Employees

8.SELECT * from Products
Where Price Between 50 and 100

9.SELECT Distinct Category, ProductName from Products

10.SELECT Distinct Category, ProductName from Products
Order by Productname desc

11.SELECT top 10 * from Products
Order by Price desc

12.SELECT * ,Coalesce (FirstName, LastName) from Employees

13.SELECT Distinct Category, Price from Products

14.SELECT * from Employees
Where Age between 30 and 40 or Department='Marketing'

15.SELECT * from Employees
Order by Salary Desc
Offset 10 rows Fetch next 10 rows only;

16.SELECT * from Products
Where Price <= 1000 and Stock > 50
Order by Stock asc

17.SELECT * from Products
Where ProductName Like '%e%'

18.SELECT * from Employees
Where Department In ('HR', 'IT', 'Finance')

19.SELECT * from Customers
Order by City asc, PostalCode desc

20.SELECT top 5 * from Products
Order by SalesAmount desc

21.SELECT 
    FirstName,
    LastName,
    FirstName + ' ' + LastName AS FullName
FROM Employees;

22.SELECT Distinct Category, Productname, Price from Products
Where Price > 50

23. SELECT * From Products
Where Price < 0.10 * (SELECT AVG(Price) from Products)

24.SELECT * from Employees
Where Age < 30 and Department = 'HR' or Department = 'IT'

25.SELECT * from Customers
Where Email Like '%@gmail.com'

26.SELECT * from Employees
Where Salary > All (SELECT Salary from Employees Where Department = 'Sales')

27.SELECT *
FROM Orders
WHERE OrderDate BETWEEN 
      DATEADD(DAY, -180, (SELECT MAX(OrderDate) FROM Orders))
      AND (SELECT MAX(OrderDate) FROM Orders);





