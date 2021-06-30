10. Crearea tabelelor în SQL ?i inserarea de date coerente în fiecare 
dintre acestea (minimum 5 înregistr?ri în fiecare tabel neasociativ;
minimum 10 înregistr?ri în tabelele asociative). 
13. Crearea unei secven?e ce va fi utilizat? în inserarea înregistr?rilor
în tabele (punctul 10).

CREATE TABLE CATEGORII
(cod_categorie number(5) constraint pkey_categorie primary key,
gen varchar2(25) constraint gen not null
);

CREATE TABLE SERII
(cod_serie number(5) constraint pkey_serie primary key,
nume varchar2(25)
);
ALTER TABLE serii
MODIFY(nume not null);


CREATE TABLE CARTI
(cod_carte number(5) constraint pkey_carte primary key,
denumire varchar2(100) constraint denumire_carte not null,
numar_pagini number(5),
pret number(3),
an_aparitie number(4),
numar_exemplare number(3),
numar_volum number(2) default null,
cod_serie number(5)constraint fkey_carte_serie references serii(cod_serie)
);

alter table carti
drop column numar_exemplare;

ALTER TABLE carti
MODIFY(pret number(5,2));

desc carti;

CREATE TABLE LIMBI
(cod_limba number(5) constraint pkey_limba primary key,
limba varchar2(25)
);

CREATE TABLE SCRIITORI
(cod_scriitor number(5) constraint pkey_scriitor primary key,
nume varchar2(25),
prenume varchar2(25),
nationalitate varchar2(12),
sex char(1),
data_nastere date default sysdate,
data_deces date default null
);

CREATE TABLE CLIENTI
(cod_client number(5) constraint pkey_client primary key,
nume varchar2(25)
);

CREATE TABLE ORASE
(cod_oras number(5)  constraint pkey_oras primary key,
denumire varchar2(25),
judet varchar2(25),
cod_postal char(6)
);
ALTER TABLE orase
MODIFY(denumire not null);


CREATE TABLE LOCATII
(cod_locatie number(5),
cod_oras number(5) constraint fk_locatie_oras references orase(cod_oras),
    constraint pk_compus primary key(cod_locatie, cod_oras),
strada varchar2(50),
numar number(4)
);
ALTER TABLE locatii
MODIFY(strada not null);


CREATE TABLE LIBRARII
(cod_librarie number(5) constraint pk_librarie primary key,
data_infiintare date default sysdate,
denumire varchar2(25),
cod_locatie number(5),
cod_oras number(5),
constraint fk_compus foreign key(cod_locatie, cod_oras) references locatii(cod_locatie, cod_oras) 
);
ALTER TABLE librarii
MODIFY(denumire not null);

CREATE TABLE ANGAJATI
(cod_angajat number(5) constraint pkey_angajat primary key,
nume varchar2(25),
prenume varchar2(25),
salariu number(4),
telefon char(10),
sex char(1),
tip_angajat varchar2(25) not null,
cod_librarie number(5) constraint fkey_ang_librarie references librarii(cod_librarie)
);
ALTER TABLE angajati
MODIFY(nume not null);


CREATE TABLE CUMPARARI
(cod_cumparare number(5) constraint pk_cump primary key,
data_cump date default sysdate,
cod_carte number(5) constraint fk_cump_carte references carti(cod_carte),
cod_angajat number(5) constraint fk_cump_ang references angajati(cod_angajat),
cod_client number(5) constraint fk_cump_client references clienti(cod_client)
);


CREATE TABLE ARE
(cod_scriitor number(5), 
cod_carte number(5),
cod_categorie number(5),
constraint fk_are_scriitor foreign key(cod_scriitor) references scriitori(cod_scriitor),
constraint fk_are_carte foreign key(cod_carte) references carti(cod_carte),
constraint fk_are_categorie foreign key(cod_categorie) references categorii(cod_categorie),
constraint pk_compus_are primary key(cod_scriitor, cod_carte, cod_categorie)
);


CREATE TABLE TRADUSE
(cod_carte number(5) constraint fk_trad_carte references carti(cod_carte),
cod_limba number(5) constraint fk_trad_limba references limbi(cod_limba),
constraint pk_compus_trad primary key(cod_carte, cod_limba)
);


CREATE SEQUENCE SEQ_S
INCREMENT by 1
START WITH 100
MAXVALUE 10000
NOCYCLE;

--SCRIITORI
insert into  scriitori
values (SEQ_S.NEXTVAL, 'Ban', 'Adrian', 'Romana', 'm', sysdate, null);  --nu se stie data de nastere

insert into  scriitori
values (SEQ_S.NEXTVAL, 'Ban', 'Ema', 'Romana', 'f', sysdate, null);

insert into  scriitori
values (SEQ_S.NEXTVAL, 'Arp', 'David', 'Romana', 'm', to_date('26-05-1940','dd-mm-yyyy'), null);

insert into  scriitori
values (SEQ_S.NEXTVAL, 'Arp', 'Claudia', 'Romana', 'f', to_date('26-07-1942','dd-mm-yyyy'), null);

insert into  scriitori
values (SEQ_S.NEXTVAL, 'Oke', 'Janette', 'Canadiana', 'f', to_date('18-02-1935','dd-mm-yyyy'), null);

insert into  scriitori
values (SEQ_S.NEXTVAL, 'Dickens', 'Charles', 'Britanica', 'm', to_date('07-02-1812','dd-mm-yyyy'), to_date('09-06-1870','dd-mm-yyyy'));

insert into  scriitori
values (SEQ_S.NEXTVAL, 'Witemeyer', 'Karen', 'Americana', 'f', sysdate, null);

