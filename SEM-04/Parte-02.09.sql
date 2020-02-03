--04.09

begin tran
delete from UnidadUso
where idficha=100
rollback

--Validación de eliminación
select * from UnidadUso
where idficha=100

--04.10
begin tran
delete u
from  UnidadUso u
join  Ficha     f
on    u.idficha=f.idficha
where f.idencuestador=23
rollback

--Validación de eliminación
select u.*
from  UnidadUso u
join  Ficha     f
on    u.idficha=f.idficha
where f.idencuestador=23

--04.11

--Creación de tabla con idunidaduso eliminados
create table #eliminados
(
idunidaduso int 
)

--Eliminación de 5 de manera aleatoria
delete TOP(5) u
output deleted.idunidaduso into #eliminados
from  UnidadUso u
join  Ficha     f
on    u.idficha=f.idficha
join  Manzana m
on    f.idmanzana=m.idmanzana
where  m.idsector=1

--Validación de Eliminados
select u.*
from  UnidadUso u
join  Ficha     f
on    u.idficha=f.idficha
join  Manzana m
on    f.idmanzana=m.idmanzana
where  m.idsector=1 and u.idunidaduso=5

--Consulta de Unidades de Uso eliminadas
select * from #eliminados

--4.13

--Consulta de Persona con Id 101
select * from Persona
where idpersona=101

--Creación de tabla Temporal con
--Dirección y FecNacimiento anterior y nueva
create table #modificados(
direccionant varchar(200),
direccionnueva varchar(200),
fecnacimientoant date,
fecnacimientonueva date
)

--Creación de tabla Temporal con
--Dirección, fecnacimiento y sexo anterior y nueva
create table #modificados2(
direccionant varchar(200),
direccionnueva varchar(200),
fecnacimientoant date,
fecnacimientonueva date,
sexoant char(1),
sexonuevo char(1)
)

--Actualización y guardado de información
begin tran
UPDATE p
set   p.idubigeo=3,
      p.direccion='URB. LOS CIPRESES M-24',
	  p.numdoc='22064382',
	  sexo='F',
	  fecnacimiento='1969-04-10'
output deleted.direccion,--Antigua dirección
       inserted.direccion,--Nueva dirección
	   deleted.fecnacimiento,--Antigua Fecnacimiento
	   inserted.fecnacimiento,--Nueva Fecnacimiento
	   deleted.sexo,
	   inserted.sexo
into  #modificados2
from Persona p
where idpersona=101
rollback

--Consulta de modificados
select * from #modificados2

--4.14

--Crear la columna Costo.
alter table Ficha add costo decimal(5,2)

--Calcular el costo para todas las fichas.
update f
set    f.costo=10.00+f.numhabitantes* 20.00
from   ficha f

--Mostrar reporte

select 
c.idcliente,
p.nombres+' '+p.apellidos as NOMBRE_COMPLETO,
f.montopago as MONTO_PAGO,
f.idficha,
f.costo as COSTO,
case when f.montopago>=f.costo then 'Cliente genera ganancia'
else 'Cliente genera pérdida' end as mensaje
from ficha f 
join cliente c on f.idcliente=c.idcliente
join persona p on c.idpersona=p.idpersona

