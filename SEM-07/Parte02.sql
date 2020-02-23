--7.1 PA
--A
CREATE PROCEDURE USP_PROGRESION_A(@t1 int,@n int,@r int)
--ALTER PROCEDURE USP_PROGRESION_A(@t1 int,@n int,@r int)
--DROP PROCEDURE USP_PROGRESION_A
as
begin
	select 'TERN'=@t1+(@n-1)*@r
end

exec USP_PROGRESION_A 1,100,1
execute USP_PROGRESION_A 1,100,1
execute USP_PROGRESION_A @t1=1,@n=100,@r=1

sp_helptext 'USP_PROGRESION_A'--Ver definición de procedimiento

--B
CREATE FUNCTION F_PROGRESION_A(@t1 int,@n int,@r int) RETURNS TABLE
--ALTER PROCEDURE USP_PROGRESION_A(@t1 int,@n int,@r int)
--DROP PROCEDURE USP_PROGRESION_A
as
return
	select 'TERN'=@t1+(@n-1)*@r

select TERN from F_PROGRESION_A(1,100,1)

--C
--CREATE FUNCTION FE_PROGRESION(@t1 int,@n int,@r int) RETURNS INT
ALTER FUNCTION FE_PROGRESION(@t1 int,@n int,@r int) RETURNS INT
as
begin
	declare @tn int= (select @t1+(@n-1)*@r)
	return @tn

	--return (select @t1+(@n-1)*@r as TN) 
end

SELECT dbo.FE_PROGRESION(1,100,1) as TN

--7.3
--A: Cantidad páginas
CREATE FUNCTION F_NUM_PAGINAS(@tampag int) returns int
as
begin
	declare @resto int=(select count(1) from Persona)%@tampag --3

	declare @totpag int=(select case when @resto>0 then (select count(1) from Persona)/@tampag+1
								else (select count(1) from Persona)/@tampag end)

	return @totpag

end
select count(1) from Persona--1003
select dbo.F_NUM_PAGINAS(10)

SELECT CAST(ROUND(91*1.00/10,0) AS INTEGER)
SELECT 5%2

select dbo.F_NUM_PAGINAS(1003)
--PROCEDIMIENTO ALMACENADO
ALTER PROCEDURE USP_NUM_PAGINAS(@tampag int) 
as
begin
	declare @resto int=(select count(1) from Persona)%@tampag --3
	declare @totpag int

	IF @resto>0
	begin
		set @totpag=(select count(1) from Persona)/@tampag+1
	end
	else
	begin
		set @totpag=(select count(1) from Persona)/@tampag
	end

	select @totpag as TOTPAG
end

EXECUTE USP_NUM_PAGINAS 10

--B
create procedure USP_REP_PERSONAS(@tampag int, @numpag int)
as
begin
	select  
	ROW_NUMBER() OVER(ORDER BY LTRIM(nombres) + ' '+LTRIM(apellidos)) as POSICION,
	LTRIM(nombres) + ' '+LTRIM(apellidos) as [NOMBRE COMPLETO]
	from persona
	order by [NOMBRE COMPLETO]
	OFFSET @tampag*(@numpag-1) ROWS
	FETCH NEXT @tampag ROWS ONLY
end

EXEC USP_REP_PERSONAS 10,2--Traer las personas de la página 2 con una longitud de página 10.
EXEC USP_REP_PERSONAS 10,3--Traer las personas de la posición 21 a la 30.

--7.4
CREATE PROCEDURE USP_DETALLE_FICHA(@idficha int)
as
begin
	 --CABECERA
	 --Parametros
	 SELECT
	 (select valor from Parametro where variable='RAZON_SOCIAL') AS RAZON_SOCIAL,
	 (select valor from Parametro where variable='RUC') AS RUC_EMPRESA,
	 (select GETDATE()) AS CONSULTA_AL
	 --Datos del cliente
	 select CONCAT(p.nombres,' ', p.apellidos) as NOMBRE_COMPLETO,
			p.direccion as DIRECCION,
			f.montopago as MONTO_PAGO
	 from ficha f
	 join cliente c on f.idcliente=c.idcliente
	 join persona p on p.idpersona=c.idpersona
	 where idficha=@idficha
	 --Unidades de Uso
	 select ROW_NUMBER() OVER (ORDER BY idunidaduso asc) as #UNIDAD,
			descripcion,
			categoria 
	 from   UnidadUso
	 where idficha=@idficha
end

EXECUTE USP_DETALLE_FICHA 11

--7.5
CREATE PROCEDURE USP_INSMANZANA(@nombre varchar(5),@estado bit,@idsector int)
as
begin
	declare @idmanzana int, @mensaje varchar(300)
	if exists (select 1 from Manzana where nombre=@nombre)--Si  nombre de manzana ya existe
	begin
		set @mensaje='Manzana con nombre existente'
		set @idmanzana=0
	end
	else--Si nombre de manzana no existe
	begin
		insert into Manzana values (@nombre,@estado,@idsector)
		set @mensaje='Manzana insertada'
		set @idmanzana=IDENT_CURRENT('Manzana')
	end

	select @mensaje as MENSAJE,@idmanzana as IDMANZANA
end

select IDENT_CURRENT('Manzana')

EXECUTE USP_INSMANZANA '0202',1,1

--7.7

create procedure USP_ACTUALIZA_ASIGNA(@idencuestador int, @idmanzana int,
@fecinicio date,@fecfin date,@idsupervisor int)
as
begin 
	declare @menasignación varchar(300)
	--Si asignación existe
	if exists(select 1 from Asignacion where idencuestador=@idencuestador and idmanzana=@idmanzana)
	begin
		update a
			set a.fecinicio=@fecinicio,
				a.fecfin=@fecfin,
				a.idsupervisor=@idsupervisor
		from Asignacion a
		where a.idencuestador=@idencuestador and a.idmanzana=@idmanzana

		set @menasignación='Asignación actualizada'
	end
	else
	begin
		set @menasignación='Asignación no identificada'
	end

	select @menasignación as MENSAJE,@idencuestador as IDENCUESTADOR, @idmanzana as IDMANZANA
	
end

select * from Asignacion

--12	2	2020-01-19	1	NULL
--OK
EXECUTE USP_ACTUALIZA_ASIGNA @idencuestador=12, @idmanzana=2,
@fecinicio='2020-04-01',@fecfin='2020-12-31',@idsupervisor=5

--NO_OK
EXECUTE USP_ACTUALIZA_ASIGNA @idencuestador=0, @idmanzana=2,
@fecinicio='2020-04-01',@fecfin='2020-12-31',@idsupervisor=5

--7.9
CREATE PROCEDURE USP_DELUNIDAD(@idunidaduso int)
as
begin
	
	declare @meneliminacion varchar(300)
	--Si unidad de uso existe
	if exists(select 1 from UnidadUso where idunidaduso=@idunidaduso)
	begin
		delete u
		from   UnidadUso u
		where  u.idunidaduso=@idunidaduso

		set @meneliminacion='Unidad de uso eliminada'
	end
	else
	begin
		set @meneliminacion='Unidad de uso no eliminada'
		set @idunidaduso=0
	end

	select @meneliminacion as MENSAJE,@idunidaduso as IDUNIDADUSO

end

EXECUTE USP_DELUNIDAD 3000

select * from UnidadUso where idunidaduso=7