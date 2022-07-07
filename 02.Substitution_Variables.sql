-- 1. Se afis numele instructorului cu id 1 din tabela instructori: 
set serveroutput on;
declare
v_nume instructori.nume%type;
begin
select nume into v_nume from instructori where id_instructor =1;
dbms_output.put_line('Numele este: '||v_nume);
end;
/


-- 2. Se selecteaza numele si salariul instructorilor care au 
-- sal < sal mediu al instructorului cu id 1
SET SERVEROUTPUT ON
SET AUTOPRINT ON
VARIABLE salMed number
BEGIN
select avg(sal) into :salMed from instructori where id_instructor = 1;
dbms_output.put_line(:salMed);
END;
/
select * from instructori where sal< :salMed;


-- 3. Sa se afiseze nr de elevi al instructorului al carui id este introdus de la tastatura
set serveroutput on;
declare
nrElevi number;
begin
select count(id_elev) into nrElevi from ELEVI where id_instructor=&introducetiid;
dbms_output.put_line('Numarul de elevi al instructorului este '|| nrElevi );
end;
/


-- 4. Se afiseaza salariul si prenumele instructorului cu prenumele Calin
SET SERVEROUTPUT ON
VARIABLE g_salariul number
define s_prenume= Calin
DECLARE 
v_prenume instructori.prenume%type;
BEGIN
select prenume,sal into v_prenume, :g_salariul
from instructori where prenume='&s_prenume'; 
DBMS_OUTPUT.PUT_LINE ('Prenumele angajatului este: '||v_prenume);
END;
/
print g_salariul


-- 5. Utilizând un tip de dată înregistrare definit de utilizator, să se afișeze categoria care are id = 1
set serveroutput on;
declare
type tip_categ is record(
v_id_categ categorie_masini.id_categ%type,
v_categ categorie_masini.categorie%type
);
vect tip_categ;
begin
select id_categ,categorie into vect  from categorie_masini where id_categ=1;
dbms_output.put_line('Categoria: '|| vect.v_categ);
end;
/

-- 6. Utilizând un tip de dată înregistrare de același tip cu tabela instructori 
--să se afişeze sal al instructorului cu id 1

declare
instructoriTot instructori%rowtype;
begin
select * into instructoriTot from instructori where id_instructor=1;
dbms_output.put_line('Nume: '||instructoriTot.nume||
' Prenume: '||instructoriTot.prenume);
end;
/


-- 7. Utilizând un tip de dată înregistrare de același tip cu un rând din tabela 
--instructori să se afișeze denumirea fiecărei categorie de la id-ul: 1,2,3,4,5
declare
categLinie instructori%rowtype;
i number:=1;
begin
loop
select * into categLinie from instructori where id_instructor=i;
dbms_output.put_line(categLinie.categorie);
exit when i>4;
i:=i+1;
end loop;
end;
/

