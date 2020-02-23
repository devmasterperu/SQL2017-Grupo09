--6.8

select
idsector as IDSECTOR,
nombre as MANZANA,
rm.total as TOTAL,
ROW_NUMBER() OVER(PARTITION BY m.idsector ORDER BY rm.total DESC) AS RN,
--LAG(COLUMNA,TOTPOSICIONES,VALOR_DEFECTO)
LAG(rm.total,1,0) OVER(PARTITION BY m.idsector ORDER BY rm.total DESC) AS LAG,
LEAD(rm.total,1,0) OVER(PARTITION BY m.idsector ORDER BY rm.total DESC) AS LEAD,
FIRST_VALUE(rm.total) OVER(PARTITION BY m.idsector ORDER BY rm.total DESC) AS FV,
LAST_VALUE(rm.total) OVER(PARTITION BY m.idsector ORDER BY rm.total DESC) AS LV
from Manzana m
left join
(
	select idmanzana,count(1) as total
	from   ficha
	group by idmanzana
) rm on m.idmanzana=rm.idmanzana
where rm.total>0