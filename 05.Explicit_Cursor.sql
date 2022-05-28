-- 1.Se afi?eaz? printr-un ciclu FOR numele ?i salariile instructorilor cu categoria B
set serveroutput on;
declare
cursor Parcurge is 
select nume,sal 
from instructori 
where upper(Categorie) like '%B%';
begin
for i in Parcurge
loop
dbms_output.put_line(i.nume||' '||i.sal);
end loop;
end; 
/
 
-- 2.Se afi?eaz? numarul elevilor al fiecarui instructor
set serveroutput on;
declare
begin
for i in (
select i.id_instructor,i.nume, count(id_elev) Contor
from instructori i, elevi e
where i.id_instructor=e.id_instructor
group by i.id_instructor,i.nume)
loop
dbms_output.put_line(i.nume||' are '||i.Contor|| ' elevi' );
end loop;
end; 
/
 
-- 3. Sa se afiseze instructorii care au salariul mai mare decat o variabila data de la tastatura
-- Dam valoarea 5999
declare
CURSOR myCursor(valoare number) is 
select * from instructori where sal>valoare;
variabilamyCursor myCursor%rowtype;
valoareaMea number:=&valMea;
begin 
if not myCursor%isopen then
open myCursor(valoareaMea);
end if;
LOOP
fetch myCursor into variabilamyCursor;
dbms_output.put_line(variabilamyCursor.nume);
exit when myCursor%NOTFOUND;
END LOOP;
end;
/
 



-- 4.Pentru fiecare instructor sa se afiseze elevii
declare
--Cursor sa selecteze instructorii
cursor CInstructor is
select id_instructor,nume from instructori;
--Cursor care pt fiecare instructor afiseaza elevii
cursor Elev(Vid_instructor number)
is
select e.nume
from instructori i,elevi e
where i.id_instructor=e.id_instructor
and i.id_instructor=Vid_instructor
order by i.id_instructor asc;
begin
for i in CInstructor
loop
dbms_output.put_line('Instructorul cu ID '||i.id_instructor||' si numele '|| i.nume||' are: ');
    for j in Elev(i.id_instructor) LOOP
    dbms_output.put_line('Elevul cu numele: '||j.nume);
    END LOOP;
end loop;
end;
/


 

-- 5.Folosirea CURRENT OF , NO WAIT SI FOR UPDATE 
Create table EleviCuInstructori
as 
select e.ID_ELEV IDELEV,e.nume NumeElev,e.prenume PrenumeElev,i.id_instructor IDiNSTRUCTOR,i.sal salariuInstructor
from elevi e,instructori i
where e.id_instructor=i.id_instructor
and upper(i.categorie) like '%B%';
declare
Cursor myCursor is select * from EleviCuInstructori for update of idelev nowait;
myvar myCursor%rowtype;
begin
for i in myCursor
LOOP
update EleviCuInstructori
set salariuinstructor=salariuinstructor*1.19
where current of myCursor;
DBMS_OUTPUT.PUT_LINE('Noul salariu al instructorului '||i.numeinstructor||' este '||i.salariuinstructor);
END LOOP;
end;
/
 
 



