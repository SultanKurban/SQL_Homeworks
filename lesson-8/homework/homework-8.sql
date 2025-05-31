
-----HOMEWORK-8 -----

--1.Using Products table, find the total number of products available in each category.
--SELECT * FROM Products
1.SELECT DISTINCT Category, SUM(StockQuantity) AS Total_num_Prod
FROM Products
GROUP BY Category

--2.Using Products table, get the average price of products in the 'Electronics' category.
--SELECT * FROM Products
2.SELECT Category, AVG(Price) AS AVG_price
FROM Products
WHERE Category Like 'Electronics'
GROUP BY Category

--3.Using Customers table, list all customers from cities that start with 'L'.
--SELECT * FROM Customers
3.SELECT FirstName, LastName, City
FROM Customers
WHERE City Like 'L%'

--4.Using Products table, get all product names that end with 'er'.
---SELECT * FROM Products
4.SELECT ProductName
FROM Products
WHERE ProductName Like '%er'

--5.Using Customers table, list all customers from countries ending in 'A'.
--SELECT * FROM Customers
5.SELECT FirstName, LastName, Country
FROM Customers
WHERE Country Like '%A'

--6.Using Products table, show the highest price among all products.
--SELECT * FROM Products
6.SELECT MAX(Price) AS The_highest_price
FROM Products

--7.Using Products table, label stock as 'Low Stock' if quantity < 30, else 'Sufficient'.
--SELECT * FROM Products
7.SELECT ProductName, StockQuantity,
CASE 
	WHEN StockQuantity < 30 THEN 'Low Stock'
	ELSE 'Sufficient'
END AS 'Label stock'
FROM Products

--8.Using Customers table, find the total number of customers in each country.
--SELECT * FROM Customers
8.SELECT DISTINCT Country, COUNT(CustomerID) AS Total_numb_cust
FROM Customers
GROUP BY Country

--9.Using Orders table, find the minimum and maximum quantity ordered.
9.SELECT * FROM Orders
SELECT MIN(Quantity) AS Min_quantity_ordered, MAX(Quantity) AS Max_quantity_ordered
FROM Orders

--10.Using Orders and Invoices tables, list customer IDs who placed orders in 2023 January to find those 
		--who did not have invoices.
--SELECT * FROM Orders
--SELECT * FROM Invoices
/*
SELECT DISTINCT Orders.CustomerID 
FROM Orders
LEFT JOIN Invoices ON Orders.CustomerID=Invoices.CustomerID
WHERE 
		Orders.OrderDate >= '2023-01-01' 
	AND Orders.OrderDate < '2023-02-01'
	AND Invoices.InvoiceID IS NULL;
*/
10.SELECT DISTINCT CustomerID
FROM Orders 
WHERE 
    OrderDate >= '2023-01-01' AND OrderDate < '2023-02-01'
    AND NOT EXISTS (
        SELECT 1
        FROM Invoices 
        WHERE 
			Invoices.CustomerID = Orders.CustomerID
			AND Invoices.InvoiceDate >= '2023-01-01' AND Invoices.InvoiceDate < '2023-02-01'
    );
	
--11.Using Products and Products_Discounted table, 
		--Combine all product names from Products and Products_Discounted including duplicates.
11.SELECT ProductName FROM Products
UNION ALL
SELECT ProductName FROM Products_Discounted

--12.Using Products and Products_Discounted table, 
		--Combine all product names from Products and Products_Discounted without duplicates.
12.SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted

--13.Using Orders table, find the average order amount by year.
--SELECT * FROM Orders
13.
SELECT DISTINCT YEAR(OrderDate) AS Years,
				AVG(TotalAmount) AS AVG_ord_amount
FROM Orders
GROUP By YEAR(OrderDate)

--14.Using Products table, group products based on price: 'Low' (<100), 'Mid' (100-500), 'High' (>500). 
		--Return productname and pricegroup.
--SELECT * FROM Products
14.
SELECT ProductName,
CASE
	WHEN Price < 100 THEN 'Low'
	WHEN Price >= 100 and Price <= 500 THEN 'Mid'
	ELSE 'High'
END AS PriceGroup
FROM Products
--15.Using City_Population table, use Pivot to show values of Year column in seperate columns ([2012], [2013]) 
			---and copy results to a new Population_Each_Year table.
---SELECT * FROM city_population
15.
SELECT * FROM 
(
	SELECT district_name, population, year FROM city_population
) AS source_table
PIVOT 
(
	SUM(population)
	FOR YEAR IN ([2012], [2013])
) AS Population_Each_Year

--16.Using Sales table, find total sales per product Id.
--SELECT * FROM Sales
16.
SELECT DISTINCT ProductID, SUM(SaleAmount)
FROM Sales
GROUP BY ProductID, SaleAmount
--17.Using Products table, use wildcard to find products that contain 'oo' in the name. Return productname.
--SELECT * FROM Products
17.
SELECT ProductName
FROM Products
WHERE ProductName like '%oo%'
--18.Using City_Population table, use Pivot to show values of City column in seperate columns 
			--(Bektemir, Chilonzor, Yakkasaroy) and copy results to a new Population_Each_City table.
--SELECT * FROM city_population
18.
SELECT * FROM 
(
	SELECT district_name, population, year FROM city_population
) AS source_table
PIVOT
(
	SUM(population)
	FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS Population_Each_City

--19.Using Invoices table, show top 3 customers with the highest total invoice amount. Return CustomerID and Totalspent.
--SELECT * FROM Invoices
19.
SELECT TOP 3  CustomerID,  TotalAmount AS TotalSpent
FROM Invoices
ORDER BY TotalAmount DESC

--20.Transform Population_Each_Year table to its original format (City_Population).
---SELECT * FROM city_population
20.
SELECT * FROM 
(
	SELECT district_name, population, YEAR FROM city_population
) AS source_table
PIVOT
(
	SUM(population)
	FOR year IN ([2012], [2013])
) AS pivot_table

--21.Using Products and Sales tables, list product names and the number of times each has been sold. (Research for Joins)
--SELECT * FROM Products
--SELECT * FROM Sales
21.
SELECT ProductName, COUNT(Products.ProductID) AS Number_of_sales
FROM Products

INNER JOIN Sales ON Products.ProductID = Sales.ProductID
GROUP BY ProductName

--22.Transform Population_Each_City table to its original format (City_Population).
--SELECT * FROM city_population
22.
SELECT * FROM
(
	SELECT district_name, population, year FROM city_population
) AS source_table
PIVOT
(
	SUM(population)
	FOR district_name IN ([Chilonzor], [Yakkasaroy], [Mirobod], [Yashnobod], [Bektemir]) 
)AS pivot_table



