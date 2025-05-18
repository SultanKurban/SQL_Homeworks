1.Select ProductName as Name, * from Products

2.Select * from Customers as Client

3.Select * from Products
Union
Select * from Products_Discounted

4.Select * from Products
Intersect
Select * from Products_Discounted

5.Select distinct CustomerName, Country from Customers

6.Select * ,Case When Price > 1000 Then 'High'
		Else 'Low'
		End
From Products

7.Select *,IIF (StockQuantity > 100, 'Yes', 'No')  
		As NewStock
from Products_Discounted
		
8.Select * from Products
Union
Select * from Products_Discounted

9.Select * from Products
Except
Select * from Products_Discounted

10.Select *, IIF (Price > 1000, 'Expensive', 'Affordable')
		As Conditional
from Products

11.Select * from Employees
where Age < 25 or Salary > 60000

12.UPDATE Employees
SET Salary = Salary * 1.10
WHERE Department = 'HR' OR EmployeeID = 5;

13.Select *, Case
		When SaleAmount > 500 Then 'Top Tier'
		When SaleAmount < 500 and SaleAmount > 200 Then 'Mid Tier'
		Else 'Low Tier'
		End
From Sales

14.Select * from Orders
Except
Select * from Sales

15.Select *,	Case
				When Quantity = 1 then '3%'
				When Quantity Between 1 and 3 then '5%'
			Else '7%'
			End As Discount
from Orders
