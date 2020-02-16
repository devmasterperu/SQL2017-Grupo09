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