--SEMANA 02

--2.0
-- Progresión aritmética creciente
-- TN=T1+(N-1)*R

declare @t1 int=1
declare @n int=100
declare @r int=2

select 'TN'=@t1+(@n-1)*@r, @t1+(@n-1)*@r as TN2
--Progresion geométrica creciente
--TN=T1*R a la (N-1)
declare @t1_ bigint=1
declare @n_ bigint=10
declare @r_ bigint=2

select 'TN'=@t1_*power(@r_,@n_-1)


--2.1

--select * from Sector
select 
nombre,
--estado,
case when estado=0 then 'Manzana inactiva' else 'Manzana activa' end as estado,
--idsector,
case 
when idsector=1 then 'SECTOR_NOROESTE'
when idsector=2 then 'SECTOR_NORESTE'
when idsector=3 then 'SECTOR_SUROESTE'
when idsector=4 then 'SECTOR_SURESTE'
else '-' end as sector
from Manzana

--2.2

select nombre [sector],estado,
case when estado=1 then 'El sector '+nombre+' se encuentra ACTIVO'
else 'El sector '+nombre+' se encuentra INACTIVO' END
as mensaje,
case when estado=1 then CONCAT('El sector ',nombre,' se encuentra ACTIVO')
else CONCAT('El sector ',nombre,' se encuentra INACTIVO') END as mensaje2
from Sector

--2.3
--TIPO NUMERO NOMBRES APELLIDOS UBIGEO
--2.3.a
select idubigeo,nomdistrito from Ubigeo
select 'DNI' as TIPO,
numdoc,
LTRIM(nombres) as nombres,
apellidos,
idubigeo,
case 
when idubigeo=1	then 'HUACHO'
when idubigeo=2	then 'AMBAR'
when idubigeo=3 then 'CALETA DE CARQUIN'
when idubigeo=4 then 'CHECRAS'
when idubigeo=5	then 'HUALMAY'
when idubigeo=6	then 'HUAURA'
when idubigeo=7	then 'LEONCIO PRADO'
when idubigeo=8	then 'PACCHO'
when idubigeo=9	then 'SANTA LEONOR'
when idubigeo=10 then 'SANTA MARÍA'
when idubigeo=11 then 'SAYAN'
when idubigeo=12 then 'VEGUETA'
else '-' end as ubigeo
from Persona
where idtipo=1 --DNI
order by LTRIM(nombres) asc

--2.3.b
--2.3.a
select idubigeo,nomdistrito from Ubigeo
select 'DNI' as TIPO,
numdoc,
LTRIM(apellidos) as apellidos,
idubigeo,
case 
when idubigeo=1	then 'HUACHO'
when idubigeo=2	then 'AMBAR'
when idubigeo=3 then 'CALETA DE CARQUIN'
when idubigeo=4 then 'CHECRAS'
when idubigeo=5	then 'HUALMAY'
when idubigeo=6	then 'HUAURA'
when idubigeo=7	then 'LEONCIO PRADO'
when idubigeo=8	then 'PACCHO'
when idubigeo=9	then 'SANTA LEONOR'
when idubigeo=10 then 'SANTA MARÍA'
when idubigeo=11 then 'SAYAN'
when idubigeo=12 then 'VEGUETA'
else '-' end as ubigeo
from Persona
where idtipo=1 --DNI
order by LTRIM(apellidos) desc

--2.3.c

select 'DNI' as TIPO,
numdoc,
LTRIM(nombres) as nombres,
LTRIM(apellidos) as apellidos,
idubigeo,
case 
when idubigeo=1	then 'HUACHO'
when idubigeo=2	then 'AMBAR'
when idubigeo=3 then 'CALETA DE CARQUIN'
when idubigeo=4 then 'CHECRAS'
when idubigeo=5	then 'HUALMAY'
when idubigeo=6	then 'HUAURA'
when idubigeo=7	then 'LEONCIO PRADO'
when idubigeo=8	then 'PACCHO'
when idubigeo=9	then 'SANTA LEONOR'
when idubigeo=10 then 'SANTA MARÍA'
when idubigeo=11 then 'SAYAN'
when idubigeo=12 then 'VEGUETA'
else '-' end as ubigeo
from Persona
where idtipo=1 --DNI
order by LTRIM(nombres) asc,LTRIM(apellidos) desc,ubigeo

--2.3.d

