
--SUBCONSULTAS EN LA PARTE DEL SELECT
--5.1
--El total de fichas.
select count(1) from Ficha
--El total de fichas con tipo de consumidor “G”.
select count(1) from Ficha where tipoconsumidor='G'
--El total de fichas con tipo de consumidor “M”.
select count(1) from Ficha where tipoconsumidor='M'
--El total de fichas con tipo de consumidor “P”.
select count(1) from Ficha where tipoconsumidor='P'

--CE
SELECT
(select count(1) from Ficha) as TOTAL, --CI
(select count(1) from Ficha where tipoconsumidor='G') [TOT-G], --CI
(select count(1) from Ficha where tipoconsumidor='M') [TOT-M], --CI
(select count(1) from Ficha where tipoconsumidor='P') [TOT-P]  --CI

--CE
SELECT
count(1) TOTAL, --ATRIBUTO
(select count(1) from Ficha where tipoconsumidor='G') [TOT-G], --CI
(select count(1) from Ficha where tipoconsumidor='M') [TOT-M], --CI
(select count(1) from Ficha where tipoconsumidor='P') [TOT-P]  --CI
FROM Ficha

--5.2
--CE
SELECT
(select count(1) from Encuestador) as TOT_E_S,--CI
(select count(1) from Encuestador where tipo='E') as TOT_E,--CI
(select count(1) from Encuestador where tipo='S') as TOT_S--CI

--5.3
--NOTAS:
--REPLACE(CAMPO O EXPRESION,VALOR_BUSQUEDA,VALOR_REEMPLAZO)
--UPPER(CAMPO O EXPRESION).Convierte a mayúscula.
--LOWER(CAMPO O EXPRESION).Convierte a minúscula.
--RTRIM(CAMPO O EXPRESION).Elimina espacios en blanco hacia la derecha.
--LTRIM(CAMPO O EXPRESION).Elimina espacios en blanco hacia la izquierda.
SELECT
e.idencuestador,
e.usuario,
REPLACE(RTRIM(LTRIM(UPPER(p.nombres))),' ','_') as NOMBRES,--
REPLACE(RTRIM(LTRIM(UPPER(p.apellidos))),' ','_') as APELLIDOS,
(SELECT COUNT(1) FROM Ficha WHERE idencuestador=e.idencuestador) as totfichas, --CI
--(SELECT COUNT(1) FROM Ficha WHERE idencuestador=11) as totfichas --CI
CASE 
WHEN (SELECT COUNT(1) FROM Ficha WHERE idencuestador=e.idencuestador) BETWEEN 1 AND 19 THEN 'Baja Productividad'
WHEN (SELECT COUNT(1) FROM Ficha WHERE idencuestador=e.idencuestador) BETWEEN 20 AND 29 THEN 'Mediana Productividad'
WHEN (SELECT COUNT(1) FROM Ficha WHERE idencuestador=e.idencuestador) >=30 THEN 'Alta Productividad'
ELSE 'Sin fichas'
END as Mensaje
FROM Encuestador e
INNER JOIN Persona p ON e.idpersona=p.idpersona
where e.tipo='E'

--5.4
--CE
select 
m.nombre as MANZANA,
(select count(1) from Ficha f where f.idmanzana=m.idmanzana) as TOTAL,--CI
case 
when (select count(1) from Ficha f where f.idmanzana=m.idmanzana)=0 then 'Sin recorrido'
when (select count(1) from Ficha f where f.idmanzana=m.idmanzana) between 1 and 59 then 'Manzana con poco recorrido'
when (select count(1) from Ficha f where f.idmanzana=m.idmanzana) between 60 and 99 then 'Manzana medianamente recorrido'
when (select count(1) from Ficha f where f.idmanzana=m.idmanzana)>=100 then 'Manzana con gran recorrido'
end as Mensaje
from Manzana m

--5.5
select
e.usuario,
(select count(1) from Ficha where idencuestador=e.idencuestador) as TOTAL_U,--CI1
(select count(1) from Ficha ) as TOTAL,--CI2
CAST(ROUND((select count(1) from Ficha where idencuestador=e.idencuestador)*100.00/(select count(1) from Ficha ),3)
AS DECIMAL(4,3))as PORCENTAJE
from Encuestador e
order by TOTAL_U desc

--5.6
select nombre,
(select COUNT(1) from Ficha where idmanzana=mm.idmanzana ) as TOTAL_M,--CI1
(select count(1) from Ficha ) as TOTAL,--CI2
CAST(ROUND((select count(1) from Ficha where idmanzana=mm.idmanzana)*100.00/(select count(1) from Ficha ),2)
AS DECIMAL(4,2))as PORCENTAJE
from Manzana mm

--5.7
--Obtener por idmanzana: total, maxmotpago,minmtopago,prompago

select
m.idmanzana as ID,
m.nombre as MANZANA,
ISNULL(rm.total,0) as TOTAL_FICHAS,
ISNULL(rm.maxpago,0) as MAXIMO_MTOPAGO,
ISNULL(rm.minpago,0) as MIN_MTOPAGO,
ISNULL(rm.prompago,0) as PROMPAGO
from Manzana m
left join
--CI
(
select idmanzana,count(1) as total,max(montopago)as maxpago,min(montopago) as minpago,avg(montopago) as prompago
from Ficha
group by idmanzana
) rm on m.idmanzana=rm.idmanzana

--5.8
--Con tabla derivada
--CI1
select
u.nomdepartamento,
u.nomprovincia,
u.nomdistrito,
ru.totpersonas as TOTAL,
ru.fecnacimientomax,
DAY(ru.fecnacimientomax) as DIA_NACIMIENTO,
MONTH(ru.fecnacimientomax) as MES_NACIMIENTO,
YEAR(ru.fecnacimientomax) as AÑO_NACIMIENTO
from ubigeo u
left join
(
select idubigeo,count(1) as totpersonas,max(fecnacimiento) as fecnacimientomax
from Persona
group by idubigeo
) ru on u.idubigeo=ru.idubigeo
--left join
--(
--select idubigeo,count(1) as totpersonas,max(fecnacimiento) as fecnacimientomax
--from Persona
--group by idubigeo
--) ru2 on u.idubigeo=ru2.idubigeo
--Con CTE

WITH CTE_RU
AS
(	select idubigeo,count(1) as totpersonas,max(fecnacimiento) as fecnacimientomax
	from Persona
	group by idubigeo
)
select
u.nomdepartamento,
u.nomprovincia,
u.nomdistrito,
ru.totpersonas as TOTAL,
ru.fecnacimientomax,
DAY(ru.fecnacimientomax) as DIA_NACIMIENTO,
MONTH(ru.fecnacimientomax) as MES_NACIMIENTO,
YEAR(ru.fecnacimientomax) as AÑO_NACIMIENTO
from ubigeo u
left join CTE_RU ru on u.idubigeo=ru.idubigeo
--left join CTE_RU ru2 on u.idubigeo=ru2.idubigeo
select * from CTE_RU