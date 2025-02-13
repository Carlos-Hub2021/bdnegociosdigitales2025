
use TiendaVideoJuegos

use Northwind

select * from Categories as C
inner join Products as p			-- esto consuta dos tablas
on C.CategoryID = P.CategoryID;


select 
C.CategoryID,
CategoryName,
ProductName,
UnitPrice,								
UnitsInStock
from Categories as C
inner join Products as p			
on C.CategoryID = P.CategoryID;



select 
C.CategoryID,
CategoryName,
ProductName,
UnitPrice,								
UnitsInStock
from Categories as C
inner join Products as p			
on C.CategoryID = P.CategoryID;


select 
C.CategoryID as 'Numero de categoria',
CategoryName as 'Nombre de categoria',
ProductName as 'Nombre de Producto',
UnitPrice as Precio,								
UnitsInStock as Existencia
from Categories as C
inner join Products as p			
on C.CategoryID = P.CategoryID;


-- seleccionar los productos de la categoria beverages y condiments donde
-- la existencia esta en 18 y 30

select *
from  Products as P
 join Categories as C
on P.CategoryID = c.CategoryID;
where C.CategoryName in ('Beverages', 'Condiments') 
and P.UnitsInStock between '18' and '30'


--	seleccionar  los productos y sus impotes realizados de marso a junio de 
-- de 1996 mostrando la fecha de la orden id producto y inporte

select 
o.OrderID, o.OrderDate, od.ProductID, 
(od.UnitPrice * od.Quantity) as Importe
from Orders as O
join [Order Details] as Od
on od.OrderID = o.OrderID
where o.OrderDate between '1996-07-01' and '1996-10-31'

--	Mostrar el inporte total de ventas de la consuta anterior

select 
sum (od.Quantity * od.UnitPrice) as [Inporte de ventas]
from Orders as O
join [Order Details] as Od
on od.OrderID = o.OrderID
where o.OrderDate between '1996-07-01' and '1996-10-31'


-- obtener los nombres de los clientes y de los paises a los paises a los que se enviaron sus pedidos 

select 
o.CustomerID,
o.ShipCountry
from Orders as o 
inner join Customers as C
on c.CustomerID = o.CustomerID

order by 2 desc


select 
C.CompanyName,
o.ShipCountry,
o.ShipName
from Orders as o 
inner join Customers as C
on c.CustomerID = o.CustomerID

order by o.ShipCountry desc


-- obtener los prodectos y probedores

select 
p.ProductName as [N Producto],
s.CompanyName as [N Probedor]
from Suppliers as s
inner join Products as p
on p.SupplierID = s.SupplierID


-- obtener los pedidos order y los empleados que los gestionaron 
select 
o.OrderID,
concat (e.FirstName, ' ', e.LastName) as 'Nombre'
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID


-- listar los pruductos con sus presion y la categoria a la que pertenece

select 
c.CategoryID,
c.CategoryNameas 'N categoria',
p.ProductName as 'N Producto',
p.UnitPrice as 'Precio'
from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID


-- obtener el nombre de cliente , el numero de orden  yla fecha de orden
select 
CompanyName as 'Ciente',
OrderID as 'N de orden',
OrderDate as 'fecha'
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID


-- listar las ordenes mostrando el numero de order nombre de producto y la cantidad que de vendio

select 
OrderID as 'N orden',
ProductName as 'N producto',
Quantity as 'C vendida'
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID



select 
top 5
OrderID as 'N orden',
ProductName as 'N producto',
Quantity as 'C vendida'
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID
order by Quantity desc


select 
OrderID as 'N orden',
ProductName as 'N producto',
Quantity as 'C vendida'
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID
where OrderID = '11031'
order by Quantity desc


select 
OrderID as 'N orden',
count(*) as 'cantidad de P'
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID
group by OrderID
order by OrderID 



-- 7.-	obtener los empleados y sus respectivos jefes 

select 
concat (en.FirstName, '', en.LastName) as 'nombre',
concat (j1.FirstName,'', j1.LastName) as 'jefe'
from Employees as en
inner join Employees as j1
on en.ReportsTo = j1. EmployeeID

select
FirstName,
ReportsTo
from Employees

-- listar los pedidos y el
-- nombre de la empresa de  
-- trasporte utilizado

select
* 
from Orders as o 
inner join Shippers as s
on o.ShipVia = s.



select * from Orders
select * from Shippers


-- obtener la cantidas tota de ventas

select 
sum (Quantity)
from [Order Details]

select 
CategoryName as 'N categoria',
sum (Quantity) as 'Productos vendidos'
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
group by CategoryName
order by CategoryName 


-- obtener el total de ventas por empleados 
select 
concat (e.FirstName, '' ,e.LastName) as Nombre,
sum((Quantity * UnitPrice) -(Quantity * UnitPrice) * Discount) as 'Total'

from Orders as o 
inner join Employees as e
on o.EmployeeID = e.EmployeeID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by e.FirstName, e.LastName

---