select 'DNI' as TIPO,
numdoc,
LTRIM(nombres) as nombres,
apellidos,
idubigeo,
case 
when idubigeo=1	then 'HUACHO'
when idubigeo=2	then 'AMBAR'
when idubigeo=3 then 'CALETA DE CARQUIN'
when idubigeo=4 then 'CHECRAS'
when idubigeo=5	then 'HUALMAY'
when idubigeo=6	then 'HUAURA'
when idubigeo=7	then 'LEONCIO PRADO'
when idubigeo=8	then 'PACCHO'
when idubigeo=9	then 'SANTA LEONOR'
when idubigeo=10 then 'SANTA MARÍA'
when idubigeo=11 then 'SAYAN'
when idubigeo=12 then 'VEGUETA'
else '-' end as ubigeo,
fecnacimiento
from Persona
where idtipo=1 --DNI
order by fecnacimiento asc

--2.4 

--TIPO NUMERO NOMBRE COMPLETO DIRECCION UBIGEO
select idtipo as TIPO,
numdoc as NUMERO,
LTRIM(nombres) + ' '+LTRIM(apellidos) as [NOMBRE COMPLETO],
direccion,
case 
when idubigeo=1	then 'HUACHO' when idubigeo=2	then 'AMBAR'
when idubigeo=3 then 'CALETA DE CARQUIN' when idubigeo=4 then 'CHECRAS'
when idubigeo=5	then 'HUALMAY' when idubigeo=6	then 'HUAURA'
when idubigeo=7	then 'LEONCIO PRADO' when idubigeo=8	then 'PACCHO'
when idubigeo=9	then 'SANTA LEONOR' when idubigeo=10 then 'SANTA MARÍA' when idubigeo=11 then 'SAYAN'
when idubigeo=12 then 'VEGUETA'
else '-' end as ubigeo,
fecnacimiento
from Persona
--2.4.a Personas con valor de ubigeo 1,3 y 5.
--where idubigeo IN (1,3,5)
--2.4.b Personas con fecha de nacimiento entre el "01/01/1970 y el 31/12/1970.
--where fecnacimiento BETWEEN '1970-01-01' AND '1970-12-31'
--2.4.c Personas cuyo nombre completo inicie con “A”.
--where LTRIM(nombres) + ' '+LTRIM(apellidos) LIKE 'A%'
--2.4.d Personas cuyo nombre completo contenga la secuencia “ABA”.
--where  LTRIM(nombres) + ' '+LTRIM(apellidos) LIKE '%ABA%'
--2.4.e Personas cuyo nombre completo finalice en “AN”.
--where  LTRIM(nombres) + ' '+LTRIM(apellidos) LIKE '%AN'
--2.4.f Personas cuyo nombre completo inicie y finalice con “O”.
--where  LTRIM(nombres) + ' '+LTRIM(apellidos) LIKE 'O%O'
--2.4.g Personas cuyo nombre completo contenga la secuencia “ABA” desde la 2° posición.
--where  LTRIM(nombres) + ' '+LTRIM(apellidos) LIKE '_ABA%'
--begin tran
--update Persona
--set nombres='FABAS'
--where idpersona=2
--rollback
--2.4.h Personas cuyo antepenúltimo carácter del nombre completo sea “M”.
--where  LTRIM(nombres) + ' '+LTRIM(apellidos) LIKE '%M__'
--2.4.i Personas cuyo segundo y penúltimo carácter del nombre completo sea “E”.
--where  LTRIM(nombres) + ' '+LTRIM(apellidos) LIKE '_E%E_'
--2.4.j Personas cuyo nombre completo inicie y finalice con una vocal.
--where  LTRIM(nombres) + ' '+LTRIM(apellidos) LIKE '[aeiou]%[aeiou]'
--2.4.k Personas cuyo nombre completo inicie y finalice con una vocal.
--where  LTRIM(nombres) + ' '+LTRIM(apellidos) LIKE '[^aeiou]%[^aeiou]'
--2.4.l Personas cuyo nombre completo inicie con una vocal y finalice con una consonante.
--where  LTRIM(nombres) + ' '+LTRIM(apellidos) LIKE '[aeiou]%[^aeiou]'
select idtipo as TIPO,
numdoc as NUMERO,
LTRIM(nombres) + ' '+LTRIM(apellidos) as [NOMBRE COMPLETO],
direccion,
case 
when idubigeo=1	then 'HUACHO' when idubigeo=2	then 'AMBAR'
when idubigeo=3 then 'CALETA DE CARQUIN' when idubigeo=4 then 'CHECRAS'
when idubigeo=5	then 'HUALMAY' when idubigeo=6	then 'HUAURA'
when idubigeo=7	then 'LEONCIO PRADO' when idubigeo=8	then 'PACCHO'
when idubigeo=9	then 'SANTA LEONOR' when idubigeo=10 then 'SANTA MARÍA' when idubigeo=11 then 'SAYAN'
when idubigeo=12 then 'VEGUETA'
else '-' end as ubigeo,
fecnacimiento
from Persona
--2.4.m Personas cuya dirección inicie con “A” y sean del ubigeo “Leoncio Prado”,“Paccho”, “Santa Leonor” y “Santa María”.
--where direccion LIKE 'A%' AND idubigeo in (7,8,9,10)
--2.4.n Personas cuyo nombre completo inicie con “E” o sean del ubigeo “Paccho”,“Santa Leonor” y “Santa María”.
--where LTRIM(nombres) + ' '+LTRIM(apellidos) LIKE 'E%' OR idubigeo in (8,9,10)
--2.4.0 Personas cuya dirección inicie con “A” y sean del ubigeo “Leoncio Prado”,
--“Paccho”, “Santa Leonor” y “Santa María” Y nombre completo inicie con
--“E” o sean del ubigeo “Paccho”, “Santa Leonor” y “Santa María”.
--where 
--(direccion LIKE 'A%' AND idubigeo in (7,8,9,10))--P
--AND
--(LTRIM(nombres) + ' '+LTRIM(apellidos) LIKE 'E%' OR idubigeo in (8,9,10))--Q
--2.4.p Personas cuya dirección inicie con “A” y sean del ubigeo “Leoncio Prado”,
--“Paccho”, “Santa Leonor” y “Santa María” O nombre completo inicie con
--“E” o sean del ubigeo “Paccho”, “Santa Leonor” y “Santa María”.
--where 
--(direccion LIKE 'A%' AND idubigeo in (7,8,9,10))--P
--OR
--(LTRIM(nombres) + ' '+LTRIM(apellidos) LIKE 'E%' OR idubigeo in (8,9,10))--Q
--2.4.Q Personas cuya dirección NO cumpla la siguiente condición: Iniciar con “A”
--y sean del ubigeo “Leoncio Prado”, “Paccho”, “Santa Leonor” y “Santa
--María”.
where 
--NOT (direccion LIKE 'A%' AND idubigeo in (7,8,9,10))
direccion NOT LIKE 'A%' OR idubigeo not in (7,8,9,10)

