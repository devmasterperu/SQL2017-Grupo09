/* Tipo de Documento */


INSERT INTO TipoDocumento VALUES ('LIBRETA ELECTORAL O DNI')
go 
INSERT INTO TipoDocumento VALUES ('CARNET DE EXTRANJERIA')
go 
INSERT INTO TipoDocumento VALUES ('REG. UNICO DE CONTRIBUYENTES')
go 
INSERT INTO TipoDocumento VALUES ('PASAPORTE')
go 
INSERT INTO TipoDocumento VALUES ('PART. DE NACIMIENTO-IDENTIDAD')
go 
INSERT INTO TipoDocumento VALUES ('OTROS')
go 

--SELECT * FROM TipoDocumento
--Comando para modificar una tabla
--ALTER TABLE TipoDocumento ALTER COLUMN nombre varchar(40)

/*UBIGEO*/

insert into ubigeo values ('15','LIMA','08','HUAURA','01','HUACHO') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','02','AMBAR') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','03','CALETA DE CARQUIN') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','04','CHECRAS') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','05','HUALMAY') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','06','HUAURA') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','07','LEONCIO PRADO') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','08','PACCHO') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','09','SANTA LEONOR') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','10','SANTA MARÍA') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','11','SAYAN') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','12','VEGUETA') 
go


/*SECTORES*/
insert into sector values ('SECTOR_NOROESTE','-',1)
go
insert into sector values ('SECTOR_NORESTE','-',1)
go
insert into sector values ('SECTOR_SUROESTE','-',1)
go
insert into sector values ('SECTOR_SURESTE','-',1)
go

select * from sector
/*MANZANAS*/
insert into manzana(nombre,idsector,estado) values ('0001',1,0)
go
insert into manzana(nombre,idsector,estado) values ('0002',1,1)
go
insert into manzana(nombre,idsector,estado) values ('0003',1,1)
go
insert into manzana(nombre,idsector,estado) values ('0004',1,1)
go
insert into manzana(nombre,idsector,estado) values ('0005',2,1)
go
insert into manzana(nombre,idsector,estado) values ('0006',2,0)
go
insert into manzana(nombre,idsector,estado) values ('0007',2,1)
go
insert into manzana(nombre,idsector,estado) values ('0008',2,1)
go
insert into manzana(nombre,idsector,estado) values ('0009',3,1)
go
insert into manzana(nombre,idsector,estado) values ('0010',3,1)
go
insert into manzana(nombre,idsector,estado) values ('0011',3,1)
go
insert into manzana(nombre,idsector,estado) values ('0012',3,1)
go
insert into manzana(nombre,idsector,estado) values ('0013',4,1)
go
insert into manzana(nombre,idsector,estado) values ('0014',4,1)
go
insert into manzana(nombre,idsector,estado) values ('0015',4,0)
go
insert into manzana(nombre,idsector,estado) values ('0016',4,1)
go

select * from manzana

--Primeras consultas

SELECT idsector,count(idmanzana) as total --P5
from manzana --P1
where estado=1 --P2
--where count(idmanzana)>2
group by idsector --P3
having count(idmanzana)>2
--having total>2 --P4
order by total desc --P6

--Uso de operadores
declare @num1 int=100

declare @num2 int
set     @num2=150


select @num2+@num1 as suma,
	   @num2-@num1 as resta,
	   @num2*@num1 as multiplica,
	   @num2/@num1 as modulo,
	   @num2%@num1 as resto

--Concatenación
declare @num3 varchar(50)=100

declare @num4 varchar(50)
set     @num4=150

select @num4+@num3 as suma,
       CONCAT(@num4,@num3) as concatena2
	   --@num4-@num3 as resta,
	   --@num4*@num3 as multiplica,
	   --@num4/@num3 as modulo,
	   --@num4%@num3 as resto

--Uso de DISTINCT
select idsector from Manzana
select distinct idsector from Manzana

select coddepartamento,nomdepartamento from Ubigeo
select distinct coddepartamento,nomdepartamento from Ubigeo

--Uso de alias Tabla

select M.nombre, estado,idsector from Manzana as M --Forma 1
select M.nombre, estado,idsector from Manzana M --Forma 2
select [Mi M].nombre, estado,idsector from Manzana [Mi M] --Forma 3

--Uso de alias Columna

select M.nombre as nomManzana, estado,idsector from Manzana as M --Forma 1
select M.nombre nomManzana, estado,idsector from Manzana as M --Forma 2
select 'nomManzana'=M.nombre, estado,idsector from Manzana as M --Forma 3