insert into  scriitori
values (SEQ_S.NEXTVAL, 'Drumes', 'Mihail', 'Romana', 'm', to_date('26-11-1901','dd-mm-yyyy'), to_date('07-02-1982','dd-mm-yyyy'));

insert into  scriitori
values (SEQ_S.NEXTVAL, 'Bunn', 'T. Davis', 'Americana', 'm',to_date('01-01-1952','dd-mm-yyyy'), null);

insert into  scriitori
values (SEQ_S.NEXTVAL, 'Rowling', 'J.K.', 'Britanica', 'f',to_date('31-07-1965','dd-mm-yyyy'), null);

insert into  scriitori
values (SEQ_S.NEXTVAL, 'Dumas', 'Alexandre', 'Franceza', 'm',to_date('24-07-1802','dd-mm-yyyy'), to_date('05-12-1870','dd-mm-yyyy'));
commit;
select* from scriitori;

--carti

CREATE SEQUENCE SEQ_CARTI
INCREMENT by 1
START WITH 1000
MAXVALUE 100000
NOCYCLE;

insert into carti
values(SEQ_CARTI.NEXTVAL, 'Invitatia la vals',336, 30.60, 1936, null, null); 

insert into carti
values(SEQ_CARTI.NEXTVAL, 'Vreau sa ma casatoresc',210, 30, 2010, null, null); 

insert into carti
values(SEQ_CARTI.NEXTVAL, 'Scrisoare de dragoste',432, 29, 1938, null, null); 

insert into carti
values(SEQ_CARTI.NEXTVAL, 'Mostenirea', 294 , 27, 2001, 3, 310);  --Cantecul Acadiei -oke si bunn
insert into carti
values(SEQ_CARTI.NEXTVAL, 'Binecuvantatul tarm',286, 28.5 , 1936, 5, 310); 
insert into carti
values(SEQ_CARTI.NEXTVAL, 'Locul de intalnire',318, 27, 1999, 1, 310); 
insert into carti
values(SEQ_CARTI.NEXTVAL, 'Limanul mult dorit',324, 27, 2000, 2 , 310); 
insert into carti
values(SEQ_CARTI.NEXTVAL, 'Un far calauzitor',256, 27, 2002, 4, 310); 

update carti
set an_aparitie = 2000, numar_volum = 2
where cod_carte = 1068;

update carti
set an_aparitie = 2002, numar_volum = 5
where cod_carte = 1070;

insert into carti
values(SEQ_CARTI.NEXTVAL, 'A fost odata intr-o vara',224, 21.85, 1981, 1, 300); 
insert into carti
values(SEQ_CARTI.NEXTVAL, 'Promisiunea unei noi primaveri',222, 21.85, 1989, 4, 300); 
insert into carti
values(SEQ_CARTI.NEXTVAL, 'Vanturi tomnatice',220, 21.85, 1987, 2, 300); 
insert into carti
values(SEQ_CARTI.NEXTVAL, 'Iarna nu tine o vesnicie',216, 21.85, 1988, 3, 300); 


insert into carti
values(SEQ_CARTI.NEXTVAL, 'Cu capul in nori',315, 31, 2010, null, null); 

insert into carti
values(SEQ_CARTI.NEXTVAL, 'Mireasa pe masura',295, 28.50, 2010, null, null); 

insert into carti
values(SEQ_CARTI.NEXTVAL, 'Sa-i castige inima',321, 28, 2011, null, null); 

insert into carti
values(SEQ_CARTI.NEXTVAL, 'Sotia Centurionului',321, 35, 2010, 1, 320); 
insert into carti
values(SEQ_CARTI.NEXTVAL, 'Flacara ascunsa',388, 35, 2011, 2, 320); 
insert into carti
values(SEQ_CARTI.NEXTVAL, 'Drumul spre Damasc',432, 35, 2011, 3, 320); 

insert into carti
values(SEQ_CARTI.NEXTVAL, 'Harry Potter si camera secretelor',400, 48.48, 1998, 2, 330); 
insert into carti
values(SEQ_CARTI.NEXTVAL, 'Harry Potter si pocalul de foc',728, 58, 2000, 4, 330);
insert into carti
values(SEQ_CARTI.NEXTVAL, 'Harry Potter si printul semisange', 650, 64.64, 2005, 6, 330);
insert into carti
values(SEQ_CARTI.NEXTVAL, 'Harry Potter si talismanele mortii',784, 64.64, 2007, 7, 330);
insert into carti
values(SEQ_CARTI.NEXTVAL, 'Harry Potter si ordinul phoenix',990, 64.64, 2003, 5, 330);
insert into carti
values(SEQ_CARTI.NEXTVAL, 'Harry Potter si piatra filosofala',532, 42, 1997, 1, 330);
insert into carti
values(SEQ_CARTI.NEXTVAL, 'Harry Potter si prizonierul din Azkaban',464, 48.48, 1999, 3, 330);


insert into carti
values(SEQ_CARTI.NEXTVAL, 'Cei trei muschetari',224, 21, 1844, 1, 340);
insert into carti
values(SEQ_CARTI.NEXTVAL, 'Dupa 20 de ani',622, 33, 1845, 2, 340);

insert into carti
values(SEQ_CARTI.NEXTVAL, 'Marile sperante',544, 30, 1861, null, null);

select* from carti;

--serii
CREATE SEQUENCE SEQ_SERII
INCREMENT by 10
START WITH 300
MAXVALUE 10000
NOCYCLE;

insert into serii
values(SEQ_SERII.NEXTVAL,'Anotimpurile inimii');
insert into serii
values(SEQ_SERII.NEXTVAL,'Cantecul Acadiei');
insert into serii
values(SEQ_SERII.NEXTVAL,'Faptele credintei');
insert into serii
values(SEQ_SERII.NEXTVAL, 'Harry Potter');
insert into serii
values(SEQ_SERII.NEXTVAL, 'Cei trei muschetari');
commit;
select* from serii;

