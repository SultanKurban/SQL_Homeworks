
---=== HOMEWORK - 18 ---===

--1. Create a temporary table named MonthlySales to store the total quantity sold and total revenue for each product in the current month.
		--Return: ProductID, TotalQuantity, TotalRevenue
--SELECT * FROM Products
--SELECT * FROM Sales
------------
----- creating temp.table
CREATE TABLE #MonthlySales (ProductID int, TotalQuantity INT, TotalRevenue decimal(10,2))
-------nninserting values
INSERT INTO #MonthlySales (ProductID, TotalQuantity, TotalRevenue)
----- 
SELECT p.ProductID, 
		total_quantity_sold, 
		total_quantity_sold * Price AS TotalRevenue
FROM Products As p 
	JOIN (
		SELECT  ProductID, 
				SUM(Quantity) AS total_quantity_sold--, 
		---		MAX(SaleDate) AS current_month
		FROM Sales 
		WHERE MONTH(SaleDate) = 4
		GROUP BY ProductID
		) AS s
	ON p.ProductID = s.ProductID

---calling temp_table
SELECT * FROM #MonthlySales

--2. Create a view named vw_ProductSalesSummary that returns product info along with total sales quantity across all time.
		--Return: ProductID, ProductName, Category, TotalQuantitySold
--SELECT * FROM Products
--SELECT * FROM Sales
--order by ProductID
----creating view
CREATE VIEW vw_productSalesSummary
AS

SELECT	*
FROM Products 
	JOIN (
		SELECT	ProductID, 
				SUM(Quantity) AS TotalQuantitySold 
		FROM Sales
		GROUP BY ProductID
		) AS s 
	ON Products.ProductID = s.ProductID

----- calling view 
SELECT	ProductID, 
		ProductName, 
		Category, 
		TotalQuantitySold 
FROM vw_ProductSalesSummary

--3. Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)
		--Return: total revenue for the given product ID
--SELECT * FROM Products
--SELECT * FROM Sales
---------creating inside
SELECT p.ProductID, SUM(Price * Quantity) AS total_revenue
FROM Products AS p 
JOIN Sales AS s 
	ON p.ProductID = s.ProductID
	WHERE p.ProductID = 20
GROUP BY p.ProductID

----creating function
CREATE FUNCTION fn_GetTotalRevenueForProduct (@ProductID INT)
RETURNS TABLE
AS
RETURN (
		SELECT p.ProductID, SUM(Price * Quantity) AS total_revenue
		FROM Products AS p 
		JOIN Sales AS s 
			ON p.ProductID = s.ProductID
		WHERE p.ProductID = @ProductID
		GROUP BY p.ProductID
		)
--------calling function
SELECT * FROM dbo.fn_GetTotalRevenueForProduct (20)

--4. Create an function fn_GetSalesByCategory(@Category VARCHAR(50))
		--Return: ProductName, TotalQuantity, TotalRevenue for all products in that category.
		--Now we will move on with 2 Lateral-thinking puzzles (5 and 6th puzzles). 
		--Lateral-thinking puzzles are the ones that can’t be solved by straightforward logic — you have to think outside the box. 

--SELECT * FROM Products
--SELECT * FROM Sales
----------------inside
SELECT ProductName, 
		SUM(Quantity) AS total_quantity, 
		SUM(Quantity*Price) AS total_revenue 
FROM Products AS p 
JOIN Sales AS s 
	ON p.ProductID = s.ProductID
WHERE Category = 'Electronics'
GROUP BY ProductName
-------------------creating function
CREATE FUNCTION fn_GetSalesByCategory (@Category VARCHAR(50))

RETURNS TABLE
AS

	RETURN 
	(
	SELECT ProductName, 
		SUM(Quantity) AS total_quantity, 
		SUM(Quantity*Price) AS total_revenue 
	FROM Products AS p 
	JOIN Sales AS s 
		ON p.ProductID = s.ProductID
	WHERE Category = @Category
	GROUP BY ProductName
	)
------ calling function
SELECT * FROM dbo.fn_GetSalesByCategory ('Electronics')

