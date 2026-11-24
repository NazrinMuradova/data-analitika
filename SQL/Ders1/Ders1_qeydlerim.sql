/* Ders 1 qeydler */

select /* selectden sonra yazilan sheyler sutunlarda cap olunur */

select getdate() as 'Tarix ve Saat'   /* burda getdate funksiyasi bize tarixi,saati verir; as (alias) ise ad verir hemin xananin ustundeki bos xanaya;daha sonra ' ' ona gore istifade ediremki daxilinde yazdiqlarim oldugub kimi cap olunsun, ' ' olmadan yazsam error vererdi(soz sayi 1den cox olarsa, boshlugu xeta olaraq qebul edir) */

select 1  /* bu sadece xana icherisinde 1i cap edir, bu ve bundan onceki select emrlerini eyni anda run etsem ikisi de ishleyecek amma ayri ayri  yerlerde netice gorunur  */
select 1 amerika /*burda 1den sonra yazdigim sutunun adi olur(advermenin bashqa yolu)*/
select '1' 'amerika' /* burda da eyni qaydada, IKINCI yazdigimiz sutunun ADIDIR; DEYER,AD */ 

select 1 'eded' /* 1i eded sutununa aid etdik, dirnaq isaresinin icinde ne yazilirsa oldugu kimi print olunur*/
select 'eded' 1 /* ERROR verecek, 1ci neyise yazib sonra ad vermeliyik; Yaz ve Sonra aid oldugu yeri Adlandir */

select 'Nezrin Muradova Azad' /* selectde neyi yazirsansa hamisi sutunda cap olunur */
select 'Nezrin' + ' ' + ' ' + 'Muradova Azadqizi' /*daha uzun yolu concat basha dushmeye komek meqsedi(asagida)*/

select 'Nezz' as Ad /* sutuna ad veririk */
select 'Nezz' as Ad ve soyad /* ERROR verecek, cunki bosluqlari tanimir,as isledende bosluq QETI OLMAZ */
select 'Nezz' as Ad_ve_soyad /* burda simvol var isleyecek */
select 'Nezi' [Adiniz ve soyadiniz:] /* advermenin bashqa yolu*/

select cast('Salam. Necesen?' as char(8)) /* Salam. N sadece bunu print edir(8 simvol), char'da nece simvol vermisense ona tamamlayir;yeni simvolSayi 8den azdirsa qalan simvollari boshluqlarla doldurur 8e catana kimi, yox 8den coxdursa 8 olan kimi dayanir*/
select cast('Salam. Necesen?' as varchar(500)) /* varchar cox deqiqdir yazdigin qeder simvol varsa onu cap edir, yoxdursa tamamlamaga CALISMIR! */

select cast('salam, necəsiniz?' as nchar(13)) /* n ile bashlayan (var)charlari isledende 'ə' herfi kimi ingiliscede olmayan herflerin yerine sual print olunur avtomatik*/
select cast(N'salam, necəsiniz?' as nchar(13)) /* textin qabagina N yazanda, az dilinde herfler sual yox ele ozu kimi cap olunur*/

select cast('salamlar' as varchar(MAX)) as 'Sütunumun adı = çoxlu cümlələr' /* bu o demekdir ki limitsizdir, ne yazilirsa qebul olunur;Elave olaraq, biz sutuna ne ad veririkse o da cap olunur onun elifbayla elaqesi yoxdur*/
/* NULL melumat yoxdur,hecne yoxdur demekdir. */

                               /* RIYAZI EMELLER */


select 6+7  toplama, 6-7  'cixma', 6/7.0 as bolme, 6*7  [vurma_emeli], 16%7 [qaliq] /* burda hem vergulden istifade edib sutunlari ayirmisiq, hem de adlandirmisiq*/
/*bolme emelini edende boleni  .0 shekilinde yazmaliyiq deqiq cavabi almaq ucun*/

/* Bu hisseye qeder ne edirdikse hamisi master database(default) esasinda icra olunurdu. Indi spesifik secirik, BikeStores databazasindan istifade edecem*/
select * /* selectden sonra ulduz isaresini isletmek butun sutunlari istemekdir; yazdigim shey butun sutunlari ehate elesin*/

/* Amma daha SPESIFIK sutun seciremse unvani DEQIQ yaziram asagidaki kimi*/
select product_id from BikeStores.production.products /* ilk olaraq select yazib kecirem from, sonra birbasa databaza adi yazilir, bele davam, sonra select ve from arasina gelib rahat tapirsan(asan versiyadir)*/

select product_id as mehsul_id from BikeStores.production.products /*ad verdim: product_id deyishdi oldu mehsul_id*/
select product_id  mehsul_id from BikeStores.production.products /* diger adverme usulu */

/* CONCAT birleshdirmek */
select 'Nezrin' + ' ' + ' ' + 'Muradova Azadqizi' as Ad_Soyad_AtaAdi 
select concat('Nezrin',' ', 'Muradova Azadqizi') [AD_SOYAD_ATAADI] /* ustegeller gedir sadece vergul qalir */
select first_name as ilk_ad, last_name soyad from BikeStores.sales.customers 
select first_name ilk_ad, last_name soyad from BikeStores.sales.customers /* spesifik sutunlar secib ad verdim */
select first_name + ' ' + last_name 'Ad  ve Soyad' from BikeStores.sales.customers 
select first_name + ' ' + last_name [Ad  ve Soyad] from BikeStores.sales.customers /*bu ve evvelki setrde iki xanani birlesdirib ad verdim sutuna*/


/* YENI DATABASE YARATMAQ */
create database Test_db /* Test_db veya TestDB yazmaq olur. Databazani yaradiriq sonra object explorer hissesinde databazanin uzerine sag klik edib script database as->create to->new secirik ki databaza tamamlansin */
create schema Test_schema /* bele yazsaq ugurla tamamlandigi yazilsada, security hissesinden schema secib yaratdigimi schemani gormuruk, cunki aid oldugu databazani tanimir*/


create database Test_db /* run etmeye ehtiyac YOXDUE, onsuzda databaza yaratmisiq*/
use Test_db
create schema Test_schema  /* ayrica USE olan setri run edirik databazamiz taninir, sonra kecirik novbeti setri run edirik ve schema aktiv olur(bayaqki problem aradan qalxir) */

/* 
create table Muellimler(
muellimAd nvarchar(20),
muellimID int, 
)
*/
use Test_db
create table Test_schema.Muellimler(
muellimAd nvarchar(20),
muellimID int, /* int identity (x,y) limit qoyur sanki */
)
use Test_db
create table Test_schema.customers(
cust_ID int identity(1, 1), /* int identity (x,y) limit qoyur sanki */
custAd nvarchar(30),
custEmail varchar(80), 
yaradilmaTarixi datetime default getdate()
)