--2.5 
select LTRIM(nombres) as nombre,count(idpersona) as numero
from persona
group by LTRIM(nombres)
order by count(idpersona) desc --610

select TOP 7 LTRIM(nombres) as nombre,count(idpersona) as numero
from persona
group by LTRIM(nombres)
order by count(idpersona) desc--7 resultados

select TOP 7 PERCENT LTRIM(nombres) as nombre,count(idpersona) as numero
from persona
group by LTRIM(nombres)
order by count(idpersona) desc--43 resultados

--2.6

select TOP 7 WITH TIES LTRIM(nombres) as nombre,count(idpersona) as numero
from persona
group by LTRIM(nombres)
order by count(idpersona) desc--10 resultados

select TOP 7 PERCENT WITH TIES  LTRIM(nombres) as nombre,count(idpersona) as numero
from persona
group by LTRIM(nombres)
order by count(idpersona) desc--52 resultados

--2.7

select TOP 2 idsector as sector,count(idmanzana) as manzanas,
CONCAT('El sector ',idsector,' tiene ',count(idmanzana),' manzanas') as mensaje
from Manzana 
where estado=1
group by idsector
order by count(idmanzana) desc--2 resultados

--2.8

select TOP 2 WITH TIES idsector as sector,count(idmanzana) as manzanas,
CONCAT('El sector ',idsector,' tiene ',count(idmanzana),' manzanas') as mensaje
from Manzana 
where estado=1
group by idsector
order by count(idmanzana) desc--4 resultados

select idsector as sector,count(idmanzana) as manzanas
from Manzana 
where estado=1
group by idsector
order by count(idmanzana) desc

--2.9
select  LTRIM(nombres) + ' '+LTRIM(apellidos) as [NOMBRE COMPLETO]
from persona
order by [NOMBRE COMPLETO]
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY

select  LTRIM(nombres) + ' '+LTRIM(apellidos) as [NOMBRE COMPLETO]
from persona
order by [NOMBRE COMPLETO]
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY

select  LTRIM(nombres) + ' '+LTRIM(apellidos) as [NOMBRE COMPLETO]
from persona
order by [NOMBRE COMPLETO]
OFFSET 20 ROWS
FETCH NEXT 10 ROWS ONLY


declare @tampag int=10 --Tamaño de Página 10
declare @numpag int=50 -- Número de Pagina 1

select  LTRIM(nombres) + ' '+LTRIM(apellidos) as [NOMBRE COMPLETO]
from persona
order by [NOMBRE COMPLETO]
OFFSET @tampag*(@numpag-1) ROWS
FETCH NEXT @tampag ROWS ONLY
