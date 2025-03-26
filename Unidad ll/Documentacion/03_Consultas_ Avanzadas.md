# Consultas SQL para Northwind y TiendaVideoJuegos

```sql
use TiendaVideoJuegos
use Northwind
```

## Consultas básicas de JOIN
- Consulta básica entre Categories y Products
```sql

select * from Categories as C
inner join Products as p            -- esto consulta dos tablas
on C.CategoryID = P.CategoryID;

-- Selección de columnas específicas
select 
    C.CategoryID,
    CategoryName,
    ProductName,
    UnitPrice,                                
    UnitsInStock
from Categories as C
inner join Products as p            
on C.CategoryID = P.CategoryID;

-- Con alias de columnas
select 
    C.CategoryID as 'Numero de categoria',
    CategoryName as 'Nombre de categoria',
    ProductName as 'Nombre de Producto',
    UnitPrice as Precio,                                
    UnitsInStock as Existencia
from Categories as C
inner join Products as p            
on C.CategoryID = P.CategoryID;
```

## Consultas con filtros WHERE

```sql
-- Productos de categorías Beverages y Condiments con existencia entre 18 y 30
select *
from Products as P
join Categories as C
on P.CategoryID = c.CategoryID
where C.CategoryName in ('Beverages', 'Condiments') 
and P.UnitsInStock between '18' and '30';

-- Productos y sus importes de marzo a junio de 1996
select 
    o.OrderID, o.OrderDate, od.ProductID, 
    (od.UnitPrice * od.Quantity) as Importe
from Orders as O
join [Order Details] as Od
on od.OrderID = o.OrderID
where o.OrderDate between '1996-07-01' and '1996-10-31';

-- Importe total de ventas del período anterior
select 
    sum(od.Quantity * od.UnitPrice) as [Inporte de ventas]
from Orders as O
join [Order Details] as Od
on od.OrderID = o.OrderID
where o.OrderDate between '1996-07-01' and '1996-10-31';
```

## Consultas con clientes y países

```sql
-- Nombres de clientes y países de envío
select 
    o.CustomerID,
    o.ShipCountry
from Orders as o 
inner join Customers as C
on c.CustomerID = o.CustomerID
order by 2 desc;

-- Con nombre de compañía
select 
    C.CompanyName,
    o.ShipCountry,
    o.ShipName
from Orders as o 
inner join Customers as C
on c.CustomerID = o.CustomerID
order by o.ShipCountry desc;
```

## Consultas con productos y proveedores

```sql
-- Productos y sus proveedores
select 
    p.ProductName as [N Producto],
    s.CompanyName as [N Probedor]
from Suppliers as s
inner join Products as p
on p.SupplierID = s.SupplierID;

-- Pedidos y empleados que los gestionaron
select 
    o.OrderID,
    concat(e.FirstName, ' ', e.LastName) as 'Nombre'
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID;
```

## Consultas con categorías y precios

```sql
-- Productos con sus precios y categorías
select 
    c.CategoryID,
    c.CategoryName as 'N categoria',
    p.ProductName as 'N Producto',
    p.UnitPrice as 'Precio'
from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID;

-- Clientes con sus números de orden y fechas
select 
    CompanyName as 'Ciente',
    OrderID as 'N de orden',
    OrderDate as 'fecha'
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID;
```

## Consultas de órdenes y detalles

```sql
-- Órdenes con productos y cantidades vendidas
select 
    OrderID as 'N orden',
    ProductName as 'N producto',
    Quantity as 'C vendida'
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID;

-- Top 5 productos más vendidos
select top 5
    OrderID as 'N orden',
    ProductName as 'N producto',
    Quantity as 'C vendida'
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID
order by Quantity desc;

-- Productos vendidos en orden específica
select 
    OrderID as 'N orden',
    ProductName as 'N producto',
    Quantity as 'C vendida'
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID
where OrderID = '11031'
order by Quantity desc;

-- Cantidad de productos por orden
select 
    OrderID as 'N orden',
    count(*) as 'cantidad de P'
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID
group by OrderID
order by OrderID;
```

## Consultas de empleados y jefes

```sql
-- Empleados y sus jefes
select 
    concat(en.FirstName, '', en.LastName) as 'nombre',
    concat(j1.FirstName, '', j1.LastName) as 'jefe'
from Employees as en
inner join Employees as j1
on en.ReportsTo = j1.EmployeeID;

-- Información básica de empleados
select
    FirstName,
    ReportsTo
from Employees;
```

## Consultas de transporte y ventas

```sql
-- Pedidos y empresas de transporte
select * 
from Orders as o 
inner join Shippers as s
on o.ShipVia = s.ShipperID;

-- Consultas básicas de tablas
select * from Orders;
select * from Shippers;

-- Cantidad total de ventas
select sum(Quantity)
from [Order Details];

-- Productos vendidos por categoría
select 
    CategoryName as 'N categoria',
    sum(Quantity) as 'Productos vendidos'
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
group by CategoryName
order by CategoryName;
```

