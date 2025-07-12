
----==== HOMEWORK - 15 ==---

--1. Task: Retrieve employees who earn the minimum salary in the company. Tables: employees (columns: id, name, salary)
--SELECT * FROM employees0

SELECT *
FROM Employees0
WHERE Salary = (SELECT MIN(Salary) FROM employees0);

--2. Task: Retrieve products priced above the average price. Tables: products (columns: id, product_name, price)
--SELECT * FROM products

SELECT *
FROM products
WHERE price > (SELECT AVG(price) FROM products)
 
--3. Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" department. Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)
--SELECT * FROM departments
--SELECT * FROM employees

SELECT name FROM employees
WHERE department_id IN (SELECT id FROM departments WHERE department_name = 'Sales')

--4. Task: Retrieve customers who have not placed any orders. Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)
--SELECT * FROM customers
--SELECT * FROM orders

SELECT name FROM customers
WHERE NOT EXISTS (SELECT order_id FROM orders WHERE orders.customer_id = customers.customer_id) 
--5. Task: Retrieve products with the highest price in each category. Tables: products (columns: id, product_name, price, category_id)
--SELECT * FROM products1

SELECT * FROM products1 AS p1
WHERE price =
		(
		SELECT MAX(price) FROM products1 AS p2
		WHERE p1.category_id = p2.category_id
		)
--6. Task: Retrieve employees working in the department with the highest average salary. Tables: employees (columns: id, name, salary, department_id), departments (columns: id, department_name)
--SELECT * FROM employees1
--SELECT * FROM departments1

SELECT * FROM employees1 AS e JOIN departments1 d ON e.department_id = d.id
WHERE department_id = (SELECT TOP 1 department_id 
						FROM employees1
						GROUP BY department_id
						ORDER BY AVG(salary) DESC
						)
--7. Task: Retrieve employees earning more than the average salary in their department. Tables: employees (columns: id, name, salary, department_id)
--SELECT * FROM employees2
--SELECT AVG(salary) FROM employees2

SELECT name, salary,
	(SELECT AVG(salary) 
		FROM employees2 AS emp1 
		WHERE emp1.department_id = emp2.department_id
		) AS avg_salary 
FROM employees2 AS emp2
WHERE salary > (SELECT AVG(salary) 
					FROM employees2 AS emp1 
					WHERE emp1.department_id = emp2.department_id
					)

--8. Task: Retrieve students who received the highest grade in each course. Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)
--SELECT * FROM students
--SELECT * FROM grades

	SELECT * FROM students AS s JOIN grades As g ON s.student_id = g.student_id
	WHERE g.grade = (
					SELECT MAX(grade) FROM grades g2
					WHERE g2.course_id = g.course_id
					)
--9. Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. Tables: products (columns: id, product_name, price, category_id)
--SELECT * FROM products2

SELECT p1.id, p1.product_name, p1.category_id, p1.price
FROM products2 p1
WHERE 2 = (
    SELECT COUNT(DISTINCT p2.price)
    FROM products2 p2
    WHERE p2.category_id = p1.category_id
      AND p2.price > p1.price
);
--10. Task: Retrieve employees with salaries above the company average but below the maximum in their department. Tables: employees (columns: id, name, salary, department_id)
SELECT * FROM employees3

SELECT * FROM employees3 AS emp1
WHERE salary < (SELECT MAX(salary) FROM employees3 AS emp2 WHERE emp1.department_id = emp2.department_id)
	AND salary > (SELECT AVG(salary) FROM employees3) 
				

