--1. Creati un pachet de functii si subprograme

create or replace package ActualizareELEVI is
PROCEDURE AdaugaELEV(pID elevi.id_elev%type, pNume elevi.nume%type,pPrenume elevi.prenume%type,pVarsta elevi.varsta%type,
pIDSEDIU elevi.id_sediu_apartenenta%type,pIDINSTRUCTOR elevi.id_instructor%type);
PROCEDURE Modifica(pID elevi.id_elev%type, pNume elevi.nume%type,pPrenume elevi.prenume%type,pVarsta elevi.varsta%type,
pIDSEDIU elevi.id_sediu_apartenenta%type,pIDINSTRUCTOR elevi.id_instructor%type);
--SupraIncarcare
PROCEDURE ModificaNume(pID elevi.id_elev%type, pNume elevi.nume%type);
PROCEDURE STERGEELEV(pID elevi.id_elev%type);
FUNCTION ExistaElev(pID elevi.id_elev%type)
return BOOLEAN;
exceptie EXCEPTION;
END;
/

create or replace package BODY ActualizareELEVI is
FUNCTION ExistaElev(pID in elevi.id_elev%type)
return BOOLEAN
IS
vId elevi.id_elev%type;
BEGIN
select id_elev into vID
from elevi
where id_elev=pID;
return true;
EXCEPTION
when NO_DATA_FOUND then
return false;
END;
PROCEDURE AdaugaELEV(pID elevi.id_elev%type, pNume elevi.nume%type,pPrenume elevi.prenume%type,pVarsta elevi.varsta%type,
pIDSEDIU elevi.id_sediu_apartenenta%type,pIDINSTRUCTOR elevi.id_instructor%type)
IS
BEGIN
if ExistaElev(pID) then
raise exceptie;
else
insert into elevi (id_elev,nume,prenume,varsta, id_sediu_apartenenta,id_instructor) values (pID,pNume,pPrenume,pVarsta,pIDSEDIU,pIDINSTRUCTOR);
end if;
EXCEPTION
when exceptie then
dbms_output.put_line(' Exista deja un elev');
END;
PROCEDURE Modifica(pID elevi.id_elev%type, pNume elevi.nume%type,pPrenume elevi.prenume%type,pVarsta elevi.varsta%type,
pIDSEDIU elevi.id_sediu_apartenenta%type,pIDINSTRUCTOR elevi.id_instructor%type) is
BEGIN
if ExistaElev(pID) then
update Elevi
set Nume=pNume,Prenume=pPrenume where
id_elev=pID;
else
raise exceptie;
end if;
EXCEPTION
when exceptie then
dbms_output.put_line(' ID NEGASIT ');
END;
--SupraIncarcare
PROCEDURE ModificaNume(pID elevi.id_elev%type, pNume elevi.nume%type) IS
BEGIN
if ExistaElev(pID) then
update Elevi set nume=pNume where id_elev=pID;
else
raise exceptie;
end if;
EXCEPTION
when exceptie then
dbms_output.put_line(' ID NEGASIT ');
END;
PROCEDURE STERGEELEV(pID elevi.id_elev%type) IS
BEGIN
if ExistaElev(pID) then
delete from Elevi where id_elev=pID;
else
raise exceptie;
end if;
EXCEPTION
when exceptie then
dbms_output.put_line(' ID NEGASIT pentru a-l putea sterge ');
END;
END;
/
Apelul procedurilor / funcțiilor din cadrul pachetului:
execute ActualizareELEVI.AdaugaELEV(20,'Georgescu','Robert',25,3,4);

call actualizareelevi.ModificaNume(20,'Calin');

begin 
 actualizareelevi.ModificaNume(20,'Rares');
 end ;
 /
