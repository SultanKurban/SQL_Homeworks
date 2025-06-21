
----HOMEWORK - 14 ---

--1.Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)

---SELECT * FROM TestMultipleColumns
SELECT
  Name AS FullName,
  LTRIM(RTRIM(LEFT(Name, CHARINDEX(',', Name) - 1))) AS Name,
  LTRIM(RTRIM(SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name)))) AS Surname
FROM TestMultipleColumns
WHERE CHARINDEX(',', Name) > 0;

--2.Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)

--SELECT * FROM TestPercent
SELECT *
FROM TestPercent
WHERE CHARINDEX('%', Strs) > 0;

--3.In this puzzle you will have to split a string based on dot(.).(Splitter)

--SELECT * FROM Splitter
SELECT	SUBSTRING(Vals, 1, CHARINDEX('.',Vals)-1),
		SUBSTRING(Vals, CHARINDEX('.',Vals)+1, CHARINDEX('.',Vals)-1),
		SUBSTRING(Vals, CHARINDEX('.',Vals)+CHARINDEX('.',Vals)+1, LEN(Vals))
		FROM Splitter

---CHARINDEX(substring, string, start)
---SUBSTRING(string, start, length)
---PATINDEX(%pattern%, string)
---REPLACE(string, from_string, new_string)
---TRANSLATE(string, characters, translations)

--4.Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)

SELECT TRANSLATE('1234ABC123456XYZ1234567890ADS', '0123456789', 'XXXXXXXXXX') AS result;

--5.Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)
---testDots

SELECT *
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2 
;

--6.Write a SQL query to count the spaces present in the string.(CountSpaces)
--SELECT * FROM CountSpaces

SELECT 
LEN(texts) - LEN(REPLACE(texts, ' ', ''))
FROM CountSpaces

--7.write a SQL query that finds out employees who earn more than their managers.(Employee)
--SELECT * FROM Employee

SELECT e.Id, e.Name, e.Salary
FROM Employee AS e JOIN Employee AS m ON e.ManagerId = m.Id
WHERE e.Salary > m.Salary

--8.Find the employees who have been with the company for more than 10 years, but less than 15 years. 
		--Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service 
			--(calculated as the number of years between the current date and the hire date).(Employees)
--SELECT * FROM Employees

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS Years_of_Service
FROM Employees
WHERE DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 15

--9.Write a SQL query to separate the integer values and the character values into two different columns.(rtcfvty34redt)

SELECT 
    'rtcfvty34redt' AS original,
        REPLACE(TRANSLATE('rtcfvty34redt', '0123456789', REPLICATE(' ', 10)), ' ', '') AS letters,
		REPLACE(TRANSLATE('rtcfvty34redt', 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', REPLICATE(' ', 52)), ' ', '') AS numbers;
	
--10.write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)
--SELECT * FROM weather

SELECT t2.RecordDate
FROM weather AS t1 
JOIN weather AS t2 
	ON t2.RecordDate = DATEADD(DAY, 1, t1.RecordDate)
WHERE t1.Temperature < t2.Temperature

--11.Write an SQL query that reports the first login date for each player.(Activity)

---CHARINDEX(substring, string, start)
---SUBSTRING(string, start, length)
---PATINDEX(%pattern%, string)
---REPLACE(string, from_string, new_string)
---TRANSLATE(string, characters, translations)
 
--SELECT * FROM Activity

SELECT player_id,  MIN(event_date) AS first_login_date
FROM Activity
--WHERE games_played > 0
GROUP BY player_id

--12.Your task is to return the third item from that list.(fruits)
--SELECT * FROM fruits

DECLARE @fruits VARCHAR(100) = 'apple.banana.orange.pear';

SELECT 
    x.value('.', 'VARCHAR(100)') AS third_fruit
FROM (
    SELECT CAST('<x>' + REPLACE(@fruits, '.', '</x><x>') + '</x>' AS XML) AS fruit_xml
) AS t
CROSS APPLY fruit_xml.nodes('/x[3]') AS Split(x);

--13.Write a SQL query to create a table where each character from the string will be converted into a row.(sdgfhsdgfhs@121313131)
--SELECT 'sdgfhsdgfhs@121313131' 
---SUBSTRING(string, start, length)

DECLARE @str VARCHAR(MAX) = 'sdgfhsdgfhs@121313131';

SELECT 
    n AS Position,
    SUBSTRING(@str, n, 1) AS Character
INTO CharactersTable1
FROM (
    SELECT TOP (LEN(@str))
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects
) AS Numbers;

--14.You are given two tables: p1 and p2. Join these tables on the id column. 
		--The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)
