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
order by m.nombre,f.numhabitantes ASC


