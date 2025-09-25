-- 1.จงแสดงให้เห็นว่าพนักงานแต่ละคนขายสินค้าประเภท Beverage ได้เป็นจำนวนเท่าใด และเป็นจำนวนกี่ชิ้น เฉพาะครึ่งปีแรกของ 2540(ทศนิยม 4 ตำแหน่ง)
SELECT
  E.EmployeeID,
  CONCAT(E.FirstName, ' ', E.LastName) AS EmployeeName,
  CAST(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS DECIMAL(18,4)) AS TotalAmount_Beverages,
  CAST(SUM(OD.Quantity) AS DECIMAL(18,4)) AS TotalQuantity_Beverages
FROM Orders O
  JOIN [Order Details] OD ON O.OrderID = OD.OrderID
  JOIN Products P ON OD.ProductID = P.ProductID
  JOIN Categories C ON P.CategoryID = C.CategoryID
  JOIN Employees E ON O.EmployeeID = E.EmployeeID
WHERE C.CategoryName = 'Beverages'
  AND O.OrderDate >= '1997-01-01' AND O.OrderDate < '1997-07-01'
GROUP BY E.EmployeeID, CONCAT(E.FirstName, ' ', E.LastName)
ORDER BY E.EmployeeID;

-- 2.   จงแสดงชื่อบริษัทตัวแทนจำหน่าย  เบอร์โทร เบอร์แฟกซ์ ชื่อผู้ติดต่อ จำนวนชนิดสินค้าประเภท Beverage ที่จำหน่าย โดยแสดงจำนวนสินค้า จากมากไปน้อย 3 อันดับแรก
SELECT TOP 3
  S.SupplierID,
  S.CompanyName AS SupplierCompany,
  S.Phone,
  S.Fax,
  S.ContactName,
  COUNT(DISTINCT P.ProductID) AS Beverage_ProductCount
FROM Suppliers S
  JOIN Products P ON S.SupplierID = P.SupplierID
  JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE C.CategoryName = 'Beverages'
GROUP BY S.SupplierID, S.CompanyName, S.Phone, S.Fax, S.ContactName
ORDER BY COUNT(DISTINCT P.ProductID) DESC;

-- 3.   จงแสดงข้อมูลชื่อลูกค้า ชื่อผู้ติดต่อ เบอร์โทรศัพท์ ของลูกค้าที่ซื้อของในเดือน สิงหาคม 2539 ยอดรวมของการซื้อโดยแสดงเฉพาะ ลูกค้าที่ไม่มีเบอร์แฟกซ์
SELECT
  C.CustomerID,
  C.CompanyName,
  C.ContactName,
  C.Phone,
  CAST(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS DECIMAL(18,4)) AS TotalPurchased_Aug1996
FROM Customers C
  JOIN Orders O ON C.CustomerID = O.CustomerID
  JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE MONTH(O.OrderDate) = 8 AND YEAR(O.OrderDate) = 1996
  AND (C.Fax IS NULL OR LTRIM(RTRIM(C.Fax)) = '')
GROUP BY C.CustomerID, C.CompanyName, C.ContactName, C.Phone
HAVING SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) > 0
ORDER BY TotalPurchased_Aug1996 DESC;

-- 4.   แสดงรหัสสินค้า ชื่อสินค้า จำนวนที่ขายได้ทั้งหมดในปี 2541 ยอดเงินรวมที่ขายได้ทั้งหมดโดยเรียงลำดับตาม จำนวนที่ขายได้เรียงจากน้อยไปมาก พรอ้มทั้งใส่ลำดับที่ ให้กับรายการแต่ละรายการด้วย
SELECT
  ROW_NUMBER() OVER (ORDER BY SUM(OD.Quantity) ASC) AS RankAscending,
  P.ProductID,
  P.ProductName,
  CAST(SUM(OD.Quantity) AS INT) AS TotalQuantity_1998,
  CAST(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS DECIMAL(18,4)) AS TotalAmount_1998
FROM [Order Details] OD
  JOIN Orders O ON OD.OrderID = O.OrderID
  JOIN Products P ON OD.ProductID = P.ProductID
WHERE YEAR(O.OrderDate) = 1998
GROUP BY P.ProductID, P.ProductName
ORDER BY TotalQuantity_1998 ASC;

