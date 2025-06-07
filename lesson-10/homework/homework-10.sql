
-----HOMEWORK 10  ----

--1.Using the Employees and Departments tables, write a query to return the names and salaries of employees 
	--whose salary is greater than 50000, along with their department names.
		--🔁 Expected Columns: EmployeeName, Salary, DepartmentName

SELECT Name AS EmployeeName, Salary, DepartmentName
FROM Employees INNER JOIN Departments 
ON Employees.DepartmentID = Departments.DepartmentID
WHERE Salary > 50000

--2.Using the Customers and Orders tables, write a query to display customer names and order dates for orders placed in the year 2023.
		--🔁 Expected Columns: FirstName, LastName, OrderDate

SELECT FirstName, LastName, OrderDate
FROM Customers INNER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID
WHERE YEAR(OrderDate) = 2023 

--3.Using the Employees and Departments tables, write a query to show all employees along with their department names. 
	--Include employees who do not belong to any department.
		--🔁 Expected Columns: EmployeeName, DepartmentName

SELECT Name AS EmployeeName, DepartmentName 
FROM Employees FULL JOIN Departments 
ON Employees.DepartmentID = Departments.DepartmentID

--4.Using the Products and Suppliers tables, write a query to list all suppliers and the products they supply. 
	--Show suppliers even if they don’t supply any product.
		--🔁 Expected Columns: SupplierName, ProductName

SELECT SupplierName, ProductName 
FROM Products FULL JOIN Suppliers 
ON Products.SupplierID = Suppliers.SupplierID

--5.Using the Orders and Payments tables, write a query to return all orders and their corresponding payments. 
	--Include orders without payments and payments not linked to any order.
		--🔁 Expected Columns: OrderID, OrderDate, PaymentDate, Amount

SELECT Orders.OrderID, OrderDate, PaymentDate, Amount 
FROM Orders FULL JOIN Payments 
ON Orders.OrderID = Payments.OrderID

--6.Using the Employees table, write a query to show each employee's name along with the name of their manager.
		--🔁 Expected Columns: EmployeeName, ManagerName

SELECT man.Name As EmployeeName, emp.Name As ManagerName
FROM Employees AS emp JOIN Employees AS man 
ON emp.EmployeeID = man.ManagerID

--7.Using the Students, Courses, and Enrollments tables, write a query to list the names of students 
	--who are enrolled in the course named 'Math 101'.
		--🔁 Expected Columns: StudentName, CourseName

SELECT Name AS StudentName, CourseName
FROM Enrollments	
INNER JOIN Students ON Enrollments.StudentID = Students.StudentID
INNER JOIN Courses ON Enrollments.CourseID = Courses.CourseID
WHERE CourseName LIKE 'Math 101'

--8.Using the Customers and Orders tables, write a query to find customers who have placed an order with more than 3 items. 
	--Return their name and the quantity they ordered.
		--🔁 Expected Columns: FirstName, LastName, Quantity

SELECT FirstName, LastName, Quantity
FROM Customers INNER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID
WHERE Quantity > 3

--9.Using the Employees and Departments tables, write a query to list employees working in the 'Human Resources' department.
		--🔁 Expected Columns: EmployeeName, DepartmentName

SELECT Name AS EmployeeName, DepartmentName
FROM Employees INNER JOIN Departments 
ON Employees.DepartmentID = Departments.DepartmentID
WHERE DepartmentName LIKE 'Human Resources'

--10.Using the Employees and Departments tables, write a query to return department names that have more than 5 employees.
		--🔁 Expected Columns: DepartmentName, EmployeeCount

SELECT DepartmentName, COUNT(Employees.DepartmentID) AS EmployeeCount 
FROM Departments INNER JOIN Employees 
ON Departments.DepartmentID = Employees.DepartmentID
GROUP BY  DepartmentName 
HAVING COUNT(Employees.DepartmentID) > 5

--11.Using the Products and Sales tables, write a query to find products that have never been sold.
		--🔁 Expected Columns: ProductID, ProductName

SELECT Products.ProductID, ProductName 
FROM Products LEFT JOIN Sales 
ON Products.ProductID = Sales.ProductID
WHERE Sales.ProductID IS NULL

--12.Using the Customers and Orders tables, write a query to return customer names who have placed at least one order.
		--🔁 Expected Columns: FirstName, LastName, TotalOrders

SELECT FirstName, LastName, Quantity AS TotalOrders 
FROM Customers INNER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID
WHERE Quantity >= 1

--13.Using the Employees and Departments tables, write a query to show only those records 
	--where both employee and department exist (no NULLs).
		--🔁 Expected Columns: EmployeeName, DepartmentName

SELECT * FROM Employees FULL JOIN Departments 
ON Employees.DepartmentID = Departments.DepartmentID
WHERE Departments.DepartmentName IS NOT NULL

--14.Using the Employees table, write a query to find pairs of employees who report to the same manager.
		--🔁 Expected Columns: Employee1, Employee2, ManagerID

SELECT emp.Name AS Employee1, man.Name AS Employee2, emp.ManagerID 
FROM Employees AS emp 
		INNER JOIN Employees AS man ON emp.ManagerID = man.ManagerID
									AND emp.EmployeeID < man.EmployeeID