--5. You have to create a function that get one argument as input from user and the function should return 'Yes' 
		--if the input number is a prime number and 'No' otherwise. You can start it like this:
--Create function dbo.fn_IsPrime (@Number INT)
--Returns ...
--This is for those who has no idea about prime numbers: 
--A prime number is a number greater than 1 that has only two divisors: 1 and itself(2, 3, 5, 7 and so on).
------------------------------

CREATE FUNCTION fn_IsPrime (@Number INT)
RETURNS TABLE
AS

RETURN	(
		SELECT @Number AS number,
		CASE 
			WHEN @Number % 2 = 0 THEN 'No'
			ELSE 'Yes'
			END AS result
		) 

SELECT * FROM dbo.fn_IsPrime (17)

------------------------

--6. Create a table-valued function named fn_GetNumbersBetween that accepts two integers as input:

ALTER FUNCTION fn_GetNumbersBetween (@start INT, @end INT)
RETURNS TABLE
AS
RETURN
	(
--------------------	
	WITH Numbers AS	
			(
			SELECT @start AS Number
			UNION ALL
			SELECT Number + 1
			FROM Numbers
			WHERE Number < @end
			)
		SELECT * FROM Numbers
----------------------------
	)
SELECT * FROM dbo.fn_GetNumbersBetween (34, 67)
----------------------------

--7. Write a SQL query to return the Nth highest distinct salary from the Employee table. 
	--If there are fewer than N distinct salaries, return NULL.  ?????????????

---------------------------
ALTER FUNCTION fn_comparing (@num INT)
RETURNS TABLE 
AS
RETURN(
		SELECT    ROW_NUMBER() OVER (ORDER BY ProductID) AS row_num,
					CASE	
						WHEN ProductID < @num THEN Null
						ELSE ProductID
					END AS comparing
		FROM Products
	---	GROUP BY ProductID
		ORDER BY Price DESC
		OFFSET @num ROWS
		FETCH NEXT @num + 2 ROWS ONLY
	)
SELECT * FROM fn_comparing (10)

--8. Write a SQL query to find the person who has the most friends.
		--Return: Their id, The total number of friends they have 
SELECT TOP 1 person_id AS id, COUNT(*) AS num
FROM (
    SELECT requester_id AS person_id FROM table_1
    UNION ALL
    SELECT accepter_id AS person_id FROM table_1
) AS all_friends
GROUP BY person_id
ORDER BY num DESC
;

--9. Create a View for Customer Order Summary.
/*Create a view called vw_CustomerOrderSummary that returns a summary of customer orders. The view must contain the following columns:

Column Name | Description
customer_id | Unique identifier of the customer
name | Full name of the customer
total_orders | Total number of orders placed by the customer
total_amount | Cumulative amount spent across all orders
last_order_date | Date of the most recent order placed by the customer
*/

--SELECT * FROM Customers
--SELECT * FROM Orders

---creating view
CREATE VIEW vw_CustomerOrderSummary
AS

SELECT c.customer_id, 
		name, 
		city, 
		total_orders, 
		last_order_date, 
		total_amount 
FROM Customers AS c 
JOIN (
	SELECT	customer_id,
			COUNT(customer_id) AS total_orders, 
			MAX(order_date) AS last_order_date, 
			SUM(amount) AS total_amount 
	FROM Orders
	GROUP BY customer_id
	) AS o ON c.customer_id = o.customer_id

------ calling view
SELECT	customer_id, 
		name, 
		total_orders, 
		last_order_date, 
		total_amount 
FROM vw_CustomerOrderSummary

--10. Write an SQL statement to fill in the missing gaps. You have to write only select statement, no need to modify the table
SELECT * FROM Gaps

SELECT 
  RowNumber,
  (
    SELECT TOP 1 TestCase
    FROM Gaps AS g2
    WHERE g2.RowNumber <= g1.RowNumber
      AND g2.TestCase IS NOT NULL
    ORDER BY g2.RowNumber DESC
  ) AS FilledWorkflow
FROM Gaps AS g1;
