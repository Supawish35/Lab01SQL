--1.หาตำาแหน่งของ Nancy ก่อน
select Title from Employees where FirstName = 'namcy'

--2ต้องการหาข้อมูลเดียวกับข้อ 1 
select * 
from Employees 
where Title = (select Title from Employees where FirstName = 'namcy' )

--3ต้องการชื่ออายุพนักงานที่มีอายุมากที่สุด
select  FirstName,lastname from Employees
where BirthDate = (select min(BirthDate) from Employees)

--4ต้องการสินค้าที่มีราคามากกว่าสินค้าชื่อ ikura 
select productName from Products
where productName = 'ikura'
--5ต้องการชื่อบริษัทลูกค้าที่อยู๋เมืองเดียวกับบริษัทชืื่อ Thomas Hardy
select companyName from Customers 
where City =  (select city from Customers
               where  companyName = 'Around the Horn')
--6ต้องการหมายเลขใบสั่งซื้อรายแรกในปี 1998
select * from Orders
where OrderDate = ( select min(OrderDate)from Orders
                   where YEAR(OrderDate) =1998)
--7ต้องการชื่อนามสกุลของพนักงานที่เข้างานคนล่าสุด
select firstName,lastName from Employees
where HireDate = (select max(HireDate)from Employees)
--ข้อมูลใบสั่งซื้อที่ส่งไปยังประเทศที่ไม่มีผู้ผลิตสินค้าตั้งอยู่
select * from Orders
where ShipCountry not in (select distinct country from Suppliers)
--ต้องการข้อมูลสินค้าที่มีราคาน้อยกว่า50$
SELECT * FROM Products
WHERE UnitPrice < 50;

--คำสั่ง Dml
select * from Shippers

--ตาราง มี pk เป็น AutoIncremant
INSERT INTO Shippers
VALUES ( 'บริษัทขนมเยอะจำกัด','081-1234567')

INSERT INTO Suppliers(CompanyName)
VALUES ('บริษัทขนมหาศาลจำกัด')

select * from Customers

--PK,Char,nchar
INSERT INTO  Customers(CustomerID,CompanyName,Phone)
VALUES ('Udru1','บริษัทซื้อเยอะจำกัด','089-1234567')


--คำสั่ง update
Update Shippers set Phone = '087-9998888'
where CompanyName = 'บริษัทขนเยอะจำกัด'

update Shippers set Phone = '036-5155658'
where ShipperID = 4

update Customers set ContactName ='วรมิมทร์',ContactTitle='HR', Address = 'อุดรธานี Thailand'
Where CustomerID = 'Udru1'

DELETE FROM Shippers
WHERE ShipperID = 5


