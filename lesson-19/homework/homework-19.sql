
-----==== HOMEWORK 19 --

--1.=========

--Create a stored procedure that:
/*
Creates a temp table #EmployeeBonus
Inserts EmployeeID, FullName (FirstName + LastName), Department, Salary, and BonusAmount into it
(BonusAmount = Salary * BonusPercentage / 100)
Then, selects all data from the temp table.
*/
-----4-step-----creating procedure
CREATE PROCEDURE employee_bonus_calculator
AS
BEGIN
-------1-step------creating temp table
	CREATE TABLE #EmployeeBonus 
					(EmployeeID INT, 
					FullName VARCHAR(50), 
					Department VARCHAR(50), 
					Salary FLOAT, 
					BonusAmount FLOAT)
-----2-step------inserting values
	INSERT INTO #EmployeeBonus
	SELECT EmployeeID, 
			CONCAT(FirstName,' ' , LastName) AS FullName, 
			e.Department, 
			Salary, 
			(Salary * BonusPercentage / 100) AS BonusAmount  
	FROM Employees AS e 
	JOIN DepartmentBonus AS dB 
	ON e.Department = dB.Department
----3-step-------calling
	SELECT * FROM  #EmployeeBonus

END
----5-step-----calling procedure
EXECUTE employee_bonus_calculator

--2.=======

--Create a stored procedure that:
/*
Accepts a department name and an increase percentage as parameters
Update salary of all employees in the given department by the given percentage
Returns updated employees from that department.
*/
--SELECT * FROM Employees
--SELECT * FROM DepartmentBonus
------2-step ----- creating procedure
CREATE PROCEDURE proc_1 @Department VARCHAR(50), @inc_per DECIMAL (10, 2)
AS
BEGIN
-------1-step----filtering values
	SELECT EmployeeID, 
			FirstName, 
			LastName, 
			Salary, 
			@inc_per AS new_percentage, 
			Salary + ((@inc_per * Salary)/100) AS increased_salary
	FROM Employees AS e 
	JOIN DepartmentBonus AS dB 
		ON e.Department = dB.Department
	WHERE e.Department = @Department 
	--GROUP BY e.Department
	ORDER BY BonusPercentage ASC
END
-----------3-step --- calling procedure
EXECUTE proc_1 @Department = 'IT', @inc_per = 50

--3. ============

/*
Perform a MERGE operation that:

Updates ProductName and Price if ProductID matches
Inserts new products if ProductID does not exist
Deletes products from Products_Current if they are missing in Products_New
Return the final state of Products_Current after the MERGE.
*/
--SELECT * FROM Products_Current	
--SELECT * FROM Products_New

MERGE Products_Current AS target
USING Products_New	AS source
ON target.ProductID = source.ProductID
WHEN MATCHED
THEN 
	UPDATE
	SET target.ProductName = source.ProductName,
		target.Price = source.Price
WHEN NOT MATCHED BY target
THEN 
	INSERT 
		(ProductID, ProductName, Price)
	VALUES
		(source.ProductID, source.ProductName, source.Price)
WHEN NOT MATCHED BY source
THEN
	DELETE;

--4. ===========

/* 
Tree Node
Each node in the tree can be one of three types:
"Leaf": if the node is a leaf node.
"Root": if the node is the root of the tree.
"Inner": If the node is neither a leaf node nor a root node.
Write a solution to report the type of each node in the tree.
*/
--leaf 
--SELECT * FROM Tree

SELECT
    t.id,
    CASE
        WHEN t.p_id IS NULL THEN 'Root'
        WHEN NOT EXISTS (
            SELECT 1 FROM tree AS ch WHERE ch.p_id = t.id
        ) THEN 'Leaf'
        ELSE 'Inner'
    END AS type
FROM
    tree AS t;

--5. ===========
/*
Confirmation Rate

Find the confirmation rate for each user. If a user has no confirmation requests, the rate should be 0.
*/
--SELECT * FROM Signups
--SELECT * FROM Confirmations

;WITH CTE_1 AS (
			SELECT s.user_id,  
					CASE 
						WHEN action = 'confirmed' THEN 1.00
						ELSE 0.00
					END AS confirmation_rate
			FROM Signups AS s 
			LEFT JOIN Confirmations AS c 
				ON s.user_id = c.user_id
			)
SELECT	user_id, --confirmation_rate,
		CAST(SUM(confirmation_rate)/(COUNT(confirmation_rate)) AS DECIMAL(3,2)) AS confirmation_rate
FROM CTE_1
GROUP BY user_id
ORDER BY confirmation_rate ASC 

--6. ===========
--Find all employees who have the lowest salary using subqueries.
--SELECT * FROM employees1

SELECT name
FROM employees1
WHERE salary =(SELECT MIN(salary) FROM employees1)

--7. ===========
--Get Product Sales Summary
/*Create a stored procedure called GetProductSalesSummary that:

Accepts a @ProductID input
Returns:
ProductName
Total Quantity Sold
Total Sales Amount (Quantity × Price)
First Sale Date
Last Sale Date
If the product has no sales, return NULL for quantity, total amount, first date, and last date, 
	but still return the product name.
*/
--SELECT * FROM Products
--SELECT * FROM Sales

-----2-step------creating procedure
CREATE PROCEDURE GetProductSalesSummary (@ProductID INT)
AS
BEGIN
----1-step--filtering
	SELECT	
			ProductName, 
			SUM(Quantity) AS TotalQuantitySold,
			SUM(Quantity * Price) AS TotalSalesAmount,
			MIN(SaleDate) AS first_sale_date, 
			MAX(SaleDate) AS last_sale_date
	FROM Products AS p 
	LEFT JOIN Sales AS s 
		ON p.ProductID = s.ProductID
	WHERE p.ProductID = @ProductID
	GROUP BY ProductName
END
-----3-step----calling---------------------
EXECUTE GetProductSalesSummary @ProductID = 14


