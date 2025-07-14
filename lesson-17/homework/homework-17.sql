
---====  HOMEWORK 17 --==
--1. You must provide a report of all distributors and their sales by region. 
	--If a distributor did not have any sales for a region, rovide a zero-dollar value for that day. 
			--Assume there is at least one sale for each region
--SELECT * FROM RegionSales

SELECT	cross_join.Region, 
		cross_join.Distributor, 
		COALESCE(Sales, 0) AS Sales 
FROM 
	(SELECT DISTINCT d.Distributor, 
				r.Region 										  
		FROM RegionSales AS d
			CROSS JOIN 
			RegionSales AS r) AS cross_join  
				LEFT JOIN RegionSales AS r_s
							ON r_s.Distributor = cross_join.Distributor 
								AND r_s.Region = cross_join.Region

--2. Find managers with at least five direct reports
--SELECT * FROM Employee

SELECT name FROM Employee
WHERE id IN(SELECT managerId 
		FROM Employee  
		GROUP BY managerId
		HAVING COUNT(*) >= 5)

--3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
--SELECT * FROM Products
--SELECT * FROM Orders

SELECT	product_name, 
		SUM(unit) AS unit
FROM Products AS P 
		JOIN	(
				SELECT * FROM Orders
				WHERE DATEPART(month, order_date) = 02 
						AND product_id IN (
									SELECT product_id FROM Orders
									Group BY product_id
									HAVING SUM(unit) > = 100
									) 
				) AS O ON P.product_id = O.product_id
GROUP BY product_name
HAVING SUM(unit) >= 100

--4. Write an SQL statement that returns the vendor from which each customer has placed the most orders
--SELECT * FROM Orders2

SELECT	CustomerID, 
		Vendor 
FROM Orders2
WHERE Count IN(
			SELECT MAX(Count) 
			FROM Orders2 
			GROUP BY CustomerID)

--5. You will be given a number as a variable called @Check_Prime check if this number is prime 
		--then return 'This number is prime' else return 'This number is not prime'
DECLARE @Check_Prime INT = 91;
DECLARE @is_prime

-- Step 1: Handle numbers less than 2
IF @Check_Prime < 2
BEGIN
    PRINT 'This number is not prime';
END
ELSE
BEGIN
    -- Step 2: Recursive CTE to generate numbers from 2 to FLOOR(SQRT(@Check_Prime))
    ;WITH NumbersCTE AS (
        SELECT 2 AS num
        UNION ALL
        SELECT num + 1
        FROM NumbersCTE
        WHERE num + 1 <= FLOOR(SQRT(@Check_Prime))
    )
    -- Step 3: Check if any number divides @Check_Prime
    SELECT @is_prime = 
        CASE 
            WHEN EXISTS (
                SELECT 1 
                FROM NumbersCTE 
                WHERE @Check_Prime % num = 0
            )
            THEN 0
            ELSE 1
        END
    OPTION (MAXRECURSION 1000);  -- Prevent infinite loops

    -- Step 4: Print result
    IF @is_prime = 1
        PRINT 'This number is prime';
    ELSE
        PRINT 'This number is not prime';
END

--6. Write an SQL query to return the number of locations,in which location most signals sent, 
		--and total number of signal for each device from the given table.
--SELECT * FROM Device
----

SELECT MAX(Device_id) AS max_device FROM Device GROUP BY Device_id
----
SELECT COUNT(Locations) AS number_of_location FROM Device GROUP BY Locations
----
SELECT Locations FROM Device GROUP BY Locations
-----
SELECT COUNT (Device_id) AS number_of_device FROM Device GROUP BY Device_id


--7. Write a SQL to find all Employees who earn more than the average salary in their corresponding department. 
		--Return EmpID, EmpName,Salary in your output
--SELECT * FROM Employee2;

SELECT emp1.EmpID, emp1.EmpName, emp1.Salary
FROM Employee2 AS emp1
WHERE emp1.Salary IN
			(
			SELECT AVG(Salary) AS avg_salary 
			FROM Employee2 AS emp2 
			WHERE emp2.DeptID = emp1.DeptID
			)
