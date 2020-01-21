--SEMANA 03

--3.1.a

select
s.nombre,m.nombre,m.estado
from Sector s CROSS JOIN Manzana m

--3.1.b

select
s.nombre,m.nombre,m.estado
from Sector s CROSS JOIN Manzana m
where m.estado=1

--3.1.c

select
s.nombre,m.nombre,m.estado
from Sector s CROSS JOIN Manzana m
where m.estado=1 and m.nombre like '001%'

select
Sector.nombre,Manzana.nombre,Manzana.estado
from Sector CROSS JOIN Manzana 
where Manzana.estado=1 and Manzana.nombre like '001%'

--3.2

select
p.idtipo as TIPO,
P.numdoc as NUMERO,
CONCAT(LTRIM(p.nombres),' ',LTRIM(p.apellidos)) as NOMBRE_COMPLETO,
u.nomdistrito as UBIGEO
from persona p inner join ubigeo u on p.idubigeo=u.idubigeo
where p.nombres LIKE '%JORGE%' OR p.apellidos LIKE '%CAMARGO%'

/* Incorrecto el campo de cruce
select
p.idtipo as TIPO,
P.numdoc as NUMERO,
CONCAT(LTRIM(p.nombres),' ',LTRIM(p.apellidos)) as NOMBRE_COMPLETO,
u.nomdistrito as UBIGEO
from persona p inner join ubigeo u on p.idpersona=u.idubigeo
*/

--3.3

select m.nombre as MANZANA,s.nombre as SECTOR,concat('ID manzana es ',m.idmanzana) as mensaje
from Manzana m inner join Sector s
on m.idsector=s.idsector
where m.estado=1

--3.4
--FECINICIO  FECFIN
--2020-01-01 2020-01-18
--20200101   20200118
--ISNULL(col,'-')
select
m.nombre as MANZANA,
p.nombres+' ' +p.apellidos as ENCUESTADOR,
a.idsupervisor as SUPERVISOR,
a.fecinicio as FECINICIO,
--a.fecfin,
--CONVERT(VARCHAR(8),ISNULL(FECFIN,GETDATE()),112) as FECFIN2,
CONVERT(DATE,GETDATE()) as FECFIN3
from Manzana m 
inner join Asignacion a on m.idmanzana=a.idmanzana
inner join Encuestador e on e.idencuestador=a.idencuestador
inner join Persona p on p.idpersona=e.idpersona
where 
--CONVERT(VARCHAR(8),FECINICIO,112)<=CONVERT(VARCHAR(8),GETDATE(),112)
--AND  CONVERT(VARCHAR(8),GETDATE(),112)<=CONVERT(VARCHAR(8),ISNULL(FECFIN,GETDATE()),112)
CONVERT(VARCHAR(8),GETDATE(),112) BETWEEN CONVERT(VARCHAR(8),FECINICIO,112) AND CONVERT(VARCHAR(8),ISNULL(FECFIN,GETDATE()),112)


--3.5
select m.nombre as MANZANA, 
t.nombre as NOM_TIPO_DOC_E,
p.numdoc as NUM_DOC_E,
CONCAT(LTRIM(p.nombres),' ',LTRIM(p.apellidos)) as ENCUESTADOR,
CONCAT(LTRIM(ps.nombres),' ',LTRIM(ps.apellidos)) as SUPERVISOR
from Manzana m
inner join Asignacion a on m.idmanzana=a.idmanzana
--Obtener datos personales de Encuestador
inner join Encuestador e on e.idencuestador=a.idencuestador
inner join Persona p on p.idpersona=e.idpersona
inner join TipoDocumento t on p.idtipo=t.idtipo
--Obtener datos personales de Supervisor
inner join Encuestador s on a.idsupervisor=s.idencuestador
inner join Persona ps on ps.idpersona=s.idpersona
where
CONVERT(VARCHAR(8),GETDATE(),112) BETWEEN CONVERT(VARCHAR(8),FECINICIO,112) AND CONVERT(VARCHAR(8),ISNULL(FECFIN,GETDATE()),112)

--3.6

select
e.usuario,
e.idencuestador,
ISNULL(a.idmanzana,0) AS IDMANZANA,
ISNULL(a.fecinicio,'9999-12-31') AS FECINICIO,
ISNULL(a.fecfin,'9999-12-31') AS FECFIN
from encuestador e left join asignacion a on e.idencuestador=a.idencuestador
where e.tipo='E' and e.estado=1
/*COMENTARIO*/
--asignacion a left join encuestador e on e.idencuestador=a.idencuestador
--Solo encuestadores con asignación
select
e.usuario,
e.idencuestador,
ISNULL(a.idmanzana,0) AS IDMANZANA,
ISNULL(a.fecinicio,'9999-12-31') AS FECINICIO,
ISNULL(a.fecfin,'9999-12-31') AS FECFIN
from encuestador e inner join asignacion a on e.idencuestador=a.idencuestador
where e.tipo='E' and e.estado=1

--3.7
select m.nombre as MANZANA, case when m.estado=1 then 'activo' else 'inactivo' end as ESTADO,
m.idsector,isnull(a.idencuestador,0) ID_ENCUESTADOR
from Manzana m
left join Asignacion a
on m.idmanzana=a.idmanzana

--3.8
select e.usuario,
		e.idencuestador,
		p.nombres + ' ' + p.apellidos as NOMBRES_COMPLETOS,
		ISNULL(a.idmanzana,0) AS IDMANZANA,
		ISNULL(a.fecinicio,'9999-12-31') AS FECINICIO,
		ISNULL(a.fecfin,'9999-12-31') AS FECFIN
from Encuestador e inner join persona p on e.idpersona = p.idpersona 
left join asignacion a on e.idencuestador = a.idencuestador
where e.tipo = 'E' and e.estado = 1