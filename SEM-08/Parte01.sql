--8.1

ALTER PROCEDURE USP_INSMANZANA(@nombre varchar(5),@estado bit,@idsector int)
as
begin try
	declare @idmanzana int, @mensaje varchar(300)
	if exists (select 1 from Manzana where nombre=@nombre)--Si  nombre de manzana ya existe
	begin
		--set @mensaje='Manzana con nombre existente'
		--set @idmanzana=0

		--raiserror ('Manzana con nombre existente',16,1)
		raiserror (50100,16,1)
	end
	else--Si nombre de manzana no existe
	begin
		insert into Manzana values (@nombre,@estado,@idsector)
		set @mensaje='Manzana insertada'
		set @idmanzana=IDENT_CURRENT('Manzana')
	end

	select @mensaje as MENSAJE,@idmanzana as IDMANZANA
end try
begin catch
	SELECT
	ERROR_NUMBER() AS ERRNUM,
	ERROR_MESSAGE() AS ERRMSG,
	ERROR_SEVERITY() AS ERRSEV,
	ERROR_PROCEDURE() AS ERRPROC,
	ERROR_LINE() AS ERRLINE;
end catch

--VALIDACIONES
--OK-1° Ejecución
 EXECUTE USP_INSMANZANA  @nombre='9999',@estado=1,@idsector=4
 --NO_OK - 2° Ejecución
 EXECUTE USP_INSMANZANA  @nombre='9999',@estado=1,@idsector=4
 --NO_OK - 3° Ejecución
 EXECUTE USP_INSMANZANA  @nombre='9998',@estado=1,@idsector=5
 --Incluir código de error 50100
 exec sp_addmessage @msgnum=50100,@severity=16,
 @msgtext='Manzana con nombre existente',@lang='us_english'

 select * from sys.sysmessages
 where error=50100
 --NO_OK - 4° Ejecución
 EXECUTE USP_INSMANZANA  @nombre='9998',@estado=1,@idsector=4

 --8.3
 create procedure USP_ACTUALIZA_ASIGNA(@idencuestador int, @idmanzana int,
@fecinicio date,@fecfin date,@idsupervisor int)
as
begin try
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
		--set @menasignación='Asignación no identificada'
		THROW 50030,'Asignación no identificada',1;
	end

	select @menasignación as MENSAJE,@idencuestador as IDENCUESTADOR, @idmanzana as IDMANZANA
	
end try
begin catch
	SELECT
	ERROR_NUMBER() AS ERRNUM,
	ERROR_MESSAGE() AS ERRMSG,
	ERROR_SEVERITY() AS ERRSEV,
	ERROR_PROCEDURE() AS ERRPROC,
	ERROR_LINE() AS ERRLINE;
end catch

--Con una asignación y supervisor existente.
select * from Asignacion
where idencuestador=13 and idmanzana=2

execute USP_ACTUALIZA_ASIGNA @idencuestador=13, @idmanzana=2,
@fecinicio='2020-04-01',@fecfin='2020-12-31',@idsupervisor=4

-- Con una asignación NO existente.
execute USP_ACTUALIZA_ASIGNA @idencuestador=99, @idmanzana=9,
@fecinicio='2020-04-01',@fecfin='2020-12-31',@idsupervisor=4

-- Con una asignación existente y supervisor NO existente.
execute USP_ACTUALIZA_ASIGNA @idencuestador=13, @idmanzana=2,
@fecinicio='2020-04-01',@fecfin='2020-12-31',@idsupervisor=999


--8.6
alter procedure USP_INS_FICHA(
@idcliente int, 
@idmanzana int, 
@idencuestador int,
@tipoconsumidor char(1), 
@numhabitantes int,
@estado bit)
as
begin try
	begin transaction --Inicio de transacción
	--Operacion 01
	insert into Ficha(idcliente,idmanzana,idencuestador,tipoconsumidor,numhabitantes,estado)
	values (@idcliente,@idmanzana,@idencuestador,@tipoconsumidor,@numhabitantes,@estado);

	throw 50060,'Error inesperado',1--Sólo para pruebas.
	--Operación 02
	update e
	set    e.numfichas=(select count(1) from Ficha where idencuestador=@idencuestador)
	from   Encuestador e
	where  e.idencuestador=@idencuestador
	
	commit transaction --Pasar de borrador a limpio (Permanente)
end try
begin catch
	rollback transaction
	SELECT
	ERROR_NUMBER() AS ERRNUM,
	ERROR_MESSAGE() AS ERRMSG,
	ERROR_SEVERITY() AS ERRSEV,
	ERROR_PROCEDURE() AS ERRPROC,
	ERROR_LINE() AS ERRLINE;
end catch



/*
begin tran
delete from UnidadUso

select * from UnidadUso
rollback

delete from UnidadUso
where idunidaduso>=995
*/
select * from Encuestador
execute USP_INS_FICHA @idcliente=950, @idmanzana=4, @idencuestador=13,
@tipoconsumidor='G', @numhabitantes=10, @estado=1

--Validación OK
select * from Ficha where idencuestador=13 and idmanzana=4 and idcliente=950
select count(1) from Ficha where idencuestador=13 
select * from Encuestador where idencuestador=13

execute USP_INS_FICHA @idcliente=949, @idmanzana=4, @idencuestador=13,
@tipoconsumidor='G', @numhabitantes=10, @estado=1

select * from Ficha where idencuestador=13 and idmanzana=4 and idcliente=949