--categorii
CREATE SEQUENCE SEQ_CATEG
INCREMENT by 1
START WITH 10
MAXVALUE 10000
NOCYCLE;

insert into categorii values(SEQ_CATEG.NEXTVAL,'romantic');
insert into categorii values(SEQ_CATEG.NEXTVAL,'fictiune');
insert into categorii values(SEQ_CATEG.NEXTVAL,'istoric');
insert into categorii values(SEQ_CATEG.NEXTVAL,'de familie');
insert into categorii values(SEQ_CATEG.NEXTVAL,'crestin');
insert into categorii values(SEQ_CATEG.NEXTVAL,'geografie');
insert into categorii values(SEQ_CATEG.NEXTVAL,'dezvoltare personala');
insert into categorii values(SEQ_CATEG.NEXTVAL,'psihologic');
insert into categorii values(SEQ_CATEG.NEXTVAL,'fantastic');
insert into categorii values(SEQ_CATEG.NEXTVAL,'drama');
insert into categorii values(SEQ_CATEG.NEXTVAL,'mister');
insert into categorii values(SEQ_CATEG.NEXTVAL,'aventura');
insert into categorii values(SEQ_CATEG.NEXTVAL,'bildungsroman');
commit;


insert into are values(100,1091,16);  --vreau sa ma casatoresc - cod 1091 
insert into are values(101,1091, 16);  ---scriitori cod 100, 101, 102, 103  
insert into are values(102,1091, 16);  ---categorie dezv personala-16
insert into are values(103,1091, 16);


insert into are values(104,1067,14); --Janette Oke 104 si Bunn - 108  --seria cantecul Acadiei
insert into are values(104,1068,14);  ---carti 1067, 1068, 1069, 1070, 1071
insert into are values(104,1069,14);  --gen :romantic-10, fictiune-11, crestin-14
insert into are values(104,1070,14);
insert into are values(104,1071,14);
insert into are values(104,1067,11); --Janette Oke  --seria cantecul Acadiei
insert into are values(104,1068,11);
insert into are values(104,1069,11);
insert into are values(104,1070,11);
insert into are values(104,1071,11);
insert into are values(104,1067,10); --Janette Oke  --seria cantecul Acadiei
insert into are values(104,1068,10);
insert into are values(104,1069,10);
insert into are values(104,1070,10);
insert into are values(104,1071,10);

insert into are values(108,1067,14); -- Davis Bunn  --seria cantecul Acadiei
insert into are values(108,1068,14);
insert into are values(108,1069,14);
insert into are values(108,1070,14);
insert into are values(108,1071,14);
insert into are values(108,1067,11); --Davis Bunn  --seria cantecul Acadiei
insert into are values(108,1068,11);
insert into are values(108,1069,11);
insert into are values(108,1070,11);
insert into are values(108,1071,11);
insert into are values(108,1067,10); --Davis Bunn  --seria cantecul Acadiei
insert into are values(108,1068,10);
insert into are values(108,1069,10);
insert into are values(108,1070,10);
insert into are values(108,1071,10);


insert into are values(104,1072,11);     --anotimpurile inimii(1072,1073,1074,1075) -fictiune-11
insert into are values(104,1073,11);
insert into are values(104,1074,11);
insert into are values(104,1075,11); 
insert into are values(104,1072,10);     --anotimpurile inimii -romantic-10
insert into are values(104,1073,10);
insert into are values(104,1074,10);
insert into are values(104,1075,10);
insert into are values(104,1072,14);     --anotimpurile inimii-crestin-14
insert into are values(104,1073,14);
insert into are values(104,1074,14);
insert into are values(104,1075,14);


insert into are values(106,1076,10);    --106 -karen Witemeyer   --romantic 10
insert into are values(106,1077,10);     --romane 1076,1077,1078
insert into are values(106,1078,10);

insert into are values(106,1076,11);    --106 -karen Witemeyer --fictiune  11
insert into are values(106,1077,11);
insert into are values(106,1078,11);

insert into are values(106,1076,14);    --106 -karen Witemeyer --crestin 14
insert into are values(106,1077,14);
insert into are values(106,1078,14);


insert into are values(104, 1079,11);   --Oke(104) si Bun(108)--seria Faptele credintei(302) --istoric-12, fictiune--11, crestin-14
insert into are values(104, 1080,11);         --1079,1080,1081
insert into are values(104, 1081,11);
insert into are values(104, 1079,12);   --Oke(104) si Bun(108)--seria Faptele credintei(302) --istoric-12, fictiune--11, crestin-14
insert into are values(104, 1080,12);
insert into are values(104, 1081,12);
insert into are values(104, 1079,14);   --Oke(104) si Bun(108)--seria Faptele credintei(302) --istoric-12, fictiune--11, crestin-14
insert into are values(104, 1080,14);
insert into are values(104, 1081,14);
insert into are values(108, 1079,11);   --Oke(104) si Bun(108)--seria Faptele credintei(302) --istoric-12, fictiune--11, crestin-14
insert into are values(108, 1080,11);
insert into are values(108, 1081,11);
insert into are values(108, 1079,12);   --Oke(104) si Bun(108)--seria Faptele credintei(302) --istoric-12, fictiune--11, crestin-14
insert into are values(108, 1080,12);
insert into are values(108, 1081,12);
insert into are values(108, 1079,14);   --Oke(104) si Bun(108)--seria Faptele credintei(302) --istoric-12, fictiune--11, crestin-14
insert into are values(108, 1080,14);
insert into are values(108, 1081,14);
commit;

