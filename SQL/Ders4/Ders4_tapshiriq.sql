---DERS4---

--Tapshiriq1--
--use RetailSalesTrainingDB
--select * from sales.OrderDetails
--select orderid, unitprice, qty from sales.OrderDetails

select avg(qty * unitprice) as orta_qazanc, count(*) as umumi_say, sum(qty * unitprice) as cem_qazanc 
from sales.OrderDetails
where qty*unitprice > 1000 and discount = 0.000 

--Tapshiriq2--
select region, count(fax) as null_olmayan_regionlarda_fax_sayi from Sales.Customers
where region is not null
group by region;   --cedveli regionlara bolur; her region ayrı qrup olur--

--Tapshiriq3--
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    City VARCHAR(50),
    OrderStatus VARCHAR(30),
    OrderDate DATE,
    Amount DECIMAL(10,2)
);
INSERT INTO Orders VALUES
(1,'Baku','Completed','2025-01-05',5000),
(2,'Baku','Completed','2025-01-10',7000),
(3,'Baku','Completed','2025-02-15',6000),
(4,'Baku','Completed','2025-03-12',8000),
(5,'Baku','Completed','2025-04-01',9000),
(6,'Baku','Completed','2025-04-10',7500),
(7,'Baku','Completed','2025-05-05',8200),
(8,'Baku','Completed','2025-05-15',9100),
(9,'Baku','Completed','2025-06-01',10000),
(10,'Baku','Completed','2025-06-10',11000),
(11,'Baku','Completed','2025-06-15',12000),
(12,'Ganja','Pending','2025-02-05',3000),
(13,'Ganja','Pending','2025-02-10',4000),
(14,'Ganja','Pending','2025-03-01',3500),
(15,'Ganja','Pending','2025-03-15',4500);
 

 select city, orderstatus, count(*) as sifarish_sayi, sum(amount) as umumi_mebleg  from Orders --count(*) ona gore istifade etdimki setirleri saysin cunki her setir 1 sifarish  saxlayir completed/pending --
 where orderdate >= '2025-01-01' and orderdate < '2026-01-01'
 group by city, orderstatus
 having count(*) > 10;


 --Tapshiriq4--
 CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    Gender VARCHAR(10),
    Salary DECIMAL(10,2),
    HireDate DATE
);
INSERT INTO Employees VALUES
(1,101,'Male',4000,'2024-02-01'),
(2,101,'Male',4500,'2024-03-10'),
(3,101,'Male',4700,'2024-04-15'),
(4,101,'Female',5000,'2024-05-01'),

(5,102,'Female',6000,'2024-01-15'),
(6,102,'Female',6200,'2024-02-20'),
(7,102,'Female',6300,'2024-03-05'),
(8,102,'Female',6400,'2024-04-10'),

(9,103,'Male',7000,'2023-01-01'),
(10,103,'Male',7100,'2023-02-01'),
(11,103,'Male',7200,'2023-03-01'),
(12,103,'Male',7300,'2023-04-01');

select DepartmentID, Gender, count(*) as ischi_sayi, min(salary) as min_maash, max(salary) as max_maash from dbo.Employees
where hiredate >= '2024-01-01'
group by DepartmentID, Gender
having count(*) > 3   


--Tapshiriq5--
select departmentid, count(*) as ishci_sayi, min(salary) as min_maash, max(salary) as max_maash from dbo.Employees
group by departmentid --ishcileri departamentlere gore qruplara boldu--
having count(*) > 3    --sadece ishci sayi 3den cox olan qruplari saxladi--