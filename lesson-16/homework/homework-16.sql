

---===---HOMEWORK - 16  --

--1. Create a numbers table using a recursive query from 1 to 1000.
;WITH CTE1 AS(
			SELECT 1 AS NUMBER
			UNION ALL
			SELECT NUMBER+1 FROM CTE1
			WHERE NUMBER < 1000
			)
SELECT NUMBER FROM CTE1 OPTION (MAXRECURSION 1000)

--2.Write a query to find the total sales per employee using a derived table.(Sales, Employees)
--SELECT * FROM Sales
--SELECT * FROM Employees
/*
SELECT EmployeeID, SUM(SalesAmount) AS total_sales
FROM Sales
GROUP By EmployeeID
*/
SELECT Employees.EmployeeID, FirstName, LastName, total_sales
FROM Employees JOIN
					(
						SELECT EmployeeID, SUM(SalesAmount) AS total_sales
						FROM Sales
						GROUP By EmployeeID
					) AS Derived_table
				ON Employees.EmployeeID = Derived_table.EmployeeID

--3.Create a CTE to find the average salary of employees.(Employees)
--SELECT * FROM Employees

;WITH CTE AS 
	(
	SELECT AVG(Salary) AS avg_salary 
	FROM Employees
	)
SELECT * FROM CTE
--4.Write a query using a derived table to find the highest sales for each product.(Sales, Products)
--SELECT * FROM Sales
--SELECT * FROM Products
/*
SELECT ProductID, MAX(SalesAmount) AS highest_sales
FROM Sales
GROUP BY ProductID
*/
SELECT Products.ProductID, ProductName, highest_sales 
FROM Products JOIN
					(
						SELECT ProductID, MAX(SalesAmount) AS highest_sales
						FROM Sales
						GROUP BY ProductID
					) AS Derived_table
				ON Products.ProductID = Derived_table.ProductID

--5.Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.
;WITH CTE_n AS(
			SELECT 1 AS numbers
			UNION ALL
			SELECT numbers * 2 FROM CTE_n
			WHERE numbers < 500000
			)
SELECT numbers FROM CTE_n OPTION (MAXRECURSION 0)

--6.Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
--SELECT * FROM Sales
--SELECT * FROM Employees

;WITH CTE_sales AS
	(
	SELECT EmployeeID, COUNT(SalesID) AS count_sales
	FROM Sales
	GROUP BY EmployeeID
	)
SELECT C_s.EmployeeID, FirstName, LastName, count_sales 
FROM CTE_sales AS C_s 
JOIN Employees AS Emp ON C_s.EmployeeID = Emp.EmployeeID 
WHERE count_sales > 5

--7.Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
--SELECT * FROM Sales
--SELECT * FROM Products

;WITH CTE_sales AS
		(
		SELECT ProductID, SUM(SalesAmount) AS sales_amount
		FROM Sales
		GROUP BY ProductID
		)
SELECT C_s.ProductID, ProductName, sales_amount 
FROM CTE_sales AS C_s 
JOIN Products AS P ON C_s.ProductID = P.ProductID
WHERE sales_amount > 500

--8.Create a CTE to find employees with salaries above the average salary.(Employees)
--SELECT * FROM Employees

;WITH CTE_avg_salary AS
		(
		SELECT AVG(Salary) AS avg_salary
		FROM Employees
		)
SELECT EmployeeID, FirstName, LastName, Salary
FROM Employees AS E CROSS JOIN CTE_avg_salary AS C_a_s 
WHERE Salary > avg_salary

--9.Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
--SELECT * FROM Employees
--SELECT * FROM Sales

SELECT TOP 5 emp.EmployeeID, FirstName, LastName, num_order FROM Employees AS emp JOIN
(
SELECT EmployeeID, COUNT(EmployeeID) AS num_order
FROM Sales
GROUP BY EmployeeID
) AS n_o ON emp.EmployeeID = n_o.EmployeeID

--10.Write a query using a derived table to find the sales per product category.(Sales, Products)
--SELECT * FROM Sales
--SELECT * FROM Products

SELECT p.ProductID, SUM(t_s.total_sales) AS total_sales
FROM Products AS P JOIN
	(
	SELECT ProductID, SUM(SalesAmount) AS total_sales
	FROM Sales
	GROUP BY ProductID
	) AS t_s ON P.ProductID = t_s.ProductID
GROUP BY p.ProductID
/*
SELECT P.ProductID, SUM(count_sale) 
FROM Products AS P JOIN
		(
		SELECT ProductID, COUNT(ProductID) AS count_sale
		FROM Sales
		GROUP BY ProductID
		) AS c_s ON P.ProductID = c_s.ProductID
GROUP BY P.ProductID
*/

--11.Write a script to return the factorial of each value next to it.(Numbers1)
--SELECT * FROM Numbers1

;WITH CTE_rec AS(
			SELECT Number AS original_number, 1 AS n, 1 AS factorial FROM Numbers1
			UNION ALL
			SELECT original_number, n + 1, (n + 1) * factorial FROM CTE_rec
			WHERE n + 1 <= original_number
			)
SELECT original_number, factorial FROM CTE_rec
WHERE original_number = n
ORDER BY n