select * from carti;

  --drumes-107 - carti invitatie la vals 1065 - 10 -11- 17, scrisoare de dragoste -1066- categorii- 10 -11
insert into are values(107,1065,10);   
insert into are values(107,1065,11);
insert into are values(107,1065,17);
insert into are values(107,1066,10);
insert into are values(107,1066,11);

--Harry potter - 1082-....-1088  --autoare-109- fictiune 11,  fantastic 18, drama 19, mister 20
insert into are values(109,1082,11);
insert into are values(109,1083,11);
insert into are values(109,1084,11);
insert into are values(109,1085,11);
insert into are values(109,1086,11);
insert into are values(109,1087,11);
insert into are values(109,1088,11);

insert into are values(109,1082,18);
insert into are values(109,1083,18);
insert into are values(109,1084,18);
insert into are values(109,1085,18);
insert into are values(109,1086,18);
insert into are values(109,1087,18);
insert into are values(109,1088,18);

insert into are values(109,1082,19);
insert into are values(109,1083,19);
insert into are values(109,1084,19);
insert into are values(109,1085,19);
insert into are values(109,1086,19);
insert into are values(109,1087,19);
insert into are values(109,1088,19);

insert into are values(109,1082,20);
insert into are values(109,1083,20);
insert into are values(109,1084,20);
insert into are values(109,1085,20);
insert into are values(109,1086,20);
insert into are values(109,1087,20);
insert into are values(109,1088,20);

-- dumas -110   - carti 1089, 1090- categ (12, 21)  (12,11)
insert into are values(110, 1089, 12);
insert into are values(110, 1089, 21);
insert into are values(110, 1090, 12);
insert into are values(110, 1090, 11);

--dickens - marile sperante
insert into are values(105, 1092, 22);

---------------------------------------------------------
CREATE SEQUENCE SEQ_LB
INCREMENT by 10
START WITH 10
MAXVALUE 10000
NOCYCLE;

insert into limbi values (SEQ_LB.NEXTVAL,'romana');  --20
insert into limbi values (SEQ_LB.NEXTVAL,'engleza');  --30
insert into limbi values (SEQ_LB.NEXTVAL,'franceza');  --40
insert into limbi values (SEQ_LB.NEXTVAL,'germana');  --50
insert into limbi values (SEQ_LB.NEXTVAL,'rusa');  --60

select*from carti;
select* from limbi;
insert into traduse values(1065, 20);
insert into traduse values(1066,20);
insert into traduse values(1067,20);
insert into traduse values(1068,20);
insert into traduse values(1069,20);
insert into traduse values(1070,20);
insert into traduse values(1071,20);

insert into traduse values(1067,30);
insert into traduse values(1068,30);
insert into traduse values(1069,30);
insert into traduse values(1070,30);
insert into traduse values(1071,30);

insert into traduse values(1072,20);
insert into traduse values(1073,20);
insert into traduse values(1074,20);
insert into traduse values(1075,20);

insert into traduse values(1076,20);
insert into traduse values(1077,20);
insert into traduse values(1078,20);

insert into traduse values(1079,20);
insert into traduse values(1080,20);
insert into traduse values(1081,20);

insert into traduse values(1082,20);
insert into traduse values(1083,20);
insert into traduse values(1084,20);
insert into traduse values(1085,20);
insert into traduse values(1086,20);
insert into traduse values(1087,20);
insert into traduse values(1088,20);

insert into traduse values(1082,30);
insert into traduse values(1083,30);
insert into traduse values(1084,30);
insert into traduse values(1085,30);
insert into traduse values(1086,30);
insert into traduse values(1087,30);
insert into traduse values(1088,30);

insert into traduse values(1082,40);
insert into traduse values(1083,40);
insert into traduse values(1084,40);
insert into traduse values(1085,40);
insert into traduse values(1086,40);
insert into traduse values(1087,40);
insert into traduse values(1088,40);

insert into traduse values(1089,20);
insert into traduse values(1090,20);

insert into traduse values(1089,40);
insert into traduse values(1090,40);

insert into traduse values(1091,20);

--orase
CREATE SEQUENCE SEQ_OR
INCREMENT by 10
START WITH 2000
MAXVALUE 10000
NOCYCLE;
insert into orase values(SEQ_OR.NEXTVAL, 'Bucuresti', null, '012581');
insert into orase values(SEQ_OR.NEXTVAL, 'Oradea', 'Bihor', '410001');
insert into orase values(SEQ_OR.NEXTVAL, 'Cluj-Napoca', 'Cluj', '010292');
insert into orase values(SEQ_OR.NEXTVAL, 'Voluntari', 'Ilfov', '077191');
insert into orase values(SEQ_OR.NEXTVAL, 'Iasi', 'Iasi', '700028');
insert into orase values(SEQ_OR.NEXTVAL, 'Drobeta Turnul Severin', 'Mehedinti', '220036');

select*from orase;

--locatii
CREATE SEQUENCE SEQ_LOC
INCREMENT by 10
START WITH 90
MAXVALUE 1000
NOCYCLE;
insert into locatii values(SEQ_LOC.NEXTVAL, 2010, 'Strada Doamnei', 20);
insert into locatii values(SEQ_LOC.NEXTVAL, 2030, 'Strada Fierului', 2);
insert into locatii values(SEQ_LOC.NEXTVAL, 2030, 'Strada Republicii', 35);
insert into locatii values(SEQ_LOC.NEXTVAL, 2020, 'Strada Avram Iancu', 10);
insert into locatii values(SEQ_LOC.NEXTVAL, 2050, 'Strada Vasile Lupu', 148);
insert into locatii values(SEQ_LOC.NEXTVAL, 2060, 'Strada Gheorghe Sincai', 17);
insert into locatii values(SEQ_LOC.NEXTVAL, 2010, 'Strada Baltaretului', 7);

