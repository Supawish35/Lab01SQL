-- แบบฝึกหัด SQL ใช้ฐานข้อมูล  Minimart
-- 1. สินค้าที่มีราคา 15 บาท
SELECT * FROM products WHERE UnitPrice = 15;

-- 2. สินค้าที่มีจำนวนคงเหลือในสต๊อกต่ำกว่า 250
SELECT * FROM products WHERE UnitsInStock < 250;

-- 3. รหัสสินคา ชื่อสินค้าที่เลิกจำหน่ายแล้ว
SELECT productId, productName FROM products WHERE discontinued = 1;

-- 4. รหัสสินค้า ชื่อสินค้า ราคา ของสินค้าที่มีราคามากกว่า 100
SELECT productId, productName, UnitPrice FROM products WHERE UnitPrice > 100;

-- 5. รหัสสินค้า และราคาของยางลบ
SELECT productId, UnitPrice FROM products WHERE productName = 'ยางลบ';

-- 6. หมายเลขใบเสร็จ วันที่ และ ราคารวม ของใบเสร็จที่ออกก่อนวันที่ 15 ก.พ.
SELECT receiptId, ReceiptDate, TotalCash FROM receipts WHERE ReceiptDate < '2023-02-15';

-- 7. รหัสสินค้า ชื่อสินค้า ที่มีจำนวนคงเหลือตั้งแต่ 400 ขึ้นไป
SELECT productId, productName FROM products WHERE UnitsInStock >= 400;

-- 8. รหัสสินค้า ชื่อสินค้า ราคา และ จำนวนคงเหลือ ของแชมพู,แป้งเด็ก,ดินสอ,ยางลบ
SELECT productId, productName, UnitPrice, UnitsInStock FROM Products
WHERE productName IN ('แชมพู', 'แป้งเด็ก', 'ดินสอ', 'ยางลบ');

-- 9. รายละเอียดของสินค้าประเภทเครื่องเขียน
SELECT * FROM categories 
WHERE categoryName = 'เครื่องเขียน';

-- 10. รหัสประเภทสินค้า ชื่อประเภท และรายละเอียดของ สินค้าประเภทเครื่องสำอาง
SELECT categoryId, categoryName, description FROM categories WHERE categoryName = 'เครื่องสำอาง';

-- 11.คำนำหน้า ชื่อ นามสกุล ของพนักงานที่เป็น Sale Representative
SELECT Title, firstName, lastName FROM employees WHERE position = 'Sale Representative';

-- 12. รหัสพนักงาน ชื่อพนักงาน ชื่อผู้ใช้ รหัสผ่าน ของพนักงานทุกคน
SELECT employeeId, firstName, lastName, username, password FROM employees;

-- 13. ชื่อผู้ใช้ และรหัสผ่านของพนักงานที่ชื่อก้องนิรันดร์
SELECT username, password FROM employees WHERE firstName = 'ก้องนิรันดร์';

-- 14. รหัสพนักงานที่ออกใบเสร็จหมายเลข 3
SELECT employeeId FROM receipts WHERE receiptId = 3;

-- 15. รหัสสินค้า ชื่อสินค้า ราคา ของสินค้าที่มีรหัสประเภท 2, 4
SELECT productId, productName, UnitPrice FROM products WHERE categoryId IN (2, 4);

