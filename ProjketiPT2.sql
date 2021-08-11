CREATE DATABASE Ecommerce
use Ecommerce


create table Konsumatori(

    Konsumatori_ID int identity (1,1),
	Emri varchar(20) not null,
	Mbiemri varchar(20) not null,
    Emri_Kontaktues char(3),
	constraint   Konsumatori_ID primary key (Konsumatori_ID)
)

create table Furnizuesi(

   Furnizuesi_ID int not null identity (100,1),
   Emri_Kompanis varchar(20) not null,
   Koha_Dergimit date,
   Pagesat int  check (Pagesat>1000),
   Website varchar(20),
   Numri_Llogarise int not null
   constraint Furnizuesi_ID primary key (Furnizuesi_ID)
)

create table Useri/*Useri eshte specializimi i 2 entiteteve si konsumatori dhe furnizues krijojn Userin*/(
	KonsuamtoriID int UNIQUE ,
	FurnizuesiID int UNIQUE,
	constraint mark_user primary key (KonsuamtoriID,FurnizuesiID ),
	constraint mark_user_Konsumatori  foreign key(KonsuamtoriID)  references Konsumatori(Konsumatori_ID),
	constraint mark_user_Furnizuesi  foreign  key(FurnizuesiID)  references Furnizuesi(Furnizuesi_ID)

)
   
create table InformacionePersonale(
      Datelindja date,
	  Shteti varchar(20),
	  Qyteti varchar(20),
	  Rruga varchar(40),
	  KodiPostal char (10),
	  Emaili varchar(30) UNIQUE,
	  KonsumatoriID INT Unique,
	  constraint mark_Info primary key ( KonsumatoriID),
	  constraint mark_info_Konsumatori  foreign key( KonsumatoriID )  references Konsumatori(Konsumatori_ID)
	 
)
create table InformacionePersonaleFurnizuesi(
      Datelindja date,
	  Shteti varchar(20),
	  Qyteti varchar(20),
	  Rruga varchar(40),
	  KodiPostal char (10),
	  Emaili varchar(30) UNIQUE,
	  FurnizuesID INT Unique,
	  constraint mark_Info_F primary key ( FurnizuesID),
	  constraint mark_info_Furnizuesi  foreign key( FurnizuesID )  references Konsumatori(Konsumatori_ID)
	 
)


create table Produkti (
      
	  Produkti_ID int not null primary key identity(1000,2),
	  Emri_Produktit varchar(30) not null,
	  FurnizuesiID int not null,
	  Sasia_Disponueshme int not null,
	  Cmimi money,
	  Foto image,
	  Renditja_Nivelit float,
	  SasiaPerNjesi integer not null,
	  Njesia_Madhesis char(1),
	  Zbritja money,
	  Pershkrimi_Produktit varchar(255),
	  KategoriaID int not null,
	  AdminiID int not null,
	  Constraint mark_Furnizuesi foreign key(FurnizuesiID) references Furnizuesi(Furnizuesi_ID),
	  foreign key(AdminiID) references Admini(Admini_ID),
	  Constraint mark_Kategoria foreign key(KategoriaID) references Kategoria(Kategoria_ID)

	  



)

create table Admini(

    Admini_ID int not null primary key,
	Admini_Emri varchar(10),
	Admini_Username varchar(20) not null,
	Admini_Passwordi Varchar(100),
	



)

create table Mbikqyresi(

    Mbikqyresi_ID int not null primary key identity (80,2),
	Emri varchar(10) not null,
	Kategoria varchar(20) UNIQUE,
    AdminiID int not null,
	constraint mark_Adminin foreign key(AdminiID) references Admini(Admini_ID),
	KeshilluesiMbikqyres int  foreign key references Mbikqyresi(Mbikqyresi_ID)
)
drop table Produkti
create table Kategoria(
     
 Kategoria_ID int not null primary key,
 Emri_Kategoris varchar(20) not null,
 foto image,
 Pershkrimi varchar(255)

)

create table Ka_ne_Shport(
  
  KonsumatoriID int not null,
  ProduktiID int not null,
  ShportaID int not null,
  primary key (KonsumatoriID,ProduktiID,ShportaID),
  constraint mark_Konsumatori foreign key (KonsumatoriID) references Konsumatori(Konsumatori_ID),
  constraint mark_Produkti foreign key (ProduktiID) references Produkti(Produkti_ID),
  constraint mark_Shporta foreign key( ShportaID) references Shporta(Shporta_ID)

 
 )
 
 create table Shporta(
 
   Shporta_ID int not null primary key,
   Numri_Produkteve int not null,
   Cmimi money,
)

