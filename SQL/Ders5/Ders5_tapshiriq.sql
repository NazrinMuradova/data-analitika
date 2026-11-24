--Tapshiriq 5--
--1ci hisse--
create database CRM_task --yeni databaza yaratdim--
use CRM_task
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100)
);
INSERT INTO Customers (CustomerID, FullName, Phone, Email) VALUES
(1, '   ali mammadov   ', '0551234567', 'ali.mammadov@gmail.com'),
(2, 'LEYLA QASIMLI', '+994551112233', 'leyla.qasimli@yahoo.com'),
(3, '  rAsIm  kerimov', '994551234567', 'rasim.kerimovmail.com'),  -- səhv email ( @ yoxdur )
(4, 'nigar HUSEYNOVA   ', '0557654321', '  nigar.huseynova@mail.ru'),
(5, '   ELVIN   ABDULLAYEV', '+994507654321', 'elvin.abdullayev@company.az'),
(6, 'turan', '501234567', 'turan@gmail.com'), -- səhv telefon formatı
(7, '   sevda  memmedova  ', '994507778899', NULL),
(8, 'KAMRAN ISMAYILOV', '0550001122', 'kamran.ismayilov@outlook.com');

select * from Customers /* customers cedvelini yoxlayiriq*/

--Ad və soyadı təmizləyin (sağ-sol boşluqları silin)--
select CustomerID,LTRIM(RTRIM(FUllName)) as CleanName from Customers /*RTRIM sagdakı, LTRIM soldakı boshluqları silir */

--Ad və soyadın ilk hərfini böyük edin, qalanlarını kiçik edin--
with clean as  --CTE (common table expression)istifade etdim, clean adli muveqqeti cedvel yaratdim ve asagida netice hazir olandan sonra select bu neticeni de nezere alib burdan istifade edecek-- 
(
    select CustomerID,LOWER(REPLACE(REPLACE(LTRIM(RTRIM(FullName)), '  ', ' '), '  ', ' ')) as Name
    -- LTRIM/RTRIM: sol ve sag boshluqlari silir, REPLACE 2 defe: ortadakı artıq boshluqları 1 boshluqa endirir, LOWER: butun herfleri kicik edir--
    from Customers
)
select CustomerID,
case when CHARINDEX(' ', Name) = 0       --boshluq yoxdursa
           then UPPER(LEFT(Name, 1)) + SUBSTRING(Name, 2, LEN(Name))   -- yalnız ilk herfi boyuk
           else UPPER(LEFT(Name, 1))  -- adın ilk herfi boyuk
              + SUBSTRING(Name, 2, CHARINDEX(' ', Name) - 1) -- adın qalanı + boshluq
              + UPPER(SUBSTRING(Name, CHARINDEX(' ', Name) + 1, 1))  -- soyadın ilk herfi boyuk
              + SUBSTRING(Name, CHARINDEX(' ', Name) + 2, LEN(Name)) -- soyadın qalanı
       end as FullName
from clean;

--Bütün telefon nömrələrini vahid formata salın: +994XXXXXXXXX
select CustomerID, Phone as OldPhone, '+994' + RIGHT(phone, 9) as NewPhoneFormat from Customers  --right(phone, 9) son 9 reqemi goturur;verilen duzgun format esasinda mehz 9 reqem qeyd etdim 

--Email domain hissəsini ayrıca sütun kimi çıxarın
with clean as (
    select CustomerID,
           LTRIM(RTRIM(Email)) as CleanEmail -- her ehtimala kenar boshluqları sildim
    from Customers
)
select CustomerID, CleanEmail as Email,
case when CHARINDEX('@', CleanEmail) > 0     -- @ varsa
then SUBSTRING(CleanEmail, CHARINDEX('@', CleanEmail) + 1, 100)  -- @-dən sonrakı hisseni goturdu
else NULL -- @ yoxdursa bosh burax
end as EmailDomain
from Clean;

--Email-də "@" olmayan səhv dataları tapın
select * from Customers where email not like '%@%'


            --2ci hisse tapshiriqlar--
CREATE TABLE Cards (
    CardID INT PRIMARY KEY,
    CardNumber VARCHAR(25),
    CustomerName VARCHAR(100)
);
INSERT INTO Cards (CardID, CardNumber, CustomerName) VALUES

-- ✅ Düzgün 16 rəqəmli
(1, '5478123456789123', 'Ali Mammadov'),
(2, '547812345678912', 'Leyla Qasimli'),
(3, '54781234567891234', 'Rasim Kerimov'),
(4, '54781234A6789123', 'Nigar Huseynova'),
(5, '5478-1234-5678-9123', 'Elvin Abdullayev'),
(6, '5478 1234 5678 9123', 'Sevda Memmedova'),
(7, NULL, 'Turan Aliyev'),
(8, 'ABCDEF1234567890', 'Kamran Ismayilov');

-- select * from Cards

-- Kart nömrəsinin yalnız son 4 rəqəmi görünsün: ************9123

select CardID, CardNumber, REPLICATE('*', LEN(CardNumber) - 4) + RIGHT(CardNumber, 4) as MaskedCards from Cards --sadece son 4 reqemin gorunmesi lazim oldugu ucun diger simvollari * ile evezleyirik replicate funksiyasi vasitesile, evezlediyimiz hisseni ise sagdan 4 reqem ile birleshdiririk

--Kart nömrəsinin uzunluğu 16 deyilsə, səhv kimi işarələyin.
select CardNumber, LEN(CardNumber) as CardLength, 
case when CardNumber is NULL then 'Sehv'
when LEN(CardNumber) <> 16 then 'Sehv'
else 'Duzgun'
end as LengthStatus
from cards

--Kart nömrəsində yalnız rəqəm olub-olmadığını yoxlayın (PATINDEX istifadə edin)
select CardID, CardNumber, PATINDEX('%[^0-9]%', CardNumber) AS NonDigitPosition, 
case when CardNumber is NULL then 'Sehv'
when PATINDEX('%[^0-9]%', CardNumber) > 0 then 'Sehv' -- reqem olmayan simvol varsa netice sehv olacaq
else 'duzgun' --yuxaridaki hal olmazsa , netice duzgundur
end as DigitStatus
from Cards
--tapshiriq 2nin xulasesi--
select CardID,CustomerName,CardNumber,
REPLICATE('*', LEN(CardNumber) - 4) + RIGHT(CardNumber, 4) AS MaskedCard,

case when CardNumber is NULL then 'Sehv'
when LEN(CardNumber) <> 16 then 'Sehv'
else 'Duzgun'
end as LengthStatus, 

case when CardNumber is NULL then 'Sehv'
when PATINDEX('%[^0-9]%', CardNumber) > 0 then 'Sehv'
else 'duzgun'
end as DigitStatus
from Cards
