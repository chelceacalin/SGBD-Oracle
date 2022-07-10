--1 .Procedura modifica_salariul prime?te doi parametrii:
--p_id_instructor ?i procent ?i majoreaz? cu procentul specificat
--salariul instructorului cu acel id
set serveroutput on;
create or replace procedure ModificaSalariul(p_id_instructor instructori.id_instructor%type, procent number)
is
vSal instructori.sal%type;
BEGIN
select sal into vSal 
from instructori
where id_instructor=p_id_instructor;
dbms_output.put_line('Salariul inainte de modificare: '||vSal);
update instructori
set sal=sal*(procent/100+1)
where id_instructor=p_id_instructor;
select sal into vSal from instructori where id_instructor=p_id_instructor;
dbms_output.put_line('Salariul DUPA de modificare: '||vSal);
END;
/
call ModificaSalariul(1,15);
EXECUTE ModificaSalariul(1, 15);
begin
 ModificaSalariul(1,15);
end;
/
 


-- 2. Procedura calculeaz? salariul mediu ?i îl returneaz? printr-un parametru de tip OUT
create or replace procedure CalcSalMediu(Psal out number)
is
BEGIN
select avg(sal) into psal from instructori;
dbms_output.put_line(Psal);
END;
/
variable Vmediu number;
call CalcSalMediu(:Vmediu);
print Vmediu;
 

--3. Procedura prime?te ca parametru de tip IN id_ul unui instructor 
--?i returneaz? prin parametrii de tip OUT numele ?i salariul acestuia:

create or replace procedure Afiseaza(pID in instructori.id_instructor%type,NumeInstructor out varchar,vsal out number)
is
begin
select nume,sal into NumeInstructor,vsal 
from instructori 
where id_instructor=pID;
dbms_output.put_line(NumeInstructor|| ' Salariul : '||vsal);
END;
/
declare
vNume instructori.nume%type;
vSal instructori.sal%type;
begin
Afiseaza(1,vNume,vSal);
END;
/
 
--4. Modifica salariul instructorului  care are salariul mai mic decat sal mediu
create or replace procedure Modif(Pid_Instructor in instructori.id_instructor%type ,pSalMediu in out number)
is
nume instructori.nume%type;
salariu instructori.sal%type;
begin
select sal into salariu
from instructori where id_instructor=Pid_Instructor;
if salariu<pSalMediu then
  ModificaSalariul(Pid_Instructor,15);
 end if;
 CalcSalMediu(pSalMediu);
end;
/
variable SalTemp number;
call  Modif(2,:SalTemp);
print SalTemp;
 

--5. Cauta instructorul dupa id
SET SERVEROUTPUT ON;
create or replace procedure cauta_Instructor (pIDINS instructori.id_instructor%type,pNume out instructori.nume%type,vSal out instructori.sal%type)
is
BEGIN
select nume,sal into  pNume, vSal
from instructori
where id_instructor=pIDINS;

dbms_output.put_line(pNume|| ' '||vSal);
END;
/
--Apel 1
variable Nume varchar;
variable Sal number
call cauta_Instructor(1,:Nume,:Sal);

--Apel 2
Declare 
pNume1  instructori.nume%type;
vSal1  instructori.sal%type;
BEGIN 
cauta_Instructor(1,pNume1,vSal1);
END; 
/

 

-- 6. Apelul procedurii intr-un bloc anonim
SET SERVEROUTPUT ON
DECLARE
vID_instructor instructori.id_instructor%type;
vnume instructori.nume%type;
salar instructori.sal%type;
VSalMed number;
BEGIN
vID_instructor:=1;
cauta_Instructor(vID_instructor,vnume,salar);
CalcSalMediu(VSalMed);
dbms_output.put_line('Salariul mediu este: '||VSalMed);
Modif(vID_instructor,VSalMed);
Cauta_Instructor(vID_instructor,vnume,salar);
vID_instructor:=100;
Modif(vID_instructor,VSalMed);
EXCEPTION
when no_data_found then
DBMS_OUTPUT.PUT_LINE('Instructor inexistent! ID invalid');
END; 
/

 

-- 7. Stergerea unei Proceduri
DROP PROCEDURE Modif;
 
--8. Vizualizarea procedurilor
Select object_name
From user_objects
Where object_type='PROCEDURE';
 
--9. Vizualizarea corpului procedurii
Select text
From user_source
Where name='Cauta_Instructor' and type='PROCEDURE';



-- FUNCTII



--10 .Func?ia verifica_salariul returneaz? TRUE/FALSE daca salariatul are salariul mai mare/mai mic sau egal cu salariul mediu  si NULL daca salariatul nu exista

create or replace function verifica_salariul(pID_instructor in instructori.id_instructor%type,pSal in instructori.sal%type)
return Boolean
IS
vSal instructori.sal%type;
BEGIN
select sal into Vsal from instructori where id_instructor=pID_instructor;
if Vsal<Psal then
return true;
else
return false;
end if;
EXCEPTION
WHEN no_data_found THEN
return NULL;
END;
/

--11. Vizualizarea tipului returnat
describe verifica_salariul;
 

--12. Apel
SET SERVEROUTPUT ON
DECLARE
v_sal_mediu number;
BEGIN
CalcSalMediu (v_sal_mediu);
IF (verifica_salariul(1, v_sal_mediu) IS NULL) then
dbms_output.put_line('Instructor cu ID invalid!');
elsif (verifica_salariul(1, v_sal_mediu)) then
dbms_output.put_line('Instructorul are sal> avg ');
else
dbms_output.put_line('Instructorul are sal < avg ');
end if;
END;
/

 

--13 . O alta metoda de folosire a functiilor
CREATE OR REPLACE FUNCTION SalariuModificat (sal IN NUMBER, proc IN NUMBER)
RETURN NUMBER 
IS
BEGIN
RETURN (sal*proc/100);
END SalariuModificat;
/
select nume,SalariuModificat(sal,5) as Sal
from instructori;

   



