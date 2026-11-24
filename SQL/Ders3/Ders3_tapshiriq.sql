---DERS3---
--Tapshiriq1--
use BikeStores
select email, state from sales.customers where email like ('%yahoo%'); /* emailin istenilen yerinde yahoo olanlar*/

begin tran; /*transaction bashlasin*/
update sales.customers set state = 'XX' where email like '%yahoo%'; -- yalnız emailinde yahoo olan mushterilerin state'ni deyishib XX edir--
select email, state from sales.customers where email like '%yahoo%'; /*yoxlayiriq transaction daxilindeyik burda*/
rollback tran; /*deyishikliyi geri alib original versiyaya qayidiriq*/

select  email, state from sales.customers where email like '%yahoo%'; /* rollback ugurla icra olundu */

--Tapshiriq2--

select email, street from sales.customers where email in('damian.dawson@hotmail.com' , 'luis.tyler@gmail.com' , 'casey.gill@gmail.com'); /*emaillere uygun kuce adlarinin priginal veziyyetine baxiriq*/

begin tran;
update sales.customers set street = 'Not Available' where email in('damian.dawson@hotmail.com' , 'luis.tyler@gmail.com' , 'casey.gill@gmail.com'); /*transaction bashladib update funksiyasindan istifade ederek qeyd etdiyimiz emaillere uygun kuce deyerlerini deyishirik*/
select email, street from sales.customers where email in('damian.dawson@hotmail.com' , 'luis.tyler@gmail.com' , 'casey.gill@gmail.com');/*deyishikliyi yoxladim*/
rollback tran; /*rollback ederek deyishikliyi aradan qaldiririq*/

select email, street from sales.customers where email in('damian.dawson@hotmail.com', 'luis.tyler@gmail.com' , 'casey.gill@gmail.com');/*duzgun icra olundugunu tesdiq etdik, rollback istifade etdikden sonra cedvelimiz original veziyyetine qayitdi*/

--Tapshiriq3--
select street, city from sales.customers
select street, city from sales.customers where street like '% St.%' and city like '% %';
begin tran;
delete from sales.customers where street like '%St.' and city like '% %';
select street, city from sales.customers where street like '% St.%' and city like '% %';
rollback tran;

--Tapshiriq4--
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT,
Supplier NVARCHAR(50) DEFAULT 'Unknown'
);
ALTER TABLE Products
ADD CONSTRAINT CHK_Stock CHECK (Stock >= 0); /*stock sifirdan az ola bilmez shertini qoyuruq*/

INSERT INTO Products (ProductName, Category, Price, Stock, Supplier)
VALUES
('Laptop Pro',   'Electronics', 1200.00, 15, 'TechCorp'),
('Smartphone X', 'Electronics',  800.00, 50, 'MobileInc'),
('Tablet Plus',  'Electronics',  500.00,  0, 'GadgetWorld'),
('Desk Chair',   'Furniture',    150.00, 20, 'FurniCo'),
('Office Desk',  'Furniture',    300.00, 10, 'FurniCo');
select*from  products 
select * from products where ((Category = 'Electronics' and Price > 600) or (Stock in(0,10)))
select * from products where ((Supplier like 'Furn%') and (Stock in(0,10))) /* 0 ve ya 10 shertini ona gore istifade edirem ki bizde olan cedveldeki melumata esasen kodumuzun neticesi olsun*/

--Tapshiriq5--
CREATE TABLE Sales (
SaleID INT IDENTITY(1,1) PRIMARY KEY,
CustomerName NVARCHAR(100),
ProductCategory NVARCHAR(50),
Country NVARCHAR(50),
OrderAmount DECIMAL(10,2)
);
INSERT INTO Sales (CustomerName, ProductCategory, Country, OrderAmount) VALUES
('Ali Mammadov', 'Electronics', 'Azerbaijan', 1500.00),
('Elvin Huseyn', 'Furniture', 'Turkey', 2000.00),
('Leyla Aliyeva', 'Office Supplies', 'Azerbaijan', 1200.00),
('Aliyev Orkhan', 'Electronics', 'Turkey', 900.00),
('Elvin Guliyev', 'Furniture', 'Germany', 2500.00),
('Ali Rzayev', 'Office Supplies', 'Azerbaijan', 1100.00),
('Nigar Hasan', 'Electronics', 'Turkey', 1300.00),
('Elvin Sadiq', 'Electronics', 'Turkey', 500.00);

select * from sales where ( (CustomerName like 'Ali%') and (ProductCategory in ('Electronics', 'Furniture', 'Office Supplies')) and (Country in ('Azerbaijan', 'Turkey')) and (OrderAmount > 1000)); 