UNION ALL
SELECT emp1.EmpID, emp1.EmpName, emp1.Salary
FROM Employee2 AS emp1
WHERE emp1.Salary >
			(
			SELECT AVG(Salary) AS avg_salary 
			FROM Employee2 AS emp2 
			WHERE emp2.DeptID = emp1.DeptID
			)
ORDER BY EmpID

--8.You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers. 
		--If a ticket has some but not all the winning numbers, you win $10. If a ticket has all the winning numbers, you win $100. 
				--Calculate the total winnings for today’s drawing.
--SELECT * FROM Numbers
--SELECT * FROM Tickets

;WITH CTE_WinningCount AS (
	SELECT COUNT(*) AS total_win_nums
	FROM Numbers
),
CTE_TicketMatches AS (
	SELECT 
		t.TicketID,
		COUNT(*) AS matched_count
	FROM Tickets As t
	JOIN Numbers AS n
		ON t.Number = n.Number
	GROUP BY t.TicketID
),
CTE_TicketWinning AS (
	SELECT 
		tm.TicketID,
		CASE
			WHEN tm.matched_count = wc.total_win_nums THEN 100
			WHEN tm.matched_count > 0 THEN 10
			ELSE 0
		END AS prize
	FROM CTE_TicketMatches AS tm
	CROSS JOIN CTE_WinningCount AS wc
)
SELECT SUM(prize) AS total_winnings
FROM CTE_TicketWinning

--9. Write an SQL query to find the total number of users and the total amount spent using mobile only,
		--desktop only and both mobile and desktop together for each date.
--SELECT * FROM Spending
/*
;WITH CTE_1 AS
	(
	SELECT 
			User_id,
			SUM(Amount) AS total_amount,
			MAX(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) AS used_m,
			MAX(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) AS used_d,
			MAX(CASE WHEN Platform = 'Mobile' and Platform = 'Desktop' THEN 1 ELSE 0 END) AS used_both
	FROM Spending 
	GROUP BY User_id, platform, Amount

	) 
SELECT	SUM(used_m) AS Mobile_used, 
		SUM(used_d) Desktop_used, 
		SUM(used_both) AS Both_used,
		SUM(total_amount) AS total_amount_spent
FROM CTE_1
*/
-------------------------
--SELECT * FROM Spending

WITH DeviceUsage AS (
    SELECT
        user_id,
        Spend_date,
        MAX(CASE WHEN Platform = 'mobile' THEN 1 ELSE 0 END) AS used_mobile,
        MAX(CASE WHEN Platform = 'desktop' THEN 1 ELSE 0 END) AS used_desktop
    FROM Spending
    GROUP BY user_id, Spend_date
),
UsageType AS (
    SELECT
        user_id,
        Spend_date,
        CASE 
            WHEN used_mobile = 1 AND used_desktop = 0 THEN 'mobile_only'
            WHEN used_mobile = 0 AND used_desktop = 1 THEN 'desktop_only'
            WHEN used_mobile = 1 AND used_desktop = 1 THEN 'both'
        END AS usage_type
    FROM DeviceUsage
),
UserAmount AS (
    SELECT
        user_id,
        Spend_date,
        SUM(Amount) AS total_amount
    FROM Spending
    GROUP BY user_id, Spend_date
),
ClassifiedUsage AS (
    SELECT
        ut.Spend_date,
        ut.usage_type,
        ua.user_id,
        ua.total_amount
    FROM UsageType ut
    JOIN UserAmount ua
      ON ut.user_id = ua.user_id AND ut.Spend_date = ua.Spend_date
)
SELECT
    Spend_date,
    usage_type,
    COUNT(DISTINCT user_id) AS total_users,
    SUM(total_amount) AS total_amount_spent
FROM ClassifiedUsage
GROUP BY Spend_date, usage_type
ORDER BY Spend_date, usage_type;

--10. Write an SQL Statement to de-group the following data.

SELECT * FROM Grouped

;WITH CTE_gr AS(
		SELECT Product, 1 AS e
		FROM Grouped
		UNION ALL
		SELECT Product, 1 AS n
		FROM Grouped
		UNION ALL
		SELECT Product, 1 AS p
		FROM Grouped
		)
SELECT * FROM CTE_gr

