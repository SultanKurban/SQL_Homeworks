
-----HOMEWORK 11 --

/*
1.Return: OrderID, CustomerName, OrderDate
Task: Show all orders placed after 2022 along with the names of the customers who placed them.
Tables Used: Orders, Customers
*/

SELECT OrderID, CONCAT (FirstName, + '', + LastName) AS CustomerName, OrderDate 
FROM Customers INNER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID
WHERE YEAR(OrderDate) > 2022

/*
2.Return: EmployeeName, DepartmentName
Task: Display the names of employees who work in either the Sales or Marketing department.
Tables Used: Employees, Departments
*/

SELECT Name AS EmployeeName, DepartmentName 
FROM Employees INNER JOIN Departments 
ON Employees.DepartmentID = Departments.DepartmentID
WHERE DepartmentName LIKE 'Sales' or DepartmentName LIKE 'Marketing' 

/*
3.Return: DepartmentName, MaxSalary
Task: Show the highest salary for each department.
Tables Used: Departments, Employees
*/

SELECT DepartmentName, MAX(Salary) AS MaxSalary  
FROM Employees INNER JOIN Departments 
ON Employees.DepartmentID = Departments.DepartmentID
GROUP BY DepartmentName

/*
4.Return: CustomerName, OrderID, OrderDate
Task: List all customers from the USA who placed orders in the year 2023.
Tables Used: Customers, Orders
*/

SELECT CONCAT(FirstName, +'',+LastName) AS CustomerName, OrderID, OrderDate 
FROM Customers INNER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID
WHERE Country LIKE 'USA' and YEAR(OrderDate) = 2023

/*
5.Return: CustomerName, TotalOrders
Task: Show how many orders each customer has placed.
Tables Used: Orders , Customers
*/
 
SELECT CONCAT(FirstName, + '',+ LastName) AS CustomerName, COUNT(OrderID) AS TotalOrders 
FROM Customers INNER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID
GROUP BY CONCAT(FirstName, + '',+ LastName)
/*
6.Return: ProductName, SupplierName
Task: Display the names of products that are supplied by either Gadget Supplies or Clothing Mart.
Tables Used: Products, Suppliers
*/

SELECT ProductName, SupplierName
FROM Products INNER JOIN Suppliers 
ON Products.SupplierID = Suppliers.SupplierID
WHERE SupplierName LIKE 'Gadget Supplies' or SupplierName LIKE 'Clothing Mart'

/*
7.Return: CustomerName, MostRecentOrderDate
Task: For each customer, show their most recent order. Include customers who haven't placed any orders.
Tables Used: Customers, Orders
*/

SELECT CONCAT(FirstName, + '',+LastName) AS CustomerName, MAX(OrderDate) AS MostRecentOrderDate
FROM Customers FULL JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Orders.CustomerID, CONCAT(FirstName, + '',+LastName)

/*
8.Return: CustomerName, OrderTotal
Task: Show the customers who have placed an order where the total amount is greater than 500.
Tables Used: Orders, Customers
*/

SELECT CONCAT(FirstName,+'',+LastName) AS CustomerName, TotalAmount AS OrderTotal 
FROM Customers INNER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID
WHERE TotalAmount > 500

/*
9.Return: ProductName, SaleDate, SaleAmount
Task: List product sales where the sale was made in 2022 or the sale amount exceeded 400.
Tables Used: Products, Sales
*/

SELECT ProductName, SaleDate, SaleAmount 
FROM Products INNER JOIN Sales 
ON Products.ProductID = Sales.ProductID
WHERE YEAR(SaleDate) = 2022 or SaleAmount > 400

/*
10.Return: ProductName, TotalSalesAmount
Task: Display each product along with the total amount it has been sold for.
Tables Used: Sales, Products
*/

SELECT ProductName, SUM(Products.ProductID * Price) AS TotalSalesAmount
FROM Products INNER JOIN Sales 
ON Products.ProductID = Sales.ProductID
GROUP BY ProductName
/*
11.Return: EmployeeName, DepartmentName, Salary
Task: Show the employees who work in the HR department and earn a salary greater than 60000.
Tables Used: Employees, Departments
*/

SELECT Name AS EmployeeName, DepartmentName, Salary 
FROM Employees INNER JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID
WHERE DepartmentName LIKE 'Human Resources' and Salary > 60000

/*
12.Return: ProductName, SaleDate, StockQuantity
Task: List the products that were sold in 2023 and had more than 100 units in stock at the time.
Tables Used: Products, Sales
*/

SELECT ProductName, SaleDate, StockQuantity 
FROM Products INNER JOIN Sales 
ON Products.ProductID = Sales.ProductID
WHERE YEAR(SaleDate) = 2023 and StockQuantity > 100

/*
13.Return: EmployeeName, DepartmentName, HireDate
Task: Show employees who either work in the Sales department or were hired after 2020.
Tables Used: Employees, Departments
*/

SELECT Name AS EmployeeName, DepartmentName, HireDate 
FROM Employees INNER JOIN Departments 
ON Employees.DepartmentID = Departments.DepartmentID
WHERE DepartmentName LIKE 'Sales' and YEAR(HireDate) > 2020

/*
14.Return: CustomerName, OrderID, Address, OrderDate
Task: List all orders made by customers in the USA whose address starts with 4 digits.
Tables Used: Customers, Orders
*/

SELECT CONCAT(FirstName, + '', +LastName) AS CustomerName, OrderID, Address, OrderDate, Country 
FROM Customers INNER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID
WHERE Country LIKE 'USA' and Address LIKE '4%'

/*
15.Return: ProductName, Category, SaleAmount
Task: Display product sales for items in the Electronics category or where the sale amount exceeded 350.
Tables Used: Products, Sales
*/

SELECT * FROM Products	INNER JOIN Sales ON Products.ProductID = Sales.ProductID
						FULL JOIN Categories ON Products.Category = Categories.CategoryID
WHERE CategoryName LIKE 'Electronics' or SaleAmount > 350
/*
16.Return: CategoryName, ProductCount
Task: Show the number of products available in each category.
Tables Used: Products, Categories
*/

SELECT COALESCE(CategoryName, 'Unknown') CategoryName, COUNT(ProductID) AS ProductCount 
FROM Categories FULL JOIN Products 
ON Categories.CategoryID = Products.Category
GROUP BY CategoryName

/*
17.Return: CustomerName, City, OrderID, Amount
Task: List orders where the customer is from Los Angeles and the order amount is greater than 300.
Tables Used: Customers, Orders
*/

SELECT CONCAT(FirstName,+ '', +LastName) AS CustomerName, City, OrderID, TotalAmount AS Amount 
FROM Customers FULL JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID
WHERE City LIKE 'Los Angeles' and TotalAmount > 300

/*
18.Return: EmployeeName, DepartmentName
Task: Display employees who are in the HR or Finance department, or whose name contains at least 4 vowels.
Tables Used: Employees, Departments
*/

SELECT * FROM Employees FULL JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
WHERE DepartmentName LIKE 'Human Resources' or DepartmentName LIKE 'Finance' or Name LIKE '____'

/*
19.Return: EmployeeName, DepartmentName, Salary
Task: Show employees who are in the Sales or Marketing department and have a salary above 60000.
Tables Used: Employees, Departments
*/

SELECT Name AS EmployeeName, DepartmentName, Salary 
FROM Employees FULL JOIN Departments 
ON Employees.DepartmentID = Departments.DepartmentID
WHERE DepartmentName LIKE 'Sales' or DepartmentName LIKE 'Marketing' and Salary > 60000
