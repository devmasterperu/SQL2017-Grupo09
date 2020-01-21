--PREGUNTA 01

declare @X1 INT=10

select 'F(X)'=2*POWER(@X1,2)+3*@X1+1

declare @X2 INT=20

select 'F(X)'=2*POWER(@X2,2)+3*@X2+1

declare @X3 INT=30

select 'F(X)'=2*POWER(@X3,2)+3*@X3+1

--PREGUNTA 02

--2.1
--a
select ciiu,descripcion from produccion.tbActividadEconomica
where (descripcion NOT LIKE '%CULTIVO%' AND descripcion NOT LIKE '%PESCA%') OR ciiu LIKE '01%'
order by ciiu desc

select ciiu,descripcion from produccion.tbActividadEconomica
where NOT(descripcion LIKE '%CULTIVO%' or descripcion LIKE '%PESCA%') OR ciiu LIKE '01%'
order by ciiu desc

--b
select ciiu,descripcion from produccion.tbActividadEconomica
where (descripcion NOT LIKE '%CULTIVO%' AND descripcion NOT LIKE '%PESCA%') OR ciiu LIKE '02%'
order by ciiu desc

select ciiu,descripcion from produccion.tbActividadEconomica
where NOT(descripcion LIKE '%CULTIVO%' or descripcion LIKE '%PESCA%') OR ciiu LIKE '02%'
order by ciiu desc

--c
select ciiu,descripcion from produccion.tbActividadEconomica
where (descripcion NOT LIKE '%CULTIVO%' AND descripcion NOT LIKE '%PESCA%') OR ciiu LIKE '03%'
order by ciiu desc

select ciiu,descripcion from produccion.tbActividadEconomica
where NOT (descripcion LIKE '%CULTIVO%' or descripcion LIKE '%PESCA%') OR ciiu LIKE '03%'
order by ciiu desc

--2.2
--a
select ciiu,descripcion from produccion.tbActividadEconomica
where ciiu LIKE '%11'
order by descripcion asc
offset 5 rows 
fetch next 5 rows only

--b
select ciiu,descripcion from produccion.tbActividadEconomica
where ciiu LIKE '%11'
order by descripcion asc
offset 10 rows 
fetch next 5 rows only

--c
select ciiu,descripcion from produccion.tbActividadEconomica
where ciiu LIKE '%11'
order by descripcion asc
offset 15 rows 
fetch next 5 rows only


--2.3

--a
select TOP 6 idemprendimiento,count(ciiu) as total from produccion.tbEmprendimientoActividad
group by idemprendimiento
--order by total desc
order by count(ciiu) desc

--b
select TOP 6 WITH TIES idemprendimiento,count(ciiu) as total from produccion.tbEmprendimientoActividad
group by idemprendimiento
--order by total desc
order by count(ciiu) desc

--c
select TOP 10 PERCENT idemprendimiento,count(ciiu) as total from produccion.tbEmprendimientoActividad
group by idemprendimiento
--order by total desc
order by count(ciiu) desc


