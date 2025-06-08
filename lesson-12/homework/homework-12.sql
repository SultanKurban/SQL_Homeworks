
----HOMEWORK - 12 ---

---1. Combine Two Tables
/* 
----person table 
| personId | lastName | firstName |
+----------+----------+-----------+
| 1        | Wang     | Allen     |
| 2        | Alice    | Bob       |

---adress table
| addressId | personId | city          | state      |
+-----------+----------+---------------+------------+
| 1         | 2        | New York City | New York   |
| 2         | 3        | Leetcode      | California |

--Output
| firstName | lastName | city          | state    |
+-----------+----------+---------------+----------+
| Allen     | Wang     | Null          | Null     |
| Bob       | Alice    | New York City | New York |
*/

SELECT firstName, lastName, city, state 
FROM Person LEFT JOIN Address 
ON Person.personId = Address.personId

---2. Employees Earning More Than Their Managers

/*
---Employee table
| id | name  | salary | managerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | Null      |
| 4  | Max   | 90000  | Null      |

| id | name  | salary | managerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | Null      |
| 4  | Max   | 90000  | Null      |

| Employee |
+----------+
| Joe      |
*/

SELECT Employee1.name AS Employee
FROM Employee AS Employee1 INNER JOIN Employee AS Employee2 
ON Employee1.managerId = Employee2.id
WHERE Employee1.salary > Employee2.salary

---3. Duplicate Emails

SELECT DISTINCT P1.email 
FROM Person AS P1  INNER JOIN Person AS P2 
ON	P1.email = P2.email 
	and P1.id != P2.id

---4. Delete Duplicate Emails	

SELECT * FROM Person
DELETE P1 
FROM Person AS P1 
INNER JOIN Person AS P2 
ON	P1.email = P2.email 
and P1.id > P2.id

---5. Find those parents who has only girls.

SELECT DISTINCT girls.ParentName
FROM boys FULL JOIN girls 
ON boys.ParentName = girls.ParentName
WHERE boys.id IS NULL

---6.Total over 50 and least
---PUZZLE. Find total Sales amount for the orders which weights more than 50 for each customer along with their least weight.
			--(from TSQL2012 database, Sales.Orders Table)

SELECT	custid, 
		SUM(freight) AS Total_sales_amount, 
		MIN(freight) AS Least_freight 
FROM TSQL2012.Sales.Orders
WHERE freight > 50
GROUP BY custid

---7. Carts
--Expected table
/*
| Item Cart 1 | Item Cart 2 |  
|-------------|-------------|  
| Sugar       | Sugar       | 
| Bread       | Bread       |  
| Juice       |             |  
| Soda        |             |  
| Flour       |             |
|             | Butter      |  
|             | Cheese      |  
|             | Fruit       |
*/

SELECT	ISNULL(Cart1.Item, '') AS ItemCart1,
		ISNULL(Cart2.Item, '') AS ItemCart2,
  CASE	WHEN Cart1.Item IS NOT NULL AND Cart2.ITEM IS NOT NULL THEN 0
		WHEN Cart2.ITEM IS NULL THEN 1
	   	    ELSE 2
	   END AS STATUS_NUM
FROM Cart1 FULL JOIN Cart2 ON Cart1.Item = Cart2.Item
Order BY STATUS_NUM

----8. Customers Who Never Order
/*
| Customers |
+-----------+
| Henry     |
| Max       |
*/

SELECT name AS Customers
FROM Customers FULL JOIN Orders 
ON Customers.id = Orders.customerId
WHERE Orders.id IS NULL

---9.Students and Examinations

/*
Write a solution to find the number of times each student attended each exam.
Return the result table ordered by student_id and subject_name.
The result format is in the following example.

Output table

| student_id | student_name | subject_name | attended_exams |
+------------+--------------+--------------+----------------+
| 1          | Alice        | Math         | 3              |
| 1          | Alice        | Physics      | 2              |
| 1          | Alice        | Programming  | 1              |
| 2          | Bob          | Math         | 1              |
| 2          | Bob          | Physics      | 0              |
| 2          | Bob          | Programming  | 1              |
| 6          | Alex         | Math         | 0              |
| 6          | Alex         | Physics      | 0              |
| 6          | Alex         | Programming  | 0              |
| 13         | John         | Math         | 1              |
| 13         | John         | Physics      | 1              |
| 13         | John         | Programming  | 1              |
*/

SELECT 
    s.student_id, 
    s.student_name, 
    subj.subject_name,
    COUNT(e.student_id) AS exam_count
FROM Students s
CROSS JOIN (
    SELECT DISTINCT subject_name FROM Examinations
) subj
LEFT JOIN Examinations e 
    ON s.student_id = e.student_id 
    AND subj.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, subj.subject_name
ORDER BY s.student_id, subj.subject_name;
