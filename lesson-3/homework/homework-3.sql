1. Bulk insert is used for importing data from externel text files (.txt or .cvs).
	In this case used following: Bulk insert TableName 
					From 'C:\Path\filename.cvs'
					With (
						Fieldterminator = ',',
						Rowterminator = '\n',
						Firstrow = 2
					);

2. CSV (Comma-Separated Values), TXT (Plain text), XML, DAT (data files)

3. Create table Products (ProductID int primary key, ProductName Varchar(50), Price Decimal(10,2))

4. Insert into Products 
	Values (1, 'pencil', 3000), (2, 'book', 45000), (3, 'pen', 5000)
	

5. NULL allows column without value (empty), NOT NULL doesn't! NULL is used when the data is unknown. However, NOT NULL requiries the value.

6. Create table Products (ProductID int identity, ProductName Varchar(50) Unique, Price Decimal(10,2))
	Insert into Products 
	Values ('pencil', 3000), ('book', 45000), ('pen', 5000), ('note', 4000)

7. --Comment is used for provinding explanations or notes for SQL codes. The comment doesn't affect the code and its running.
	--There are two types of comments in SQL: single line --Comment and Multi-line /*Comment*/

8.Create table Categories (CategoryID Int Primary Key, Categoryname Varchar(50) Unique)

9. The IDENTITY column in SQL Server is used to automatically generate unique numeric values for a column. 

10. Bulk insert Products
	from 'C:\Users\User\Downloads\Telegram Desktop\Products.txt'
		with (
				firstrow = 2,
				Fieldterminator = ',',
				rowterminator = '\n'
			);

11. Create table Products 
	    (ProductID Int Primary key,
	    ProductName Varchar(50),
	    Price Decimal(10,2),
	    CategoryID Int,
	    Foreign key (CategoryID) References Categories (CategoryID)
	    );

12. 	Primary key is used for identifying each record in the table, only one is allowed in a table. And also it doesn't allow null values. 
	Unique key is used for ensuring all values in the column of the table, multiple unique keys is allowed in a table. And also it allows null values.

13. Create table Products 
	    (ProductID int identity, 
	      ProductName Varchar(50) Unique, 
	      Price Decimal(10,2) Check (Price>0))

14. Alter table Products
	  Add Stock Int Not null

15. SELECT 
    	ProductID,
   	 ProductName,
   	 ISNULL(Price, 0) AS Price
	FROM Products;

16. Integrate data between raleted tables. These tables called: parent and child. In this case the value in the child must match a value in the parent table.
	
Usage:
-- Parent table	
	CREATE TABLE Categories (
  	 	 CategoryID INT PRIMARY KEY,
   	 	CategoryName VARCHAR(100)
		);

-- Child table with FOREIGN KEY
	CREATE TABLE Products (
    		ProductID INT PRIMARY KEY,
    		ProductName VARCHAR(50),
    		CategoryID INT,
    		FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

17. Create table customers (Id Int Identity, Name Varchar(50), Age Int Check(Age >=18), City Varchar(50), Unique (Name, Age))

18. Create table customer3 (Id Int Identity (100,10), Name Varchar(50), Age Int, City Varchar(50))

19.Create table OrderDetails (
	    OrderID Int,
	    ProductID Int,
	    Quantity Int,
	    Price Decimal(10,2),
	    Primary key (OrderID, ProductID)
	  );

20.Explain the use of COALESCE and ISNULL functions for handling NULL values.

	COALESCE and ISNULL functions are used for replacing Null values with a default value, but there are differnces between them.
	For example: Numbers of arguments is only 2 in ISNULL function, but multiple in COALESCE function.
	Using code: ISNULL(expression, replacement_value) and COALESCE(expr1, expr2, ..., exprN)

21.Create table Employees (
	  EmpID int Primary Key,
	  Email varchar (50) Unique
  	);

22.CREATE TABLE Customers4 (
    CustomerID INT PRIMARY KEY Identity,
    CustomerName VARCHAR(100)
	  );
Insert Customers4	
	Values ('Madina'), ('Xusan'), ('Noila')

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    FOREIGN KEY (CustomerID) 
        REFERENCES Customers4(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
  