-- 5.   จงแสดงข้อมูลของสินค้าที่ขายในเดือนมกราคม 2540 เรียงตามลำดับจากมากไปน้อย 5 อันดับใส่ลำดับด้วย รวมถึงราคาเฉลี่ยที่ขายให้ลูกค้าทั้งหมดด้วย
SELECT TOP 5
  ROW_NUMBER() OVER (ORDER BY SUM(OD.Quantity) DESC) AS Rank,
  P.ProductID,
  P.ProductName,
  CAST(SUM(OD.Quantity) AS INT) AS TotalQuantity_Jan1997,
  CAST(AVG(OD.UnitPrice * (1 - OD.Discount)) AS DECIMAL(18,4)) AS AvgSoldPricePerUnit_Jan1997
FROM [Order Details] OD
  JOIN Orders O ON OD.OrderID = O.OrderID
  JOIN Products P ON OD.ProductID = P.ProductID
WHERE MONTH(O.OrderDate) = 1 AND YEAR(O.OrderDate) = 1997
GROUP BY P.ProductID, P.ProductName
ORDER BY TotalQuantity_Jan1997 DESC;

-- 6.   จงแสดงชื่อพนักงาน จำนวนใบสั่งซื้อ ยอดเงินรวมทั้งหมด ที่พนักงานแต่ละคนขายได้ ในเดือน ธันวาคม 2539 โดยแสดงเพียง 5 อันดับที่มากที่สุด
SELECT TOP 5
  CONCAT(E.FirstName, ' ', E.LastName) AS EmployeeName,
  COUNT(DISTINCT O.OrderID) AS OrderCount_Dec1996,
  CAST(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS DECIMAL(18,4)) AS TotalSales_Dec1996
FROM Employees E
  JOIN Orders O ON E.EmployeeID = O.EmployeeID
  JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE MONTH(O.OrderDate) = 12 AND YEAR(O.OrderDate) = 1996
GROUP BY CONCAT(E.FirstName, ' ', E.LastName)
ORDER BY TotalSales_Dec1996 DESC;

-- 7.   จงแสดงรหัสสินค้า ชื่อสินค้า ชื่อประเภทสินค้า ที่มียอดขาย สูงสุด 10 อันดับแรก ในเดือน ธันวาคม 2539 โดยแสดงยอดขาย และจำนวนที่ขายด้วย
SELECT TOP 10
  P.ProductID,
  P.ProductName,
  C.CategoryName,
  CAST(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS DECIMAL(18,4)) AS TotalSales_Dec1996,
  CAST(SUM(OD.Quantity) AS INT) AS TotalQuantity_Dec1996
FROM [Order Details] OD
  JOIN Orders O ON OD.OrderID = O.OrderID
  JOIN Products P ON OD.ProductID = P.ProductID
  JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE MONTH(O.OrderDate) = 12 AND YEAR(O.OrderDate) = 1996
GROUP BY P.ProductID, P.ProductName, C.CategoryName
ORDER BY TotalSales_Dec1996 DESC;

-- 8.   จงแสดงหมายเลขใบสั่งซื้อ ชื่อบริษัทลูกค้า ที่อยู่ เมืองประเทศของลูกค้า ชื่อเต็มพนักงานผู้รับผิดชอบ ยอดรวมในแต่ละใบสั่งซื้อ จำนวนรายการสินค้าในใบสั่งซื้อ และเลือกแสดงเฉพาะที่จำนวนรายการในใบสั่งซื้อมากกว่า 2 รายการ
SELECT
  O.OrderID,
  C.CompanyName AS CustomerCompany,
  C.Address,
  C.City,
  C.Country,
  CONCAT(E.FirstName, ' ', E.LastName) AS EmployeeName,
  CAST(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS DECIMAL(18,4)) AS OrderTotal,
  COUNT(OD.ProductID) AS ItemCount
FROM Orders O
  JOIN Customers C ON O.CustomerID = C.CustomerID
  JOIN Employees E ON O.EmployeeID = E.EmployeeID
  JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY O.OrderID, C.CompanyName, C.Address, C.City, C.Country, CONCAT(E.FirstName, ' ', E.LastName)
HAVING COUNT(OD.ProductID) > 2
ORDER BY O.OrderID;

-- 9.   จงแสดง ชื่อบริษัทลูกค้า ชื่อผู้ติดต่อ เบอร์โทร เบอร์แฟกซ์ ยอดที่สั่งซื้อทั้งหมดในเดือน ธันวาคม 2539 แสดงผลเฉพาะลูกค้าที่มีเบอร์แฟกซ์
SELECT
  C.CustomerID,
  C.CompanyName,
  C.ContactName,
  C.Phone,
  C.Fax,
  CAST(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS DECIMAL(18,4)) AS TotalPurchased_Dec1996
