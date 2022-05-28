-- 1. Creati un trigger care sa fie declansat la inserarea
-- unei intrari noi in tabela instructori
set serveroutput on;
CREATE OR REPLACE TRIGGER insInstructor 
AFTER INSERT on Instructori
BEGIN
dbms_output.put_line(' S-a adaugat un instructor');
END;
/
 

-- 2. Creati un trigger care sa fie declansat la
-- insert, update si delete si sa insereze in tabela LogsOp
CREATE TABLE LogsOp 
(
tipOperatie CHAR(10), 
utilizator VARCHAR2(50), 
data DATE DEFAULT SYSDATE
);
CREATE OR REPLACE TRIGGER Tip_ExamenTrigger 
BEFORE INSERT or UPDATE or DELETE on Tip_Examen 
DECLARE 
tipOperatie LogsOp.tipOperatie%TYPE; 
BEGIN 
  case
  when INSERTING then tipOperatie :='Insert';
  when UPDATING then tipOperatie:='Update';
  ELSE tipOperatie :='Delete';
  END case;
  INSERT INTO LogsOp(tipOperatie, utilizator, data) VALUES (tipOperatie, user, sysdate);
END;
/
--Verificarea execu?iei:
--inserarea in tabela
insert into tip_examen values (11,'Practic');
Select * from LogsOp;

 
delete from tip_examen where id_examen=11;
Select * from LogsOp;
 

-- 3. Creati un trigger care sa fie declansat la
-- inserarea unui examen cu un id peste maximul curent

CREATE OR REPLACE TRIGGER RestrictONTIP_EXAMEN
BEFORE INSERT OR UPDATE on tip_examen
FOR EACH ROW
DECLARE
idmax tip_examen.ID_EXAMEN%type;
BEGIN
select max(id_examen) into idmax from tip_examen;
if :NEW.id_examen>idmax then
    Raise_application_error(-20202,' ID-UL ESTE PREA MARE ');
end if;
END;
/
insert into tip_examen values (100,'Practic');

 
-- 4. Creati un trigger care sa controleze unicitatea examenelor
create sequence mysequence
start with 15
increment by 1
maxvalue 100
nocycle;

CREATE OR REPLACE TRIGGER RestrictUNIC
BEFORE INSERT  on tip_examen
FOR EACH ROW
BEGIN
select mysequence.nextval into :new.id_examen from dual;
END;
/
 
insert into tip_examen values (mysequence.nextval,'Practic');
---- Am schimbat incrementul la 2
 

--6. Dezactivarea unui trigger
ALTER TRIGGER RestrictUNIC DISABLE;
 
--7. Compilarea unui trigger  --acelasi mesaj ca mai sus
ALTER TRIGGER RestrictUNIC COMPILE;
--8. Stergerea  unui trigger
DROP TRIGGER RestrictUNIC;
 










