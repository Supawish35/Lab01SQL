
SELECT *
FROM Employees

SELECT EmployeeID, FirstName, LastName
FROM Employees

SELECT EmployeeID, FirstName, LastName
FROM Employees
WHERE City = 'London'
--? อยู่ในเมืองลอนดอน

SELECT CustomerID, City, Country
FROM Customers
SELECT DISTINCT CustomerID, City, Country
FROM Customers

--? Show CompanyName, ContactName, Phone from Customers where City is London
Select *
FROM Products
where UnitPrice > 200

Select *
FROM Products
where UnitPrice <= 5

--? Show CompanyName, ContactName, Phone from Customers where City is London or Vancouver
Select *
FROM Customers
where City = 'London' OR City = 'vancouver'

--? Show CompanyName, ContactName, Phone from Customers where City is London or Vancouver
Select *
FROM Customers
WHERE Country = 'USA' OR City = 'vancouver'

--? Show CompanyName, ContactName, Phone from Customers where Country is USA or City is vancouver
Select CompanyName, ContactName, Phone
FROM Customers
WHERE Country = 'USA' OR City = 'vancouver'

--? Show data from Products where UnitPrice is greater than 50 and UnitsInStock is less than 20
SELECT *
FROM Products
WHERE UnitPrice >= 50 and UnitsInStock < 20

--? Show data from Products where UnitPrice is between 20 and 100
SELECT *
FROM Products
WHERE UnitPrice >= 20 and UnitPrice <= 100

SELECT *
FROM Products
WHERE UnitPrice BETWEEN 50 AND 100

--? Show data from Customers where Country is Brazil, Argentina, or Mexico
SELECT *
FROM Customers
WHERE Country = 'Brazil'
    OR Country = 'Argentina'
    OR Country = 'Mexico'

SELECT *
FROM Customers
WHERE Country IN ('Brazil', 'Argentina', 'Mexico')

--? Show data from Customers where Country is Brazil, Argentina, or Mexico and does not have a fax number
SELECT *
FROM Customers
WHERE Country IN ('Brazil', 'Argentina', 'Mexico') AND fax is NULL

--? Show data from Customers where Country is Brazil, Argentina, or Mexico and has a fax number
SELECT *
FROM Customers
WHERE Country IN ('Brazil', 'Argentina', 'Mexico') AND fax is not NULL

SELECT *
FROM Customers
WHERE Country IN ('Brazil', 'Argentina', 'Mexico') AND not fax is NULL

--? Show data from Customers where Country is not 'USA' or City is not 'vancouver'
Select CompanyName, ContactName, Phone
FROM Customers
WHERE not(Country = 'USA' OR City = 'vancouver')

--? Show data from Employees where FirstName starts with 'N'
SELECT *
FROM Employees
WHERE FirstName like 'N%'
--? Show data from Employees where FirstName ends with 'N'
SELECT *
FROM Employees
WHERE FirstName like '%N'

--? Show data from Customers where Country starts with 'N'
SELECT *
FROM Customers
WHERE Country LIKE '%N'

--? Show data from Customers where CompanyName or ContactName has 'ny' in it
SELECT *
FROM Customers
WHERE CompanyName LIKE '%ny%' or ContactName LIKE '%ny%'

--? Show data from Employees where FirstName has 5 characters
SELECT *
FROM Employees
WHERE FirstName LIKE '_____'

--? Show data from Employees where FirstName has 3 characters and the second character is 'a' and the last character is 't'
SELECT *
FROM Employees
WHERE FirstName LIKE '_a%t'

--? Show data from Employees where FirstName starts with 'ars'
SELECT *
FROM Employees
WHERE FirstName LIKE '[ars]%'

--? Show data from Employees where FirstName starts with 'a' to 'm'
SELECT *
FROM Employees
WHERE FirstName LIKE '[a-m]%'

--? sorting data from Employees by FirstName in ascending order
SELECT ProductID, ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--? sorting data from Customer by ContactName in ascending order
SELECT CompanyName, ContactName
FROM Customers
ORDER BY ContactName ASC

--? sorting data from Products by CategoryID in ascending order and UnitPrice in descending order
SELECT CategoryID, ProductName, UnitPrice
FROM Products
ORDER BY CategoryID ASC, UnitPrice DESC