select* from locatii;

--librarie
CREATE SEQUENCE SEQ_LIBR
INCREMENT by 10
START WITH 40
MAXVALUE 1000
NOCYCLE;

desc librarii;
insert into librarii values(SEQ_LIBR.NEXTVAL,to_date('10-10-2015','dd-mm-yyyy'), 'Libraria Iulius',100,2010);
insert into librarii values(SEQ_LIBR.NEXTVAL,to_date('06-11-2020','dd-mm-yyyy'), 'Libraria Iulius',110,2030);
insert into librarii values(SEQ_LIBR.NEXTVAL,to_date('04-06-2017','dd-mm-yyyy'), 'Libraria Iulius',140,2050);
insert into librarii values(SEQ_LIBR.NEXTVAL,to_date('10-08-2010','dd-mm-yyyy'), 'Libraria Iulius',130,2020);
insert into librarii values(SEQ_LIBR.NEXTVAL,to_date('16-05-2008','dd-mm-yyyy'), 'Libraria Iulius',120,2030);

select* from librarii;

--angajati
CREATE SEQUENCE SEQ_ANG
INCREMENT by 1
START WITH 400
MAXVALUE 10000
NOCYCLE;

desc angajati;
insert into angajati values(SEQ_ANG.NEXTVAL, 'Popescu', 'Maria', 1275, '0761234567','f','vanzator',50);
insert into angajati values(SEQ_ANG.NEXTVAL, 'Popa', 'Marin', 2450, '0761236666','m','vanzator',70);
insert into angajati values(SEQ_ANG.NEXTVAL, 'Ionescu', 'Adiel', 2725, '0769999967','m','vanzator',90);
insert into angajati values(SEQ_ANG.NEXTVAL, 'Marinescu', 'Claudiu', 1600, '0761234000','m','vanzator',100);
insert into angajati values(SEQ_ANG.NEXTVAL, 'Ionescu', 'Mircea', 1550, '0731114567','m','ingrijitor',100);
insert into angajati values(SEQ_ANG.NEXTVAL, 'Georgescu', 'Aurica', 1500, '0724444413','f','ingrijitor',90);
insert into angajati values(SEQ_ANG.NEXTVAL, 'Popa', 'Marinela', 1450, '0760004567','f','ingrijitor',70);
insert into angajati values(SEQ_ANG.NEXTVAL, 'Noiescu', 'Amalia', 1970, '0761233357','f','ingrijitor',50);


insert into angajati values(SEQ_ANG.NEXTVAL, 'Iona', 'Adrian', 1300, '0733333387','m','vanzator',50);
insert into angajati values(SEQ_ANG.NEXTVAL, 'Popovici', 'Adina', 1750, '0727677606','f','vanzator',60);
insert into angajati values(SEQ_ANG.NEXTVAL, 'Mihaita', 'Claudia', 1000, '0729090909','f','vanzator',60);
insert into angajati values(SEQ_ANG.NEXTVAL, 'Vasilescu', 'Lenuta', 1600, '0761114597','f','ingrijitor',60);

commit;
select* from angajati;

--inserare in clienti
CREATE SEQUENCE SEQ_CL
INCREMENT by 10
START WITH 90
MAXVALUE 10000
NOCYCLE;

insert into clienti values(SEQ_CL.NEXTVAL, 'Anton');
insert into clienti values(SEQ_CL.NEXTVAL, 'Aurel');
insert into clienti values(SEQ_CL.NEXTVAL, 'Andronescu');
insert into clienti values(SEQ_CL.NEXTVAL, 'Bunescu');
insert into clienti values(SEQ_CL.NEXTVAL, 'Cornilescu');
insert into clienti values(SEQ_CL.NEXTVAL, 'Corvin');
insert into clienti values(SEQ_CL.NEXTVAL, 'Dumitrache');
insert into clienti values(SEQ_CL.NEXTVAL, 'Titulescu');
insert into clienti values(SEQ_CL.NEXTVAL, 'Carol');
insert into clienti values(SEQ_CL.NEXTVAL, 'Marinescu');  
insert into clienti values(SEQ_CL.NEXTVAL, 'Dumitru');
insert into clienti values(SEQ_CL.NEXTVAL, 'Laurentiu');
insert into clienti values(SEQ_CL.NEXTVAL, 'Preda');
insert into clienti values(SEQ_CL.NEXTVAL, 'Dinu');
insert into clienti values(SEQ_CL.NEXTVAL, 'Gheorghe');
commit;

desc cumparari;
select*from carti;
select*from angajati;
select*from clienti;
---inserare in cumparare
CREATE SEQUENCE SEQ_CUMP
INCREMENT by 1
START WITH 99
MAXVALUE 1000
NOCYCLE;
                                                                                            ---carte-angajat-client
insert into cumparari values(SEQ_CUMP.NEXTVAL ,to_date('20-04-2021 11:30', 'dd-mm-yyyy hh24:mi'),1065,401,100);
insert into cumparari values(SEQ_CUMP.NEXTVAL ,to_date('20-07-2020 21:17', 'dd-mm-yyyy hh24:mi'),1081,409,160);
insert into cumparari values(SEQ_CUMP.NEXTVAL ,to_date('20-07-2020 21:17', 'dd-mm-yyyy hh24:mi'),1080,409,160);
insert into cumparari values(SEQ_CUMP.NEXTVAL ,to_date('20-07-2020 21:17', 'dd-mm-yyyy hh24:mi'),1079,409,160);
insert into cumparari values(SEQ_CUMP.NEXTVAL ,to_date('04-10-2019 13:55', 'dd-mm-yyyy hh24:mi'),1066,402,170);
insert into cumparari values(SEQ_CUMP.NEXTVAL ,to_date('25-03-2021 11:30', 'dd-mm-yyyy hh24:mi'),1067,410,180);
insert into cumparari values(SEQ_CUMP.NEXTVAL ,to_date('25-03-2021 17:00', 'dd-mm-yyyy hh24:mi'),1068,411,180);

