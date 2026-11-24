--Tapshiriq 6--
--CASE 1--
create database DateFunctionsTaskDB
use DateFunctionsTaskDB
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    RegistrationDate DATE,
    LastLoginDate DATE
);
INSERT INTO Customers (CustomerID, FullName, RegistrationDate, LastLoginDate) VALUES
(1, 'Ali Mammadov', '2024-01-15', '2025-02-20'),
(2, 'Leyla Qasimli', '2024-06-01', '2024-11-01'),
(3, 'Rasim Kerimov', '2025-01-20', '2025-02-23'),
(4, 'Nigar Huseynova', '2024-12-05', '2024-12-25'),
(5, 'Elvin Abdullayev', '2025-02-10', '2025-02-27'),
(6, 'Sevda Memmedova', '2024-09-15', '2024-12-20'),
(7, 'Turan Aliyev', '2025-02-01', '2025-02-21');

--select *from customers
--Qeydiyyatdan bu günə qədər neçə gün keçdiyini hesablayın
select CustomerID, FullName, RegistrationDate, 
DATEDIFF(day, RegistrationDate, GETDATE()) as DaysSinceRegistration from Customers --DATEDIFF funksiyasi vasitesile, qeydiyyatdan kecen mushetirilerin qeydiyyat tarixinden indiye qeder nece gun kecdiyini bildik--

--90 gündən çox aktiv olmayan müştəriləri tapın
select CustomerID, FullName, LastLoginDate, 
DATEDIFF(day, LastLoginDate, GETDATE()) as DaysInactive from Customers --son logindən bu gune qeder kecen gun
where DATEDIFF(day, LastLoginDate, GETDATE()) > 90; --90 gunden cox kecenleri goster

--Son 7 gün ərzində login olanları çıxarın
select CustomerID, FullName, LastLoginDate, 
DATEDIFF(day, LastLoginDate, GETDATE()) as Last7DaysActive from Customers
where DATEDIFF(day, LastLoginDate, GETDATE()) <= 7   --Son 7 gun erzinde login olanlar

--cedvelde verilen tarixler indiki tarixle 1 ilden artiq gun sayi ile ferqlenir, ona gore getdate evezine cedvelde olan tarixlere en yaxin olan spesifik  tarix yazacam--
select CustomerID, FullName, LastLoginDate, 
DATEDIFF(day, LastLoginDate, '2025-02-27') as Last7DaysActive from Customers
where DATEDIFF(day, LastLoginDate,'2025-02-27') <= 7  

--Qeydiyyatın hansı rübdə (quarter) olduğunu göstərin
-- 1-ci usul:
select FullName,RegistrationDate,DATEPART(QUARTER, RegistrationDate) as QuarterNo from Customers --datepart funksiyasi  vasitesile quarter istifade ederek aylar rublere bolundu
--2-ci usul:
select FullName, RegistrationDate, MONTH(RegistrationDate) as MonthNo,
case when MONTH(RegistrationDate) IN (1, 2, 3) then 1
when MONTH(RegistrationDate) IN (4, 5, 6) then 2
when MONTH(RegistrationDate) IN (7, 8, 9) then 3
when MONTH(RegistrationDate) IN (10, 11, 12) then 4
end as QuarterNo
from Customers;


--CASE2--
create database SalaryRankingDB
use SalaryRankingDB
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);
INSERT INTO Employees (EmployeeID, FullName, Department, Salary) VALUES
(1, 'Ali Mammadov', 'IT', 5000),
(2, 'Leyla Qasimli', 'IT', 7000),
(3, 'Rasim Kerimov', 'HR', 4000),
(4, 'Nigar Huseynova', 'HR', 4500),
(5, 'Elvin Abdullayev', 'IT', 7000),
(6, 'Sevda Memmedova', 'Finance', 6000),
(7, 'Turan Aliyev', 'Finance', 6000),
(8, 'Kamran Ismayilov', 'Finance', 5500),
(9, 'Aysel Mehdiyeva', 'HR', 4500),
(10, 'Orxan Huseynli', 'IT', 5000);