--SELECT * FROM p1
--SELECT * FROM p2
---REPLACE(string, from_string, new_string)

SELECT p1.id, 
	CASE 
		WHEN p1.code=0 THEN p2.code
		ELSE p1.code
	END AS replaced_code
FROM p1 INNER JOIN p2 ON p1.id = p2.id

--15.Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:
		--If the employee has worked for less than 1 year → 'New Hire'
		--If the employee has worked for 1 to 5 years → 'Junior'
		--If the employee has worked for 5 to 10 years → 'Mid-Level'
		--If the employee has worked for 10 to 20 years → 'Senior'
		--If the employee has worked for more than 20 years → 'Veteran'(Employees)
--SELECT * FROM Employees

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS Years_of_Service,
CASE 
	WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'NEw Hire'
	WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 1 AND 5 THEN 'Junior'
	WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 5 AND 10 THEN 'Mid-Level'
	WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 20 THEN 'Senior'
	ELSE 'Veteran'
END AS Emp_stage
FROM Employees

--16.Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)
--SELECT * FROM GetIntegers

SELECT 
    ID,
    Vals,
    CAST(
        LEFT(Vals, 
             PATINDEX('%[^0-9]%', Vals + 'a') - 1
        ) AS INT
    ) AS StartingInteger
FROM GetIntegers
WHERE 
    PATINDEX('[0-9]%', Vals) = 1;

---CHARINDEX(substring, string, start)
---SUBSTRING(string, start, length)
---PATINDEX(%pattern%, string)
---REPLACE(string, from_string, new_string)
---TRANSLATE(string, characters, translations)

--17.In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)
--SELECT * FROM MultipleVals

SELECT 
    ID,
    STUFF(
        STUFF(Vals, 1, 1, SUBSTRING(Vals, CHARINDEX(',', Vals) + 1, 1)),
        CHARINDEX(',', Vals) + 1, 
        1, 
        LEFT(Vals, 1)
    ) AS SwappedValue
FROM MultipleVals
--18.Write a SQL query that reports the device that is first logged in for each player.(Activity)
--SELECT * FROM Activity

SELECT device_id,  MIN(event_date) AS first_login_date
FROM Activity
--WHERE games_played > 0
GROUP BY device_id

--19.You are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week. 
	--For each week, the total sales will be considered 100%, 
	--and the percentage sales for each day of the week should be calculated based on the area sales for that week.(WeekPercentagePuzzle)
--SELECT * FROM WeekPercentagePuzzle

SELECT
    Area,
    [Date],
    DayName,
    FinancialWeek,
    FinancialYear,
    SalesLocal,
    SalesRemote,
    (ISNULL(SalesLocal, 0) + ISNULL(SalesRemote, 0)) AS DailySales,
    SUM(ISNULL(SalesLocal, 0) + ISNULL(SalesRemote, 0)) 
        OVER (PARTITION BY Area, FinancialYear, FinancialWeek) AS WeeklyTotal,
    ROUND(
        (ISNULL(SalesLocal, 0) + ISNULL(SalesRemote, 0)) * 100.0 /
        NULLIF(SUM(ISNULL(SalesLocal, 0) + ISNULL(SalesRemote, 0)) 
            OVER (PARTITION BY Area, FinancialYear, FinancialWeek), 0),
        2
    ) AS PercentageOfWeek
FROM WeekPercentagePuzzle
WHERE SalesLocal IS NOT NULL OR SalesRemote IS NOT NULL
ORDER BY Area, FinancialYear, FinancialWeek, [Date];
