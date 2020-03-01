--SOLUCIONARO 3° EXAMEN

--1
CREATE FUNCTION FN_TOTALES() RETURNS TABLE
AS
RETURN
SELECT
--TOT-CLI
(select count(1) from Cliente) AS [TOT-CLI],
--TOT-CLI-Z3
(select count(1) from Cliente c join Zona z on c.idzona=z.idzona
where z.nombre='Cipreses-Z3') AS [TOT-CLI-Z3],
--TOT-CLI-Z6
(select count(1)
from Cliente c join Zona z on c.idzona=z.idzona
where z.nombre='Cipreses-Z6') AS [TOT-CLI-Z6],
--TOT-CLI-Z9
(select count(1) from Cliente c join Zona z on c.idzona=z.idzona
where z.nombre='Cipreses-Z9') AS [TOT-CLI-Z9]

select * from FN_TOTALES()

--2
create view V_REPORTE_EMPRESA 
AS
select
razonsocial as EMPRESA,
numdoc as RUC,
direccion as DIRECCION,
(select count(1) from Telefono t where t.estado=1 and t.idcliente=c.idcliente) as [TOT-TELEFONOS-CLI],
(select count(1) from Telefono t where t.estado=1) as [TOT-TELEFONOS] 
from Cliente c
where tipocliente=2

select * from V_REPORTE_EMPRESA
--4
alter function F_REPORTE_SMS(@Mensaje varchar(300)) returns table
return
	select 
	numero,
	--'Hola, no olvide realizar el pago de su servicio de Internet' as MENSAJE
	@Mensaje as MENSAJE
	from Telefono
	where estado=1 and tipo='SMS'

	select * from F_REPORTE_SMS('Hola, no olvide realizar el pago de su servicio de Internet')
	select * from F_REPORTE_SMS('Hola, el último día de pago es el 31/03')
	select * from F_REPORTE_SMS('')

--5

WITH CTE_TEL_INC AS
(
select tipo,numero,idcliente from dbo.Telefono where estado=1--Sistemas
except
select tipo,numero,idcliente from comercial.Telefono where estado=1--Comercial
)
select 'Teléfono inconsistente' as MENSAJE,* from CTE_TEL_INC

--3
create view V_RPORTE_CLIENTES 
as
select 
case when tipocliente=1 then 'PERSONA' else 'EMPRESA' end as TIPO_CLIENTE,
case when tipocliente=1 then CONCAT(c.nombres,' ',c.apellidopat,' ',c.apellidomat)
else razonsocial end as CLIENTE,
c.direccion,
co.feccontrato,
ROW_NUMBER() OVER(PARTITION BY tipocliente ORDER BY feccontrato ASC) as RK1,
RANK() OVER(PARTITION BY tipocliente ORDER BY feccontrato ASC) as RK2,
DENSE_RANK() OVER(PARTITION BY tipocliente ORDER BY feccontrato ASC) as RK3,
NTILE(4) OVER(PARTITION BY tipocliente ORDER BY feccontrato ASC) as RK4
from Cliente c
join Contrato co on c.idcliente=co.idcliente

select * from V_RPORTE_CLIENTES





