-- 1. În func?ie de salariul instructorului având codul citit de la tastatur?,
--se va afi?a modificat pe ecran noua valoare.
declare
v_sal instructori.sal%type;
begin
select sal into v_sal from instructori where id_instructor=&ID;
dbms_output.put_line('Inainte de modificare salariul este: '||v_sal);
if v_sal > 5000 then v_sal:=v_sal*10;
elsif v_sal < 5000 then v_sal:=v_sal/10;
end if;
dbms_output.put_line('Dupa modificare salariul este: '||v_sal);
end;
/
 

-- 2. Intoarce rezultatul  intr-o variabila de tip case.
declare
v_sal instructori.sal%type;
begin
select sal into v_sal from instructori where id_instructor=&ID;
dbms_output.put_line('Inainte de modificare salariul este: '||v_sal);
v_sal:=case
when v_sal >5000 then 2*v_sal
when v_sal <5000 then v_sal/2
else 0
end;
dbms_output.put_line('Dupa modificare salariul este: '||v_sal);
end;
/
 

-- 3.  Folosim case care sa nu intoarca rezultatul.
declare
v_sal instructori.sal%type;
begin
select sal into v_sal from instructori where id_instructor=&ID;
dbms_output.put_line('Inainte de modificare salariul este: '||v_sal);
case
when v_sal >5000 then v_sal:=2*v_sal;
when v_sal <5000 then v_sal:=v_sal/2;
else v_sal:=0;
end case;
dbms_output.put_line('Dupa modificare salariul este: '||v_sal);
end;
/
 

-- 4.  Se afi?eaz? în ordine instructorii cu id-urile în intervalul 1-10 
-- atât timp cât salariul acestora este mai mic decât media:

declare
i number:=1;
v_sal instructori.sal%type;
vsalmediu number;
begin
select avg(sal) into vsalmediu from instructori;
dbms_output.put_line(vsalmediu);
loop
select sal into v_sal from instructori where id_instructor=i order by sal;
dbms_output.put_line('Instructorul cu id '||i||' are salariul '||v_sal);
i:=i+1;
exit when i>=9 or v_sal<vsalmediu;
end loop;
end; 
/

-- 5 . Se afi?eaz? în ordine instructorii cu id-urile în intervalul 1-10 
--atât timp cât salariul acestora este mai mic decât media:  CU WHILE


declare
i number:=1;
v_sal instructori.sal%type;
vsalmediu number;
begin
select avg(sal) into vsalmediu from instructori;
dbms_output.put_line(vsalmediu);
while i<=9 
loop 
select sal into v_sal from instructori where id_instructor=i order by sal;
dbms_output.put_line('Instructorul cu id '||i||' are salariul '||v_sal);
i:=i+1;
exit when  v_sal<vsalmediu;
end loop;
end;  /
 
-- 6. Se afi?eaz? în ordine instructorii cu id-urile în intervalul 1-10 
--atât timp cât salariul acestora este mai mic decât media: CU FOR
declare
v_sal instructori.sal%type;
vsalmediu number;
begin
select avg(sal) into vsalmediu from instructori;
dbms_output.put_line(vsalmediu);
for i in 1..10
loop 
select sal into v_sal from instructori where id_instructor=i order by sal;
dbms_output.put_line('Instructorul cu id '||i||' are salariul '||v_sal);
exit when  v_sal<vsalmediu;
end loop;
end; 
/
 
-- 7. S? se afi?eze num?rul de elevi ai fiec?rui instructor al c?rui id este situat în intervalul 1-10
-- s? se întrerup? afi?area în cazul în care se g?se?te primul instructor din acest interval care nu are elevi
declare
v_contor number;
index1 instructori.id_instructor%type;
begin
for index1 in 1..10 loop
select count(e.id_elev) into v_contor from elevi e,instructori i
where e.id_instructor=i.id_instructor and e.id_instructor=index1;
dbms_output.put_line('Instructorul cu id-ul: '||index1||' are: '||v_contor||' elevi');
exit when v_contor=0;
end loop;
end;
/
 
-- 8. Utilizarea unui tablou indexat de tipul instructori.nume 
DECLARE
type TEMP is table of instructori.nume%type index by pls_integer;
v_tab TEMP;
i number(5):=1;
BEGIN
loop
SELECT nume into v_tab(i) from instructori where id_instructor=i;
i:=i+1;
exit when i>=9;
end loop;
for i in v_tab.first..v_tab.last loop
IF v_tab.EXISTS(i) then
dbms_output.put_line('Nume instructor: '|| v_tab(i));
end if;
end loop;
dbms_output.put_line('Total instructori in tabloul indexat: '|| v_tab.count);
END;
/
 

-- 9. Utilizarea unui tablou indexat de acela?i tip cu un rând din tabela Instructori - %ROWTYPE

DECLARE
type instructori_Table is table of instructori%rowtype index by pls_integer;
INSTable instructori_Table;
BEGIN
for i in 1..10 loop
SELECT * into INSTable(i) from instructori where id_instructor=i;
end loop;
for i in INSTable.first..INSTable.last loop
dbms_output.put_line('Instructorul: '|| INSTable(i).nume|| ' are categ: '||INSTable(i).categorie);
end loop;
dbms_output.put_line('Total instructori in tabloul indexat: '|| INSTable.count);
END;
/
 


