

---==== HOMEWORK 21 --=====

--1. Write a query to assign a row number to each sale based on the SaleDate.

SELECT *, ROW_NUMBER() OVER (ORDER BY SaleDate) AS rn
FROM ProductSales

--2. Write a query to rank products based on the total quantity sold. give the same rank for the same amounts without skipping numbers.

SELECT * , DENSE_RANK() OVER (ORDER BY Quantity) AS dn
FROM ProductSales

--3. Write a query to identify the top sale for each customer based on the SaleAmount.

SELECT *, ROW_NUMBER() OVER (ORDER BY SaleAmount DESC) rn
FROM ProductSales

--4. Write a query to display each sale's amount along with the next sale amount in the order of SaleDate.

SELECT * , LEAD(SaleAmount, 1) OVER (ORDER BY SaleDate) AS next_sale_Amount
FROM ProductSales

--5. Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate.

SELECT *,  LAG(SaleAmount, 1, 0) OVER (Order BY SaleDate) AS previous_sale
FROM ProductSales

--6. Write a query to identify sales amounts that are greater than the previous sale's amount

;with CTE_1 AS(
SELECT *, LAG(SaleAmount, 1, 0) OVER (ORDER BY SaleDate) AS prev_sale_amount
FROM ProductSales
)
SELECT SaleID, SaleAmount, prev_sale_amount FROM CTE_1
WHERE SaleAmount > prev_sale_amount

--7. Write a query to calculate the difference in sale amount from the previous sale for every product

;with CTE_2 AS(
SELECT *, LAG(SaleAmount, 1, 0) OVER (ORDER BY SaleDate) AS prev_sale_amount
FROM ProductSales
)
SELECT *, SaleAmount-prev_sale_amount AS difference_amount FROM CTE_2 

--8. Write a query to compare the current sale amount with the next sale amount in terms of percentage change.

;with CTE_3 AS(
SELECT *, LEAD(SaleAmount, 1, 0) OVER(ORDER BY SaleDate) AS next_sale_amount
FROM ProductSales
)
SELECT *, CAST((100 * next_sale_amount)/SaleAmount AS decimal(10,0)) AS percentage_change FROM CTE_3

--9. Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.

;with CTE_4 AS(
SELECT *, LAG(SaleAmount, 1) OVER(PARTITION BY ProductName ORDER BY SaleDate) AS previous_sale
FROM ProductSales
)
SELECT *, CAST(SaleAmount/previous_sale AS decimal(5,2)) AS ratio FROM CTE_4

--10. Write a query to calculate the difference in sale amount from the very first sale of that product.

;with CTE_5 AS (
SELECT *, FIRST_VALUE(SaleAmount) OVER(PARTITION BY ProductName ORDER BY SaleDate) AS first_p_value
FROM ProductSales
)
SELECT *, SaleAmount - first_p_value AS difference_in_sale FROM CTE_5

--11. Write a query to find sales that have been increasing continuously for a product 
		--(i.e., each sale amount is greater than the previous sale amount for that product).

SELECT *, LAG(SaleAmount, 1, 0) OVER(PARTITION BY ProductName ORDER BY SaleDate) AS prev_sale
FROM ProductSales

--12. Write a query to calculate a "closing balance"(running total) for sales amounts 
		--which adds the current sale amount to a running total of previous sales.

SELECT * , SUM (SaleAmount) OVER(ORDER BY SaleDate) AS closing_balance FROM ProductSales

--13. Write a query to calculate the moving average of sales amounts over the last 3 sales.

SELECT *, 
AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_average
FROM ProductSales

--14. Write a query to show the difference between each sale amount and the average sale amount.
--SELECT * FROM ProductSales

;with CTE_6 AS(
SELECT *, CAST(AVG(SaleAmount) OVER () AS decimal (5,2)) avg_sale
FROM ProductSales
)
SELECT *, SaleAmount - avg_sale AS difference_sale  FROM CTE_6

------------------
--15. Find Employees Who Have the Same Salary Rank

SELECT *, RANK() OVER (ORDER BY Salary)
FROM Employees1

--16. Identify the Top 2 Highest Salaries in Each Department

;with CTE_7 AS (
SELECT *, ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary) AS rN FROM Employees1
)
SELECT * FROM CTE_7
WHERE rN <= 2

--17. Find the Lowest-Paid Employee in Each Department

;with CTE_8 AS (
SELECT *, ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary ASC) AS rN FROM Employees1
)
SELECT * FROM CTE_8
WHERE rN = 1

--18. Calculate the Running Total of Salaries in Each Department

SELECT * , SUM (Salary) OVER(PARTITION BY Department ORDER BY HireDate) AS running FROM Employees1

--19. Find the Total Salary of Each Department Without GROUP BY

SELECT DISTINCT Department, SUM(Salary) OVER(PARTITION BY Department) AS total_salary FROM Employees1

--20. Calculate the Average Salary in Each Department Without GROUP BY

SELECT DISTINCT Department, AVG(Salary) OVER(PARTITION BY Department) AS avg_salary FROM Employees1

--21. Find the Difference Between an Employee’s Salary and Their Department’s Average

;with CTE_9 AS (
SELECT *, AVG(Salary) OVER(PARTITION BY Department) AS avg_salary
FROM Employees1
)
SELECT Name, Salary-avg_salary AS difference_ FROM CTE_9

--22. Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)

SELECT *, AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS total_salary 
FROM Employees1

--23. Find the Sum of Salaries for the Last 3 Hired Employees

SELECT *, 
SUM(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_average
FROM Employees1
