# Views en SQL

## Sintaxis básica
```sql
/*create view nombreVista
AS
select columnas
from tabla
where condicion
*/

use northwind;
go

-- Ejemplo de creación y modificación de vista
create or alter view VistaCategoriasTodas
AS
select CategoryID, CategoryName, [Description], picture
from Categories
where CategoryName = 'Beverages'
go

-- Eliminar vista
drop view VistaCategoriasTodas
go

-- Consultar vista
select * from VistaCategoriasTodas
where CategoryName = 'Beverages'
```
## Vista para clientes de México y Brazil
```sql
go
select * from vistaOedenesCompras

create or alter view vistaClientesLatinos
as
select * from Customers
where country in('MExico','Brazil')

-- Consulta usando la vista
select CompanyName as [Cliente],
City as [Ciudad], country as [Pais]
from vistaClientesLatinos
where city = 'Sao Paulo'
order by 2 desc

-- Join con vista
select * from
Orders as o
inner join vistaClientesLatinos as vcl
on vcl.CustomerID = o.CustomerID
```

## Vista compleja para órdenes de compra
```sql
create or alter view [dbo].[vistaordenescompra]
as
select o.OrderID as [numero Orden],
o.OrderDate as [Fecha de Orden],
o.RequiredDate as [Fecha de Requisici�n],
concat(e.FirstName, ' ', e.LastName) as [Nombre Empleado],
cu.CompanyName as [Nombre del Cliente],
p.ProductName as [Nombre Producto],
c.CategoryName as [Nombre de la Categoria],
od.UnitPrice as [Precio de Venta],
od.Quantity as [Cantidad Vendida],
(od.Quantity * od.UnitPrice) as [importe]
from  
Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join orders as o
on od.OrderID = o.OrderID
inner join Customers as cu
on cu.CustomerID = o.CustomerID
inner join Employees as e
on e.EmployeeID = o.EmployeeID

-- Consultas usando la vista
select count(distinct [numero Orden]) as [Numero de Ordenes]
from vistaordenescompra

select sum([Cantidad Vendida] * [Precio de Venta]) as [importe Total]
from vistaordenescompra
go

select sum(importe) as [importe Total]
from vistaordenescompra
where year([Fecha de Orden]) between '1995' and '1996'  
go
```
## Vista con agrupación
```sql
create or alter view vista_ordenes_1995_1996
as
select [Nombre del Cliente] as 'Nombre Cliente',
sum(importe) as [importe Total]
from vistaordenescompra
where year([Fecha de Orden])
between '1995' and '1996'  
group by [Nombre del Cliente]
having count(*)>2
```

## Creación de schema y vista asociada
```sql
create schema rh

create table rh.tablarh (
  id int primary key,
  nombre nvarchar(50)
)

-- Vista horizontal
create or alter view rh.viewcategoriasproductos
as
select c.CategoryID, CategoryName, p.ProductID, p.ProductName
from
Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID;
go

select * from rh.viewcategoriasproductos
```