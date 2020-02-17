--6.3

create function F_RMANZANA() RETURNS TABLE
as
RETURN
select 
f.idficha,
f.numhabitantes,
m.nombre,
COUNT(1) OVER(PARTITION BY m.nombre) AS M_NUM_FICHAS,
SUM(numhabitantes) OVER(PARTITION BY m.nombre) AS M_TOTAL_HAB,
MAX(numhabitantes) OVER(PARTITION BY m.nombre) AS M_MAX_HAB,
MIN(numhabitantes) OVER(PARTITION BY m.nombre) AS M_MIN_HAB,
AVG(numhabitantes*1.00) OVER(PARTITION BY m.nombre) AS M_PROM_HAB
from Ficha f
join Manzana m on f.idmanzana=m.idmanzana

SELECT * FROM F_RMANZANA()

--6.4
CREATE VIEW V_REPORTE_E
AS
select 
f.idficha,
f.montopago,
CONCAT(p.nombres,' ' ,p.apellidos) as NOMENC,
COUNT(1) OVER(PARTITION BY e.idencuestador) as E_NUM_FICHAS,
SUM(montopago) OVER(PARTITION BY e.idencuestador) as E_TOT_MTOPAGO,
MAX(montopago) OVER(PARTITION BY e.idencuestador) as E_MAX_MTOPAGO,
MIN(montopago) OVER(PARTITION BY e.idencuestador) as E_MIN_MTOPAGO,
AVG(montopago) OVER(PARTITION BY e.idencuestador) as E_PROM_MTOPAGO
from Ficha f
join Encuestador e on f.idencuestador=e.idencuestador
join Persona p on e.idpersona=p.idpersona

select * from V_REPORTE_E

--6.5
create function F_R_MANZANA(@idmanzana int) returns table
return
select 
m.nombre as MANZANA,
f.idficha as IDFICHA,
f.numhabitantes as NUMHABITANTES,
ROW_NUMBER() OVER(PARTITION BY m.nombre ORDER BY f.numhabitantes ASC) as RN,--POSICIONES IRREPETIBLES
RANK() OVER(PARTITION BY m.nombre ORDER BY f.numhabitantes ASC) as RK,--POSICIONES REPETIBLES CON SALTOS DE POSICIÓN
DENSE_RANK() OVER(PARTITION BY m.nombre ORDER BY f.numhabitantes ASC) as DRK,--POSICIONES REPETIBLES SIN SALTOS DE POSICIÓN
NTILE(4) OVER(PARTITION BY m.nombre ORDER BY f.numhabitantes ASC) as NTILE4--DENTRO DE CADA MANZANA DIVIDIR EN 4 GRUPOS
from Ficha f
join Manzana m on f.idmanzana=m.idmanzana
where f.idmanzana=case when @idmanzana=0 then f.idmanzana else @idmanzana end
--order by m.nombre,f.numhabitantes ASC
SELECT * FROM F_R_MANZANA(0)
SELECT * FROM F_R_MANZANA(1)
SELECT * FROM F_R_MANZANA(2)

--6.6
CREATE FUNCTION F_R_TIPOCONSUMIDOR(@tipoconsumidor char(1)) returns table
as
return
select f.tipoconsumidor as TIPO_CONSUMIDOR,
f.idficha as ID_FICHA,
f.montopago as MTOPAGO,
ROW_NUMBER() OVER(PARTITION BY f.tipoconsumidor ORDER BY f.montopago DESC) AS RN,
RANK() OVER(PARTITION BY f.tipoconsumidor ORDER BY f.montopago DESC) AS RK,
DENSE_RANK() OVER(PARTITION BY f.tipoconsumidor ORDER BY f.montopago DESC) AS DRK,
NTILE(5) OVER(PARTITION BY f.tipoconsumidor ORDER BY f.montopago DESC) AS NTILE5,
NTILE(10) OVER(PARTITION BY f.tipoconsumidor ORDER BY f.montopago DESC) AS NTILE10,
NTILE(15) OVER(PARTITION BY f.tipoconsumidor ORDER BY f.montopago DESC) AS NTILE15
from Ficha f
where f.tipoconsumidor=case when @tipoconsumidor='T' then f.tipoconsumidor else @tipoconsumidor end
--order by f.tipoconsumidor,f.montopago DESC

select * from F_R_TIPOCONSUMIDOR('G')

