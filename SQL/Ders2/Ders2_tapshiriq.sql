/* DERS 2 Tapshiriq */

--------- DDL tapshiriqlari------

use BikeStores  /* databazani secirik*/
go
/* sales.payments yeni cədvəli yaradırıq*/
create table sales.payments(
payment_id int identity(1,1) primary key, /* her odenish ucun id yaradiriq, nomreler bir-bir avtomatik artir, PK her odenishin ferqli olmasini temin edir*/
order_id int not null, /* odenisin hansi sifarishe aidliyini gosterir, bu sutun orders cedvelindeki order_id ile elaqelenecek, not null ona gore istifade etdimki, bu xana bosh ola bilmez*/
payment_date date not null, /* odenish tarixini saxlayir, tarix mutleq qeyd edilmelidir ona gore not null istifade edirem */
amount decimal(10,2) not null, /* odenish meblegi cap olunur, vergulden sonra 2 reqem saxlamaq ucun decimal(10,2) */
payment_method varchar(50), /*odenish usulu yazilir*/

foreign key (order_id) references sales.orders(order_id) /*FK vasitesile payments ve orders cedvelleri elaqelendi, sifarish movcud deyilse odenise baglanmaq mumkun deyil*/

);
go

select * from sales.payments /* yoxladim */

alter table sales.customers add date_of_birth date , created_at datetime default getdate() /*alter ve add funksiyasi komeyi ile cedvele yeni sutunlar elave olundu*/

alter table production.products alter column list_price decimal(12,2)  /* alter column ile secdiyimiz sutunun tipinin deyishdik*/


use BikeStores
create schema hr 
select * into hr from sales.staffs   /* hr schemasi yaradib, sales.staffs cedvelini kocurdum bu schemaya*/

alter table sales.customers alter column zip_code varchar(10) not null 

create table hr.departments (
department_id int identity(1,1) primary key,
department_name varchar(100),
created_date datetime ,
);  /* hr.departments cedveli yaradib, sutunlar elave etdim */

drop table hr.departments /* cedveli ve icindeki her sheyi silir */
select * from hr.departments 

delete from hr.departments /* cedvelin daxilindeki melumatlari silir, cedvel qalir */
select * from hr.departments /* yoxladim */

alter table sales.customers drop column date_of_birth  /* bu sutun cedvelden silindi */


-------- DML tapshiriqlari --------
select*from sales.customers
insert into sales.customers (first_name, last_name, email, city, state, zip_code) values ('Test', 'Customer', 'test@example.com','New York', 'NY', '10001'); /* mehz new yorkda yashayan musteri elave etdim*/
select * from sales.customers where email = 'test@example.com'; /* yerine yetirildiyini yoxladim*/


update production.products set list_price = list_price * 1.1 where model_year = 2016 /* 201ci ile aid qiymetler 10% artib */


select*from production.stocks
delete from production.stocks /*cedveli temizleyir, ferqi gormek ucun ustdeki funksiyadan istifade etdim*/

delete from production.products where product_name like 'Electra%' and  model_year = 2016 /*electra brendinin 2016 modelleri silindi*/

insert into production.categories (category_name) values ('Hybrid Bikes'), ('Touring bykes') /* movcud sutuna yeni deyerler elave etdim*/

update sales.customers set city = 'New York City' where state = 'NY' /* NY state olan sheherler new york city olaraq deyishdirildi*/

delete from sales.stores where city = 'Baku'

insert into sales.stores (store_name) values ('Araz'),('Bravo')
select*from sales.stores

    ---------TCL tapshiriqlari--------

begin transaction; /*tranzaksiya basladi*/
insert into sales.stores (store_name) values ('Bazar store');
commit tran; /* tesdiqlendi*/


begin tran;
update production.products set list_price = list_price + 100 where product_id = 1;
update production.products set list_price = 700 where product_id = 2;
commit tran;    /* mehsullarin qiymeti deyishdirildi*/

begin tran;
delete from sales.stores where store_name = 'Araz';
rollback transaction; /* Araz adli magaza silindi ve rollback vasitesile geri alindi*/


begin tran;
insert into production.categories (category_name) values ('smartphones'); 
insert into production.products (product_name,brand_id, category_id, model_year, list_price) values ('Samsung Galaxy S26', 1,(select category_id from production.categories where  category_name = 'Smartphones'), 2026, 999.99);
commit tran; /*smartphones kateqoriyasi elave edib , yeni mehsul elave etdim*/

begin tran;
update production.products set list_price = 500 where product_id = 3;
update production.products set list_price = 700 where product_id = 5;
select product_id, product_name, list_price from production.products where product_id in (3, 5);
rollback tran;/* qiymetleri deyishdirdikden sonra rollback edib deyishiklikleri geri qayitdiini yoxladim */

/* Verilen dataya esasen identity ile cedvel yaratmaq*/

create table orders (
orderid int identity(1,1) primary key,
custid int,
empid int,
orderdate date,
requireddate date,
shippeddate date,
shipperid int,
freight decimal(10,2),
shipname nvarchar(100),
shipaddress nvarchar(200),
shipcity nvarchar(100),
shipregion nvarchar(100),
shippostalcode nvarchar(20),
shipcountry nvarchar(100)
);
insert into orders (custid, empid, orderdate, requireddate,shippeddate, shipperid, freight,shipname, shipaddress, shipcity,shipregion, shippostalcode, shipcountry) values (85, 5, '2014-07-04', '2014-08-01','2014-07-16', 3, 32.38,N'Ship to 85-B', N'6789 Rue de l''Abbaye',N'Reims', NULL, N'10345', N'France');
select * from orders;