insert into cumparari values(SEQ_CUMP.NEXTVAL ,to_date('26-02-2021 10:00', 'dd-mm-yyyy hh24:mi'),1068,411,180);

insert into cumparari values(SEQ_CUMP.NEXTVAL ,to_date('13-10-2020 16:44', 'dd-mm-yyyy hh24:mi'),1067,410,120);
insert into cumparari values(SEQ_CUMP.NEXTVAL ,to_date('29-08-2018 14:02', 'dd-mm-yyyy hh24:mi'),1068,403,100);
insert into cumparari values(SEQ_CUMP.NEXTVAL ,to_date('15-09-2019 15:17', 'dd-mm-yyyy hh24:mi'),1070,411,190);
commit;
select * from cumparari;

/*11. Formula?i în limbaj natural ?i implementa?i 5 cereri SQL complexe ce vor utiliza, în
ansamblul lor, urm?toarele elemente:
a. opera?ie join pe cel pu?in 4 tabele
b. filtrare la nivel de linii
c. subcereri nesincronizate în care intervin cel pu?in 3 tabele
d. utilizarea a cel pu?in 2 func?ii pe ?iruri de caractere, 2 func?ii pe date
calendaristice, a func?iilor NVL ?i DECODE, a cel pu?in unei expresii CASE
--DECODE (‘b’, ‘a’, ‘b’, ‘c’) =‘c’
--DECODE (‘c’, ‘a’, ‘b’, ‘c’) = ‘c’ ---echivalent cu case
e. ordon?ri 
*/

/*
desc scriitori;
desc carti;
desc categorii;
select * from carti;
-----------------------------------------------------------------------------------------------
1.Sa se mentioneze scriitorii, seriile si volumele care le compun 
ale scriitorilor contemporani ce au scris serii de tipul romantic. 
-- cerere facuta pentru a exemplifica operatie join pe 5 tabele
-- filtrare la nivel de linii
-- lower() =>functie pe siruri de caractere
*/
select  sc.nume "Scriitor", s.nume "Serie", c.denumire "Volum" 
from scriitori sc join are a on(sc.cod_scriitor=a.cod_scriitor) 
        join categorii categ on(categ.cod_categorie=a.cod_categorie)
        join carti c on (c.cod_carte=a.cod_carte)
        join serii s on (s.cod_serie=c.cod_serie)
where data_deces is null and lower(categ.gen) = 'romantic' ;
        --in baza de date sunt inserate mai multe serii si carti scrise de diversi scriitori
        --seria Harry Potter este eliminata pentru ca nu este de tip romantic
        --cartile scriitoarei Karen Witemeyer, chiar daca respecta categoria, sunt 
              --eliminate pentru ca nu compun/apartin de vreo serie
        --Seria lui Alexandre Dumas este eliminata pentru ca acesta nu este contemporan
              --(inca viu) si, in adaos, nu respecta categoria ceruta.
  
/*              
select * from angajati;
select * from librarii;
select * from locatii;
select * from orase;

2. In ce judet lucreaza vanzatoarea Popescu Maria? Daca judetul nu exista(cazul Bucurestiului), se trece orasul din care face parte.
Dar Ionescu Mircea?
--cerere creata pentru a exemplifica CASE-ul
--initcap - functie pe siruri de caractere
--filtrare la nivel de linii
--3 joinuri
*/
select a.nume, a.prenume,
        case
            when o.judet is not null then o.judet
            else  o.denumire 
        end "Aici lucreaza"
from angajati a  join librarii lib on (a.cod_librarie=lib.cod_librarie) 
        join locatii loc on(lib.cod_locatie = loc.cod_locatie) 
        join orase o on(loc.cod_oras=o.cod_oras)
where initcap(a.nume) = 'Popescu' and initcap(a.prenume) = 'Maria';  

---Iar pentru Ionescu Mircea
select a.nume, a.prenume,
        case
            when o.judet is not null then o.judet
            else  o.denumire 
        end "Aici lucreaza"
from angajati a  join librarii lib on (a.cod_librarie=lib.cod_librarie) 
        join locatii loc on(lib.cod_locatie = loc.cod_locatie) 
        join orase o on(loc.cod_oras=o.cod_oras)
where initcap(a.nume) = 'Ionescu' and initcap(a.prenume) = 'Mircea'; 

------------------------------------------------------------------------------------------------------------------
/*
3.
Scrieti lista cartile vandute in Cluj(JUDET) in ordinea vanzarii lor, de la bestseller pana la 
cea care este vanduta de cele mai putine ori, mentionandu-se titlul acestora si numarul de  exemplare vandute.
--s-a folosit order by 
--subcereri nesincronizate (3)
--lower(functie cu tip de caractere)
--join
--group by
--filtrare la nivel de linii
*/
select count(cump.cod_carte) "Numar carti vandute", car.denumire "Titlu" 
from cumparari cump join carti car on(cump.cod_carte=car.cod_carte)
where cod_angajat in (
            select cod_angajat     --Ionescu Andrian(403) lucreaza la libraria cu codul  90; Mihaita(411) si Popovici(410) la libraria cu codul 60
            from angajati
            where lower(tip_angajat) = 'vanzator' 
            and cod_librarie in (select cod_librarie   --sunt 2 librarii in cluj_napoca; coduri: 60 si 90
                                from librarii
                                where cod_oras in (
                                                    select cod_oras      --cod cluj 2030
                                                    from orase
                                                    where nvl(upper(judet),'NU') = 'CLUJ'
                                                  )
                                )
                    )
