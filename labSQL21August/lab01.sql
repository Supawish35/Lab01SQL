
SELECT p.ProductID, p.ProductName, s.CompanyName, s.Country
FROM Products p JOIN Suppliers s ON p.SupplierID = s.SupplierID

Select p.ProductID, p.ProductName, s.CompanyName, S.Country
FROM Products p , Suppliers s
WHERE p.SupplierID = s.SupplierID;

SELECT CompanyName, OrderID
FROM Orders JOIN Shippers ON Shippers.ShipperID = Orders.ShipVia
WHERE OrderID = 10275

SELECT e.EmployeeID, FirstName, OrderID
FROM Employees e join orders o on e.EmployeeID = o.EmployeeID
ORDER BY e.EmployeeID

--? ต้องการชื่อบริษัท และจำนวนการสั่งซื้อที่เกี่ยวข้อง
SELECT productID, ProductName, City, Country
FROM Products p JOIN Suppliers s ON p.SupplierID = s.SupplierID

--? ต้อวการรหัสสินค้า ชื่อสินค้า และจำนวนทั้งหมดที่ขายได้
SELECT CompanyName, COUNT(*) AS NumberOfOrders
FROM orders o join Shippers s ON o.ShipVia = s.ShipperID
GROUP BY CompanyName

--? ต้องการรหัสสินค้า ชื่อสินค้า และจำนวนทั้งหมดที่ขายได้
SELECT p.ProductID, p.ProductName, SUM(od.Quantity) AS TotalSold
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName ORDER BY 1
