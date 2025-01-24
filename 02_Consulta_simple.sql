

	-- lenjuage sql -LMD insert update delete select delate
	-- consultas simples
	use Northwind

-- mostrar todos los clientes de la empresa 
-- clientes probedores categorias productos 

	select * from Customers;
	select * from Employees;
	select * from Orders;
	select *from Suppliers;
	select * from Products;
	select * from Shippers;
	select * from Categories;
	select *from [Order Details];


-- Proyeccion	---
	select ProductID, ProductName UnitPrice, UnitsInStock from Products;

	-- quiero mostrar el numero de empleados , su primer nombre , 
	-- su Cargo , ciudad y pais 
	select * from Employees;


SELECT 
    EmployeeID ,  -- Número de empleado
    FirstName,    -- Primer nombre del empleado
    Title ,       -- Cargo del empleado
    City,         -- Ciudad
    Country       -- País
FROM 
    Employees;    -- Tabla de empleados


-- Aalias de columnas 
-- Evase a la consuta anterios visualizar el 
--EmployeeID Como numero empleado, 
--firstname como Primer nombre,
--Title como Cargo, 
--Cyti como Ciudad , 
--Country como pais

SELECT 
    EmployeeID AS [Numero Empleado], 
    FirstName AS PrimerNombre, 
    Title AS Cargo, 
    City AS Ciudad,
    Country AS Pais
FROM 
    Employees;


--Campos calculados
-- Selecionar el inporte de los productos vendidos de una orden 

select *, (UnitPrice * Quantity) as Importe from 
[Order Details] 


-- seleccionar las fechas de orden año mes dia el cliente que las ordeno y el empleado que las realiso

SELECT 
	OrderDate as 'Fecha de Orden' , 
	YEAR (OrderDate) AS Año, 
	MONTH (OrderDate) as Mes, 
	DAY (OrderDate) as Dia,
	CustomerID,
	EmployeeID
	FROM Orders;


-- clausula where
-- Operadore relacionales ( <, >, = 

select * from Customers

-- Seleccionar el cliente

select CustomerID AS 'Nombre', 
CompanyName AS 'Nombre de Compania', 
city AS 'Ciudad', 
country'Pais' 
from Customers
where CustomerID = 'bolid'

-- Selecionar todos los clientes que nos alemania
select CustomerID AS 'Nombre', 
CompanyName AS 'Nombre de Compania', 
city AS 'Ciudad', 
country'Pais' 
from Customers
where Country = 'germany'

-- Selecionar todos los clientes que nos sean de alemania 

select CustomerID AS 'Nombre', 
CompanyName AS 'Nombre de Compania', 
city AS 'Ciudad', 
country'Pais' 
from Customers
where Country <> 'germany'


-- Selecionar todos los productos 
select ProductName as 'Nombre Producto',
CategoryID as categoria,
UnitPrice as Precio, (UnitPrice * UnitsInStock) as 'Costo Inventario',
from Products
where UnitPrice > 100;


-- selecionar todas las ordenes de compro fecha de orden fecha de entrega  feha de envio cliente que se envio de 1996

select * from Orders;

SELECT 
    OrderID AS 'Orden de Compra',
    OrderDate AS 'Fecha de Orden',
    YEAR(OrderDate) AS Año, 
    MONTH(OrderDate) AS Mes, 
    DAY(OrderDate) AS Día,
    RequiredDate AS 'Fecha de Entrega',
    ShippedDate AS 'Fecha de Envío',
    CustomerID AS Cliente
FROM 
    Orders
WHERE 
    YEAR(OrderDate) = 1996; -- El año no necesita estar entre comillas
