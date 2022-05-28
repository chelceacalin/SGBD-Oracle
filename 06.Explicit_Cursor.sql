--1. S? se afi?eze instructorul cu  id 15 S? se trateze eroarea ap?rut? în cazul în c
--are nu exist? nici un instructor cu acest id
set serveroutput on;
declare
varNume instructori.nume%type;
begin
select nume into varNume from instructori where id_instructor=15;
dbms_output.put_line(varNume);
EXCEPTION
when no_Data_found then
dbms_output.put_line('Instructor cu id invalid');
end;
/
 

--2. S? se afi?eze salariul instructorului cu numele Chelcea. S? se trateze eroare ap?rut? în cazul în care exist? mai mul?i
--instructori cu acela?i nume 

update instructori set nume='Chelcea' where nume='Bogdan';
set serveroutput on;
declare 
vnume instructori.nume%type;
vsal instructori.sal%type;
begin
select nume,sal into vnume,vsal from instructori where nume='Chelcea';
dbms_output.put_line(vnume||' '||vsal);
EXCEPTION
 when too_many_rows
 then 
 dbms_output.put_line(' Au fost returnate prea multe randuri');
end;
/
 

--3. Incercarea deschiderii unui cursor deja deschis
declare
cursor myC is
select * from instructori;
begin
if not myC%isopen
then
open myC;
end if;
for i in myC
loop
dbms_output.put_line(i.nume);
exit when myC%notfound;
end loop;
EXCEPTION
when CURSOR_ALREADY_OPEN 
then
dbms_output.put_line(' Cursor deja deschis');
end;
/
 
--4. Exceptie la stergere
CREATE TABLE erori 
(utilizator VARCHAR2(40), 
data DATE, 
cod_eroare NUMBER(10), 
mesaj_eroare VARCHAR2(255)
);

DECLARE
cod NUMBER;
mesaj VARCHAR2(255);
del_exception   EXCEPTION;
PRAGMA EXCEPTION_INIT(del_exception, -2292);
BEGIN
DELETE FROM instructori;
EXCEPTION
WHEN del_exception THEN
dbms_output.put_line('Nu puteti sterge instructorii');
cod:=SQLCODE;
mesaj:=SQLERRM;
INSERT INTO erori VALUES(USER, SYSDATE, cod, mesaj);
END;
/
SELECT * FROM erori;
 
--5.  S? se modifice sal instructorului cu id-ul 65. 
--Dac? nu se produce nici o actualizare sa se afiseze o excep?ie prin care s? fie avertizat utilizatorul:
DECLARE
ID_invalid EXCEPTION;
BEGIN
UPDATE instructori 
SET sal=100
WHERE id_instructor=65;
IF SQL%NOTFOUND THEN
RAISE ID_invalid;
END IF;

EXCEPTION
WHEN ID_invalid THEN
DBMS_OUTPUT.PUT_LINE('Nu exista instructorul cu acest ID');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('A aparut o eroare! Nu se poate actualiza salariul instructorukui!');
END;
/
 

--5.  S? se modifice sal instructorului cu id-ul 65.  Folosind o EXCEPTIE PREDEFINITA NO_DATA-FOUND
DECLARE
BEGIN
UPDATE instructori 
SET sal=100
WHERE id_instructor=65;
IF SQL%NOTFOUND THEN
RAISE no_Data_found;
END IF;
EXCEPTION
WHEN no_Data_found THEN
DBMS_OUTPUT.PUT_LINE('Nu exista instructorul cu acest ID');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('A aparut o eroare! Nu se poate actualiza salariul instructorukui!');
END;
/
 

--6.  Raise Exception

SET SERVEROUTPUT ON
DECLARE
cod NUMBER(7);
mesaj VARCHAR2(255);
invalid_prod EXCEPTION;
PRAGMA EXCEPTION_INIT(invalid_prod,-20999);
BEGIN
UPDATE instructori 
SET sal=100
WHERE id_instructor=65;
IF SQL%NOTFOUND THEN
RAISE_APPLICATION_ERROR (-20999,'ID instructor invalid!');
END IF;
EXCEPTION
WHEN invalid_prod THEN
DBMS_OUTPUT.PUT_LINE('Nu exista instructorul cu acest ID');
cod:=SQLCODE;
mesaj:=SQLERRM;
INSERT INTO ERORI VALUES(USER, SYSDATE, cod, mesaj);
END;
/
 











