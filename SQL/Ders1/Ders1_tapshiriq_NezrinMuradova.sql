create database UniversitetDB /* Universitet_db da adlandirmaq olur */
create schema Personallar /* execute`dan sonra ugurla tamamlandigi yazilsada, security hissesinden schema secende yaratdigimi schemani gormuruk, cunki aid oldugu databazani tanimir*/


use UniversitetDB /* bu setri execute edirik databazamiz taninir */
create schema Personallar
create schema Academic /* bu 2 setri execute edirik ve schema`lar aktiv olur(bayaqki problem aradan qalxir)*/

create table Personallar.Telebe(
TelebeID int,
Ad nvarchar(100),
Soyad nvarchar(100),
Yash int,
"Ortalama Bal"  decimal(6,2), /* ümumi rəqəm sayi max 5dir (100.00 → 5 rəqəm), 2 onluqdan sonra (meselen 95.75 → 2 rəqəm)*/
[Dogum Tarixi] date, /* burda sutunun adinda bosluq olarsa xeta verer bu sebebden bu usullari sinadim */
Aktivdir bit 
) /* Cedvel yarandi ve sutunlar gorunur*/

alter table  Personallar.Telebe
alter column "Ortalama Bal" decimal(5,2);  /* alter funksiyasindan istifade ederek decimal ucun teyin etdiyim deyeri deyishdim */

create table Personallar.Muellimler(
MüəllimID int,
Ad nvarchar(100),
Soyad nvarchar(100),
E_poçt nvarchar(100),
ŞöbəID int,
İşəQəbulTarixi date
)

create table Academic.Kurslar (
KursID int,
KursAdı nvarchar(100),
Kredit int,
MuellimİD int,
DepartamentID int
)
