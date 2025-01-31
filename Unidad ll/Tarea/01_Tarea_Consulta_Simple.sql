use Northwind

-- 1.    Productos con categoría 1, 3 o 5
select 
ProductName as [Nombre de producto],
CategoryID as [Numero de categoria],
UnitPrice as 'Precio' 
from Products
where CategoryID in (1,3,5)

-- 2.    Clientes de México, Brasil o Argentina

	Select 
	ContactName as [Nombre cliente],
	country as 'Pais'
	from Customers
	where country in ('Mexico','Brazil','Argentina')

-- 3.    Pedidos enviados por los transportistas 1, 2 o 3 y con flete mayor a 50
	select 
	ShipName as [Nombre],
	ShipCity as 'Ciudad',
	ShipVia as 'Transportista'
	from Orders
	where ShipVia IN (1, 2, 3) AND Freight > 50;

-- 4.    Empleados que trabajan en Londres, Seattle o Buenos Aires
	
	select 
	EmployeeID as [Numero de empleado],
	Concat (FirstName ,' ',LastName, ' - ', Title) as 'Nombre Completo',
	City as 'Pais'
	
	from Employees
	where City IN ('london', 'Seattle','')



-- 5.    Pedidos de clientes en Francia o Alemania, pero con un flete menor a 100
	
	
	select * from Orders
	where Freight> 100 and (ShipCountry = 'spain' or ShipCountry ='france')
	
-- 6.    Productos con categoría 2, 4 o 6 y que NO estén descontinuados

-- 7.    Clientes que NO son de Alemania, Reino Unido ni Canadá
-- 8.    Pedidos enviados por transportistas 2 o 3, pero que NO sean a USA ni Canadá
-- 9.    Empleados que trabajan en 'London' o 'Seattle' y fueron contratados después de 1992
-- 10.    Productos de categorías 1, 3 o 5 con stock mayor a 50 y que NO están descontinuados