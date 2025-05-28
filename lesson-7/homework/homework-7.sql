---HOMEWORK-7

--1.Write a query to find the minimum (MIN) price of a product in the Products table.

--SELECT * from Products
1.
SELECT MIN(Price) from Products

--2.Write a query to find the maximum (MAX) Salary from the Employees table.
--SELECT * FROM Employees
2.
SELECT MAX(Salary) from Employees

--3.Write a query to count the number of rows in the Customers table.
--SELECT * FROM Customers
3.
SELECT COUNT(CustomerID) FROM Customers

--4.Write a query to count the number of unique product categories from the Products table.
--SELECT * FROM Products
4.
SELECT COUNT(DISTINCT Category) FROM Products

--SELECT DISTINCT Category FROM Products

--5.Write a query to find the total sales amount for the product with id 7 in the Sales table.
--SELECT * FROM Sales
5.
SELECT SUM(SaleAmount) AS Total_sales_amout
FROM Sales
WHERE ProductID=7

--6.Write a query to calculate the average age of employees in the Employees table.
--SELECT * FROM Employees
6.
SELECT AVG(Age) FROM Employees

--7.Write a query to count the number of employees in each department.
--SELECT * FROM Employees
7.
SELECT COUNT(*) AS NumberEmp, DepartmentName
FROM Employees
GROUP BY DepartmentName

--8.Write a query to show the minimum and maximum Price of products grouped by Category. Use products table.
--SELECT * FROM Products
8.
SELECT Category, MIN(Price) AS Minimum, MAX(Price) AS Maximum 
FROM Products
GROUP BY Category

--9.Write a query to calculate the total sales per Customer in the Sales table.
--SELECT * FROM Sales
9.
SELECT CustomerID, SUM(SaleAmount) AS Total_Sales
FROM Sales
GROUP BY CustomerID

--10.Write a query to filter departments having more than 5 employees from the Employees table.
------(DeptID is enough, if you don't have DeptName).
--SELECT * FROM Employees
10.
SELECT DepartmentName AS DepID--, COUNT(*)AS Num_emp 
FROM Employees
GROUP BY DepartmentName
HAVING COUNT(*) >5

--11.Write a query to calculate the total sales and average sales for each product category from the Sales table.
---SELECT * FROM Sales
11.
SELECT CustomerID, SUM(SaleAmount) AS Total_sales, AVG(SaleAmount) AS Average_sales
FROM Sales
GROUP BY CustomerID

--12.Write a query to count the number of employees from the Department HR.
--SELECT * FROM Employees
12.
SELECT COUNT(DepartmentName) AS NumberEmpHR 
FROM Employees
WHERE DepartmentName = 'HR'

--13.Write a query that finds the highest and lowest Salary by department in the Employees table.
---------(DeptID is enough, if you don't have DeptName).
--SELECT * FROM Employees
13.
SELECT DepartmentName AS DeptID, MAX(Salary) AS HighestSalary, MIN(Salary) AS LowestSalary 
FROM Employees
GROUP BY DepartmentName 

--14.Write a query to calculate the average salary per Department.
-------(DeptID is enough, if you don't have DeptName).
--SELECT * FROM Employees
14.
SELECT DepartmentName AS DeptName, AVG(Salary) AS AvgSalary 
FROM Employees
GROUP BY DepartmentName

--15.Write a query to show the AVG salary and COUNT(*) of employees working in each department.
-----(DeptID is enough, if you don't have DeptName).
---SELECT * FROM Employees
15.
SELECT DepartmentName AS DeptID, AVG(Salary) AS AvgSalary, COUNT(*) AS NumberEmp 
FROM Employees
GROUP BY DepartmentName

--16.Write a query to filter product categories with an average price greater than 400.
--SELECT * FROM Products
16.
SELECT Category, AVG(Price) AS Avg_Price
FROM Products
GROUP BY Category
HAVING AVG(Price)>400


--17.Write a query that calculates the total sales for each year in the Sales table.
/*
INSERT INTO Sales
VAlUES (41,4,5,'2024-01-04', 500)
*/

--SELECT * FROM Sales
17.
SELECT YEAR(SaleDate) As SaleYear, SUM(SaleAmount) AS Total_sales
FROM Sales
GROUP BY YEAR(SaleDate)
ORDER BY SaleYear;

--18.Write a query to show the list of customers who placed at least 3 orders.
--SELECT * FROM Orders
18.
SELECT DISTINCT CustomerID, SUM(Quantity) AS Total_quantity
FROM Orders
GROUP BY CustomerID, Quantity
HAVING Quantity>=3

--19.Write a query to filter out Departments with average salary expenses greater than 60000.
-----(DeptID is enough, if you don't have DeptName).
---SELECT * FROM Employees
19.
SELECT DISTINCT DepartmentName, AVG(Salary) AS AVG_Salary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 60000

---20.Write a query that shows the average price for each product category, 
		---and then filter categories with an average price greater than 150.
---SELECT * FROM Products
20.
SELECT DISTINCT Category, AVG(Price) AS AVG_Price
FROM Products
GROUP BY Category
HAVING AVG(Price)>150

---21.Write a query to calculate the total sales for each Customer, 
		---then filter the results to include only Customers with total sales over 1500.
--SELECT * FROM Sales
21.
SELECT DISTINCT CustomerID, SUM(SaleAmount) AS Total_Sales
FROM Sales
GROUP BY CustomerID
HAVING SUM(SaleAmount)>1500

---22.Write a query to find the total and average salary of employees in each department, 
		---and filter the output to include only departments with an average salary greater than 65000.
---SELECT * FROM Employees
22.
SELECT DISTINCT DepartmentName, COUNT(DepartmentName) AS Total_emp, AVG(Salary) AS AVG_SAlary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary)>65000

---23.Write a query to find total amount for the orders which weights more than $50 for each customer 
		---along with their least purchases.(least amount might be lower than 50, 
			---use tsql2012.sales.orders table,freight col, ask ur assistant to give the TSQL2012 database).
--SELECT * FROM tsql2012.sales.orders
23.
SELECT SUM(freight) AS Total_amt_frgt
FROM tsql2012.sales.orders
GROUP BY freight 
HAVING SUM(freight)>50

---24.Write a query that calculates the total sales and counts unique products sold in each month of each year, 
		---and then filter the months with at least 2 products sold.(Orders)
---SELECT * FROM Orders
24.
SELECT DISTINCT ProductID, SUM(TotalAmount) AS Total_Sales, YEAR(OrderDate) AS In_year, MONTH(OrderDate) AS In_month, Quantity AS Prod_sold
FROM Orders
GROUP BY ProductID, YEAR(OrderDate), MONTH(OrderDate), Quantity
HAVING Quantity>=2
ORDER BY ProductID, YEAR(OrderDate), MONTH(OrderDate)

---25.Write a query to find the MIN and MAX order quantity per Year. From orders table. 
---SELECT * FROM Orders
25.
SELECT DISTINCT YEAR(OrderDate) AS Order_year, MIN(Quantity) AS Min_Quantity, MAX(Quantity) AS Max_Quantity
FROM Orders
GROUP BY YEAR(OrderDate)