--12.This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
--SELECT * FROM Example
---CHARINDEX(substring, string, start)
---SUBSTRING(string, start, length)
---PATINDEX(%pattern%, string)
---REPLACE(string, from_string, new_string)
---TRANSLATE(string, characters, translations)

;WITH CTE_Chars AS (
    SELECT 
        Id,
        CAST(LEFT(String, 1) AS CHAR(1)) AS Character,
        1 AS Position,
        String
    FROM Example

    UNION ALL

    SELECT 
        Id,
        CAST(SUBSTRING(String, Position + 1, 1) AS CHAR(1)),
        Position + 1,
        String
    FROM CTE_Chars
    WHERE Position < LEN(String)
)

SELECT 
    Id,
    Position,
    Character
FROM CTE_Chars
ORDER BY Id, Position
OPTION (MAXRECURSION 1000);

--13.Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
SELECT * FROM Sales

;WITH CTE_sales AS(
			SELECT DATEPART(MONTH, SaleDate) AS month_number, SUM(SalesAmount) AS sales_amt
			FROM Sales
			GROUP BY SaleDate, SalesAmount
		--	ORDER BY month_number
			)
SELECT month_number, SUM(sales_amt) AS total_sales
FROM CTE_sales
GROUP BY month_number

--14.Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)
--SELECT * FROM Sales
--Order by SaleDate
--SELECT * FROM Employees

SELECT e.EmployeeID, SUM(total_sales) AS tot_sales, quart
FROM Employees AS e RIGHT JOIN 
		(
		SELECT EmployeeID, SUM(SalesAmount) AS total_sales, SaleDate,
				CASE
					WHEN DATEPART(QUARTER, SaleDate) = 1 THEN 1
					WHEN DATEPART(QUARTER, SaleDate) = 2 THEN 2
					WHEN DATEPART(QUARTER, SaleDate) = 3 THEN 3
					WHEN DATEPART(QUARTER, SaleDate) = 4 THEN 4
				END AS quart
		FROM Sales
		GROUP BY EmployeeID, SaleDate
		)AS t_s ON e.EmployeeID = t_s.EmployeeID
GROUP BY e.EmployeeID, quart
HAVING SUM(total_sales) > 4500

--15.This script uses recursion to calculate Fibonacci numbers
--F(n) = F(n-1) + F(n-2), with F(0) = 0 and F(1) = 1. ----- 0,1,1,2,3,5,8,13,21,...

;WITH CTE_f AS(
			SELECT 0 AS fibo, 0 AS fibo1, 1 AS fibo2
			UNION ALL
			SELECT fibo+1, fibo2, fibo1+fibo2 FROM CTE_f
			WHERE fibo < 20
			)
SELECT fibo+1 AS position, fibo2 AS Fibonacci
FROM CTE_f OPTION (MAXRECURSION 0)
		
--16.Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
SELECT * FROM FindSameCharacters

SELECT * FROM FindSameCharacters
WHERE LEN(Vals) > 1
AND LEN(REPLACE(Vals, LEFT(Vals,1), ''))=0
--17.Create a numbers table that shows all numbers 1 through n and their order gradually increasing 
		--by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)
---CHARINDEX(substring, string, start)
---SUBSTRING(string, start, length)
---PATINDEX(%pattern%, string)

;WITH cte_rec AS ( 
				SELECT 1 AS num, 
				CAST('1' AS VARCHAR(MAX)) AS value 
				UNION ALL
				SELECT num + 1, 
				value + CAST(num + 1 AS VARCHAR) FROM cte_rec
				WHERE num < 5
				)
SELECT value FROM cte_rec OPTION(MAXRECURSION 5)

--18.Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)
SELECT * FROM Employees
SELECT * FROM Sales

SELECT E.EmployeeID, total_monthly_sales, MONTH--, MAX(total_monthly_sales)
FROM Employees AS E
						JOIN		
						(
						SELECT	EmployeeID, 
								DATEPART(YEAR, SaleDate) AS YEAR,-------------------
								DATEPART(MONTH, SaleDate) AS MONTH,-----------------------------
								SUM(SalesAmount) AS total_monthly_sales----------------------------------------
						FROM Sales
						WHERE SaleDate >= DATEADD(MONTH, -4, GETDATE())
						GROUP BY EmployeeID, DATEPART(YEAR, SaleDate), DATEPART(MONTH, SaleDate)
			--			ORDER BY MONTH
						)AS s
						ON E.EmployeeID = s.EmployeeID
GROUP BY E.EmployeeID, total_monthly_sales, MONTH
ORDER BY MONTH


--19.Write a T-SQL query to remove the duplicate integer values present in the string column. 
		--Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)
SELECT * FROM RemoveDuplicateIntsFromNames

;WITH CTE_recursive AS(
					SELECT PawanName, 
						1 AS position, 
						SUBSTRING(Pawan_slug_name, 1, 1) AS charr,
						Pawan_slug_name
					FROM RemoveDuplicateIntsFromNames
					UNION ALL
					SELECT PawanName, 
						position + 1, 
						SUBSTRING(Pawan_slug_name, position+1, 1),
						Pawan_slug_name
					FROM CTE_recursive
					WHERE position + 1 <= LEN(Pawan_slug_name)
					)
SELECT PawanName, charr, COUNT(*) AS takror FROM CTE_recursive 