create table InforamcioneFaturimi(
 
 Faturimi_ID int not null primary key identity (10000,1),
 Data_Skadimit_Karteles date,
 PIN_Kredit_Kartela int not null,
 Numri_Kredit_Kartela int not null,
 Id_Kartes int ,
 Data_Fatures date,
 Adresa_Faturimit varchar(20) not null
 )

 create table Ka_Info_Faturimi(

 KonsumatoriID int ,
 FaturimiID int,
 primary key (KonsumatoriID,FaturimiID),
 foreign key( FaturimiID )references InforamcioneFaturimi(Faturimi_ID),
 foreign key( KonsumatoriID) references Konsumatori(Konsumatori_ID)

 )
 create table Financieri(
  Financieri_ID int not null  primary key,
  Emri varchar(20) not null,
  Mbiemri varchar(20)not null,
  Mosha int,
  Paga int default 750

  )
 
 create table Kontrollon(
 
    FaturimiID int ,
	KonsumatoriID int ,
	FinancieriID int,
	primary key (FaturimiID,KonsumatoriID,FinancieriID),
	foreign key( FaturimiID )references InforamcioneFaturimi(Faturimi_ID),
    foreign key( KonsumatoriID) references Konsumatori(Konsumatori_ID),
    foreign key(FinancieriID) references Financieri(Financieri_ID)
 
 
 )
 
 create table Blerjet(
 
 KonsumatoriID int ,
 FaturimiID int,
 primary key (KonsumatoriID,FaturimiID),
 foreign key( FaturimiID )references InforamcioneFaturimi(Faturimi_ID),
 foreign key( KonsumatoriID) references Konsumatori(Konsumatori_ID)

 )
 
 create table Porosia(
  PorosiaID int not null primary key identity (0000,1),
  Data_Porosis date,
  Data_Dergeses date,
  Porosia_Permes varchar (10) ,
  FaturimiID int,
  TransportuesiID int,
  foreign key( FaturimiID )references InforamcioneFaturimi(Faturimi_ID),
  foreign key (TransportuesiID) references Transportues(Transportuesi_ID)
 
 
 
 )
 drop table Porosia
 create table Transportues(
 Transportuesi_ID int not null primary key,
 Emri_Kompanis varchar(20),
 Telefoni int not null,
 
 
 
 )

 create table Detajet_e_Porosis(
 
  Porosia_ID int not null,
  ProduktiID int not null,
  Sasia int ,
  Zbritja int,
  Cmimi money,
  foreign key (Porosia_ID) references Porosia(PorosiaID),
  foreign key (ProduktiID) references Produkti(Produkti_ID)


 
 
 )

 create table Jep(
 KonsumatoriID int ,
 ShportaID int,
 Porosia_ID int,
 foreign key (Porosia_ID) references Porosia(PorosiaID),
 foreign key( KonsumatoriID) references Konsumatori(Konsumatori_ID),
 foreign key (ShportaID) references Shporta(Shporta_ID),
 Vula_kohore time

 
 
 )
 
  --Insertimi i te dhenava ne Tabelen Prind Furnizuesi
  SET IDENTITY_INSERT Porosia on

  INSERT INTO [dbo].[Furnizuesi]([Furnizuesi_ID],[Emri_Kompanis],[Koha_Dergimit],[Pagesat],[Website],[Numri_Llogarise]) VALUES (1,'A-Komerc','2020-01-10',1500,'www.akomerc.net',123456789)
  INSERT INTO [dbo].[Furnizuesi]([Furnizuesi_ID],[Emri_Kompanis],[Koha_Dergimit],[Pagesat],[Website],[Numri_Llogarise]) VALUES (2,'B-Komerc','2020-01-9',5000,'www.bkomerc.com',17894532)
  INSERT INTO [dbo].[Furnizuesi]([Furnizuesi_ID],[Emri_Kompanis],[Koha_Dergimit],[Pagesat],[Website],[Numri_Llogarise]) VALUES (3,'AlTrade','2020-01-2',10000,'www.Altrade.org',1234569859)
  INSERT INTO [dbo].[Furnizuesi]([Furnizuesi_ID],[Emri_Kompanis],[Koha_Dergimit],[Pagesat],[Website],[Numri_Llogarise]) VALUES (4,'FisiKomerc','2020-11-10',5478,'www.FisiKomerc.net',69456789)
  INSERT INTO [dbo].[Furnizuesi]([Furnizuesi_ID],[Emri_Kompanis],[Koha_Dergimit],[Pagesat],[Website],[Numri_Llogarise]) VALUES (5,'Viva','2020-11-15',1547,'www.akomerc.net',35686789)
  INSERT INTO [dbo].[Furnizuesi]([Furnizuesi_ID],[Emri_Kompanis],[Koha_Dergimit],[Pagesat],[Website],[Numri_Llogarise]) VALUES (6,'KlevioCom','2020-12-5',30000,'www.Viva.net',9635842)
  INSERT INTO [dbo].[Furnizuesi]([Furnizuesi_ID],[Emri_Kompanis],[Koha_Dergimit],[Pagesat],[Website],[Numri_Llogarise]) VALUES (7,'Deon','2021-01-10',20000,'www.Deon.net',13597466)
  INSERT INTO [dbo].[Furnizuesi]([Furnizuesi_ID],[Emri_Kompanis],[Koha_Dergimit],[Pagesat],[Website],[Numri_Llogarise]) VALUES (8,'ShabiTEX','2021-01-5',7800,'www.ShabiTEX.net',17894512)
  INSERT INTO [dbo].[Furnizuesi]([Furnizuesi_ID],[Emri_Kompanis],[Koha_Dergimit],[Pagesat],[Website],[Numri_Llogarise]) VALUES (9,'XYZ','2020-05-10',78945,'www.xyz.cn',85236975)
  INSERT INTO [dbo].[Furnizuesi]([Furnizuesi_ID],[Emri_Kompanis],[Koha_Dergimit],[Pagesat],[Website],[Numri_Llogarise]) VALUES (10,'MacedoniTex','2021-01-15',2874,'www.mtx.com',875597466)
  INSERT INTO [dbo].[Furnizuesi]([Furnizuesi_ID],[Emri_Kompanis],[Koha_Dergimit],[Pagesat],[Website],[Numri_Llogarise]) VALUES (11,'BritishTex','2020-05-10',100000,'www.British.co.uk',87946512)
 
 --Insertimi i te dhenave ne Tabelen Prind Kategoria
 INSERT INTO [dbo].[Kategoria]([Kategoria_ID],[Emri_Kategoris],[foto],[Pershkrimi]) VALUES(555,'Shoes',null,'Ketu eshte Kategoria e Kepuceve per Femije')
 INSERT INTO [dbo].[Kategoria]([Kategoria_ID],[Emri_Kategoris],[foto],[Pershkrimi]) VALUES(888,'Fashion',null,'Fashion Kategori')
 INSERT INTO [dbo].[Kategoria]([Kategoria_ID],[Emri_Kategoris],[foto],[Pershkrimi]) VALUES(777,'Men’s Clothing',null,'Veshje per Meshkuj')
 INSERT INTO [dbo].[Kategoria]([Kategoria_ID],[Emri_Kategoris],[foto],[Pershkrimi]) VALUES(222,'Men’s Shoes',null,'Kepuc per Meshkuj')
 INSERT INTO [dbo].[Kategoria]([Kategoria_ID],[Emri_Kategoris],[foto],[Pershkrimi]) VALUES(333,'Women’s Clothing',null,'Veshje per Vajza')
 INSERT INTO [dbo].[Kategoria]([Kategoria_ID],[Emri_Kategoris],[foto],[Pershkrimi]) VALUES(444,'Elecrtonics',null,'Elektronike')
 INSERT INTO [dbo].[Kategoria]([Kategoria_ID],[Emri_Kategoris],[foto],[Pershkrimi]) VALUES(441,'Musical Instruments',null,'Insutrumente Muzikore')
 INSERT INTO [dbo].[Kategoria]([Kategoria_ID],[Emri_Kategoris],[foto],[Pershkrimi]) VALUES(442,'Sports',null,'Sport')
 INSERT INTO [dbo].[Kategoria]([Kategoria_ID],[Emri_Kategoris],[foto],[Pershkrimi]) VALUES(443,'Video Games',null,'Video Lojra')
 INSERT INTO [dbo].[Kategoria]([Kategoria_ID],[Emri_Kategoris],[foto],[Pershkrimi]) VALUES(998,'Women"s Shoesv',null,'Kepuc per Vajza')
 

 


  --Insertimi i te dhenave ne Tabelen Prind Admini
  INSERT INTO [dbo].[Admini]([Admini_ID],[Admini_Emri],[Admini_Username],[Admini_Passwordi]) VALUES(33,'Richard','Rich123','abcA123.')
  INSERT INTO [dbo].[Admini]([Admini_ID],[Admini_Emri],[Admini_Username],[Admini_Passwordi]) VALUES(35,'Paul','Paul.P','Hello123.')
  INSERT INTO [dbo].[Admini]([Admini_ID],[Admini_Emri],[Admini_Username],[Admini_Passwordi]) VALUES(37,'Nick','NickJ','Wolrd.')
  INSERT INTO [dbo].[Admini]([Admini_ID],[Admini_Emri],[Admini_Username],[Admini_Passwordi]) VALUES(38,'Hector','HHh.H','5684585.')
  INSERT INTO [dbo].[Admini]([Admini_ID],[Admini_Emri],[Admini_Username],[Admini_Passwordi]) VALUES(39,'Granit','Granittt','98567.') 
  INSERT INTO [dbo].[Admini]([Admini_ID],[Admini_Emri],[Admini_Username],[Admini_Passwordi]) VALUES(45,'Gabriel','Gabi','658455.')
  INSERT INTO [dbo].[Admini]([Admini_ID],[Admini_Emri],[Admini_Username],[Admini_Passwordi]) VALUES(65,'Nicolas','N321','123654')
  INSERT INTO [dbo].[Admini]([Admini_ID],[Admini_Emri],[Admini_Username],[Admini_Passwordi]) VALUES(56,'Joe','Joe87','123456')
  INSERT INTO [dbo].[Admini]([Admini_ID],[Admini_Emri],[Admini_Username],[Admini_Passwordi]) VALUES(54,'Emile','EMILE','123456.')
  INSERT INTO [dbo].[Admini]([Admini_ID],[Admini_Emri],[Admini_Username],[Admini_Passwordi]) VALUES(40,'Bernd','B20','123456.')
	   INSERT INTO [dbo].[Admini]([Admini_ID],[Admini_Emri],[Admini_Username],[Admini_Passwordi]) VALUES(35,'Emi','EmiE','123456')
