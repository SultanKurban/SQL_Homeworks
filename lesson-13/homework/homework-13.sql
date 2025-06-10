
----HOMEWORK - 13 ----

--1.You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table.

SELECT CONCAT(EMPLOYEE_ID, '-', FIRST_NAME,' ', LAST_NAME) AS Full_name FROM Employees

--2.Update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'

SELECT  REPLACE(PHONE_NUMBER, '124', '999') AS Replacing_phone_number FROM Employees

--3.That displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. 
		--Give each column an appropriate label. Sort the results by the employees' first names.(Employees)

SELECT FIRST_NAME, LEN(FIRST_NAME) AS LENGTH_F_N FROM Employees
WHERE FIRST_NAME LIKE '[AJM]%'
ORDER BY FIRST_NAME

--4.Write an SQL query to find the total salary for each manager ID.(Employees table)

SELECT MANAGER_ID, SUM(Salary) AS TOTAL_SALARY
FROM Employees
GROUP BY MANAGER_ID

--5.Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table

SELECT Year1, GREATEST(Max1,Max2,Max3) FROM TestMax

--6.Find me odd numbered movies and description is not boring.(cinema)

SELECT * 
FROM cinema
WHERE id % 2 = 1 and description NOT LIKE 'boring'

--7.You have to sort data based on the Id but Id with 0 should always be the last row. 
		--Now the question is can you do that with a single order by column.(SingleOrder)

SELECT * FROM SingleOrder
ORDER BY 
	CASE WHEN id=0 THEN 1
		 ELSE 0
	END, id 

--8.Write an SQL query to select the first non-null value from a set of columns. 
		--If the first column is null, move to the next, and so on. If all columns are null, return null.(person)

SELECT * FROM person
SELECT COALESCE(ssn, passportid, itin) AS first_non_null
FROM person;

--9.Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)

SELECT
  PARSENAME(REPLACE(FullName, ' ', '.'), 3) AS FirstName,
  PARSENAME(REPLACE(FullName, ' ', '.'), 2) AS MiddleName,
  PARSENAME(REPLACE(FullName, ' ', '.'), 1) AS LastName
FROM Students;

--10.For every customer that had a delivery to California, 
		--provide a result set of the customer orders that were delivered to Texas. (Orders Table)

SELECT table1.CustomerID, table1.OrderID, table1.DeliveryState 
FROM Orders table1 
JOIN (
	SELECT * FROM Orders
	WHERE DeliveryState = 'CA'
) table2  
ON table1.CustomerID = table2.CustomerID
WHERE table1.DeliveryState ='TX'

--11.Write an SQL statement that can group concatenate the following values.(DMLTable)

SELECT STRING_AGG(String, ' ') AS full_query
FROM DMLTable

--12.Find all employees whose names (concatenated first and last) contain the letter "a" at least 3 times.

SELECT CONCAT(First_name, + ' ',+LAST_NAME) AS Full_name
FROM Employees
WHERE LEN(CONCAT(First_name, + ' ',+LAST_NAME)) - LEN(REPLACE(CONCAT(First_name, + ' ',+LAST_NAME), 'a', '')) >= 3

--13.The total number of employees in each department and the percentage of those employees 
	--who have been with the company for more than 3 years(Employees)

SELECT 
  DEPARTMENT_ID,
  COUNT(*) AS TotalEmployees,
  COUNT(CASE 
           WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 
           THEN 1 
        END) AS EmployeesOver3Years,
  ROUND(
    COUNT(CASE 
             WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 
             THEN 1 
          END) * 100.0 / COUNT(*),
    2
  ) AS PercentOver3Years
FROM Employees
GROUP BY DEPARTMENT_ID;

--14.Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)

SELECT DISTINCT JobDescription, MIN(MissionCount) AS most_expeienced, MAX(MissionCount) AS least_experienced--, SpacemanID
FROM Personal
GROUP BY  JobDescription

--15.Write an SQL query that separates the uppercase letters, lowercase letters, numbers, 
		--and other characters from the given string 'tf56sd#%OqH' into separate columns.
SELECT *
FROM string_split('t,f,5,6,s,d,#,%,O,q,H',',');

--16.Write an SQL query that replaces each row with the sum of its value and the previous rows' value. (Students table)

SELECT 
    StudentID, 
	FullName,
    Grade,
    SUM(Grade) OVER (ORDER BY StudentID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS prev_rows_value
FROM Students;

--17.You are given the following table, which contains a VARCHAR column that contains mathematical equations. 
		--Sum the equations and provide the answers in the output.(Equations)

SELECT 
   equation,
  SUM(CAST(value AS INT)) AS result
FROM Equations
CROSS APPLY STRING_SPLIT(equation, '+')
GROUP BY  equation;
--18.Given the following dataset, find the students that share the same birthday.(Student Table)

SELECT DISTINCT table1.Birthday, table1.StudentName, table2.StudentName 
FROM Student AS table1 INNER JOIN Student AS table2 ON table1.StudentName != table2.StudentName 
								and table1.Birthday = table2.Birthday 

--19.You have a table with two players (Player A and Player B) and their scores. 
		--If a pair of players have multiple entries, aggregate their scores into a single row for each unique pair of players. 
		--Write an SQL query to calculate the total score for each unique player pair(PlayerScores)

SELECT 
    CASE 
        WHEN playerA < playerB THEN playerA 
        ELSE playerB 
    END AS playerA,
    CASE 
        WHEN playerA < playerB THEN playerB 
        ELSE playerA 
    END AS playerB,
    SUM(score) AS total_score
FROM PlayerScores
GROUP BY 
    CASE 
        WHEN playerA < playerB THEN playerA 
        ELSE PlayerB 
    END,
    CASE 
        WHEN playerA < playerB THEN PlayerB 
        ELSE PlayerA 
    END;
