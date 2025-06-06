

-----HOMEWORK - 9

--1.Using Products, Suppliers table List all combinations of product names and supplier names.
1.
SELECT Products.ProductName, Suppliers.SupplierName
FROM Products
CROSS JOIN Suppliers

--2.Using Departments, Employees table Get all combinations of departments and employees.
2.
SELECT Departments.DepartmentName, Employees.Name
FROM Departments
CROSS JOIN Employees

--3.Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. 
			--Return supplier name and product name
3.
SELECT ProductName, SupplierName
FROM Products
INNER JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID

--4.Using Orders, Customers table List customer names and their orders ID.
4.
SELECT FirstName, LastName, OrderID
FROM Customers INNER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID

--5.Using Courses, Students table Get all combinations of students and courses.
5.
SELECT StudentID, Name, CourseName 
FROM Students CROSS JOIN Courses

--6.Using Products, Orders table Get product names and orders where product IDs match.
6.
SELECT ProductName, OrderID 
FROM Products INNER JOIN Orders 
ON Products.ProductID = Orders.ProductID

--7.Using Departments, Employees table List employees whose DepartmentID matches the department.
7.
SELECT Name, DepartmentName
FROM Departments INNER JOIN Employees 
ON Departments.DepartmentID = Employees.DepartmentID

--8.Using Students, Enrollments table List student names and their enrolled course IDs.
8.
SELECT Name, CourseID 
FROM Students INNER JOIN Enrollments 
ON Students.StudentID = Enrollments.StudentID

--9.Using Payments, Orders table List all orders that have matching payments.
9.
SELECT Payments.OrderID, Payments.PaymentID
FROM Payments INNER JOIN Orders 
ON Payments.OrderID = Orders.OrderID

--10.Using Orders, Products table Show orders where product price is more than 100.
10.
SELECT OrderID, Price
FROM Orders INNER JOIN Products 
ON Orders.ProductID = Products.ProductID
WHERE Price > 100

--11.Using Employees, Departments table List employee names and department names where department IDs are not equal. 
		---It means: Show all mismatched employee-department combinations.
11.
SELECT Name, DepartmentName
FROM Employees INNER JOIN Departments 
ON Employees.DepartmentID != Departments.DepartmentID

--12.Using Orders, Products table Show orders where ordered quantity is greater than stock quantity.
12.
SELECT OrderID, Quantity, StockQuantity
FROM Orders INNER JOIN Products 
ON Orders.ProductID = Products.ProductID
WHERE Quantity > StockQuantity

--13.Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.
13.
SELECT FirstName, LastName, ProductID
FROM Customers INNER JOIN Sales 
ON Customers.CustomerID = Sales.CustomerID
WHERE SaleAmount >= 500

--14.Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.
14.
SELECT Name, CourseName
FROM Enrollments	
INNER JOIN Students ON Students.StudentID = Enrollments.StudentID
INNER JOIN Courses ON Courses.CourseID = Enrollments.CourseID

--15.Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”.
15.
SELECT ProductName, SupplierName 
FROM Products INNER JOIN Suppliers 
ON Products.SupplierID = Suppliers.SupplierID
WHERE SupplierName LIKE '%Tech%'

--16.Using Orders, Payments table Show orders where payment amount is less than total amount.
16.
SELECT Orders.OrderID
FROM Orders INNER JOIN Payments 
ON Orders.OrderID = Payments.OrderID
WHERE Amount < TotalAmount

--17.Using Employees and Departments tables, get the Department Name for each employee.
17.
SELECT Name, DepartmentName
FROM Employees INNER JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID

--18.Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.
18.
SELECT ProductName, CategoryName 
FROM Products INNER JOIN Categories 
ON Products.Category = Categories.CategoryID
WHERE CategoryName LIKE 'Electronics' or CategoryName LIKE 'Furniture'

--19.Using Sales, Customers table Show all sales from customers who are from 'USA'.
19.
SELECT SaleID, Country
FROM Sales INNER JOIN Customers 
ON Sales.CustomerID = Customers.CustomerID
WHERE Country LIKE 'USA'

--20.Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.
20.
SELECT OrderID, Country, TotalAmount
FROM Orders INNER JOIN Customers 
ON Orders.CustomerID = Customers.CustomerID
WHERE Country LIKE 'Germany' and TotalAmount > 100

--21.Using Employees table List all pairs of employees from different departments.
21.
SELECT	emp.EmployeeID, 
		emp.Name, 
		dep.DepartmentID
FROM Employees AS emp JOIN Employees AS dep 
ON emp.EmployeeID < dep.EmployeeID
WHERE emp.DepartmentID != dep.DepartmentID

--22.Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price).
22.
SELECT Orders.OrderID, TotalAmount, Quantity, Price 
FROM Payments
	INNER JOIN Orders  ON Orders.OrderID = Payments.OrderID
	INNER JOIN Products ON Orders.ProductID = Products.ProductID
WHERE TotalAmount != (Quantity*Price)

--23.Using Students, Enrollments, Courses table Find students who are not enrolled in any course.
23.
SELECT  Name
FROM Students LEFT JOIN Enrollments 
ON Students.StudentID = Enrollments.StudentID
WHERE Enrollments.StudentID IS NULL

--24.Using Employees table List employees who are managers of someone, 
			---but their salary is less than or equal to the person they manage.
24.
SELECT  mang.Name, mang.Salary, emp.Name, emp.Salary
FROM Employees AS emp JOIN Employees AS mang 
ON emp.ManagerID = mang.EmployeeID
WHERE emp.Salary > = mang.Salary

--25.Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it.
25.
SELECT Customers.CustomerID, Customers.FirstName
FROM Customers 
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
LEFT JOIN Payments ON Orders.OrderID = Payments.OrderID
WHERE Payments.OrderID IS NULL;