--Insertimi i te dhenave ne Tabelen Prind Produkti
 SET IDENTITY_INSERT Konsumatori off
 INSERT INTO [dbo].[Produkti]([Produkti_ID],[Emri_Produktit],[FurnizuesiID],[Sasia_Disponueshme],[Cmimi],[Foto],[Renditja_Nivelit],[SasiaPerNjesi],[Njesia_Madhesis],[Zbritja],[Pershkrimi_Produktit],[KategoriaID],[AdminiID]) VALUES (1000,'RVROVIC Kepuc per femije',8,11,10.99,null,10,5,34,null,'rehati e pabesueshme
      fleksibilitet ,stil bashkëkohor',555,33)


INSERT INTO [dbo].[Produkti]([Produkti_ID],[Emri_Produktit],[FurnizuesiID],[Sasia_Disponueshme],[Cmimi],[Foto],[Renditja_Nivelit],[SasiaPerNjesi],[Njesia_Madhesis],[Zbritja],[Pershkrimi_Produktit],[KategoriaID],[AdminiID]) VALUES (1002,'Nike T-Shirt',10,15,25.0,null,4,9,'M',null,'rehati e pabesueshme
      fleksibilitet ,stil bashkëkohor',888,37)

INSERT INTO [dbo].[Produkti]([Produkti_ID],[Emri_Produktit],[FurnizuesiID],[Sasia_Disponueshme],[Cmimi],[Foto],[Renditja_Nivelit],[SasiaPerNjesi],[Njesia_Madhesis],[Zbritja],[Pershkrimi_Produktit],[KategoriaID],[AdminiID]) VALUES (1004,'Nike T-Shirt',5,15,25.0,null,4,6,'S',null,'rehati e pabesueshme
      fleksibilitet ,stil bashkëkohor',888,39)


INSERT INTO [dbo].[Produkti]([Produkti_ID],[Emri_Produktit],[FurnizuesiID],[Sasia_Disponueshme],[Cmimi],[Foto],[Renditja_Nivelit],[SasiaPerNjesi],[Njesia_Madhesis],[Zbritja],[Pershkrimi_Produktit],[KategoriaID],[AdminiID]) VALUES (1006,'DADAWEN Kepuce per  Vajza',5,1,22.94,null,4,1,39,null,'WaterProof',555,54)


INSERT INTO [dbo].[Produkti]([Produkti_ID],[Emri_Produktit],[FurnizuesiID],[Sasia_Disponueshme],[Cmimi],[Foto],[Renditja_Nivelit],[SasiaPerNjesi],[Njesia_Madhesis],[Zbritja],[Pershkrimi_Produktit],[KategoriaID],[AdminiID]) VALUES (1008,'Lightweight T-Shirt',7,50,19.54,null,4,47,'X',null,'Bluze me mëngë të gjata',555,56)

INSERT INTO [dbo].[Produkti]([Produkti_ID],[Emri_Produktit],[FurnizuesiID],[Sasia_Disponueshme],[Cmimi],[Foto],[Renditja_Nivelit],[SasiaPerNjesi],[Njesia_Madhesis],[Zbritja],[Pershkrimi_Produktit],[KategoriaID],[AdminiID]) VALUES (1010,'Computer Microphone',3,22,15.29,null,4,15,'P',null,'Dizajn kompakt me pemë metalike të rregullueshme 360 ​​°',441,40)

INSERT INTO [dbo].[Produkti]([Produkti_ID],[Emri_Produktit],[FurnizuesiID],[Sasia_Disponueshme],[Cmimi],[Foto],[Renditja_Nivelit],[SasiaPerNjesi],[Njesia_Madhesis],[Zbritja],[Pershkrimi_Produktit],[KategoriaID],[AdminiID]) VALUES (1012,'GELETE Smart Glasses Wireless',9,5,36.99,null,4,2,'P',null,'Syze dielli IPX4 i papërshkueshëm nga uji',444,45)

INSERT INTO [dbo].[Produkti]([Produkti_ID],[Emri_Produktit],[FurnizuesiID],[Sasia_Disponueshme],[Cmimi],[Foto],[Renditja_Nivelit],[SasiaPerNjesi],[Njesia_Madhesis],[Zbritja],[Pershkrimi_Produktit],[KategoriaID],[AdminiID]) VALUES (1014,'FIFA 21 – Xbox One & Xbox Series X',9,5,30.00,null,4,2,'X',null,'Merrni FIFA 21 për të dy sistemet e lojërave aktuale dhe ato të gjeneratës së ardhshme',443,56)

INSERT INTO [dbo].[Produkti]([Produkti_ID],[Emri_Produktit],[FurnizuesiID],[Sasia_Disponueshme],[Cmimi],[Foto],[Renditja_Nivelit],[SasiaPerNjesi],[Njesia_Madhesis],[Zbritja],[Pershkrimi_Produktit],[KategoriaID],[AdminiID]) VALUES (1016,'GELETE Smart Glasses Wireless',5,5,36.99,null,4,2,'P',null,'Syze dielli IPX4 i papërshkueshëm nga uji',444,38)

INSERT INTO [dbo].[Produkti]([Produkti_ID],[Emri_Produktit],[FurnizuesiID],[Sasia_Disponueshme],[Cmimi],[Foto],[Renditja_Nivelit],[SasiaPerNjesi],[Njesia_Madhesis],[Zbritja],[Pershkrimi_Produktit],[KategoriaID],[AdminiID]) VALUES (1018,'Solomon Kepuc per Vjaza',5,5,125.25,null,4,2,'P',null,'Waterproof',998,65)

INSERT INTO [dbo].[Produkti]([Produkti_ID],[Emri_Produktit],[FurnizuesiID],[Sasia_Disponueshme],[Cmimi],[Foto],[Renditja_Nivelit],[SasiaPerNjesi],[Njesia_Madhesis],[Zbritja],[Pershkrimi_Produktit],[KategoriaID],[AdminiID]) VALUES (1020,'Top Adidas',11,5,89,null,4,2,'P',null,'Top futbolli ',442,35)
INSERT INTO [dbo].[Produkti]([Produkti_ID],[Emri_Produktit],[FurnizuesiID],[Sasia_Disponueshme],[Cmimi],[Foto],[Renditja_Nivelit],[SasiaPerNjesi],[Njesia_Madhesis],[Zbritja],[Pershkrimi_Produktit],[KategoriaID],[AdminiID]) VALUES (1018,'Solomon Kepuc per Vjaza',5,5,125.25,null,4,2,'P',null,'Waterproof',998,65)

	 
	 --Delete Statement
	 delete from Produkti where Produkti_ID=1002
	 delete from Produkti where Produkti_ID=1010

	 select * from Jep



	 --Insertimi i te dhenave ne tabelen Mbikqyresi
	 INSERT INTO [dbo].[Mbikqyresi]([Mbikqyresi_ID],[Emri],[Kategoria],[AdminiID],[KeshilluesiMbikqyres]) VALUES (80,'Rob','Shoes',33,null)
	 INSERT INTO [dbo].[Mbikqyresi]([Mbikqyresi_ID],[Emri],[Kategoria],[AdminiID],[KeshilluesiMbikqyres]) VALUES (82,'Bob','Fashion',35,80)
	 INSERT INTO [dbo].[Mbikqyresi]([Mbikqyresi_ID],[Emri],[Kategoria],[AdminiID],[KeshilluesiMbikqyres]) VALUES (84,'Mikel','Men’s Shoes',38,86)
	 INSERT INTO [dbo].[Mbikqyresi]([Mbikqyresi_ID],[Emri],[Kategoria],[AdminiID],[KeshilluesiMbikqyres]) VALUES (86,'QQQ','Men’s Clothing',37,null)
	 INSERT INTO [dbo].[Mbikqyresi]([Mbikqyresi_ID],[Emri],[Kategoria],[AdminiID],[KeshilluesiMbikqyres]) VALUES (88,'Agim','Women’s Clothing',39,null)
	 INSERT INTO [dbo].[Mbikqyresi]([Mbikqyresi_ID],[Emri],[Kategoria],[AdminiID],[KeshilluesiMbikqyres]) VALUES (90,'Petrit','Elecrtonics',45,null)
	 INSERT INTO [dbo].[Mbikqyresi]([Mbikqyresi_ID],[Emri],[Kategoria],[AdminiID],[KeshilluesiMbikqyres]) VALUES (92,'HHH','Sports',65,null)
	 INSERT INTO [dbo].[Mbikqyresi]([Mbikqyresi_ID],[Emri],[Kategoria],[AdminiID],[KeshilluesiMbikqyres]) VALUES (94,'WWW','Musical Instruments',45,null)
	
	 INSERT INTO [dbo].[Mbikqyresi]([Mbikqyresi_ID],[Emri],[Kategoria],[AdminiID],[KeshilluesiMbikqyres]) VALUES (96,'Pedro','Video Games',54,null)
     INSERT INTO [dbo].[Mbikqyresi]([Mbikqyresi_ID],[Emri],[Kategoria],[AdminiID],[KeshilluesiMbikqyres]) VALUES (98,'Pedro','Women"s Shoes',40,null)
	 INSERT INTO [dbo].[Mbikqyresi]([Mbikqyresi_ID],[Emri],[Kategoria],[AdminiID],[KeshilluesiMbikqyres]) VALUES (100,'Amii','All',56,null)


	 --Insertimi i te dhenave ne tabelen Konsumatori
	 INSERT INTO [dbo].[Konsumatori]([Konsumatori_ID],[Emri],[Mbiemri],[Emri_Kontaktues]) VALUES (1,'Jeton','Sopa','JTS')
	 INSERT INTO [dbo].[Konsumatori]([Konsumatori_ID],[Emri],[Mbiemri],[Emri_Kontaktues]) VALUES (2,'Arber','Sopa','ABS')
	 INSERT INTO [dbo].[Konsumatori]([Konsumatori_ID],[Emri],[Mbiemri],[Emri_Kontaktues]) VALUES (12,'Mikel','Arteta','Mkl')
	 INSERT INTO [dbo].[Konsumatori]([Konsumatori_ID],[Emri],[Mbiemri],[Emri_Kontaktues]) VALUES (4,'Frank','Lampard','frL')
	 INSERT INTO [dbo].[Konsumatori]([Konsumatori_ID],[Emri],[Mbiemri],[Emri_Kontaktues]) VALUES (5,'Andrea','Conte','ACC')
	 INSERT INTO [dbo].[Konsumatori]([Konsumatori_ID],[Emri],[Mbiemri],[Emri_Kontaktues]) VALUES (6,'Nol','Gashi','NLG')
	 INSERT INTO [dbo].[Konsumatori]([Konsumatori_ID],[Emri],[Mbiemri],[Emri_Kontaktues]) VALUES (7,'Filan','Fisteku','FLK')
	 INSERT INTO [dbo].[Konsumatori]([Konsumatori_ID],[Emri],[Mbiemri],[Emri_Kontaktues]) VALUES (8,'Filan1','Fisteku1','FF1')
	 INSERT INTO [dbo].[Konsumatori]([Konsumatori_ID],[Emri],[Mbiemri],[Emri_Kontaktues]) VALUES (9,'Bardh','Bardhi','BBB')
	 INSERT INTO [dbo].[Konsumatori]([Konsumatori_ID],[Emri],[Mbiemri],[Emri_Kontaktues]) VALUES (10,'Arsim','Krasniqi','Ak1')
	 INSERT INTO [dbo].[Konsumatori]([Konsumatori_ID],[Emri],[Mbiemri],[Emri_Kontaktues]) VALUES (11,'Ole','Solskajer','OGS')

	 --Insertimi i te dhenave ne tabelen TeDhenaPersonal
	 INSERT INTO [dbo].[InformacionePersonale]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[KonsumatoriID]) Values('1950-01-11','Kosove','Prishtine','Muharrem Fejza',10000,'js@gmail.com',1)
     INSERT INTO [dbo].[InformacionePersonale]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[KonsumatoriID]) Values('1978-05-14','Shqiper','Durres','Rr.Plazhi',2000,'ArberAlbania@gmail.com',2)
	 INSERT INTO [dbo].[InformacionePersonale]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[KonsumatoriID]) Values('1982-01-11','Spanje','Malaga','MalagaS123',36000,'MikelArteta@yahoo.com',12)
	 INSERT INTO [dbo].[InformacionePersonale]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[KonsumatoriID]) Values('1967-11-5','Itali','Milan','MilanC',50000,'ConteTeam@yahoo.com',5)
     INSERT INTO [dbo].[InformacionePersonale]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[KonsumatoriID]) Values('1982-01-11','Spanje','Malaga','MalagaS123',36000,'Frank912@hotmail.com',4)
	 INSERT INTO [dbo].[InformacionePersonale]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[KonsumatoriID]) Values('1999-11-5','Kosove','Peje','GjergjFishta',30000,'nolgg@gmail.com',6)
	  INSERT INTO [dbo].[InformacionePersonale]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[KonsumatoriID]) Values('1992-12-10','Kosove','Mitrovice','IsaB',20000,'FilanFistekju@gmail.com',7)
	   INSERT INTO [dbo].[InformacionePersonale]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[KonsumatoriID]) Values('2000-06-5','Kosove','Prizeren','Sheshi',40000,'Filani11@hotmail.com',8)
	    INSERT INTO [dbo].[InformacionePersonale]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[KonsumatoriID]) Values('1998-02-17','Maqedoni','Shkup','FilipiII',72000,'BrdhiSkopje@yahoo.com',9)
		 INSERT INTO [dbo].[InformacionePersonale]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[KonsumatoriID]) Values('2000-07-11','Montenegro','Plave','Magjistralja',65100,'Cima@yahoo.com',10)
		  INSERT INTO [dbo].[InformacionePersonale]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[KonsumatoriID]) Values('1960-09-15','Norvegji','Oslo','Jsw32',461100,'OleOnthwheel@gmail.com',11)

		  --Insertmimi i te dhenave ne tablelen [InformacionePersonaleFurnizuesi]
		   INSERT INTO [dbo].[InformacionePersonaleFurnizuesi]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[FurnizuesID]) Values(null,'Norvegji','Oslo','46644',461100,'Akomerc@gmail.com',1)
		   INSERT INTO [dbo].[InformacionePersonaleFurnizuesi]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[FurnizuesID]) Values(null,'Kroaci','Zagreb','Street19',10010,'Bkomerc@gmail.com',2)
		   INSERT INTO [dbo].[InformacionePersonaleFurnizuesi]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[FurnizuesID]) Values(null,'Kosove','Prishtine','Emshir',1000,'FisiKom@gmail.com',4)
	      INSERT INTO [dbo].[InformacionePersonaleFurnizuesi]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[FurnizuesID]) Values(null,'Kosove','Prishtine','FusheKosove',10000,'Viva@gmail.com',5)
	       INSERT INTO [dbo].[InformacionePersonaleFurnizuesi]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[FurnizuesID]) Values(null,'Shqiperi','Tirane','Blloku',1001,'Klevio@gmail.com',6)
			     INSERT INTO [dbo].[InformacionePersonaleFurnizuesi]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[FurnizuesID]) Values(null,'Kosove','Peje','Vito',30000,'deontextile@gmail.com',7)
			   INSERT INTO [dbo].[InformacionePersonaleFurnizuesi]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[FurnizuesID]) Values(null,'Kosove','Prishtine','Aktash',10000,'Shabi123@hotmail.com',8)
				     INSERT INTO [dbo].[InformacionePersonaleFurnizuesi]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[FurnizuesID]) Values(null,'Kine','Pekin',null,61554,'xyz@gmail.com.cn',9)
					   INSERT INTO [dbo].[InformacionePersonaleFurnizuesi]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[FurnizuesID]) Values(null,'Maqedoni','Tetove',null,1200,'ma@gmail.com',10)
					     INSERT INTO [dbo].[InformacionePersonaleFurnizuesi]([Datelindja],[Shteti],[Qyteti],[Rruga],[KodiPostal],[Emaili],[FurnizuesID]) Values(null,'Angli','Southampton',null,014,'BritishTex@gmail.co.uk',11)
		   delete from InformacionePersonaleFurnizuesi where FurnizuesID=4

		   --Inserttimi i te dhenave ne tabelen InforamcioneFaturimi
		   Insert into [dbo].[InforamcioneFaturimi]([Faturimi_ID],[Data_Skadimit_Karteles],[PIN_Kredit_Kartela],[Numri_Kredit_Kartela],[Id_Kartes],[Data_Fatures],[Adresa_Faturimit]) values(10000,'2024-01-11',2000,123456789,245,'2021-01-10','Kosovo/Peje')
		   Insert into [dbo].[InforamcioneFaturimi]([Faturimi_ID],[Data_Skadimit_Karteles],[PIN_Kredit_Kartela],[Numri_Kredit_Kartela],[Id_Kartes],[Data_Fatures],[Adresa_Faturimit]) values(10001,'2022-01-11',1967,987456123,433,'2021-01-10','Kosovo/Prishtine')
           Insert into [dbo].[InforamcioneFaturimi]([Faturimi_ID],[Data_Skadimit_Karteles],[PIN_Kredit_Kartela],[Numri_Kredit_Kartela],[Id_Kartes],[Data_Fatures],[Adresa_Faturimit]) values(10002,'2025-01-11',1955,852963741,456,'2021-01-10','Kosovo/Peje')
		   Insert into [dbo].[InforamcioneFaturimi]([Faturimi_ID],[Data_Skadimit_Karteles],[PIN_Kredit_Kartela],[Numri_Kredit_Kartela],[Id_Kartes],[Data_Fatures],[Adresa_Faturimit]) values(10003,'2021-06-11',0202,147258369,895,'2021-01-10','Kosovo/Prizeren')
		   Insert into [dbo].[InforamcioneFaturimi]([Faturimi_ID],[Data_Skadimit_Karteles],[PIN_Kredit_Kartela],[Numri_Kredit_Kartela],[Id_Kartes],[Data_Fatures],[Adresa_Faturimit]) values(10004,'2024-01-11',8585,18527949,200,'2021-01-10','Shqiperi/Durres')
		   Insert into [dbo].[InforamcioneFaturimi]([Faturimi_ID],[Data_Skadimit_Karteles],[PIN_Kredit_Kartela],[Numri_Kredit_Kartela],[Id_Kartes],[Data_Fatures],[Adresa_Faturimit]) values(10005,'2025-05-05',0002,753951486,988,'2021-01-10','Itali/Milan')
		   Insert into [dbo].[InforamcioneFaturimi]([Faturimi_ID],[Data_Skadimit_Karteles],[PIN_Kredit_Kartela],[Numri_Kredit_Kartela],[Id_Kartes],[Data_Fatures],[Adresa_Faturimit]) values(10006,'2024-01-11',5151,987321456,753,'2021-01-10','Spanje/Malaga')
		    Insert into [dbo].[InforamcioneFaturimi]([Faturimi_ID],[Data_Skadimit_Karteles],[PIN_Kredit_Kartela],[Numri_Kredit_Kartela],[Id_Kartes],[Data_Fatures],[Adresa_Faturimit]) values(10007,'2024-01-11',5481,19874569,547,'2021-01-10','Maqedoni/Shkup')
			 Insert into [dbo].[InforamcioneFaturimi]([Faturimi_ID],[Data_Skadimit_Karteles],[PIN_Kredit_Kartela],[Numri_Kredit_Kartela],[Id_Kartes],[Data_Fatures],[Adresa_Faturimit]) values(10008,'2024-01-11',6565,987456321,111,'2021-01-10','Norvegji/Oslo')
			  Insert into [dbo].[InforamcioneFaturimi]([Faturimi_ID],[Data_Skadimit_Karteles],[PIN_Kredit_Kartela],[Numri_Kredit_Kartela],[Id_Kartes],[Data_Fatures],[Adresa_Faturimit]) values(10009,'2024-01-11',8521,32569841,000,'2021-01-10','Montenegro/Plave')


			  --Inserttimi i te dhenave ne tabelen KAInforamcioneFaturimi

			   Insert into [dbo].[Ka_Info_Faturimi]([FaturimiID],[KonsumatoriID]) values(10000,6)
			    Insert into [dbo].[Ka_Info_Faturimi]([FaturimiID],[KonsumatoriID]) values(10001,1)
			    Insert into [dbo].[Ka_Info_Faturimi]([FaturimiID],[KonsumatoriID]) values(10002,6)
				 Insert into [dbo].[Ka_Info_Faturimi]([FaturimiID],[KonsumatoriID]) values(10003,8)
				  Insert into [dbo].[Ka_Info_Faturimi]([FaturimiID],[KonsumatoriID]) values(10004,2)
				   Insert into [dbo].[Ka_Info_Faturimi]([FaturimiID],[KonsumatoriID]) values(10005,5)
				    Insert into [dbo].[Ka_Info_Faturimi]([FaturimiID],[KonsumatoriID]) values(10006,4)
                Insert into [dbo].[Ka_Info_Faturimi]([FaturimiID],[KonsumatoriID]) values(10007,9)
				 Insert into [dbo].[Ka_Info_Faturimi]([FaturimiID],[KonsumatoriID]) values(10008,11)
				  Insert into [dbo].[Ka_Info_Faturimi]([FaturimiID],[KonsumatoriID]) values(10009,10)


				   --Inserttimi i te dhenave ne tabelen Financier

				   insert into [dbo].[Financieri]([Financieri_ID],[Emri],[Mbiemri],[Mosha],[Paga]) values(8522,'Ilir','Sopa',35,750)
				    insert into [dbo].[Financieri]([Financieri_ID],[Emri],[Mbiemri],[Mosha],[Paga]) values(8523,'Imer','Sopa',36,750)
					 insert into [dbo].[Financieri]([Financieri_ID],[Emri],[Mbiemri],[Mosha],[Paga]) values(8524,'Patrik','Mirdita',54,750)
					  insert into [dbo].[Financieri]([Financieri_ID],[Emri],[Mbiemri],[Mosha],[Paga]) values(8525,'Valon','Berisha',31,750)
					   insert into [dbo].[Financieri]([Financieri_ID],[Emri],[Mbiemri],[Mosha],[Paga]) values(8526,'Ilir','Krasniqi',45,750)
					    insert into [dbo].[Financieri]([Financieri_ID],[Emri],[Mbiemri],[Mosha],[Paga]) values(8527,'Egzon','Rama',25,750)
						 insert into [dbo].[Financieri]([Financieri_ID],[Emri],[Mbiemri],[Mosha],[Paga]) values(8528,'Hasan','Hasani',22,750)
						  insert into [dbo].[Financieri]([Financieri_ID],[Emri],[Mbiemri],[Mosha],[Paga]) values(8529,'Filan','Fisteku',44,750)
						   insert into [dbo].[Financieri]([Financieri_ID],[Emri],[Mbiemri],[Mosha],[Paga]) values(8510,'Agim','Hoxha',63,750)
						    insert into [dbo].[Financieri]([Financieri_ID],[Emri],[Mbiemri],[Mosha],[Paga]) values(8511,'Edi','Ujkani',28,750)
							

			
			--Insertimi i te dhenave ne tabelen Kontrollon
			insert into [dbo].[Kontrollon]([FaturimiID],[KonsumatoriID],[FinancieriID])values(10000,6,8522)
			insert into [dbo].[Kontrollon]([FaturimiID],[KonsumatoriID],[FinancieriID])values(10001,1,8522)
		    insert into [dbo].[Kontrollon]([FaturimiID],[KonsumatoriID],[FinancieriID])values(10002,6,8523)
			 insert into [dbo].[Kontrollon]([FaturimiID],[KonsumatoriID],[FinancieriID])values(10003,8,8524)
			  insert into [dbo].[Kontrollon]([FaturimiID],[KonsumatoriID],[FinancieriID])values(10004,2,8525)
			  insert into [dbo].[Kontrollon]([FaturimiID],[KonsumatoriID],[FinancieriID])values(10005,5,8526)
			   insert into [dbo].[Kontrollon]([FaturimiID],[KonsumatoriID],[FinancieriID])values(10006,4,8527)
		 insert into [dbo].[Kontrollon]([FaturimiID],[KonsumatoriID],[FinancieriID])values(10007,9,8528)
		 	 insert into [dbo].[Kontrollon]([FaturimiID],[KonsumatoriID],[FinancieriID])values(10008,11,8529)
			 	 insert into [dbo].[Kontrollon]([FaturimiID],[KonsumatoriID],[FinancieriID])values(10009,10,8510)
			
			
			--Insertimi i te dhenave ne tabelen Blerjet
			   Insert into [dbo].[Blerjet]([KonsumatoriID],[FaturimiID]) values(6,10000)
			    Insert into [dbo].[Blerjet]([KonsumatoriID],[FaturimiID]) values(1,10001)
			    Insert into [dbo].[Blerjet]([KonsumatoriID],[FaturimiID]) values(6,10002)
				 Insert into [dbo].[Blerjet]([KonsumatoriID],[FaturimiID]) values(8,10003)
				  Insert into [dbo].[Blerjet]([KonsumatoriID],[FaturimiID]) values(2,10004)
				   Insert into [dbo].[Blerjet]([KonsumatoriID],[FaturimiID]) values(5,10005)
				    Insert into [dbo].[Blerjet]([KonsumatoriID],[FaturimiID]) values(4,10006)
                Insert into [dbo].[Blerjet]([KonsumatoriID],[FaturimiID]) values(9,10007)
				 Insert into [dbo].[Blerjet]([KonsumatoriID],[FaturimiID]) values(11,10008)
				  Insert into [dbo].[Blerjet]([KonsumatoriID],[FaturimiID]) values(10,10009)

				  --Insertimi i te dhenave ne tabelen SHPORTA
				  insert into [dbo].[Shporta]([Shporta_ID],[Numri_Produkteve],[Cmimi])values(111,1,125.25)
				    insert into [dbo].[Shporta]([Shporta_ID],[Numri_Produkteve],[Cmimi])values(112,1,125.25)
					  insert into [dbo].[Shporta]([Shporta_ID],[Numri_Produkteve],[Cmimi])values(113,1,125.25)
					    insert into [dbo].[Shporta]([Shporta_ID],[Numri_Produkteve],[Cmimi])values(114,1,125.25)
                           insert into [dbo].[Shporta]([Shporta_ID],[Numri_Produkteve],[Cmimi])values(115,1,125.25)
						  insert into [dbo].[Shporta]([Shporta_ID],[Numri_Produkteve],[Cmimi])values(116,1,125.25)
						    insert into [dbo].[Shporta]([Shporta_ID],[Numri_Produkteve],[Cmimi])values(117,1,125.25)
							  insert into [dbo].[Shporta]([Shporta_ID],[Numri_Produkteve],[Cmimi])values(118,1,125.25)
							    insert into [dbo].[Shporta]([Shporta_ID],[Numri_Produkteve],[Cmimi])values(119,1,125.25)
								  insert into [dbo].[Shporta]([Shporta_ID],[Numri_Produkteve],[Cmimi])values(120,1,125.25)

								  --Insertimi i te dhenave ne tabelen KA NE SHPORT

								  insert into[dbo].[Ka_ne_Shport]([KonsumatoriID],[ProduktiID],[ShportaID]) values (1,1018,111)
								  insert into[dbo].[Ka_ne_Shport]([KonsumatoriID],[ProduktiID],[ShportaID]) values (2,1018,112)
								  insert into[dbo].[Ka_ne_Shport]([KonsumatoriID],[ProduktiID],[ShportaID]) values (4,1018,113)
								  insert into[dbo].[Ka_ne_Shport]([KonsumatoriID],[ProduktiID],[ShportaID]) values (5,1018,114)
								  insert into[dbo].[Ka_ne_Shport]([KonsumatoriID],[ProduktiID],[ShportaID]) values (6,1018,115)
								  insert into[dbo].[Ka_ne_Shport]([KonsumatoriID],[ProduktiID],[ShportaID]) values (7,1018,116)
								  insert into[dbo].[Ka_ne_Shport]([KonsumatoriID],[ProduktiID],[ShportaID]) values (8,1018,117)
								  insert into[dbo].[Ka_ne_Shport]([KonsumatoriID],[ProduktiID],[ShportaID]) values (9,1018,118)
								  insert into[dbo].[Ka_ne_Shport]([KonsumatoriID],[ProduktiID],[ShportaID]) values (10,1018,119)
								  insert into[dbo].[Ka_ne_Shport]([KonsumatoriID],[ProduktiID],[ShportaID]) values (11,1018,120)

		                         --Insertimi i te dhenave ne tabelen Porosia
								 insert into [dbo].[Porosia]([PorosiaID],[Data_Porosis],[Data_Dergeses],[Porosia_Permes],[FaturimiID],[TransportuesiID]) values(0000,'2020-12-28','2020-12-28','Online',10000,0)
								 insert into [dbo].[Porosia]([PorosiaID],[Data_Porosis],[Data_Dergeses],[Porosia_Permes],[FaturimiID],[TransportuesiID]) values(0001,'2020-12-28','2020-12-28','Online',10001,2)
								  insert into [dbo].[Porosia]([PorosiaID],[Data_Porosis],[Data_Dergeses],[Porosia_Permes],[FaturimiID],[TransportuesiID]) values(0002,'2020-12-28','2020-12-28','Online',10003,4)
								   insert into [dbo].[Porosia]([PorosiaID],[Data_Porosis],[Data_Dergeses],[Porosia_Permes],[FaturimiID],[TransportuesiID]) values(0003,'2020-12-28','2020-12-28','Online',10003,6)
								    insert into [dbo].[Porosia]([PorosiaID],[Data_Porosis],[Data_Dergeses],[Porosia_Permes],[FaturimiID],[TransportuesiID]) values(0004,'2020-12-28','2020-12-28','Online',10004,8)
									 insert into [dbo].[Porosia]([PorosiaID],[Data_Porosis],[Data_Dergeses],[Porosia_Permes],[FaturimiID],[TransportuesiID]) values(0005,'2020-12-28','2020-12-28','Online',10005,10)
									  insert into [dbo].[Porosia]([PorosiaID],[Data_Porosis],[Data_Dergeses],[Porosia_Permes],[FaturimiID],[TransportuesiID]) values(0006,'2020-12-28','2020-12-28','Online',10006,12)
									   insert into [dbo].[Porosia]([PorosiaID],[Data_Porosis],[Data_Dergeses],[Porosia_Permes],[FaturimiID],[TransportuesiID]) values(0007,'2020-12-28','2020-12-28','Online',10007,14)
									    insert into [dbo].[Porosia]([PorosiaID],[Data_Porosis],[Data_Dergeses],[Porosia_Permes],[FaturimiID],[TransportuesiID]) values(0008,'2020-12-28','2020-12-28','Online',10008,14)
										 insert into [dbo].[Porosia]([PorosiaID],[Data_Porosis],[Data_Dergeses],[Porosia_Permes],[FaturimiID],[TransportuesiID]) values(0009,'2020-12-28','2020-12-28','Online',10009,16)
										








								 --iNSERTIMI I TE DHENAVE NE TABELEN TREANSPORTUESI
								 insert into [dbo].[Transportues]([Transportuesi_ID],[Emri_Kompanis],[Telefoni]) values(0,'MIKMIK',044123123)
								 insert into [dbo].[Transportues]([Transportuesi_ID],[Emri_Kompanis],[Telefoni]) values(2,'GEP',044887788)
								  insert into [dbo].[Transportues]([Transportuesi_ID],[Emri_Kompanis],[Telefoni]) values(4,'FRONTAL',049666123)
								   insert into [dbo].[Transportues]([Transportuesi_ID],[Emri_Kompanis],[Telefoni]) values(6,'DHL',044521478)
								    insert into [dbo].[Transportues]([Transportuesi_ID],[Emri_Kompanis],[Telefoni]) values(8,'EDX',044789456)
									 insert into [dbo].[Transportues]([Transportuesi_ID],[Emri_Kompanis],[Telefoni]) values(10,'POSTA',044963852)
									  insert into [dbo].[Transportues]([Transportuesi_ID],[Emri_Kompanis],[Telefoni]) values(12,'XXX',044741852)
									   insert into [dbo].[Transportues]([Transportuesi_ID],[Emri_Kompanis],[Telefoni]) values(14,'AK',044258654)
									    insert into [dbo].[Transportues]([Transportuesi_ID],[Emri_Kompanis],[Telefoni]) values(16,'FFF',044321455)
										 insert into [dbo].[Transportues]([Transportuesi_ID],[Emri_Kompanis],[Telefoni]) values(18,'ASENTER',044130573)

										 --Insertimi i te dhenave ne tabelen detajet e porosis

						insert into [dbo].[Detajet_e_Porosis]([Porosia_ID],[ProduktiID],[Sasia],[Zbritja],[Cmimi])values(0000,1018,1,null,125.25)
						insert into [dbo].[Detajet_e_Porosis]([Porosia_ID],[ProduktiID],[Sasia],[Zbritja],[Cmimi])values(0001,1018,1,null,125.25)
						insert into [dbo].[Detajet_e_Porosis]([Porosia_ID],[ProduktiID],[Sasia],[Zbritja],[Cmimi])values(0002,1018,1,null,125.25)
						insert into [dbo].[Detajet_e_Porosis]([Porosia_ID],[ProduktiID],[Sasia],[Zbritja],[Cmimi])values(0003,1018,1,null,125.25)
						insert into [dbo].[Detajet_e_Porosis]([Porosia_ID],[ProduktiID],[Sasia],[Zbritja],[Cmimi])values(0004,1018,1,null,125.25)
						insert into [dbo].[Detajet_e_Porosis]([Porosia_ID],[ProduktiID],[Sasia],[Zbritja],[Cmimi])values(0005,1018,1,null,125.25)
						insert into [dbo].[Detajet_e_Porosis]([Porosia_ID],[ProduktiID],[Sasia],[Zbritja],[Cmimi])values(0006,1018,1,null,125.25)
						insert into [dbo].[Detajet_e_Porosis]([Porosia_ID],[ProduktiID],[Sasia],[Zbritja],[Cmimi])values(0007,1018,1,null,125.25)
						insert into [dbo].[Detajet_e_Porosis]([Porosia_ID],[ProduktiID],[Sasia],[Zbritja],[Cmimi])values(0008,1018,1,null,125.25)
						insert into [dbo].[Detajet_e_Porosis]([Porosia_ID],[ProduktiID],[Sasia],[Zbritja],[Cmimi])values(0009,1018,1,null,125.25)



						--Insertimi i te dhenave ne tabelen JEP
						insert into [dbo].[Jep](KonsumatoriID,[ShportaID],[Porosia_ID],[Vula_kohore])values(1,111,0000,'12:30')
					    insert into [dbo].[Jep](KonsumatoriID,[ShportaID],[Porosia_ID],[Vula_kohore])values(2,112,0001,'12:30')
						insert into [dbo].[Jep](KonsumatoriID,[ShportaID],[Porosia_ID],[Vula_kohore])values(4,113,0002,'20:14')
						insert into [dbo].[Jep](KonsumatoriID,[ShportaID],[Porosia_ID],[Vula_kohore])values(5,114,0003,'13:15')
						insert into [dbo].[Jep](KonsumatoriID,[ShportaID],[Porosia_ID],[Vula_kohore])values(6,115,0004,'11:17')
						insert into [dbo].[Jep](KonsumatoriID,[ShportaID],[Porosia_ID],[Vula_kohore])values(7,116,0005,'16:30')
						insert into [dbo].[Jep](KonsumatoriID,[ShportaID],[Porosia_ID],[Vula_kohore])values(8,117,0006,'18:39')
						insert into [dbo].[Jep](KonsumatoriID,[ShportaID],[Porosia_ID],[Vula_kohore])values(9,118,0007,'12:30')
					    insert into [dbo].[Jep](KonsumatoriID,[ShportaID],[Porosia_ID],[Vula_kohore])values(10,119,0008,'15:00')
						insert into [dbo].[Jep](KonsumatoriID,[ShportaID],[Porosia_ID],[Vula_kohore])values(11,120,0009,'05:14')


						--Përditësimin e 20 objekteve duke përdorur kushtet të caktuara. (UPDATE)
					UPDATE Konsumatori
                      SET [Emri_Kontaktues]= 'AKK'
                      WHERE Konsumatori_ID = 10;

					  UPDATE Jep
					  SET[Vula_kohore]='11:47'
					  WHERE KonsumatoriID=10;

					  ALTER TABLE Jep
                      ADD Data date;

					  UPDATE [Detajet_e_Porosis]
					  SET Cmimi=36.99
					  where [Porosia_ID]=0000;

					  UPDATE [Transportues]
					  set [Emri_Kompanis]='POSTA E SHPEJT'
					  WHERE [Transportuesi_ID]=18;


					  Alter table [Transportues]
					  ADD Xhirollogaria int 

					  Alter table Porosia
					  Alter column FaturimiID float

					  UPDATE [Detajet_e_Porosis]
					  SET Cmimi=30.00
					  where [Porosia_ID]=0001;
					 
					 UPDATE [Detajet_e_Porosis]
					  SET Cmimi=10.99
					  where [Porosia_ID]=0002;
			

			        Update Financieri
					set Paga=800

