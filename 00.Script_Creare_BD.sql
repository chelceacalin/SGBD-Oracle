DROP TABLE SEDIU CASCADE CONSTRAINTS;
DROP TABLE INSTRUCTORI CASCADE CONSTRAINTS;
DROP TABLE ELEVI CASCADE CONSTRAINTS;
DROP TABLE MASINI CASCADE CONSTRAINTS;
DROP TABLE EXAMEN CASCADE CONSTRAINTS;
DROP TABLE CHELTUIELICURENTE CASCADE CONSTRAINTS;
DROP TABLE CheltuieliAnuale CASCADE CONSTRAINTS;
DROP TABLE Categorie_Masini CASCADE CONSTRAINTS;
DROP TABLE Categorie_Examen CASCADE CONSTRAINTS;
DROP TABLE Tip_Examen CASCADE CONSTRAINTS;
 
 
CREATE TABLE SEDIU(
Id_Sediu Number(5) constraint ID_SEDIU PRIMARY KEY,
Denumire Varchar(30) NOT NULL,
Locatie Varchar(30) NOT NULL,
Nr_Instructori Number(2) NOT NULL,
Nr_Elevi Number(2) NOT NULL,
Nr_Masini Number(2) NOT NULL,
Nr_SalideCursPTTeorie Number(2) NOT NULL
);
 
CREATE TABLE INSTRUCTORI(
Id_Instructor Number(5) constraint ID_INSTRUCTOR Primary key,
Nume Varchar(20) NOT NULL ,
Prenume Varchar(20) NOT NULL,
Varsta Number(5) NOT NULL,
Ani_Experienta Number(5) NOT NULL ,
Categorie Varchar(5),
Sediu Number(5) NOT NULL,
Sal number(7,2) ,
NrTelefon Number(12) unique,
Cod_Supervizor Number(5) ,
constraint Sediu_FK foreign key(Sediu) references Sediu(Id_Sediu)
);
 
alter table INSTRUCTORI
  add constraint FK_INSTRUCTORI foreign key (Cod_Supervizor)
  references INSTRUCTORI (Id_Instructor);
 
CREATE TABLE ELEVI(
ID_Elev Number(2) constraint Nume_Elev_PK primary key,
Nume varchar(20) not null,
Prenume Varchar(20) NOT NULL,
Varsta number(2) constraint verificare_integritate check(varsta>=18),
Id_Sediu_Apartenenta Number(5),
Id_Instructor Number(2),
constraint ID_Sediu_Fk foreign key (Id_Sediu_Apartenenta) references Sediu(Id_Sediu) ,
constraint ID_INSTRUCTOR_FK foreign key (Id_Instructor) references Instructori(Id_Instructor)
);
 
CREATE TABLE Categorie_Masini(
Id_Categ NUMBER(3) constraint Categorie_Masini_Pk PRIMARY KEY,
Categorie Varchar(20) not null
);
 
CREATE TABLE MASINI(
Id_Masina number(4) constraint Masini_PK primary key,
Marca varchar2(20) not null,
COMBUSTIBIL varchar2(20),
ID_Categorie Number(3) not null,
--FOREIGN KEYS
Sediu number(5),
Instructor number(2) unique,
constraint Masini_Sediu_FK foreign key (Sediu) references Sediu (Id_Sediu),
constraint Masini_Instructor_FK foreign key (Instructor) references Instructori(Id_Instructor),
constraint Categorie_Fk foreign key (ID_Categorie) references Categorie_Masini  (Id_Categ)
);
 
CREATE TABLE Categorie_Examen(
ID_categorie Number(3) constraint categorie_Examen primary key,
Categorie Varchar(10)
);
 
CREATE TABLE Tip_Examen(
id_examen number (3) primary key,
denumire_examen varchar(10)
);
 
CREATE TABLE Examen(
ID_Examen Number(3) constraint ID_EXAMEN primary key ,
id_categorie Number(10) not null,
Data_examen DATE,
ID_Tip_Examen Number(3),
Rezultat Varchar(10),
ID_Elev Number(2),
constraint ID_ELEV_FK foreign key(ID_Elev)  references Elevi(ID_Elev),
constraint Categorie_Exam_Fk foreign key (id_categorie) references Categorie_Examen(ID_categorie),
constraint ID_Tip_Examen_FK foreign key (ID_Tip_Examen) references Tip_Examen (id_examen)
);
 
 
 
 
 