FROM Customers C
  JOIN Orders O ON C.CustomerID = O.CustomerID
  JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE MONTH(O.OrderDate) = 12 AND YEAR(O.OrderDate) = 1996
  AND (C.Fax IS NOT NULL AND LTRIM(RTRIM(C.Fax)) <> '')
GROUP BY C.CustomerID, C.CompanyName, C.ContactName, C.Phone, C.Fax
ORDER BY TotalPurchased_Dec1996 DESC;

-- 10.  จงแสดงชื่อเต็มพนักงาน จำนวนใบสั่งซื้อที่รับผิดชอบ ยอดขายรวมทั้งหมด เฉพาะในไตรมาสสุดท้ายของปี 2539 เรียงตามลำดับ มากไปน้อยและแสดงผลตัวเลขเป็นทศนิยม 4 ตำแหน่ง
SELECT
  CONCAT(E.FirstName, ' ', E.LastName) AS EmployeeName,
  COUNT(DISTINCT O.OrderID) AS OrderCount_Q4_1996,
  CAST(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS DECIMAL(18,4)) AS TotalSales_Q4_1996
FROM Employees E
  JOIN Orders O ON E.EmployeeID = O.EmployeeID
  JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE O.OrderDate >= '1996-10-01' AND O.OrderDate < '1997-01-01'
GROUP BY CONCAT(E.FirstName, ' ', E.LastName)
ORDER BY TotalSales_Q4_1996 DESC;

-- 11.  จงแสดงชื่อพนักงาน และแสดงยอดขายรวมทั้งหมด ของสินค้าที่เป็นประเภท Beverage ที่ส่งไปยังประเทศ ญี่ปุ่น
SELECT
  CONCAT(E.FirstName, ' ', E.LastName) AS EmployeeName,
  CAST(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS DECIMAL(18,4)) AS TotalSales_Beverages_To_Japan
FROM Employees E
  JOIN Orders O ON E.EmployeeID = O.EmployeeID
  JOIN [Order Details] OD ON O.OrderID = OD.OrderID
  JOIN Products P ON OD.ProductID = P.ProductID
  JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE C.CategoryName = 'Beverages'
  AND O.ShipCountry = 'Japan'
GROUP BY CONCAT(E.FirstName, ' ', E.LastName)
ORDER BY TotalSales_Beverages_To_Japan DESC;

-- 12.  แสดงรหัสบริษัทตัวแทนจำหน่าย ชื่อบริษัทตัวแทนจำหน่าย ชื่อผู้ติดต่อ เบอร์โทร ชื่อสินค้าที่ขาย เฉพาะประเภท Seafood ยอดรวมที่ขายได้แต่ละชนิด แสดงผลเป็นทศนิยม 4 ตำแหน่ง เรียงจาก มากไปน้อย 10 อันดับแรก
SELECT TOP 10
  S.SupplierID,
  S.CompanyName AS SupplierCompany,
  S.ContactName,
  S.Phone,
  P.ProductName,
  CAST(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS DECIMAL(18,4)) AS TotalSales_Seafood
FROM Suppliers S
  JOIN Products P ON S.SupplierID = P.SupplierID
  JOIN [Order Details] OD ON P.ProductID = OD.ProductID
  JOIN Orders O ON OD.OrderID = O.OrderID
  JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE C.CategoryName = 'Seafood'
GROUP BY S.SupplierID, S.CompanyName, S.ContactName, S.Phone, P.ProductName
ORDER BY TotalSales_Seafood DESC;

-- 13.  จงแสดงชื่อเต็มพนักงานทุกคน วันเกิด อายุเป็นปีและเดือน พร้อมด้วยชื่อหัวหน้า
SELECT
  CONCAT(E.FirstName, ' ', E.LastName) AS EmployeeName,
  CONVERT(VARCHAR(10), E.BirthDate, 23) AS BirthDate,
  DATEDIFF(year, E.BirthDate, GETDATE())
    - CASE WHEN DATEADD(year, DATEDIFF(year, E.BirthDate, GETDATE()), E.BirthDate) > GETDATE() THEN 1 ELSE 0 END
    AS AgeYears,
  (DATEDIFF(month, E.BirthDate, GETDATE())
    - (DATEDIFF(year, E.BirthDate, GETDATE()) * 12)) AS AgeMonths,
  CONCAT(M.FirstName, ' ', M.LastName) AS ManagerName
FROM Employees E
  LEFT JOIN Employees M ON E.ReportsTo = M.EmployeeID
ORDER BY EmployeeName;

