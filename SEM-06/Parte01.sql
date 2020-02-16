--5.11

--CI: Determinar el costo promedio
SELECT AVG(costo) from Ficha

--CE:

SELECT 
tipoconsumidor as TIPO,
concat(p.nombres,' ',p.apellidos) as CLIENTE,
f.costo as COSTO,
--69.35 as COSTOPROM
CAST(ROUND((SELECT AVG(costo) from Ficha),2) AS DECIMAL(4,2)) as COSTOPROM
FROM Ficha f 
join Cliente c on f.idcliente=c.idcliente
join Persona p on p.idpersona=c.idpersona
where costo<ROUND((SELECT AVG(costo) from Ficha),2)
order by COSTO

--5.12

--TOTAL FICHAS X ENCUESTADOR
--TOTAL PROMEDIO
--1. DETERMINAR TOTAL POR ENCUESTADOR
SELECT idencuestador,count(1) as total
FROM Ficha 
group by idencuestador
--2. DETERMINAR EL PROMEDIO
SELECT AVG(RE.total) FROM
(
	SELECT idencuestador,count(1) as total
	FROM Ficha 
	group by idencuestador
)RE

--SUBCONSULTAS
SELECT
idencuestador,
(select count(1) from Ficha f where f.idencuestador=e.idencuestador) as TOTFICHAS,--CI1
(
	SELECT AVG(RE.total) FROM
	(
		SELECT idencuestador,count(1) as total
		FROM Ficha 
		group by idencuestador
	)RE
) as TOTALPROM--CI2
FROM Encuestador e
WHERE 
(select count(1) from Ficha f where f.idencuestador=e.idencuestador)> 
(
	SELECT AVG(RE.total) FROM
	(
		SELECT idencuestador,count(1) as total
		FROM Ficha 
		group by idencuestador
	)RE
)
ORDER BY TOTFICHAS DESC

--CTE
WITH CTE_RE AS
(
	SELECT AVG(RE.total) as PROMEDIO 
	FROM
	(
		SELECT idencuestador,count(1) as total
		FROM Ficha 
		group by idencuestador
	)RE
), CTE_CE AS
(
	SELECT
	idencuestador,
	(select count(1) from Ficha f where f.idencuestador=e.idencuestador) as TOTFICHAS,--CI1
	(select PROMEDIO from CTE_RE) as TOTALPROM--CI2
	FROM Encuestador e
	WHERE 
	(select count(1) from Ficha f where f.idencuestador=e.idencuestador)> 
	(select PROMEDIO from CTE_RE)
)
SELECT * FROM CTE_CE
ORDER BY TOTFICHAS DESC

--VISTAS
CREATE VIEW dbo.V_RENCUESTADOR
AS
WITH CTE_RE AS
(
	SELECT AVG(RE.total) as PROMEDIO 
	FROM
	(
		SELECT idencuestador,count(1) as total
		FROM Ficha 
		group by idencuestador
	)RE
), CTE_CE AS
(
	SELECT
	idencuestador,
	(select count(1) from Ficha f where f.idencuestador=e.idencuestador) as TOTFICHAS,--CI1
	(select PROMEDIO from CTE_RE) as TOTALPROM--CI2
	FROM Encuestador e
	WHERE 
	(select count(1) from Ficha f where f.idencuestador=e.idencuestador)> 
	(select PROMEDIO from CTE_RE)
)
SELECT * FROM CTE_CE
--ORDER BY TOTFICHAS DESC

--Consultando la VISTA
SELECT * FROM dbo.V_RENCUESTADOR
ORDER BY TOTFICHAS DESC

--FUNCIONES DE VALOR TABLA

CREATE FUNCTION F_RENCUESTADOR(@idencuestador int) returns table
--ALTER FUNCTION F_RENCUESTADOR(@idencuestador int) returns table
as
return
	select count(1) as total 
	from Ficha f where f.idencuestador=@idencuestador

WITH CTE_RE AS
(
	SELECT AVG(RE.total) as PROMEDIO 
	FROM
	(
		SELECT idencuestador,count(1) as total
		FROM Ficha 
		group by idencuestador
	)RE
)--CTES

SELECT
idencuestador,
(select total from F_RENCUESTADOR(e.idencuestador)) as TOTFICHAS,--FUNCION DE VALOR TABLA
(select PROMEDIO from CTE_RE) as TOTALPROM--CTES
FROM Encuestador e
WHERE 
(select total from F_RENCUESTADOR(e.idencuestador))>(select PROMEDIO from CTE_RE)

CREATE FUNCTION F_RESENCUESTADORES() RETURNS TABLE
AS
RETURN
WITH CTE_RE AS
(
	SELECT AVG(RE.total) as PROMEDIO 
	FROM
	(
		SELECT idencuestador,count(1) as total
		FROM Ficha 
		group by idencuestador
	)RE
)--CTES

SELECT
idencuestador,
(select total from F_RENCUESTADOR(e.idencuestador)) as TOTFICHAS,--FUNCION DE VALOR TABLA
(select PROMEDIO from CTE_RE) as TOTALPROM--CTES
FROM Encuestador e
WHERE 
(select total from F_RENCUESTADOR(e.idencuestador))>(select PROMEDIO from CTE_RE)

SELECT * FROM  F_RESENCUESTADORES()

--5.13 

SELECT GETUTCDATE()

--5.14
--IN

SELECT usuario, 
       contrasena,
	   case when estado=1 then 'ACTIVO' ELSE 'INACTIVO' END as ESTADO, 
       EOMONTH(GETDATE()) AS CIERRE
FROM Encuestador
where tipo='E' and idencuestador in (select distinct idencuestador from ficha)