CREATE TABLE CheltuieliCurente(
id_cheltuiala number(2) constraint id_chelt_pk PRIMARY KEY,
Chelt_Salarii number(5),
id_sediu number(5),
constraint cheltuieli_sediu_fk foreign key (id_sediu) references SEDIU(Id_Sediu)
);
 
 
Create TABLE CheltuieliAnuale(
id_cheltuiala number(5) constraint id_cheltuiala_pk2 primary key,
Chelt_Intretinere number(6),
Chelt_Service_Masini number(10),
id_sediu number(5),
constraint cheltAnuale_Sediu_FK foreign key(id_sediu) references sediu(id_sediu)
);
 
 
insert into Sediu(id_sediu,denumire,locatie,nr_instructori,nr_elevi,nr_masini,nr_salidecursptteorie) values (1,'Cvorum Srl','Str.Vladimirescu Tudor','5','30','10','3');
insert into Sediu(id_sediu,denumire,locatie,nr_instructori,nr_elevi,nr_masini,nr_salidecursptteorie) values (2,'Gigalo Srl','Str. Radu Gioglovan','6','35','8','4');
insert into Sediu(id_sediu,denumire,locatie,nr_instructori,nr_elevi,nr_masini,nr_salidecursptteorie) values (3,'AlphaBet Srl','str. Alpin nr5','2','5','2','1');
insert into Sediu(id_sediu,denumire,locatie,nr_instructori,nr_elevi,nr_masini,nr_salidecursptteorie) values (4,'Transcaparti','Str. Closca NR2','10','50','15','5');
insert into Sediu(id_sediu,denumire,locatie,nr_instructori,nr_elevi,nr_masini,nr_salidecursptteorie) values (5,'ConduCuNoi','Str.Groazei','15','60','15','6');
insert into Sediu(id_sediu,denumire,locatie,nr_instructori,nr_elevi,nr_masini,nr_salidecursptteorie) values (6,'NaPermisul','Str. Al Ioan Cuza','5','20','5','2');
insert into Sediu(id_sediu,denumire,locatie,nr_instructori,nr_elevi,nr_masini,nr_salidecursptteorie) values (7,'PermisNOW','str. Crinului nr6','8','40','10','5');
insert into Sediu(id_sediu,denumire,locatie,nr_instructori,nr_elevi,nr_masini,nr_salidecursptteorie) values (8,'Radeon SRL','Str. Foamei nr 5','5','15','10','2');
insert into Sediu(id_sediu,denumire,locatie,nr_instructori,nr_elevi,nr_masini,nr_salidecursptteorie) values (9,'DriveUS','Str.Carpatilor','5','50','5','5');
insert into Sediu(id_sediu,denumire,locatie,nr_instructori,nr_elevi,nr_masini,nr_salidecursptteorie) values (10,'Carpatia Drive SRL','Str. Tudor Tudose','5','15','5','2');
 

insert into instructori(id_instructor,nume,prenume,varsta,ani_experienta,categorie,sediu,sal,NrTelefon,Cod_Supervizor) values (1,'Chelcea','Calin',20,2,'B',1,8500.25,0764765280,NULL);
insert into instructori(id_instructor,nume,prenume,varsta,ani_experienta,categorie,sediu,sal,NrTelefon,Cod_Supervizor) values (2,'Irina','Cazacu',25,4,'B,C',1,7500.23,0621456789,1);
insert into instructori(id_instructor,nume,prenume,varsta,ani_experienta,categorie,sediu,sal,NrTelefon,Cod_Supervizor) values (3,'Bianca','Alexandru',34,6,'B,C,D',2,5999.50,1234567892,1);
insert into instructori(id_instructor,nume,prenume,varsta,ani_experienta,categorie,sediu,sal,NrTelefon,Cod_Supervizor) values (4,'Malina','Albu',27,7,'A1A',4,5450,9875456784,2);
insert into instructori(id_instructor,nume,prenume,varsta,ani_experienta,categorie,sediu,sal,NrTelefon,Cod_Supervizor) values (5,'Bogdan','Gabriel',45,2,'B',4,4320,3679431567,2);
insert into instructori(id_instructor,nume,prenume,varsta,ani_experienta,categorie,sediu,sal,NrTelefon,Cod_Supervizor) values (6,'Andreea','Bak',34,12,'B',4,9200,1679753123,3);
insert into instructori(id_instructor,nume,prenume,varsta,ani_experienta,categorie,sediu,sal,NrTelefon,Cod_Supervizor) values (7,'Mircea','Badea',25,24,'A B',3,6543,2960485764,3);
insert into instructori(id_instructor,nume,prenume,varsta,ani_experienta,categorie,sediu,sal,NrTelefon,Cod_Supervizor) values (8,'Dorian','Popa',34,13,'B',7,5433,3568765789,3);
insert into instructori(id_instructor,nume,prenume,varsta,ani_experienta,categorie,sediu,sal,NrTelefon,Cod_Supervizor) values (9,'Barligea','Cosmin',35,11,'C',1,NULL,2568965443,1);
insert into instructori(id_instructor,nume,prenume,varsta,ani_experienta,categorie,sediu,sal,NrTelefon,Cod_Supervizor) values (10,'Danila','Daniel',23,2,'D',9,2365,2938495068,2);

 
 
