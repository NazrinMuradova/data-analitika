--DERS 7 tapshiriqlari--
USE SalaryRankingDB;
GO
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName NVARCHAR(100),
    City NVARCHAR(50),
    RegistrationDate DATE
)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Channel NVARCHAR(20) -- Website, Store
)
INSERT INTO Customers VALUES
(1, 'Ali Mammadov', 'Baku', '2022-01-10'),
(2, 'Leyla Aliyeva', 'Baku', '2022-03-15'),
(3, 'Murad Hasanov', 'Ganja', '2022-05-20'),
(4, 'Aysel Karimova', 'Sumqayit', '2023-02-11'),
(5, 'Rashad Ibrahimov', 'Baku', '2023-04-05'),
(6, 'Nigar Huseynova', 'Ganja', '2023-06-18'),
(7, 'Elvin Abbasov', 'Baku', '2023-08-25'),
(8, 'Sabina Rahimova', 'Sumqayit', '2023-09-01');


INSERT INTO Orders VALUES
(101, 1, '2023-01-15', 120.50, 'Website'),
(102, 2, '2023-02-20', 75.00, 'Store'),
(103, 1, '2023-03-05', 200.00, 'Website'),
(104, 3, '2024-03-18', 150.25, 'Store'),
(105, 4, '2023-04-10', 90.00, 'Website'),
(106, 5, '2024-04-22', 300.75, 'Store'),
(107, 6, '2023-05-30', 110.40, 'Website'),
(108, 7, '2023-06-12', 50.00, 'Store'),
(109, 2, '2024-07-07', 220.60, 'Website'),
(110, 3, '2023-07-21', 130.90, 'Store'),
(111, 8, '2024-08-03', 95.50, 'Website'),
(112, 5, '2023-08-19', 180.00, 'Store'),
(113, 7, '2023-09-05', 210.30, 'Website'),
(114, 1, '2024-09-17', 60.00, 'Store'),
(115, 6, '2024-10-02', 145.80, 'Website');

--Tapshiriq1--
--select * from Orders

--2024-cü ildə:Website kanalında ümumi xərcləməsi 1500 AZN-dən çox olan və Store kanalında ən az 3 sifarişi olan müştəriləri birləşdir.
select CustomerID from Orders
where YEAR(OrderDate) = 2024 and Channel = 'Website'
group by CustomerID having SUM(TotalAmount) > 1500
UNION
select CustomerID from Orders where YEAR(OrderDate) = 2024 and Channel = 'Store'
group by CustomerID having COUNT(OrderID) >= 3   --netice boshdur cunki, bu tapshiriq sherti cedvele esasen odenilmir

--2023-də 3000 AZN-dən çox xərcləyən amma 2024-də 1000 AZN-dən az xərcləyən müştəriləri çıxart. Bu, riskli müştərilərdir (azalma göstərənlər)
select CustomerID from Orders
where YEAR(OrderDate) = 2023 
group by CustomerID having SUM(TotalAmount) > 3000
 EXCEPT 
select CustomerID from Orders
where YEAR(OrderDate) = 2024 
group by CustomerID having SUM(TotalAmount) < 1000   --except vasitesile birinci SELECT-in neticesinden ikinci SELECT-in neticesini cixdi

--Həm aktiv, həm də dəyərli müştərilər: 2023-cü ildə ən az 3 sifariş edən müştərilər və 2024-cü ildə ümumi xərcləməsi 2500 AZN-dən çox olan müştərilər və
--Hər iki ildə də alış edənlər ortaq müştəriləri çıxart.
select CustomerID from Orders
where YEAR(OrderDate) = 2023 
group by CustomerID having COUNT(OrderID) >= 3
INTERSECT
select CustomerID from Orders
where YEAR(OrderDate) = 2024 
group by CustomerID having SUM(TotalAmount) > 2500  --INTERSECT vasitesile her iki select neticesinde movcud olanlari gosterecek

--High Value Customers (Yüksək dəyərli müştərilər), CTE istifadə edin: Hər müştərinin total xərclədiyi məbləği hesablayın ortalama total xərcdən çox xərcləyən müştəriləri çıxarın
-- 1) CTE:Her bir mushterinin umumi xerclemesini hesablayiriq
with CustomerTotal as (select CustomerID, SUM(TotalAmount) as TotalSpent from Orders group by CustomerID),
-- 2) CTE:Butun musterilerin orta xerclemesini hesablayiriq
AverageSpending as (select AVG(TotalSpent) as AvgSpent from CustomerTotal
)
-- 3) Esas sorgu:Ortalamadan cox xercleyen musterileri secirik
select CustomerID, TotalSpent from CustomerTotal where TotalSpent > (select AvgSpent from AverageSpending)

--Top 10 CustomersCTE + ROW_NUMBER(), Hər müştərinin total revenue-sunu hesablayın. Ən çox xərcləyən ilk 10 müştərini tapın

-- Databazani secirik
use SalaryRankingDB;
go
--Her mushteri uzre umumi xerclemeyi hesablayiriq
with CustomerRevenue as(select CustomerID, SUM(TotalAmount) as TotalRevenue from Orders group by CustomerID),
--Mushterileri umumi xerclemeye gore siralayiriq
RankedCustomers as (select CustomerID,TotalRevenue, ROW_NUMBER() over(order by TotalRevenue desc) as RowNum FROM CustomerRevenue)
--Ilk 10 mushterini neticeye cixaririq
select CustomerID, TotalRevenue,RowNum from RankedCustomers
where RowNum <= 10
order by RowNum











