
----=== HOMEWORK 20 ===-----

CREATE TABLE #Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE
);

INSERT INTO #Sales (CustomerName, Product, Quantity, Price, SaleDate) VALUES
('Alice', 'Laptop', 1, 1200.00, '2024-01-15'),
('Bob', 'Smartphone', 2, 800.00, '2024-02-10'),
('Charlie', 'Tablet', 1, 500.00, '2024-02-20'),
('David', 'Laptop', 1, 1300.00, '2024-03-05'),
('Eve', 'Smartphone', 3, 750.00, '2024-03-12'),
('Frank', 'Headphones', 2, 100.00, '2024-04-08'),
('Grace', 'Smartwatch', 1, 300.00, '2024-04-25'),
('Hannah', 'Tablet', 2, 480.00, '2024-05-05'),
('Isaac', 'Laptop', 1, 1250.00, '2024-05-15'),
('Jack', 'Smartphone', 1, 820.00, '2024-06-01');


--1. Find customers who purchased at least one item in March 2024 using EXISTS
--SELECT * FROM #Sales

SELECT CustomerName, 
		Quantity, 
		SaleDate 
FROM #Sales AS s1
WHERE EXISTS (SELECT * FROM #Sales AS s2 WHERE s2.SaleID = s1.SaleID) 
	AND  Quantity >= 1 
	AND DATEPART(MONTH,SaleDate) = 3 
	AND DATEPART(YEAR, SaleDate) = 2024

--2. Find the product with the highest total sales revenue using a subquery.
SELECT * FROM #Sales

SELECT MAX(t.total_s_r) AS highest_total_sales
FROM (SELECT Product, SUM(Quantity*Price) AS total_s_r FROM #Sales GROUP BY Product) AS t

--3. Find the second highest sale amount using a subquery
--SELECT * FROM #Sales

SELECT CustomerName, 
		Quantity*Price AS Sale_amount 
FROM #Sales
WHERE Quantity*Price = (SELECT MAX(Quantity*Price) 
						FROM #Sales 
						WHERE Quantity*Price < (SELECT MAX(Quantity*Price) 
												FROM #Sales)
						)
--4. Find the total quantity of products sold per month using a subquery
--SELECT * FROM #Sales

SELECT  t2.Month_name, 
		SUM(t2.total) AS total_quantity
FROM
	(
	SELECT  Product, 
			SUM(Quantity) AS total, 
			DATENAME(month,SaleDate) AS Month_name
	FROM #Sales
	GROUP BY Product, 
			 Quantity, 
			 SaleDate 
	) AS t2
GROUP BY t2.Month_name

--5. Find customers who bought same products as another customer using EXISTS
SELECT * FROM #Sales

SELECT CustomerName, 
		Product 
FROM #Sales s1
WHERE EXISTS (SELECT CustomerName, 
						Product 
				FROM #Sales AS s2 
				WHERE s1.Product = s2.Product 
					AND s1.CustomerName <> s2.CustomerName)

--6. Return how many fruits does each person have in individual fruit level
/*
create table Fruits(Name varchar(50), Fruit varchar(50))
insert into Fruits values ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Orange'),
							('Francesko', 'Banana'), ('Francesko', 'Orange'), ('Li', 'Apple'), 
							('Li', 'Orange'), ('Li', 'Apple'), ('Li', 'Banana'), ('Mario', 'Apple'), ('Mario', 'Apple'), 
							('Mario', 'Apple'), ('Mario', 'Banana'), ('Mario', 'Banana'), 
							('Mario', 'Orange')
-----------expected output
+-----------+-------+--------+--------+
| Name      | Apple | Orange | Banana |
+-----------+-------+--------+--------+
| Francesko |   3   |   2    |   1    |
| Li        |   2   |   1    |   1    |
| Mario     |   3   |   1    |   2    |
+-----------+-------+--------+--------+
*/
--SELECT * FROM Fruits

SELECT Name, 
		(SELECT COUNT(*) FROM Fruits AS f2 WHERE f1.Name = f2.Name AND f2.Fruit = 'Apple') AS Apple,
		(SELECT COUNT(*) FROM Fruits AS f2 WHERE f1.Name = f2.Name AND f2.Fruit = 'Orange') AS Orange,
		(SELECT COUNT(*) FROM Fruits AS f2 WHERE f1.Name = f2.Name AND f2.Fruit = 'Banana') AS Banana
FROM (SELECT DISTINCT Name FROM Fruits) AS f1

--7. Return older people in the family with younger ones
/*
create table Family(ParentId int, ChildID int)
insert into Family values (1, 2), (2, 3), (3, 4)
----------------------
ParentId	ChildID
1	2
2	3
3	4

+-----+-----+		
| PID |CHID |
+-----+-----+
|  1  |  2  |
|  1  |  3  |
|  1  |  4  |
|  2  |  3  |
|  2  |  4  |
|  3  |  4  |
+-----+-----+
*/
--1 grandfather 2 Father 3 Son 4 Grandson
--SELECT * FROM Family

SELECT p.ParentId, ch.ChildID FROM Family AS p CROSS JOIN Family ch --WHERE p.ParentId = ch.ChildID
WHERE p.ParentId <> ch.ChildID AND p.ParentId < ch.ChildID
ORDER BY P.ParentId, ch.ChildID
;

--8 Write an SQL statement given the following requirements. For every customer that had a delivery to California, 
		--provide a result set of the customer orders that were delivered to Texas
/*
CREATE TABLE #Orders
(
CustomerID     INTEGER,
OrderID        INTEGER,
DeliveryState  VARCHAR(100) NOT NULL,
Amount         MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);


INSERT INTO #Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120); 
*/
--SELECT * FROM #Orders

SELECT DISTINCT CustomerID, DeliveryState FROM #Orders AS o1
WHERE EXISTS
(SELECT CustomerID, DeliveryState FROM #Orders AS o2
WHERE o2.DeliveryState = 'CA' AND o2.CustomerID = o1.CustomerID  AND  o1.DeliveryState <> o2.DeliveryState)

--9.  Insert the names of residents if they are missing

--SELECT * FROM #residents

UPDATE #residents
SET address = 'city=Lisboa country=Portugal name=Diogo age=26' 
WHERE resid = 2;
UPDATE #residents
SET address = 'city=Milan country=Italy name=Theo age=28' 
WHERE resid = 4;
UPDATE #residents
SET address = 'city=Tashkent country=Uzbekistan name=Rajabboy age=22' 
WHERE resid = 5;

--10. Write a query to return the route to reach from Tashkent to Khorezm. 
		--The result should include the cheapest and the most expensive routes
CREATE TABLE #Routes
(
RouteID        INTEGER NOT NULL,
DepartureCity  VARCHAR(30) NOT NULL,
ArrivalCity    VARCHAR(30) NOT NULL,
Cost           MONEY NOT NULL,
PRIMARY KEY (DepartureCity, ArrivalCity)
);

INSERT INTO #Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES
(1,'Tashkent','Samarkand',100),
(2,'Samarkand','Bukhoro',200),
(3,'Bukhoro','Khorezm',300),
(4,'Samarkand','Khorezm',400),
(5,'Tashkent','Jizzakh',100),
(6,'Jizzakh','Samarkand',50);
/*
|             Route                                 |Cost |
|Tashkent - Samarkand - Khorezm                     | 500 |
|Tashkent - Jizzakh - Samarkand - Bukhoro - Khorezm | 650 |
*/
SELECT * FROM #Routes
Order BY RouteID

;WITH RouteCTE AS (
  SELECT 
    DepartureCity, 
    ArrivalCity,
    Cost,
    CAST( DepartureCity + ' -> ' +  ArrivalCity AS VARCHAR(MAX)) AS RoutePath
  FROM #Routes
  WHERE DepartureCity = 'Tashkent'

  UNION ALL

  SELECT 
    r.DepartureCity,
    r.ArrivalCity,
    cte.Cost + r.Cost AS Cost,
    cte.RoutePath + ' -> ' + r.ArrivalCity
  FROM #Routes r
  JOIN RouteCTE cte
    ON cte.ArrivalCity = r.DepartureCity
  WHERE cte.RoutePath NOT LIKE '%' + r.ArrivalCity + '%'
)

SELECT TOP 1* FROM RouteCTE
WHERE ArrivalCity = 'Khorezm'
Order BY Cost DESC;

SELECT TOP 1* FROM RouteCTE
WHERE ArrivalCity = 'Khorezm'
Order BY Cost ASC;

--11. Rank products based on their order of insertion.

SELECT * FROM #RankingPuzzle

SELECT	ID, 
		Vals, 
		(
		SELECT COUNT(*) FROM #RankingPuzzle AS t2
		WHERE t2.Vals = 'Product' AND t2.ID <= t1.ID
		) AS grouped
FROM #RankingPuzzle t1

--12. Find employees whose sales were higher than the average sales in their department
--SELECT * FROM #EmployeeSales

SELECT EmployeeName 
FROM #EmployeeSales AS t1 
WHERE 
	t1.SalesAmount >(
					SELECT AVG(SalesAmount) 
					FROM #EmployeeSales AS t2 
					WHERE t1.Department = t2.Department
					)

--13. Find employees who had the highest sales in any given month using EXISTS

SELECT DISTINCT Employeename FROM #EmployeeSales AS t1 
WHERE EXISTS (
				SELECT 1 FROM #EmployeeSales AS t2
				WHERE t2.SalesMonth = t1.SalesMonth
				GROUP BY t2.SalesMonth
				HAVING t1.SalesAmount = MAX(t2.SalesAmount)
				)

--14. Find employees who made sales in every month using NOT EXISTS
--SELECT * FROM #EmployeeSales
--Order BY EmployeeName
	
SELECT DISTINCT s1.EmployeeName
FROM #EmployeeSales s1
WHERE NOT EXISTS (
    SELECT 1
    FROM (
        SELECT DISTINCT SalesMonth FROM #EmployeeSales
    ) AS all_months
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales s2
        WHERE s2.EmployeeName = s1.EmployeeName
          AND s2.SalesMonth = all_months.SalesMonth
    )
);	

--15. Retrieve the names of products that are more expensive than the average price of all products.

SELECT Name 
FROM Products 
WHERE Price > (SELECT AVG(Price) 
				FROM Products)

--16. Find the products that have a stock count lower than the highest stock count.
SELECT * 
FROM Products
WHERE Stock < (SELECT MAX(Stock) 
				FROM Products)

--17.Get the names of products that belong to the same category as 'Laptop'.
SELECT Name 
FROM Products
WHERE Category IN (SELECT Category 
					FROM Products 
					WHERE Name = 'Laptop')

--18.  Retrieve products whose price is greater than the lowest price in the Electronics category.
SELECT Name 
FROM Products
WHERE Price > (SELECT MIN(Price) 
				FROM Products 
				WHERE Category = 'Electronics')

--19. Find the products that have a higher price than the average price of their respective category.
--SELECT * FROM Products
--ORDER BY Category
SELECT * 
FROM Products AS t1 
WHERE t1.Price > (SELECT AVG(Price) 
					FROM Products AS t2 
					WHERE t1.Category = t2.Category)

--20.Find the products that have been ordered at least once.

SELECT * 
FROM Products AS p
WHERE EXISTS (SELECT 1 
				FROM Orders AS o 
				WHERE p.ProductID = o.ProductID)

--21. Retrieve the names of products that have been ordered more than the average quantity ordered.

SELECT Name, 
		Quantity 
FROM Products AS p 
JOIN Orders AS o 
	ON p.ProductID = o.ProductID
WHERE Quantity > (SELECT AVG(Quantity) 
					FROM Orders)

--22. Find the products that have never been ordered.	

SELECT * 
FROM Products AS p
WHERE NOT EXISTS (SELECT * 
					FROM Orders AS o 
					WHERE p.ProductID = o.ProductID)

--23. Retrieve the product with the highest total quantity ordered.
--SELECT * FROM Products
--SELECT * FROM Orders
--ORder BY ProductID

SELECT Name 
FROM Products AS p 
	JOIN Orders AS o 
		ON p.ProductID = o.ProductID
WHERE Quantity = (SELECT MAX(Quantity) 
					FROM Orders)







