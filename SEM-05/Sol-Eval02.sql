 --1#
 Select 
m.nombre as M,
p.nombres+ ' '+p.apellidos as 'ENCUESTADOR',
p2.nombres+' '+p2.apellidos SUPERVISOR,
fecinicio as 'FECHA INICIO',
ISNULL(fecfin,GETDATE()) as 'FECHA FIN'
from Asignacion a
inner join Encuestador e
on a.idencuestador=e.idencuestador
inner join Manzana m
on m.idmanzana=a.idmanzana
inner join Persona p
on p.idpersona=e.idpersona
inner join Encuestador s
on s.idencuestador=a.idsupervisor
inner join Persona p2
on p2.idpersona=s.idpersona
order by m.nombre asc,ENCUESTADOR asc
offset 10 rows fetch next 10 rows only

 --1##
 Select 
m.nombre as M,
p.nombres+ ' '+p.apellidos as 'ENCUESTADOR',
p2.nombres+' '+p2.apellidos SUPERVISOR,
fecinicio as 'FECHA INICIO',
ISNULL(fecfin,GETDATE()) as 'FECHA FIN'
from Asignacion a
inner join Encuestador e
on a.idencuestador=e.idencuestador
inner join Manzana m
on m.idmanzana=a.idmanzana
inner join Persona p
on p.idpersona=e.idpersona
inner join Encuestador s
on s.idencuestador=a.idsupervisor
inner join Persona p2
on p2.idpersona=s.idpersona
order by m.nombre asc,ENCUESTADOR asc
offset 20 rows fetch next 10 rows only

 --2#
 --Tabla temporal para guardar eliminados
 create table #Asignacion_Eliminada
 (
 idencuestador int,
 idmanzanza    int
 )
 --Eliminación aleatoria de 10 asignaciones
 begin tran
 delete TOP(10) a
 output deleted.idencuestador,deleted.idmanzana INTO #Asignacion_Eliminada
 from Asignacion a 
 inner join Encuestador e on a.idencuestador=e.idencuestador
 inner join Persona p on e.idpersona=p.idpersona
 inner join Ubigeo u on p.idubigeo=u.idubigeo
 where u.nomdistrito='HUACHO'
 rollback
 --Consulta de eliminados
 select * from #Asignacion_Eliminada

 --2##
 
 --Tabla temporal para guardar eliminados
 create table #Asignacion_Eliminada
 (
 idencuestador int,
 idmanzanza    int
 )
 --Eliminación aleatoria de 5 asignaciones
 begin tran
 delete TOP(5) a
 output deleted.idencuestador,deleted.idmanzana INTO #Asignacion_Eliminada
 from Asignacion a 
 inner join Encuestador e on a.idencuestador=e.idencuestador
 inner join Persona p on e.idpersona=p.idpersona
 inner join Ubigeo u on p.idubigeo=u.idubigeo
 where u.nomdistrito='HUACHO'
 rollback
 --Consulta de eliminados
 select * from #Asignacion_Eliminada

 --3#
 begin tran
update a
set a.fecinicio='2020-02-01',
	a.fecfin='2020-12-31',
	a.idsupervisor=5
from Asignacion a
where a.idencuestador=11 and a.idmanzana=2
rollback

--4#
begin tran
update f
set f.costo=5.00+(f.numhabitantes*10.00)
from Ficha f
where f.tipoconsumidor='P'
rollback

begin tran
update f
set f.costo=10.00+(f.numhabitantes*15.00)
from Ficha f
where f.tipoconsumidor='M'
rollback

begin tran
update f
set f.costo=15.00+(f.numhabitantes*20.00)
from Ficha f
where f.tipoconsumidor='G'
rollback

select
concat(ltrim(p.nombres),' ',ltrim(p.apellidos)) as [NOMBRE COMPLETO],
f.tipoconsumidor as [TIPO CONSUMIDOR],
f.numhabitantes as [N° HABITANTES],
f.montopago as [MONTO PAGO],
f.costo as [COSTO CALCULADO],
case when f.montopago > f.costo then 'GANANCIA'
	 when f.montopago < f.costo then 'PERDIDA'
	 else 'NEUTRO'
end as MENSAJE
from Ficha f
join Cliente c on f.idcliente=c.idcliente
join Persona p on c.idpersona=p.idpersona


