
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

---------------------------------------------------------------------------------------












---------------------------------------------------------------------------------------
--  14		obtener los pedidos agrupados por pais 

	select 
	o.ShipCountry as 'pasi de envio',
	concat(o.ShipCity) as [nombre de orden]
	
	from Orders as o

	group by ShipCountry



---------------------------------------------------------------------------------------
--  15		obtener los empleados y la cantidad de territorios en los que trabajan 


select 
concat (e.FirstName, '' ,e.LastName) as [Nombre],
count (TerritoryID) as 'C territorios'
from Employees as e
inner join EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
group by e.FirstName, e.LastName



select 
concat (e.FirstName, '' ,e.LastName) as Nombre,
count (TerritoryID) as 'C territorios'
from Employees as e
inner join EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
inner join Territories as t
on et.TerritoryID = t.TerritoryID
group by e.FirstName, e.LastName, 




---------------------------------------------------------------------------------------
--  16

select 
c.CategoryName ,

from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
group by CategoryName



-- 17 obtener la cantidad total  de productos bendidos por provedor
select * from Products
select * from Shippers


 select 
 CompanyName,
 sum (od.Quantity) as [total de productos]
 
 from Shippers as s
 inner join Products as p
 on s.ShipperID=  p.SupplierID
 inner join [Order Details] as od 
 on p.ProductID= od.ProductID

 group by CompanyName
 order by 2 desc
-- 18 obtener la cantidad de pedidos envias por 
-- empresa de trasporte 


	select  
	CompanyName as 'Tasportista'
	,count(*) as [total de pedidos] 
	from Orders as o
	inner join Shippers as s
	on o.ShipVia = s.ShipperID 
	group by s.CompanyName

	-- obtener los clientes que haan realizado pedidos con maas de un pedido 

	select 
	c.CompanyName,
	count( distinct ProductID) as [numero de pedidos]
	from Customers as c
	inner join Orders as o
	on c.CustomerID = o.CustomerID
	inner join [Order Details] as od
	on od.OrderID = o.OrderID
	group by CompanyName
	order by 2 desc

	--

	-- listar la cantidad total de pedidos que se an gestionados y a que clientes se han vendidas
	-- agrupandolo por el nombre completo y deste nombre por cliente ordenados por la ciudad de mayor pedidos 

	SELECT 
    CONCAT(Customers.ContactName,
	' (', Customers.City, ')') AS NombreCompletoCliente,
    COUNT(o.OrderID) AS TotalPedidos,
    Customers.City
FROM 
    Orders as o
INNER JOIN 
    Customers ON o.CustomerID = Customers.CustomerID
GROUP BY 
    Customers.ContactName, Customers.City
ORDER BY 
    TotalPedidos DESC, Customers.City;


	select CONCAT(e.FirstName,' ', e.LastName) as Nombre
	,c.CompanyName as cliente
	,count (OrderID) as [Nombre de compania] 
	from Orders as o
	inner join Employees as e
	on o.EmployeeID = e.EmployeeID
	inner join Customers as c
	on o.CustomerID = c.CustomerID
	group by e.FirstName, e.LastName , c.CompanyName
	order by Nombre desc , [cliente]


	--	21

	-- listar las categorias con el total de ingresos generados con sus productos 
	select * from Categories
	select * from  Products
	select * from [Order Details]

	select
	CategoryName,
	sum(od.Quantity * p.UnitPrice)  as 'TotalIngresos'
	from Categories as c
	inner join Products as p
	on c.CategoryID = p.CategoryID
	inner join [Order Details] as od
	on p.ProductID = od.ProductID
	group by CategoryName
	ORDER BY TotalIngresos DESC;


	SELECT 
    C.CategoryID,
    C.CategoryName,
    SUM(OD.Quantity * OD.UnitPrice) AS TotalIngresos
	FROM  Categories C
	INNER JOIN Products P 
	ON C.CategoryID = P.CategoryID
	INNER JOIN [Order Details] as OD 
	ON P.ProductID = OD.ProductID
	GROUP BY C.CategoryID, C.CategoryName
	ORDER BY TotalIngresos DESC;



	-- listar los clinetes con el totall ($) gastados en pedidos 

select c.CompanyName,
sum (Quantity * UnitPrice) as total
from Customers as c
inner join Orders  as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on o.OrderID = od.OrderID
group by c.CompanyName

-- listar lo pedidos realizados en tre 1 de enero de 1997 y el 30 de junio

	select o.OrderDate,
	sum (Quantity * UnitPrice ) as total
	from Orders as o
	inner join [Order Details] as od
	on o.OrderID = od.OrderID
	where OrderDate between '1997-01-01' and '1997- 06-30'
	group by o.OrderDate

	--- listar los productos 

	select ProductName,
	CategoryName
	from Categories as c
	inner join Products as p
	on c.CategoryID = p.CategoryID
	where c.CategoryName in ('beverages','seafood','confections') 

	-- 25 

	select CompanyName
	from Customers as c
	inner join Orders as o
	on c.CustomerID = o.CustomerID
	where Country = 'germany'
	and o.OrderDate <'1997-01-01'

	-- 26

	select
	CompanyName,
	sum (Quantity * UnitPrice) as total
	from Customers as c
	inner join  Orders as o
	on o.CustomerID = c.CustomerID
	inner join [Order Details] as od
	on o.OrderID = od.OrderID
	group by CompanyName
	having sum (od.Quantity * od.UnitPrice) between 500 and 2000

--	left join right join full join y cross join





select * from 