-- 14.  จงแสดงชื่อบริษัทลูกค้าที่อยู่ในประเทศ USA และแสดงยอดเงินการซื้อสินค้าแต่ละประเภทสินค้า
SELECT
  C.CompanyName,
  Cat.CategoryName,
  CAST(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS DECIMAL(18,4)) AS TotalByCategory
FROM Customers C
  JOIN Orders O ON C.CustomerID = O.CustomerID
  JOIN [Order Details] OD ON O.OrderID = OD.OrderID
  JOIN Products P ON OD.ProductID = P.ProductID
  JOIN Categories Cat ON P.CategoryID = Cat.CategoryID
WHERE C.Country = 'USA'
GROUP BY C.CompanyName, Cat.CategoryName
ORDER BY C.CompanyName, TotalByCategory DESC;

-- 15.  แสดงข้อมูลบริษัทผู้จำหน่าย ชื่อบริษัท ชื่อสินค้าที่บริษัทนั้นจำหน่าย จำนวนสินค้าทั้งหมดที่ขายได้และราคาเฉลี่ยของสินค้าที่ขายไปแต่ละรายการ แสดงผลตัวเลขเป็นทศนิยม 4 ตำแหน่ง
SELECT
  S.SupplierID,
  S.CompanyName AS SupplierCompany,
  P.ProductID,
  P.ProductName,
  CAST(SUM(OD.Quantity) AS DECIMAL(18,4)) AS TotalQuantitySold,
  CAST(AVG(OD.UnitPrice * (1 - OD.Discount)) AS DECIMAL(18,4)) AS AvgSellingPricePerUnit