group by cump.cod_carte, denumire
order by count(cump.cod_carte) desc;

-------------------------------------------------------------------
/*
4.
Afiseaza acum cate luni a fost vanduta cartea 'Mostenirea' (se afiseaza pentru toate vanzarile)
--am folosit functiile sysdate, round, months_between 
*/
select  round(months_between(sysdate, data_cump)) "Cate luni au trecut"
from cumparari 
where (cod_carte) =ALL (
                        select  cod_carte 
                        from carti
                        where denumire = 'Mostenirea' 
                                    and cod_carte =ANY (select cod_carte
                                                        from cumparari)
                             );
                             

/*
5.
Un client vrea sa cumpere toata seria de carti 'Faptele credintei', inainte de a 
cumpara, vrea sa stie daca aceasta se gaseste in limba franceza, iar in caz contrar, 
in limba engleza. daca nici asa nu se gaseste, vrea sa i se spuna ca sa nu mai cumpere
--cerere creata pentru a folosi functia DECODE
--pe langa aceasta, se folosesc si subcereri necorelate pt a spori complexitatea cererii, functia upper()
*/
select  decode(lower(limba),'franceza', 'Se gaseste in limba franceza')  "franceza",
        decode(lower(limba),'engleza', 'Nu se gaseste in franceza, dar se gaseste in limba engleza')  "engleza",
        'Ne pare rau, nu se gaseste in nicio limba dorita' "negativ"
from limbi
where cod_limba  =ANY (select cod_limba
                    from traduse
                    where cod_carte in( select cod_carte
                                        from carti
                                        where cod_serie = (
                                                            select cod_serie
                                                            from serii
                                                            where UPPER(nume) = 'FAPTELE CREDINTEI'
                                                         )
                                    )
                    );

select*from traduse;

/*
11: subcereri sincronizate în care intervin cel pu?in 3 tabele
grup?ri de date, func?ii grup, filtrare la nivel de grupuri. 

6.Precizati codul, numele si numarul de carti vandute de angajatii care au vandut un numar
maxim de carti, selectandu-i doar pe aceia care lucreaza la o librarie care are numar maxim de angajati.Sa se precizeze
si unde se gasesc aceste librarii

---am folosit mai mult de 3 subcereri corelate si grupari de date,
--functii grup(count, max), alegerea doar unor linii(having)
--subcereri necorelate
--am integrat si clauza WITH cu ajutorul careia am scris o parte din blocul 
--    din cerere inainte de a-l utiliza in cerere
*/
with maxim as ( select max(count(cod_librarie)) max_libr   
             from angajati
             group by cod_librarie
             ),        --numarul maxim de angajati dintr-o librarie
numar_max_ang as (  select cod_librarie   
                    from angajati
                    having 
                    count(cod_librarie) =
                                ( select max_libr
                                 from maxim
                                 )
                    group by cod_librarie
                 )   --librariile in care se gaseste un numar maxim de angajati 

select cod_angajat,  
         ( select nume
           from angajati
           where cod_angajat=c.cod_angajat
         ) "Nume angajat",  --trebuie sa trec din cumparari in angajati pentru a afla numele angajatului
         (select count(cod_carte)
          from cumparari
          where c.cod_angajat=cod_angajat
          group by cod_angajat
         ) "Numar vanzari",  --vad cate carti a vandut un angajat
         (select ( 
                    select (
                            select strada
                            from locatii
                            where cod_locatie=l.cod_locatie
                            )
                    from librarii l
                    where ang.cod_librarie=cod_librarie
                 )     --selectarea locatiei(strada) pentru angajati trecand prin 
                       --cumparari-angajati-librarii-locatii
         from angajati ang
         where cod_angajat=c.cod_angajat
         ) "Locatie librarie"
from cumparari c 
having count(cod_angajat) = (select max(count(cod_angajat)) 
                              from cumparari
                              group by cod_angajat
                             )    --numarul maxim de carti vandute de un angajat
    and cod_angajat in ( select cod_angajat   
                        from angajati
                        where cod_librarie in (select cod_librarie
                                               from numar_max_ang)
                        )   --angajatii care lucreaza intr-o librarie cu numar maxim de angajati
group by cod_angajat;

--------------------------------------------------------------------------------------------
/*
12. Implementarea a 3 opera?ii de actualizare (UPDATE) sau suprimare (DELETE) 
a datelor utilizând subcereri.

1. Locatia librariei de pe strada Doamnei din Bucuresti se muta pe strada 
Apusului, numarul 11 (tot din Bucuresti)
--m-am gandit la cazul in care in care ar exista 2 strazi cu acelasi nume, dar in orase diferite.
--de aceea este necesar sa verific si daca orasul este cel corect, inainted e a produce schimbarea.
*/
UPDATE locatii
SET strada = 'Strada Apusului', numar = 11
WHERE initcap(strada) = 'Strada Doamnei'
            and cod_oras in (select cod_oras
                          from orase
                          where initcap(denumire) = 'Bucuresti');
                          
select * from locatii;

/*
2. Stergeti din lista de categorii acele categorii pentru care nu exista 
nicio carte in librarii.
*/
delete
from categorii
where cod_categorie not in(select distinct cod_categorie     --11 categorii folosite din 13  
                            from are);                    --de familie si geografie (nefolosite)
                            
select* from categorii;

/*
3.Pentru a promova citirea cator mai multor carti romanesti, bibliotecile propun o reducere(10%) a 
tuturor cartilor scrise de autori de nationalitate romana, indiferent de limba in care se gaseste.
---sunt 3 carti scrise de autori romani =>se modifica 3 valori
*/
update carti
set pret = pret - (pret*0.1)
where cod_carte in (
                    select distinct cod_carte
                    from are
                    where cod_scriitor in
                                (
                                select cod_scriitor 
                                from scriitori
                                where lower(nationalitate) =  'romana'
                                )
                );