-- select * from Employees 
--Bütün işçiləri maaşa görə azalan sırala və sıra nömrəsi ver (ROW_NUMBER())
select FullName, Department, Salary, ROW_NUMBER() over( order by salary desc) as RowNum from Employees --maasha gore azalan sirada duzerek,ardicil olaraq her setre unikal sira nomresi verdi, maash eyni olsa bele sira nomresi ferqlidir 

--Maaşa görə rank ver (RANK())
select  FullName, Department,Salary, RANK() over (order by salary desc) as SalaryRank from Employees --RANK() funksiyasi maashlari boyukden kiciye sıralayır ve eyni maash alan ishcilere eyni reytinq verir, novbeti reytinqde boshluq yaradır

--Eyni maaşlarda boşluq olmasın (DENSE_RANK())
select  FullName, Department,Salary, DENSE_RANK() over (order by salary desc) as SalaryRank from Employees --DENSE_RANK() funksiyasi maashlari boyukden kiciye sıralayır ve eyni maash alan ishcilere eyni reytinq verir, novbeti reytinqde boshluq yaratmir

--Hər department daxilində ayrıca maaş reytinqi çıxarın (PARTITION BY)
select EmployeeID, FullName, Department, Salary, RANK() over(partition by department order by salary desc) as department_rank from Employees

--Hər department-də ən yüksək maaş alan işçini tapın
select * from Employees e 
where Salary = (
    select MAX(Salary)
    from Employees
    where Department = e.Department
)

--CASE3--
use SalaryRankingDB
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    SalesPerson VARCHAR(100),
    SaleDate DATE,
    Amount DECIMAL(10,2),
    Region VARCHAR(50)
);

INSERT INTO Sales (SaleID, SalesPerson, SaleDate, Amount, Region) VALUES
(1, 'Ali Mammadov', '2025-01-05', 1500, 'Baku'),
(2, 'Leyla Qasimli', '2025-01-12', 2000, 'Baku'),
(3, 'Rasim Kerimov', '2025-02-03', 3000, 'Ganja'),
(4, 'Nigar Huseynova', '2025-02-15', 2500, 'Baku'),
(5, 'Elvin Abdullayev', '2025-03-01', 4000, 'Ganja'),
(6, 'Sevda Memmedova', '2025-03-18', 3500, 'Baku'),
(7, 'Turan Aliyev', '2025-04-05', 5000, 'Baku'),
(8, 'Kamran Ismayilov', '2025-04-22', 4500, 'Ganja'),
(9, 'Aysel Mehdiyeva', '2024-12-25', 3000, 'Baku'),  -- 2024-cü il, çıxarılacaq
(10, 'Orxan Huseynli', '2025-02-28', 1500, 'Ganja');

select * from Sales
--Yalnız 2025-ci ilə aid satışları çıxar
-- 1-ci usul:
select * from Sales where YEAR(SaleDate) = 2025
-- 2-ci usul:
select * from Sales where SaleDate >= '2025-01-01' and SaleDate < '2026-01-01' 

--Hər ay üzrə ümumi satış məbləğini hesabla
select MONTH(SaleDate) as SaleMonth, SUM(Amount) as TotalSales from Sales
where YEAR(SaleDate) = 2025 group by MONTH(SaleDate) order by SaleMonth

--Ayları ümumi məbləğə görə rank et
select MONTH(SaleDate) as SaleMonth, SUM(Amount) as TotalSales, RANK() over(order by SUM(amount) desc) as SalesRank from Sales
where YEAR(SaleDate) = 2025
group by MONTH(SaleDate)

--Ən yüksək satış olan ayı tap
select top 1 MONTH(SaleDate) as SaleMonth, SUM(Amount) as TotalSales from Sales 
where YEAR(SaleDate) = 2025
group by MONTH(SaleDate) 
order by TotalSales desc