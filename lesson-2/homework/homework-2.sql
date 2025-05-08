1.Create table Employees (
	EmpID INT,
	Name VARCHAR(50),
	Salary DECIMAL(10,2)
);

2.Insert into Employees (EmpID, Name, Salary) Values (1,'Komila', 150000), (2, 'Madina', 200000), (3, 'Xusan', 250000)
  Insert into Employees (EmpID, Name, Salary) 
	Values 
		(4, 'Ozodbek', 225000),
		(5, 'Asadbek', 325000),
		(6, 'Hilola', 250000)

3.UPDATE Employees
	Set Salary=7000
	Where EmpID in (1)

4.Delete Employees
	Where EmpID=2

5.Delete is used for deleting exact rows from the table. And it is possible roll back.
  TRUNCATE is used for deleting all rows from the table. And it is sometimes possible roll back.
  DROP is used for removing the structure of the table. And it is impossible roll back.

6.ALTER table Employees
	Alter column name VARCHAR(100)

7.ALTER table Employees
	Add Department VARCHAR(50)

8.ALTER table Employees
	Alter column Salary Float

9.Create table Departments (
	DepartmentID INT, 
	DepartmentName VARCHAR (50),
	PRIMARY KEY (DepartmentID)
);

10.Truncate table Employees

11.Insert into Departments (DepartmentName)
	Select Name
	From Employees
Insert into Departments (Salary)
	Select Salary
	From Employees

12.Update Employees
	Set Department = 'Management'
	Where Salary > 5000

13.Delete Employees
	Where EmpID<=6

14.Alter table Employees
	Drop Column Department 

15.EXEC sp_rename 'Employees', 'StaffMembers'

16.Drop table Departments

17.Create table Products (
	ProductID INT Primary Key,
	Productname Varchar,
	Category Varchar,
	Price Decimal
	);

18.ALTER TABLE Products
	ADD CONSTRAINT chk_price_positive
	CHECK (Price > 0);

19.ALTER TABLE Products
	Add StockQuantity INT Default(50)

20.EXEC sp_rename 'Products.Category', 'ProductCategory', 'Column';

21.Insert into Products (ProductID, Productname, ProductCategory, Price)
		Values	(1, 'Twix', 'chocalat', 7000),
				(2, 'Dena', 'juice', 11000),
				(3, 'Sarvelet', 'suasage', 45000),
				(4, 'Snickers', 'chocalat', 1000),
				(5, 'Lalaku', 'pampers', 90000)

22.SELECT *
INTO Products_Backup
FROM Products;

23.EXEC sp_rename 'Products', 'Inventory'

24.Alter table Inventory
	Alter column Price float

25.Alter table Inventory
	Add ProductCodeID int Identity (1000,5)
