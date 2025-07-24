-- แบบฝึกหัดคำสั่ง SQL ใช้ฐานข้อมูล Northwind
--1. ต้องการรหัสพนักงาน คำนำหน้า ชื่อ นามสกุล ของพนักงานที่อยู่ในเมือง London

SELECT EmployeeID, FirstName, LastName 
FROM Employees
WHERE City = 'London' 

--2. ต้องการข้อมูลสินค้าที่มีรหัสประเภท 1,2,4,8 และมีราคา ช่วง 50-100$

SELECT * 
FROM Products
WHERE (CategoryID IN (1, 2, 4, 8)) AND (UnitPrice BETWEEN 50 AND 100)

--3. ต้องการประเทศ เมือง ชื่อบริษัทลูกค้า ชื่อผู้ติดต่อ เบอร์โทร ของลูกค้าทั้งหมด

SELECT Country, City, CompanyName, ContactName, Phone 
FROM Customers
ORDER BY 1, 2, 3

--4. ข้อมูลของสินค้ารหัสประเภทที่ 1 ราคาไม่เกิน 50 หรือสินค้ารหัสประเภทที่ 8 ราคาไม่เกิน 75

SELECT * 
FROM Products
WHERE (CategoryID = 1 AND UnitPrice <= 50) 
OR (CategoryID = 8 AND UnitPrice <= 75)

--5. ชื่อบริษัทลูกค้า ที่อยู่ใน ประเทศ USA ที่ไม่มีหมายเลข FAX  เรียงตามลำดับชื่อบริษัท 

SELECT CompanyName 
FROM Customers
WHERE Country = 'USA' AND Fax IS NULL 
ORDER BY CompanyName

--6. ต้องการรหัสลูกค้า ชื่อบริษัท ชื่อผู้ติดต่อ เฉพาะ ชื่อบริษัทที่มีคำว่า 'con'

SELECT CustomerID, CompanyName, ContactName
FROM Customers
WHERE CompanyName LIKE '%con%'

--!-------------------------------------------------------------------

SELECT productID, ProductName,UnitPrice, UnitsInStock, 
   Unitprice * UnitsInStock AS StockValue
FROM Products

--?--------------------------------------------------------------------

SELECT productID as รหัสสินค้า, ProductName as สินค้า,
   UnitsInStock + UnitsOnOrder as จำนวนคงเหลือทั้งหมด,
   ReorderLevel as จุดสั่งซื้อ
FROM Products
WHERE (UnitsInStock * UnitsOnOrder) < reorderLevel

--?--------------------------------------------------------------------

SELECT productID, ProductName,UnitPrice, 
   ROUND(UnitPrice *0.07, 2) AS VAT
FROM Products

--?--------------------------------------------------------------------

SELECT employeeID, 
   TitleOfCourtesy + firstname + ' ' + lastname AS FullName
FROM Employees

--? ต้องการคำนวณรายการขายสินค้าในรายการขายที่มีรหัส 10250

SELECT * 
FROM [Order Details]
WHERE OrderID = 10250

--? คำนวณยอดส่วนลดของรายการขายที่มีรหัส 10250

SELECT *, ROUND((UnitPrice * Quantity) * (1 - Discount),2) AS NetPrice
FROM [Order Details]
WHERE OrderID = 10250

--? แสดงข้อมูลจำนวนสินค้าที่มีเก็บไว้ต่ำกว่า 15 ชิ้น

SELECT COUNT(*) จำนวนสินค้า
FROM Products
WHERE UnitsInStock < 15

SELECT COUNT(*) AS จำนวนพนักงาน
FROM Employees

SELECT COUNT(*) AS จำนวนลูกค้า
FROM Customers
WHERE Country = 'Brazil'

SELECT COUNT(*) AS สินค้าทั้งหมด
FROM [Order Details]
WHERE orderID = 10250

SELECT COUNT(*) 
FROM Orders
WHERE ShipCountry = 'Japan'

--? ต้องการราคาสินค้าต่ำสุด สูงสุด และเฉลี่ยของสินค้าทั้งหมด

SELECT MIN(UnitPrice) AS ราคาต่ำสุด, 
       MAX(UnitPrice) AS ราคาสูงสุด, 
       AVG(UnitPrice) AS ราคาเฉลี่ย
FROM Products

--? ต้องการหาค่าเฉลี่ย ราคาสูงสุด และราคาต่ำสุด ของสินค้ารหัส 5 ที่ขายได้ [order details]

SELECT AVG(UnitPrice) AS ราคาเฉลี่ย, 
       MAX(UnitPrice) AS ราคาสูงสุด, 
       MIN(UnitPrice) AS ราคาต่ำสุด
FROM [Order Details]
WHERE ProductID = 5


SELECT Country, COUNT(*) AS [num of Country]
FROM Customers
GROUP BY Country


--? ต้องการจำนวนลูกค้าในแต่ละประเทศ เรียงตามจำนวนลูกค้าจากมากไปน้อย
SELECT country, COUNT(*) AS [num of Customers]
FROM Customers
GROUP BY Country
ORDER BY [num of Customers] DESC


--? ต้องการจำนวนลูกค้าในแต่ละประเทศและเมือง เรียงตามจำนวนลูกค้าจากมากไปน้อย
SELECT country, City, COUNT(*) AS [num of Customers]
FROM Customers
GROUP BY Country, City
ORDER BY [num of Customers] DESC


--? ต้องการใบสั่งซื้อที่ส่งไปแต่ละประเทศ 
SELECT ShipCountry, COUNT(*) AS [num of Orders]
FROM Orders
GROUP BY ShipCountry


SELECT ShipCountry, COUNT(*) AS [num of Orders]
FROM Orders
GROUP BY ShipCountry
HAVING COUNT(*) > 100


--?ต้องการจำนวนใบสั่งซื้อที่ส่งไปในแต่ละประเทศเฉพาะในปี 1997

SELECT ShipCountry, COUNT(*) AS [num of Orders]
FROM Orders
WHERE YEAR(OrderDate) = 1997
GROUP BY ShipCountry
HAVING COUNT(*) > 100

SELECT ShipCountry, COUNT(*) AS [num of Orders]
FROM Orders
WHERE YEAR(OrderDate) = 1997
GROUP BY ShipCountry
HAVING COUNT(*) < 5

--? ต้องการรหัสสินค้า จำนวนที่ขายได้ทั้งหมด
SELECT ProductID, SUM(Quantity) AS TotalSold
FROM [Order Details]
GROUP BY ProductID
ORDER BY ProductID

--?ต้องการรหัสสินค้า จำนวนที่ขายได้ทั้งหมด ราคาสูงสุดและราคาต่ำสุด ราคาเฉลี่ย
SELECT ProductID, 
       SUM(Quantity) AS TotalSold, 
       MAX(UnitPrice) AS MaxPrice, 
       MIN(UnitPrice) AS MinPrice, 
       AVG(UnitPrice) AS AvgPrice
FROM [Order Details]
GROUP BY ProductID
HAVING SUM(Quantity) > 1000
ORDER BY ProductID


--? ต้องการรหัสใบสั่งซื้อ และยอดขายรวมของแต่ละใบสั่งซื้อ
SELECT orderID, ROUND(sum(UnitPrice * Quantity * (1 - Discount)), 2) AS TotalPrice
FROM [Order Details]
GROUP BY OrderID