insert into elevi (id_elev,nume,prenume,varsta, id_sediu_apartenenta,id_instructor) values (1,'Preda','Alex',19,1,1);
insert into elevi (id_elev,nume,prenume,varsta, id_sediu_apartenenta,id_instructor) values (2,'Cosma','Ana',25,2,4);
insert into elevi (id_elev,nume,prenume,varsta, id_sediu_apartenenta,id_instructor) values (3,'Anbu','Sai',21,3,3);
insert into elevi (id_elev,nume,prenume,varsta, id_sediu_apartenenta,id_instructor) values (4,'Uzumaki','Naruto',27,4,2);
insert into elevi (id_elev,nume,prenume,varsta, id_sediu_apartenenta,id_instructor) values (5,'Uchiha','Sarada',20,5,5);
insert into elevi (id_elev,nume,prenume,varsta, id_sediu_apartenenta,id_instructor) values (6,'Kimchi','Chocho',31,4,7);
insert into elevi (id_elev,nume,prenume,varsta, id_sediu_apartenenta,id_instructor) values (7,'Nara','Shikadai',19,1,1);
insert into elevi (id_elev,nume,prenume,varsta, id_sediu_apartenenta,id_instructor) values (8,'Kara','Jigen',31,2,2);
insert into elevi (id_elev,nume,prenume,varsta, id_sediu_apartenenta,id_instructor) values (9,'Popescu','Maria',32,1,3);
insert into elevi (id_elev,nume,prenume,varsta, id_sediu_apartenenta,id_instructor) values (10,'Mateescu','Ion',26,3,4);
 

insert into Categorie_Masini (id_categ,categorie) values (1,'A');
insert into Categorie_Masini (id_categ,categorie) values (2,'A1');
insert into Categorie_Masini (id_categ,categorie) values (3,'A2');
insert into Categorie_Masini (id_categ,categorie) values (4,'B1');
insert into Categorie_Masini (id_categ,categorie) values (5,'B');
insert into Categorie_Masini (id_categ,categorie) values (6,'C1');
insert into Categorie_Masini (id_categ,categorie) values (7,'C');
insert into Categorie_Masini (id_categ,categorie) values (8,'D1');
insert into Categorie_Masini (id_categ,categorie) values (9,'D');
insert into Categorie_Masini (id_categ,categorie) values (10,'BE');
 

insert into masini (id_masina,marca,combustibil,ID_CATEGORIE,sediu,instructor) values (1,'BMW','BENZINA',5,1,1);
insert into masini (id_masina,marca,combustibil,ID_CATEGORIE,sediu,instructor) values (2,'Audi','MOTORINA',5,2,2);
insert into masini (id_masina,marca,combustibil,ID_CATEGORIE,sediu,instructor) values (3,'Honda','BENZINA',1,2,3);
insert into masini (id_masina,marca,combustibil,ID_CATEGORIE,sediu,instructor) values (4,'Acura','MOTORINA',1,1,4);
insert into masini (id_masina,marca,combustibil,ID_CATEGORIE,sediu,instructor) values (5,'Nissan','BENZINA',5,5,5);
insert into masini (id_masina,marca,combustibil,ID_CATEGORIE,sediu,instructor) values (6,'Volksvagen','MOTORINA',5,4,6);
insert into masini (id_masina,marca,combustibil,ID_CATEGORIE,sediu,instructor) values (7,'Toyota','BENZINA',5,1,7);
insert into masini (id_masina,marca,combustibil,ID_CATEGORIE,sediu,instructor) values (8,'Dacia','MOTORINA',5,3,8);
insert into masini (id_masina,marca,combustibil,ID_CATEGORIE,sediu,instructor) values (9,'MercedesBus','BENZINA',9,2,9);
insert into masini (id_masina,marca,combustibil,ID_CATEGORIE,sediu,instructor) values (10,'Skania','BENZINA',7,1,10);
 