FROM Suppliers S
  JOIN Products P ON S.SupplierID = P.SupplierID
  LEFT JOIN [Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY S.SupplierID, S.CompanyName, P.ProductID, P.ProductName
ORDER BY S.CompanyName, TotalQuantitySold DESC;

-- 16.  ต้องการชื่อบริษัทผู้ผลิต ชื่อผู้ต่อต่อ เบอร์โทร เบอร์แฟกซ์ เฉพาะผู้ผลิตที่อยู่ประเทศ ญี่ปุ่น พร้อมทั้งชื่อสินค้า และจำนวนที่ขายได้ทั้งหมด หลังจาก 1 มกราคม 2541
SELECT
  S.SupplierID,
  S.CompanyName AS SupplierCompany,
  S.ContactName,
  S.Phone,
  S.Fax,
  P.ProductID,
  P.ProductName,
  CAST(SUM(OD.Quantity) AS DECIMAL(18,4)) AS TotalQuantity_Sold_After_1998_01_01
FROM Suppliers S
  JOIN Products P ON S.SupplierID = P.SupplierID
  LEFT JOIN [Order Details] OD ON P.ProductID = OD.ProductID
  LEFT JOIN Orders O ON OD.OrderID = O.OrderID
WHERE S.Country = 'Japan'
  AND (O.OrderDate IS NULL OR O.OrderDate > '1998-01-01')
-- ถ้ามีการสั่งหลังจาก 1 ม.ค.1998
GROUP BY S.SupplierID, S.CompanyName, S.ContactName, S.Phone, S.Fax, P.ProductID, P.ProductName
ORDER BY S.CompanyName, TotalQuantity_Sold_After_1998_01_01 DESC;

-- 17.  แสดงชื่อบริษัทขนส่งสินค้า เบอร์โทรศัพท์ จำนวนรายการสั่งซื้อที่ส่งของไปเฉพาะรายการที่ส่งไปให้ลูกค้า ประเทศ USA และ Canada แสดงค่าขนส่งโดยรวมด้วย
SELECT
  SH.ShipperID,
  SH.CompanyName AS ShipperCompany,
  SH.Phone,
  SUM(CASE WHEN O.ShipCountry IN ('USA','United States','United States of America','Canada') THEN 1 ELSE 0 END) AS OrdersSent_To_USA_Canada,
  CAST(SUM(CASE WHEN O.ShipCountry IN ('USA','United States','United States of America','Canada') THEN O.Freight ELSE 0 END) AS DECIMAL(18,4)) AS TotalFreight_USA_Canada
FROM Shippers SH
  LEFT JOIN Orders O ON SH.ShipperID = O.ShipVia
GROUP BY SH.ShipperID, SH.CompanyName, SH.Phone
HAVING SUM(CASE WHEN O.ShipCountry IN ('USA','United States','United States of America','Canada') THEN 1 ELSE 0 END) > 0
ORDER BY OrdersSent_To_USA_Canada DESC;

-- 18.  ต้องการข้อมูลรายชื่อบริษัทลูกค้า ชื่อผู้ติดต่อ เบอร์โทรศัพท์ เบอร์แฟกซ์ ของลูกค้าที่ซื้อสินค้าประเภท Seafood แสดงเฉพาะลูกค้าที่มีเบอร์แฟกซ์เท่านั้น
SELECT DISTINCT
  C.CustomerID,
  C.CompanyName,
  C.ContactName,
  C.Phone,
  C.Fax
FROM Customers C
  JOIN Orders O ON C.CustomerID = O.CustomerID
  JOIN [Order Details] OD ON O.OrderID = OD.OrderID
  JOIN Products P ON OD.ProductID = P.ProductID
  JOIN Categories Cat ON P.CategoryID = Cat.CategoryID
WHERE Cat.CategoryName = 'Seafood'
  AND (C.Fax IS NOT NULL AND LTRIM(RTRIM(C.Fax)) <> '');

-- 19.  จงแสดงชื่อเต็มของพนักงาน  วันเริ่มงาน (รูปแบบ 105) อายุงานเป็นปี เป็นเดือน ยอดขายรวม เฉพาะสินค้าประเภท Condiment ในปี 2540
SELECT
  CONCAT(E.FirstName, ' ', E.LastName) AS EmployeeName,
  CONVERT(VARCHAR(10), E.HireDate, 105) AS HireDate_105,
  -- อายุงาน (ปี)
  DATEDIFF(year, E.HireDate, '1997-12-31')
    - CASE WHEN DATEADD(year, DATEDIFF(year, E.HireDate, '1997-12-31'), E.HireDate) > '1997-12-31' THEN 1 ELSE 0 END AS YearsOfService,
  -- อายุงาน (เดือน เหลือ)
  (DATEDIFF(month, E.HireDate, '1997-12-31') - (DATEDIFF(year, E.HireDate, '1997-12-31') * 12)) AS MonthsOfService,
  CAST(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS DECIMAL(18,4)) AS TotalSales_Condiment_1997
FROM Employees E
  LEFT JOIN Orders O ON E.EmployeeID = O.EmployeeID
  LEFT JOIN [Order Details] OD ON O.OrderID = OD.OrderID
  LEFT JOIN Products P ON OD.ProductID = P.ProductID
  LEFT JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE C.CategoryName = 'Condiments' AND YEAR(O.OrderDate) = 1997
GROUP BY CONCAT(E.FirstName, ' ', E.LastName), E.HireDate;

-- 20.  จงแสดงหมายเลขใบสั่งซื้อ  วันที่สั่งซื้อ(รูปแบบ 105) ยอดขายรวมทั้งหมด ในแต่ละใบสั่งซื้อ โดยแสดงเฉพาะ ใบสั่งซื้อที่มียอดจำหน่ายสูงสุด 10 อันดับแรก
SELECT TOP 10
  O.OrderID,
  CONVERT(VARCHAR(10), O.OrderDate, 105) AS OrderDate_105,
  CAST(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS DECIMAL(18,4)) AS OrderTotal
FROM Orders O
  JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY O.OrderID, O.OrderDate
ORDER BY OrderTotal DESC;

--!---------------------------------------------------------------------------------------------------------------------

--ข้อมูลใบสั่งซื้อที่ส่งไปยังประเทศที่ไม่มีผู้ผลิตสินค้าตั้งอยู่
select *
from Orders
where ShipCountry not in (select distinct country
from Suppliers)
--ต้องการข้อมูลสินค้าที่มีราคาน้อยกว่า50$
SELECT *
FROM Products
WHERE UnitPrice < 50;

--คำสั่ง Dml
select *
from Shippers

--ตาราง มี pk เป็น AutoIncremant
INSERT INTO Shippers
VALUES
  ( 'บริษัทขนมเยอะจำกัด', '081-1234567')

INSERT INTO Suppliers
  (CompanyName)
VALUES
  ('บริษัทขนมหาศาลจำกัด')

select *
from Customers

--PK,Char,nchar
INSERT INTO  Customers
  (CustomerID,CompanyName,Phone)
VALUES
  ('Udru1', 'บริษัทซื้อเยอะจำกัด', '089-1234567')


--คำสั่ง update
Update Shippers set Phone = '087-9998888'
where CompanyName = 'บริษัทขนเยอะจำกัด'

update Shippers set Phone = '036-5155658'
where ShipperID = 4

update Customers set ContactName ='วรมิมทร์',ContactTitle='HR', Address = 'อุดรธานี Thailand'
Where CustomerID = 'Udru1'

DELETE FROM Shippers
WHERE ShipperID = 5


