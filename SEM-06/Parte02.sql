--Uso de UNION

select 1,2,3
union
select 1,2,4
union
select 1,2,5

--Uso de UNION ALL

select 1,2,3
union all
select 1,2,3
union all
select 1,2,3

select 1,2,3
union
select 1,2,3
union 
select 1,2,3

--6.1
--Incluye combinaciones repetidas
CREATE VIEW V_PERSONAS 
AS
select
t.nombre,
cp.numdoc,
cp.nombres,
cp.apellidos
from TipoDocumento t
inner join
(
select idtipo,numdoc,nombres, apellidos  from Persona
UNION ALL
select idtipo,numdoc,nombres, apellidos  from PersonaCarga
--select idtipo,numdoc,nombres,NULL  from PersonaCarga
) cp on t.idtipo=cp.idtipo

SELECT * FROM V_PERSONAS
--Incluye combinaciones irrepetibles
CREATE VIEW V_PERSONAS_IR
AS
select
t.nombre,
cp.numdoc,
cp.nombres,
cp.apellidos
from TipoDocumento t
inner join
(
select idtipo,numdoc,nombres, apellidos  from Persona
UNION
select idtipo,numdoc,nombres, apellidos  from PersonaCarga
) cp on t.idtipo=cp.idtipo

SELECT * FROM V_PERSONAS_IR

--C.Función de Valor Tabla
ALTER FUNCTION F_PERSONAS_R(@tipodoc int,@numdoc varchar(16)) returns table
AS
return
select
t.nombre,
cp.numdoc,
cp.nombres,
cp.apellidos
from TipoDocumento t
inner join
(
select idtipo,numdoc,nombres, apellidos  from Persona
UNION ALL
select idtipo,numdoc,nombres, apellidos  from PersonaCarga
) cp on t.idtipo=cp.idtipo
where cp.idtipo=@tipodoc and cp.numdoc=@numdoc


SELECT * FROM F_PERSONAS_R(1,'46173384')

--D  

CREATE FUNCTION F_PERSONAS_I() returns table
AS
return
select
t.nombre,
cp.numdoc,
cp.nombres,
cp.apellidos
from TipoDocumento t
inner join
(
select idtipo,numdoc,nombres, apellidos  from Persona
INTERSECT
select idtipo,numdoc,nombres, apellidos  from PersonaCarga
) cp on t.idtipo=cp.idtipo

SELECT * FROM F_PERSONAS_I()

--E
CREATE FUNCTION F_PERSONAS_E() returns table
AS
return
select
t.nombre,
cp.numdoc,
cp.nombres,
cp.apellidos
from TipoDocumento t
inner join
(
--Combinaciones en PersonaCarga pero no en Persona
select idtipo,numdoc,nombres, apellidos  from PersonaCarga
EXCEPT
select idtipo,numdoc,nombres, apellidos  from Persona
--Combinaciones en Persona pero no en PersonaCarga
--select idtipo,numdoc,nombres, apellidos  from Persona
--EXCEPT
--select idtipo,numdoc,nombres, apellidos  from PersonaCarga
) cp on t.idtipo=cp.idtipo

SELECT * FROM F_PERSONAS_E()


