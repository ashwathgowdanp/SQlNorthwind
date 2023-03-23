-- Select all customers
select * from customers;

--Get distinct countries from the Customers table.
select distinct country from customers;

-- Get all the rows from the table Customers where the Customer’s ID starts with “BL”.
select * from customers where customers.CustomerID like 'BL%';

--Get the first 100 records of the orders table. DISCUSS: Why would you do this? What else would you likely need to include in this query?
-- Looks like for better performance order by needs to be added to the query
SELECT TOP (100) [OrderID]
      ,[CustomerID]
      ,[EmployeeID]
      ,[OrderDate]
      ,[RequiredDate]
      ,[ShippedDate]
      ,[ShipVia]
      ,[Freight]
      ,[ShipName]
      ,[ShipAddress]
      ,[ShipCity]
      ,[ShipRegion]
      ,[ShipPostalCode]
      ,[ShipCountry]
  FROM [NORTHWND].[dbo].[Orders]

  --Get all customers that live in the postal codes 1010, 3012, 12209, and 05023.

  select * from customers where customers.postalcode = '1010' or 
                                customers.postalcode = '12209' or
								customers.postalcode = '05023';

-- Get all orders where the ShipRegion is not equal to NULL.

select * from orders where orders.ShipRegion is not null;

-- Get all customers ordered by the country, then by the city.

select * from customers order by customers.country, customers.city;

-- Add a new customer to the customers table. You can use whatever values.

insert into customers (CustomerID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax)
values('AS345','Rock Ventures','John','Sales manger','21486 gill rd','Novi',Null,48867,'USA',732-812-1199,Null);

-- Update all ShipRegion to the value ‘EuroZone’ in the Orders table, where the ShipCountry is equal to France.  
update orders
set orders.ShipRegion = 'EuroZone' where orders.ShipCountry = 'France';

select * from orders where orders.ShipRegion = 'EuroZone' ;

--Delete all orders from OrderDetails that have quantity of 1. 

delete from [Order Details] where [Order Details].quantity = 1;
select * from [Order Details] where [Order Details].Quantity = 1;

--Find the CustomerID that placed order 10290 (orders table).
select orders.CustomerID from orders where orders.OrderID = 10290;

--Join the orders table to the customers table. 

select Customers.CustomerID, orders.orderid
 from customers 
 inner join orders on orders.customerid = customers.customerid;

 --Get employees’ firstname for all employees who report to no one.

 select Employees.firstname from Employees where employees.ReportsTo is null;

 --Get employees’ firstname for all employees who report to Andrew.

 select Employees.firstname, Employees.ReportsTo, Employees_1.firstname from Employees inner join 
Employees Employees_1 on  Employees.ReportsTo = Employees_1.EmployeeID and Employees_1.firstname = 'Andrew';

--Calculate the average, max, and min of the quantity at the orderdetails table, grouped by the orderid.

select  max(quantity) as max_quantity, min(quantity) as min_quantity, avg(quantity) as average_quantity from [Order Details] group by orderid;

-- Calculate the average, max, and min of the quantity at the orderdetails table.

select  max(quantity), min(quantity), avg(quantity) from [Order Details];

-- Find all customers living in London or Paris
select * from customers where customers.City = 'london' or customers.City = 'Paris';

--Do an inner join, left join, right join on orders and customers tables. 

select *
 from orders 
 inner join customers on orders.customerid = customers.customerid;

 select *
 from customers 
 left join orders on orders.customerid = customers.customerid;

 select *
 from customers 
 right join orders on orders.customerid = customers.customerid;

 /* Make a list of cities where customers are coming from. The list should not have any duplicates or nulls. */

 select distinct customers.city from customers where customers.city is not null; 

 /* Show a sorted list of employees’ first names. */

 select * from Employees order by Employees.FirstName;

 /* Find total for each order */
 select unitprice,Quantity,unitprice*Quantity as total
  from [Order Details]
  left join orders  on orders.OrderID = [Order Details].OrderID;

  /* Get a list of all employees who got hired between 1/1/1994 and today */

  select * from employees where employees.HireDate >= '1994-01-01' and  employees.HireDate <= getdate();

  /* Find how long employees have been working for Northwind (in years!) */
 
     SELECT Employeeid, firstname, lastname, Hiredate, title,
	     DATEDIFF(year, Hiredate, GETDATE()) AS NumberofYears
    
      FROM EMPLOYEEs;

	  /* Get a list of all products sorted by quantity (ascending and descending order) */

	  select ProductId, productname, UnitsInStock from products
	  order by UnitsInStock ASC;

	  select ProductId, productname, UnitsInStock from products
	  order by UnitsInStock DESC;

 /* Find all products that are low on stock (quantity less than 6)
 */
 select ProductId, productname, UnitsInStock from products
 where Products.UnitsInStock < 6;

 /* Find a list of all discontinued products. */

 select ProductId, productname, Discontinued from products
 where Discontinued = 1;

/*  Find a list of all products that have Tofu in the product name. */

select ProductId, productname from products
 where productname like '%Tofu%';
 
 /* Find the product that has the highest unit price. 
 */
 select max(products.Unitprice) as price from products;

 /* Get a list of all employees who got hired after 1/1/1993
 */

 select Employees.LastName, Employees.FirstName, Employees.HireDate from Employees
 where Employees.HireDate > '1/1/1993';

 /* Get all employees who have title : “Ms.” And “Mrs.” */

 select Employees.LastName, Employees.FirstName, Employees.Title, Employees.titleofcourtesy from employees
 where employees.titleofcourtesy like '%Ms.' or
       employees.titleofcourtesy like '%Mrs.';

	   /* Get all employees who have a Home phone number that has area code 206 */

select Employees.LastName, Employees.FirstName, Employees.HomePhone from employees
where employees.HomePhone like '(206)%';

 
