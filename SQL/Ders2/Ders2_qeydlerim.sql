use Test_db
/* sutunda etmek istediyimiz deyishiklikler hamisi ALTER ile olunur*/
/*alter table + table adi    +         add   +  elave olunan sutun adi  + deyer*/
alter table     Test_schema.customers  add       telefon                varchar(20)   /* alter - deyishim etmek ucun istifade olunur, add ise cedvele yeni sutun elave edir*/


alter table     Test_schema.customers  alter column       telefon       nvarchar(50)  /* alter column- sutunun tipini deyishir*/
exec sp_rename 'Test_schema.customers', 'customers_test'  /* sutun adini deyish*/


alter table Test_schema.customers_test drop column telefon /* drop column - spesifik sutunu silir*/
select * from Test_schema.customers_test     /* yoxlayaq */

drop table Test_schema.customers_test    /* RUN ETMEDIM- cunki drop table - birbasha cedveli ve icindeki her sheyi silir*/
/* drop schema,drop database - dropdan sonra ne gelirse her sheyini silir; Amma ardicilliqla silmek lazimdir, (table, schema, database)*/


create table Test_schema.customers_test2(
cust_ID int ,
custAd nvarchar(30),
custEmail varchar(80), 
yaradilmaTarixi datetime default getdate()
)

insert into Test_schema.customers_test2(cust_ID, custAD, custEmail) values(1, 'Ali', 'ali@gmail'), (2, 'Ali2', 'ali2@gmail') /* ozumuz spesifik sutuna deyerler elave etdik*/
select * from Test_schema.customers_test2  /*yoxladim*/

insert into Test_schema.customers_test2 values(4, 'Ali4', 'ali4@gmail', '2026-10-26') /*spesifik deyer elave eledim*/
select * from Test_schema.customers_test2  /*yoxladim*/


create table Test_schema.customers_test2_backup(
cust_ID int ,
custAd nvarchar(30),
custEmail varchar(80), 
yaradilmaTarixi datetime default getdate()
)
/*run etdikden sonra kecirik novbetiye*/

insert into Test_schema.customers_test2_backup select * from Test_schema.customers_test2 /* backup cedvelini yaradib, sonra test2 cedvelindeki butun sutunlari backup cedveline kocur*/

select * into Test_schema.customers_test2_backup2 from Test_schema.customers_test2      /* yeni cedvel yaratmadan test2 cedvelindeki butun sutunlari backup 2 cedveline kocurur*/

---identity- ozumuz cedveli doldururuq----

insert into Test_schema.customers_test2 (cust_ID, custAD, custEmail, yash) values (3, 'Ali3', 'ali3@gmail', 10),(5, 'Ali5', 'ali5@gmail', 10);
select * from Test_schema.customers_test2;     /*elave deyer elave edirik, cox lazimli deyil*/


                        /* where - shert qoyur, harada olan? */
select* from Test_schema.customers_test2 where custEmail = 'ali3@gmail.com'  /* bu email olan sutunlari goster*/

delete from Test_schema.customers_test2 where custEmail = 'ali3@gmail.com' /* bu email olan sutunlari sil*/
delete from Test_schema.customers_test2 /*cedvelin icindeki her sheyi silir*/

drop table Test_schema.customers_test2 /* cedvel ve cedvele aid her sheyi sil*/

/* sinayiram bayaqki caseleri */
delete from Test_schema.customers_test2 
select * from Test_schema.customers_test2
insert into Test_schema.customers_test2(cust_ID, custAD, custEmail) values(1, 'Ali', 'ali@gmail'), (2, 'Ali2', 'ali2@gmail') /* ozumuz spesifik sutuna deyerler elave etdik*/

truncate table Test_schema.customers_test2 /* datani silir, funksiyalari silir*/

update Test_schema.customers_test2 set custEmail = 'shghadghagd' where cust_ID = 1 /* gedir deyishir*/

/* cedvele yeni sutun elave etmek isteyirem */

alter table Test_schema.customers_test2 add yash int
update Test_schema.customers_test2 set yash = yash + 5  where cust_ID = 11  /* yashi artirir, NULL hecvaxt deyishmir, hecne tesir elemir*/

--tcl --

begin tran 

update Test_schema.customers_test2
set yash = yash - 5 
where cust_ID = 12


insert into Test_schema.customers_test2(  custAD, custEmail, yash ) values ( 'ali', 'ali@gmail.com', 34), ( 'ali2', 'ali2@gmail.com', 56), ( 'ali3', 'ali3@gmail.com', 28)

commit

select @@TRANCOUNT


------
begin tran 

update Test_schema.customers_test2
set yash = yash - 5 
where cust_ID = 12


insert into Test_schema.customers_test2( custAD, email, yash ) values ( 'ali', 'ali@gmail.com', 34), ( 'ali2', 'ali2@gmail.com', 56), ( 'ali3', 'ali3@gmail.com', 28)

rollback

select * from test2_schema.customers


save tran -- 


begin tran 

update Test_schema.customers_test2
set yash = yash - 5 
where cust_ID = 12
 
save transaction step_update

insert into Test_schema.customers_test2( custAD, custEmail, yash ) values ( 'ali', 'ali@gmail.com', 34), ( 'ali2', 'ali2@gmail.com', 56), ( 'ali3', 'ali3@gmail.com', 28)

rollback transaction step_update