select * from carti;
commit;

/*   
16. Formula?i în limbaj natural ?i implementa?i în SQL: o cerere ce 
utilizeaz? opera?ia outerjoin pe minimum 4 tabele.

Sa se afiseze pentru fiecare oras cati angajati si salariul mediu in functie de oras(salariul mediu nu poate fi null, daca este,
cazul. se inlocuieste cu 0). Ordonati-le de la orasul in care se plateste cel mai bine pana la cel mai prost platit.

--a fost nevoie de 3 left outer join-uri deoarece exista orase in care nu se gasesc locatiile unor
--librarii, de asemenea, sunt locatii in care nu sunt librarii, deci nici angajari. Cu ajutorul 
--left joinului, am putut sa le selectez pe toate netinand cont daca se completeaza cu valori de null. 
--fiecare left join este important pentru a putea afisa datele dorite
*/
select o.denumire, count(cod_angajat) "Numar angajati", nvl(avg(salariu),0) "Salariu mediu"
from orase o left join locatii loc on (o.cod_oras=loc.cod_oras) 
            left join librarii lib on(loc.cod_locatie=lib.cod_locatie)
            left join angajati a on (lib.cod_librarie=a.cod_librarie)
group by o.denumire
order by nvl(avg(salariu),0) desc;

/*
16. Formula?i în limbaj natural ?i implementa?i în SQL: dou? cereri ce utilizeaz? opera?ia division.

1. Sa se afiseze scriitori care au in librarie carti cel putin de aceleasi categorii ca si scriitoarea Karen Witemeyer.
--Witemeyer(106) a scris carti de categoriile cu codurile 10,11,14
 --108 a scris carti cu codul 14, 11, 10
--106 a scris carti cu codul 14, 11, 10, 12  ->se accepta  ->Janette Oke
--104 a scris carti cu codul 14, 11, 10, 12  ->se accepta   ->T. Davis Bunn
--110 a scris carti cu codul 11, 12, 21      -> se respinge pentru ca nu este si codul 14, 10
--107 a scris carti cu codul 11, 10, 17      -> se respinge pentru ca nu este si codul 14
--109 a scris carti cu codul 11, 18, 19, 20,  -> se respinge pentru ca nu este si codul 14, 10
--100 a scris carti cu codul 16               -> se respinge
--105 a scris carti cu codul 22              -> se respinge

--caut  pentru fiecare scriitor in 'are' codurile (10,11,14)--codurile categoriilor in domeniul carora a scris KAren Witemeyer
--un scriitor poate are mai multe carti de un gen dorit si in acest caz se va selecta de mai multe ori
--exemplu: scriitorul cu codul 104 are 8 carti incadrate in categoria cu codul 10 => va fi selectata de 8 ori
--de aceea trebuie sa grupez in functie de scriitor(nume, prenume) si la numararea sa iau in considerare doar categoriile diferite
*/
select nume, prenume
from are a join scriitori s on (s.cod_scriitor=a.cod_scriitor)
where cod_categorie in (select distinct cod_categorie     --selectez codurile categoriile --10, 11, 14
                        from are
                        where cod_scriitor = ( select cod_scriitor
                                               from scriitori 
                                               where lower(prenume||nume) = 'karenwitemeyer'
                                               )
                        )
        and a.cod_scriitor != ( select cod_scriitor
                              from scriitori 
                              where lower(prenume||nume) = 'karenwitemeyer'
                              )
group by a.cod_scriitor, nume, prenume                    
having count(distinct cod_categorie) >= (   select count(distinct cod_categorie)   
                                            from are
                                            where cod_scriitor = ( select cod_scriitor
                                                                   from scriitori 
                                                                   where lower(prenume||nume) = 'karenwitemeyer'
                                                                 )
                                         );
/*
2. 
select * from traduse;
Sa se afiseze lista cartilor(doar codul) care au fost traduse exact in aceleasi limbi in care a fost tradusa si cartea cu codul 1071.
--aceasta inseamna sa fie traduse fix in toate limbile respective, 
--si sa nu fie traduse nicio alta limba
--la final se afiseaza: 1067, 1068, 1069, 1070

--cartea 1071 este tradusa in limbile cu codul 20 si 30
--cartea 1065 - doar 20  ->se respinge
--cartea 1066 - doar 20  ->se respinge
--cartea 1067 - 20, 30  ->se accepta
--cartea 1068 - 20, 30  ->se accepta
--cartea 1069 - 20, 30  ->se accepta
--cartea 1070 - 20, 30  ->se accepta
--cartea 1072 - doar in 20  ->se respinge
--...
--cartea 1082 - 20, 30, 40  ->se respinge
--cartea 1083 - 20, 30, 40  ->se respinge
--...
--cartea 1088 - 20, 30, 40  ->se respinge
--cartea 1090 - 20, 40  ->se respinge
*/
select cod_carte
from traduse
where cod_limba in (select cod_limba   --20, 30
                    from traduse
                    where cod_carte = 1071
                    )
        and cod_carte != 1071
group by cod_carte
having count(cod_carte) = (select count(cod_limba)   
                            from traduse
                            where cod_carte = 1071
                            )   --daca as scrie doar pana aici, ar spune ca sunt ok si cartile de la 1082 la 1088
MINUS

select cod_carte
from traduse
where cod_limba not in (select cod_limba   --20, 30
                        from traduse
                        where cod_carte = 1071
                        );   --am eliminat cartile care erau traduse si in alte limbi pe langa cele dorite

 