## Consultas de ventas por empleado

```sql
-- Total de ventas por empleado
select 
    concat(e.FirstName, '', e.LastName) as Nombre,
    sum((Quantity * UnitPrice) - (Quantity * UnitPrice) * Discount) as 'Total'
from Orders as o 
inner join Employees as e
on o.EmployeeID = e.EmployeeID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by e.FirstName, e.LastName;
```

## Consultas agrupadas por país

```sql
-- Pedidos agrupados por país
select 
    o.ShipCountry as 'pasi de envio',
    concat(o.ShipCity) as [nombre de orden]
from Orders as o
group by ShipCountry;
```

## Consultas de empleados y territorios

```sql
-- Empleados y cantidad de territorios
select 
    concat(e.FirstName, '', e.LastName) as [Nombre],
    count(TerritoryID) as 'C territorios'
from Employees as e
inner join EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
group by e.FirstName, e.LastName;

-- Versión extendida con join a Territories
select 
    concat(e.FirstName, '', e.LastName) as Nombre,
    count(TerritoryID) as 'C territorios'
from Employees as e
inner join EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
inner join Territories as t
on et.TerritoryID = t.TerritoryID
group by e.FirstName, e.LastName;
```

## Consultas de categorías

```sql
-- Consulta incompleta de categorías
select 
    c.CategoryName
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
group by CategoryName;
```

## Consultas de proveedores

```sql
-- Cantidad total de productos vendidos por proveedor
select 
    CompanyName,
    sum(od.Quantity) as [total de productos]
from Shippers as s
inner join Products as p
on s.ShipperID = p.SupplierID
inner join [Order Details] as od 
on p.ProductID = od.ProductID
group by CompanyName
order by 2 desc;
```

## Consultas de transporte

```sql
-- Cantidad de pedidos por empresa de transporte
select  
    CompanyName as 'Tasportista',
    count(*) as [total de pedidos] 
from Orders as o
inner join Shippers as s
on o.ShipVia = s.ShipperID 
group by s.CompanyName;
```

## Consultas de clientes

```sql
-- Clientes con más de un pedido
select 
    c.CompanyName,
    count(distinct ProductID) as [numero de pedidos]
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by CompanyName
order by 2 desc;

-- Total de pedidos por cliente con ciudad
SELECT 
    CONCAT(Customers.ContactName, ' (', Customers.City, ')') AS NombreCompletoCliente,
    COUNT(o.OrderID) AS TotalPedidos,
    Customers.City
FROM Orders as o
INNER JOIN Customers ON o.CustomerID = Customers.CustomerID
GROUP BY Customers.ContactName, Customers.City
ORDER BY TotalPedidos DESC, Customers.City;

-- Empleados y clientes atendidos
select CONCAT(e.FirstName, ' ', e.LastName) as Nombre,
    c.CompanyName as cliente,
    count(OrderID) as [Nombre de compania] 
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID
inner join Customers as c
on o.CustomerID = c.CustomerID
group by e.FirstName, e.LastName, c.CompanyName
order by Nombre desc, [cliente];
```

## Consultas de ingresos

```sql
-- Ingresos por categoría
select
    CategoryName,
    sum(od.Quantity * p.UnitPrice) as 'TotalIngresos'
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on p.ProductID = od.ProductID
group by CategoryName
ORDER BY TotalIngresos DESC;

-- Versión alternativa con CategoryID
SELECT 
    C.CategoryID,
    C.CategoryName,
    SUM(OD.Quantity * OD.UnitPrice) AS TotalIngresos
FROM Categories C
INNER JOIN Products P ON C.CategoryID = P.CategoryID
INNER JOIN [Order Details] as OD ON P.ProductID = OD.ProductID
GROUP BY C.CategoryID, C.CategoryName
ORDER BY TotalIngresos DESC;

-- Total gastado por clientes
select c.CompanyName,
    sum(Quantity * UnitPrice) as total
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on o.OrderID = od.OrderID
group by c.CompanyName;
```

## Consultas por fechas

```sql
-- Pedidos de enero a junio de 1997
select o.OrderDate,
    sum(Quantity * UnitPrice) as total
from Orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
where OrderDate between '1997-01-01' and '1997-06-30'
group by o.OrderDate;

-- Productos de categorías específicas
select ProductName,
    CategoryName
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
where c.CategoryName in ('beverages', 'seafood', 'confections');

-- Clientes alemanes con pedidos antes de 1997
select CompanyName
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
where Country = 'germany'
and o.OrderDate < '1997-01-01';

-- Clientes con gastos entre 500 y 2000
select
    CompanyName,
    sum(Quantity * UnitPrice) as total
from Customers as c
inner join Orders as o
on o.CustomerID = c.CustomerID
inner join [Order Details] as od
on o.OrderID = od.OrderID
group by CompanyName
having sum(od.Quantity * od.UnitPrice) between 500 and 2000;
```

## Consultas finales

```sql
-- Consulta de ejemplo para otros tipos de JOIN
select * from [Order Details];
```