--15.Using the Orders and Customers tables, write a query to list all orders placed in 2022 along with the customer name.
		--🔁 Expected Columns: OrderID, OrderDate, FirstName, LastName

SELECT OrderID, OrderDate, FirstName, LastName
FROM Orders INNER JOIN Customers 
ON Orders.CustomerID = Customers.CustomerID
WHERE YEAR(OrderDate) = 2022

--16.Using the Employees and Departments tables, write a query to return employees from the 'Sales' department 
	--whose salary is above 60000.
		--🔁 Expected Columns: EmployeeName, Salary, DepartmentName

SELECT Name AS EmployeeName, Salary, DepartmentName 
FROM Employees INNER JOIN Departments 
ON Employees.DepartmentID = Departments.DepartmentID
WHERE DepartmentName LIKE 'Sales' AND Salary > 60000

--17.Using the Orders and Payments tables, write a query to return only those orders that have a corresponding payment.
		--🔁 Expected Columns: OrderID, OrderDate, PaymentDate, Amount

SELECT Orders.OrderID, OrderDate, PaymentDate, Amount 
FROM Orders INNER JOIN Payments 
ON Orders.OrderID = Payments.OrderID

--18.Using the Products and Orders tables, write a query to find products that were never ordered.
		--🔁 Expected Columns: ProductID, ProductName

SELECT Products.ProductID, ProductName
FROM Products LEFT JOIN Orders 
ON Products.ProductID = Orders.ProductID
WHERE Orders.CustomerID IS NULL

--19.Using the Employees table, write a query to find employees whose salary is greater than the average salary in their own departments.
		--🔁 Expected Columns: EmployeeName, Salary

SELECT Name AS EmpoyeeName, Salary
FROM Employees AS emp1 
INNER JOIN (
		SELECT DepartmentID, AVG(Salary) AS AVG_salary
		FROM Employees
		GROUP BY DepartmentID
		)emp2 
ON emp1.DepartmentID = emp2.DepartmentID
WHERE emp1.Salary > emp2.AVG_salary


--20.Using the Orders and Payments tables, write a query to list all orders placed before 2020 that have no corresponding payment.
		--🔁 Expected Columns: OrderID, OrderDate

SELECT Orders.OrderID, Orders.OrderDate
FROM Orders LEFT JOIN Payments 
ON Orders.OrderID = Payments.OrderID
WHERE Payments.OrderID IS NULL 
AND YEAR(OrderDate) < 2020

--21.Using the Products and Categories tables, write a query to return products that do not have a matching category.
		--🔁 Expected Columns: ProductID, ProductName

SELECT ProductID, ProductName
FROM Products LEFT JOIN Categories 
ON Products.Category = Categories.CategoryID
WHERE Categories.CategoryID IS NULL

--22.Using the Employees table, write a query to find employees who report to the same manager and earn more than 60000.
		--🔁 Expected Columns: Employee1, Employee2, ManagerID, Salary

SELECT emp.Name AS Employee1, man.Name AS Employee2, emp.ManagerID, emp.Salary
FROM Employees AS emp 
		INNER JOIN Employees AS man ON emp.ManagerID = man.ManagerID
									AND emp.EmployeeID < man.EmployeeID
WHERE emp.Salary > 60000

--23.Using the Employees and Departments tables, write a query to return employees who work in departments 
	--which name starts with the letter 'M'.
		--🔁 Expected Columns: EmployeeName, DepartmentName

SELECT Name AS EmployeeName, DepartmentName 
FROM Employees INNER JOIN Departments 
ON Employees.DepartmentID = Departments.DepartmentID
WHERE DepartmentName LIKE 'M%'

--24.Using the Products and Sales tables, write a query to list sales where the amount is greater than 500, 
	--including product names.
		--🔁 Expected Columns: SaleID, ProductName, SaleAmount

SELECT SaleID, ProductName, SaleAmount 
FROM Products INNER JOIN Sales 
ON Products.ProductID = Sales.ProductID
WHERE SaleAmount > 500

--25.Using the Students, Courses, and Enrollments tables, write a query to find students who have not enrolled in the course 'Math 101'.
		--🔁 Expected Columns: StudentID, StudentName

SELECT Students.StudentID, Name AS StudentName 
FROM Enrollments 
		FULL JOIN Courses ON Enrollments.CourseID = Courses.CourseID
		FULL JOIN Students ON Enrollments.StudentID = Students.StudentID
WHERE Courses.CourseName NOT LIKE 'Math 101' or Courses.CourseName IS NULL			

--26.Using the Orders and Payments tables, write a query to return orders that are missing payment details.
		--🔁 Expected Columns: OrderID, OrderDate, PaymentID

SELECT Orders.OrderID, Orders.OrderDate, PaymentID
FROM Orders LEFT JOIN Payments 
ON Orders.OrderID = Payments.OrderID
WHERE Payments.OrderID IS NULL

--27.Using the Products and Categories tables, write a query to list products 
	--that belong to either the 'Electronics' or 'Furniture' category.
		--🔁 Expected Columns: ProductID, ProductName, CategoryName

SELECT ProductID, ProductName, CategoryName 
FROM Products INNER JOIN Categories 
ON Products.Category = Categories.CategoryID
WHERE CategoryName LIKE 'Electronics' or CategoryName LIKE 'Furniture'