insert into Tip_Examen(ID_EXAMEN,DENUMIRE_EXAMEN) values (1,'SALA');
insert into Tip_Examen(ID_EXAMEN,DENUMIRE_EXAMEN) values (2,'ORAS');
 
insert into categorie_examen (ID_CATEGORIE,categorie) values (1,'A');
insert into categorie_examen (ID_CATEGORIE,categorie) values (2,'A1');
insert into categorie_examen (ID_CATEGORIE,categorie) values (3,'A2');
insert into categorie_examen (ID_CATEGORIE,categorie) values (4,'B1');
insert into categorie_examen (ID_CATEGORIE,categorie) values (5,'B');
insert into categorie_examen (ID_CATEGORIE,categorie) values (6,'C1');
insert into categorie_examen (ID_CATEGORIE,categorie) values (7,'C');
insert into categorie_examen (ID_CATEGORIE,categorie) values (8,'D1');
insert into categorie_examen (ID_CATEGORIE,categorie) values (9,'D');
insert into categorie_examen (ID_CATEGORIE,categorie) values (10,'BE');
 
 
insert into examen (id_examen,id_categorie,data_examen,ID_Tip_Examen,rezultat,id_elev) values (1,5,TO_DATE('13.12.2020','DD-MM-YYYY'),2,'A',1);
insert into examen (id_examen,id_categorie,data_examen,ID_Tip_Examen,rezultat,id_elev) values (2,7,TO_DATE('13.12.2021','DD-MM-YYYY'),1,'A',2);
insert into examen (id_examen,id_categorie,data_examen,ID_Tip_Examen,rezultat,id_elev) values (3,9,TO_DATE('13.12.2020','DD-MM-YYYY'),2,'R',3);
insert into examen (id_examen,id_categorie,data_examen,ID_Tip_Examen,rezultat,id_elev) values (4,5,TO_DATE('13.12.2019','DD-MM-YYYY'),2,'A',4);
insert into examen (id_examen,id_categorie,data_examen,ID_Tip_Examen,rezultat,id_elev) values (5,5,TO_DATE('13.12.2018','DD-MM-YYYY'),1,'R',5);
insert into examen (id_examen,id_categorie,data_examen,ID_Tip_Examen,rezultat,id_elev) values (6,7,TO_DATE('13.12.2019','DD-MM-YYYY'),2,'A',6);
insert into examen (id_examen,id_categorie,data_examen,ID_Tip_Examen,rezultat,id_elev) values (7,7,TO_DATE('13.12.2020','DD-MM-YYYY'),2,'R',7);
insert into examen (id_examen,id_categorie,data_examen,ID_Tip_Examen,rezultat,id_elev) values (8,1,TO_DATE('13.12.2021','DD-MM-YYYY'),1,'A',8);
insert into examen (id_examen,id_categorie,data_examen,ID_Tip_Examen,rezultat,id_elev) values (9,1,TO_DATE('13.12.2000','DD-MM-YYYY'),2,'R',9);
insert into examen (id_examen,id_categorie,data_examen,ID_Tip_Examen,rezultat,id_elev) values (10,5,TO_DATE('13.12.2011','DD-MM-YYYY'),2,'A',10);
 
 
insert into cheltuieliCurente (id_cheltuiala,chelt_salarii,id_sediu) values (1,10000,1);
insert into cheltuieliCurente (id_cheltuiala,chelt_salarii,id_sediu) values (2,50000,2);
insert into cheltuieliCurente (id_cheltuiala,chelt_salarii,id_sediu) values (3,30000,3);
insert into cheltuieliCurente (id_cheltuiala,chelt_salarii,id_sediu) values (4,20000,4);
insert into cheltuieliCurente (id_cheltuiala,chelt_salarii,id_sediu) values (5,10200,5);
insert into cheltuieliCurente (id_cheltuiala,chelt_salarii,id_sediu) values (6,10530,6);
insert into cheltuieliCurente (id_cheltuiala,chelt_salarii,id_sediu) values (7,60230,8);
insert into cheltuieliCurente (id_cheltuiala,chelt_salarii,id_sediu) values (8,24300,7);
insert into cheltuieliCurente (id_cheltuiala,chelt_salarii,id_sediu) values (9,62300,9);
insert into cheltuieliCurente (id_cheltuiala,chelt_salarii,id_sediu) values (10,30340,10);
