1. Data is a source of collected facts or statistics. Data consists of texts, images, tables, figures, numbers. In other word we can say that data is unprocessed facts or statistics. There are two types of datas: structured and unstructured.
   Database is actually integrated all structured data in one digital base. This integration process may be done on base a spcecial tool. For example, MsAcces, SQL, Oracle.
   Relational database is a database that data is stored in some related tables of columns and rows. It is easy to see and control the relational database because of all information are given in structured tables.
   Table is one important element of database and is used to store all data in rows (horizontally) and columns (vertically). The table allow the user to see and understand how the data in the database is organized.

2. Server is a computer system what is used for providing information to clients and users via the network. The server responds to requests of clients and users when the clients and users wants to get the necessary data from the database.
   	SQL server is a system for controlling related database which is created by Microsoft.
	SQL server runs on Windows, Linux, Unix, OS/2.
	SQL server supports different types of data: float, integer, char, varchar. 
	The necessary data is gained from the SQL server with helping a query. 
	It is given the five key features of SQL Server in the following line:
	Security, Encrypted, Intelligent query processing, Memory managament, Analytics.

3. When using SQL Server Authentication, logins and passwords are created in SQL Server that aren't based on Windows user accounts.
	When using Windows Authentication the account name and password are taken in the operating system.
	SQL Server Authentication is less secure than Windows Authentication.
	SQL Server Authentication users have to set strong passwords.  

4.Open a New Query in SSMS. 
	Write the following code:
		CREATE DATABASE SchoolDB;
		GO
	Click Execute.

5.	CREATE TABLE Students (
		StudentID INT,
		Name VARCHAR(50),
		Age INT,
		PRIMARY KEY (StudentID)
	);

6. SQL server is relational database management system (RDBMS). It is used for storage and manage database with helping SQL. 
   SSMS (SQL Server Management Studio) is a tool for managing SQL server. It is used for writing and developing SQL queries on the graphical user interface.
   SQL (Structured Query Language) is a language. It is designed to work with relational database. 

7. SQL consists of five types of commands. These are:
	DQL (Data Query Language) commands are used for getting required data from the within scheme objects. And the result is compiled into a temporary table. SELECT is a DQL command.
	DML (Data Manipulation Language) commands are used for manipulating data in the database. Actually, DML commands are used more than other types of commands in processing database. Some examples of DML commands are given: INSERT, UPDATE, DELETE, LOCK and etc.
	DDL (Data Defenition Lnaguage) commands are usually the main commands of SQL. These commands are used for defining, deleting and altering tables and indexes of database. CREATE, DROP, ALTER, RENAME are DDL commands.
	DCL (Data Contol Language) commands are used for controlling access to data of the database. DCL consists of GRANT (for granting) and REVOKE (for revoking). 
	TCL (Transaction Control language) commands are used for transaction group a set of tasks with just one command. Each transaction begins only task and ends when all the tasks in the group are successfully completed. BEGIN TRANSACTION, COMMIT, ROLLBACK, SAVEPOINT are the commands of TCL.

8. INSERT INTO Students (StudentID, Name, Age)
	VALUES 
		(1, 'Komila', 20),
		(2, 'Xasan', 24),
		(3, 'Madina', 22);

9. 	1-step. Find and download the Restore AdventureWorksDW2022.bak file from this link :https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak
	2-step. Copy and paste the dowloaded file to C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup in your computer.
	3-step. Open SSMS, choose the folder Databases and click right of mouse and choose Restore Database.
	4-step. Choose Device from Source and Open Select Backup devices. Click on Add and find the AdventureWorksDW2022.bak file from your computer and press OK. 

