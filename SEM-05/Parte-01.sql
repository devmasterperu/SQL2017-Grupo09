
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
select * from Ficha
select count(1) from Ficha where idencuestador=2

--CE
SELECT
e.idencuestador,
e.usuario,
REPLACE(RTRIM(LTRIM(UPPER(p.nombres))),' ','_') as NOMBRES,--REPLACE(CAMPO O EXPRESION,QUE BUSCO,VALOR A COLOCAR)
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
