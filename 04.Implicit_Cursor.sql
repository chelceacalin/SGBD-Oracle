-- 1.  Sterg instructorii care au mai putin de 1 an experienta
insert into instructori(id_instructor,nume,prenume,varsta,ani_experienta,categorie,sediu,sal,NrTelefon,Cod_Supervizor) values (12,'Test','Nou',18,0,'B',1,2350,0763654280,1);
set serveroutput on
begin
delete from instructori where ani_experienta<1;
dbms_output.put_line('Au fost afectate: '||sql%rowcount||' inregistrari');
rollback;
dbms_output.put_line('Au fost afectate: '||sql%rowcount||' inregistrari');
end;
/


-- 2. Se incearca injumatatirea salariului unui instructor al carui id nu exista.

set serveroutput on
begin
update instructori  set sal=sal*0.5 where id_instructor=14;
IF SQL%NOTFOUND THEN
dbms_output.put_line('ID Invalid: ');
end if;
rollback;
end;
/




-- 3. Se incearca stearga instructorii cu id dat de la tastatura
ACCEPT g_rid PROMPT 'Introduceti id-ul instructorului:'
VARIABLE nr_sters varchar2(100)
DECLARE
BEGIN
DELETE FROM instructori WHERE id_instructor=&g_rid;
:nr_sters:=TO_CHAR(SQL%ROWCOUNT)||' Instructori Stersi';
END;
 /
PRINT nr_sters
ROLLBACK;

-- 4. Afiseaza toti instructorii care au si categoria B
declare
cursor CursorInstructori is select nume,prenume,categorie from instructori  where upper(categorie) like '%B%'; --nu trb neaparat sa pun where
vnume instructori.nume%type;
vprenume instructori.prenume%type;
vcategorie instructori.categorie%type;
begin
dbms_output.put_line('Lista cu instructori ');
open CursorInstructori;
loop
fetch CursorInstructori into vnume,vprenume,vcategorie;
exit when CursorInstructori%notfound;
dbms_output.put_line('Instructorul '||vnume||' are categoria: '||vcategorie);
end loop;
end;
/





-- 5. Afiseaza toti instructorii care au si categoria B – dar cu record
declare
cursor CursorInstructori is select nume,prenume,categorie from instructori  where upper(categorie) like '%B%'; --nu trb neaparat sa pun where
type rec_instructori is record(
vnume instructori.nume%type,
vprenume instructori.prenume%type,
vcategorie instructori.categorie%type);
variabila_record rec_instructori;
begin
dbms_output.put_line('Lista cu instructori ');
open CursorInstructori;
loop
fetch CursorInstructori into variabila_record;
exit when CursorInstructori%notfound;
dbms_output.put_line('Instructorul '||variabila_record.vnume||' are categoria: '||variabila_record.vcategorie);
end loop;
end; 
/

-- 6. Afiseaza toti instructorii care au si categoria B – dar cu rowtype

declare
cursor CursorInstructori is select nume,prenume,categorie from instructori  where upper(categorie) like '%B%'; --nu trb neaparat sa pun where
variabila_record CursorInstructori%rowtype;
begin
dbms_output.put_line('Lista cu instructori ');
open CursorInstructori;
loop
fetch CursorInstructori into variabila_record;
exit when CursorInstructori%notfound;
dbms_output.put_line('Instructorul '||variabila_record.nume||' are categoria: '||variabila_record.categorie);
end loop;
end; 
/


-- 7. Sa se incarce in tabela Elevi Jr Id elev nume si prenume la primii 5 elevi din tabela elevi
Create Table EleviJr(
id_elev number(2),
nume varchar(20),
prenume varchar(20)
);
declare 
cursor Transfera is select id_elev,nume,prenume from elevi;
varmea Transfera%rowtype;
begin
open Transfera;
for i in 1..5 loop
fetch Transfera into varmea;
insert into EleviJr values(varmea.id_elev,varmea.nume,varmea.prenume);
end loop;
close Transfera;
end; 
/
select * from elevijr;


--8. Sa se incarce in tabela Elevi Jr Id elev nume si prenume la primii 5 elevi din tabela elevi
-- Folosind ROWCOUNT

declare 
cursor Transfera is select id_elev,nume,prenume from elevi;
varmea Transfera%rowtype;
begin
open Transfera;
 loop
fetch Transfera into varmea;
exit when Transfera%rowcount<5 or transfera%notfound;
insert into EleviJr values(varmea.id_elev,varmea.nume,varmea.prenume);
end loop;
close Transfera;
end; 
/


-- 9. Sa se afiseze  primii 3 instructori si nr lor de elevi.

declare
cursor ContorElevi is 
select i.nume,count(id_elev) ContorE 
from elevi e,instructori i
where e.id_instructor=i.id_instructor
group by i.nume;
variabilaMea ContorElevi%rowtype;
begin
DBMS_OUTPUT.PUT_LINE('Numarul de elevi pentru fiecare instructor:');
if not ContorElevi%isopen  then
open ContorElevi;
end if;
loop
fetch ContorElevi into variabilaMea;
exit when ContorElevi%notfound or ContorElevi%rowcount>3;
dbms_output.put_line('Instructorul '||variabilamea.nume|| ' are '||variabilamea.ContorE|| ' elevi');
end loop;
close contorelevi;
end; 
 /
