

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



select * from Customers;
-- mostrar los paises en donde se tienen los clientes

select distinct Country as 'Pais'  from Customers -- distinct para quitar datos repetidos de un campo
order by Country



-- operadores relacionales
-- TES DE COMPARACION


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


	-- Mostrar todas las oedenes de compra selecionar 

	select Quantity
	from [Order Details] where Quantity >= 40;

	-- Mostrar el nombre completo del empeado , numero de empleado , 
	-- fecha de nacimiento , cyti y fecha de contratacion 
	-- deve ser mavor de 1993 los resutados en sus encabesados deven ser mostrados en español

	select 
	EmployeeID AS 'Numero de Empleado',
	(FirstName + ' ' + LastName) as 'Nombre Completo' ,
	
	BirthDate AS 'Fecha Nacimiento',
	City AS 'Ciudad',
	HireDate AS 'Fecha contratacion'


	from Employees 
	where year (HireDate) > 1993
	
	
	-------------------------
	
	select 
	EmployeeID AS 'Numero de Empleado',
	Concat (FirstName ,' ',LastName, '-', Title) as 'Nombre Completo' ,-- forma de acomodar dos datos en uno con:  Concat
	
	BirthDate AS 'Fecha Nacimiento',
	City AS 'Ciudad',
	HireDate AS 'Fecha contratacion'


	from Employees 
	where year (HireDate) > 1993


	-- Mostrar los empleados
	 -- que no son ditigidos por el jefe 2
	 select ReportsTo ,
	 LastName

	 from Employees
	 
	 where ReportsTo <> 2;

	 --- selecionar los empleados que no tienen jefe 
	 -- selecionar los datos que son nulos
	 select * from Employees
	 where ReportsTo is null