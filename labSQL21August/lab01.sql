
SELECT p.ProductID, p.ProductName, s.CompanyName, s.Country
FROM Products p JOIN Suppliers s ON p.SupplierID = s.SupplierID

Select p.ProductID, p.ProductName, s.CompanyName, S.Country
FROM Products p , Suppliers s WHERE p.SupplierID = s.SupplierID;

SELECT CompanyName, OrderID
FROM Orders JOIN Shippers ON Shippers.ShipperID = Orders.ShipVia
WHERE OrderID = 10275