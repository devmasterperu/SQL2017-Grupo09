
--Tabla Izquierda
select * from Encuestador e 

--Tabla Derecha
select * from Asignacion a

--3.10
select 
ISNULL(e.usuario,'-') as USUARIO,
ISNULL(e.idpersona,'-') as [ID PERSONA 2],
case when e.idpersona is null then '-' else concat('P',e.idpersona) end as [ID PERSONA],
concat('E',a.idencuestador) as [ID ENCUESTADOR],
concat('M',a.idmanzana) as [ID MANZANA],
ISNULL(a.fecinicio,'9999-12-31') as [FECHA INICIO],
ISNULL(a.fecfin,'9999-12-31') as [FEC FIN]
from Encuestador e
right join Asignacion a on e.idencuestador=a.idencuestador

--3.11
select 
isnull(m.nombre,'-') manzana
, isnull(m.idsector,'0'),
a.idencuestador,
a.idmanzana,
ISNULL(a.fecinicio,'9999-12-31') as [FECHA INICIO],
ISNULL(a.fecfin,'9999-12-31') as [FEC FIN]
from Manzana M right join Asignacion A
on M.idmanzana=A.idmanzana

--3.12

select 
isnull(m.nombre,'-') manzana
, isnull(m.idsector,'0'),
a.idencuestador,
a.idmanzana,
ISNULL(a.fecinicio,'9999-12-31') as [FECHA INICIO],
ISNULL(a.fecfin,'9999-12-31') as [FEC FIN]
from Manzana M full outer join Asignacion A
on M.idmanzana=A.idmanzana