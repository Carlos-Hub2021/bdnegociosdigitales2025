

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
    EmployeeID ,  -- N�mero de empleado
    FirstName,    -- Primer nombre del empleado
    Title ,       -- Cargo del empleado
    City,         -- Ciudad
    Country       -- Pa�s
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


-- seleccionar las fechas de orden a�o mes dia el cliente que las ordeno y el empleado que las realiso

SELECT 
	OrderDate as 'Fecha de Orden' , 
	YEAR (OrderDate) AS A�o, 
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
    YEAR(OrderDate) AS A�o, 
    MONTH(OrderDate) AS Mes, 
    DAY(OrderDate) AS D�a,
    RequiredDate AS 'Fecha de Entrega',
    ShippedDate AS 'Fecha de Env�o',
    CustomerID AS Cliente
FROM 
    Orders
WHERE 
    YEAR(OrderDate) = 1996; -- El a�o no necesita estar entre comillas


	-- Mostrar todas las oedenes de compra selecionar 

	select Quantity
	from [Order Details] where Quantity >= 40;

	-- Mostrar el nombre completo del empeado , numero de empleado , 
	-- fecha de nacimiento , cyti y fecha de contratacion 
	-- deve ser mavor de 1993 los resutados en sus encabesados deven ser mostrados en espa�ol

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


--------------------------------------------------------------
--Operadores Loguicas  
	-- or
	-- and 
	-- not

--      Seleccionar los productos que tengan un precio de entre 10 y 50
select 
ProductID as 'id producto',
UnitPrice as 'precio' ,
UnitsInStock,				-- esto es para chegar los datos que estan en un rango
ProductName as 'Nombre'						-- como en esta consuta, que es de 10 a 50
from Products
where UnitPrice >= 10 and UnitPrice <= 50  


-----------------------------------------------------------------------------

-- Mostrar todos los pedidos por clientes que no son de alemania 

select * from Orders
where not ShipCountry<> 'Germany'



-- selecionar clintes de mexio o estados unidos

select * from Customers
where Country ='USA' or Country ='Mexico'

-- Selecionar empleados que naciero 1955 y 1958
-- yb que bivan en lonbres

select * from Employees

where (year (BirthDate) >= 1955 or year (BirthDate ) <=1958)and  City = 'london' 


-- selecionar los pedidos con flete de mayor a 100
-- y enviados a francia o espa�a

select * from Orders
where Freight> 100 and (ShipCountry = 'spain' or ShipCountry ='france')

-- seleccionar las primers 5 ( top 5 ) ordenes de comras 
select top 5 * from Orders

-- Seleccionar Productos con precio entre 10 y 20
-- que no esten decontinuadas y tengan mas de 20 en stok

select 
	ProductName,
	UnitPrice,
	UnitsInStock,
	Discontinued


from Products
where UnitPrice >= 10 and UnitPrice <= 50 
		and Discontinued = 0 
		and UnitsInStock >20 

-- pedidos enviados a francia o alemania
select 
	OrderID,
	ShipCountry,
	Freight

from Orders
where (ShipCountry = 'france' or ShipCountry = 'germany')
	and Freight <50

	-- cientes que no sean de mexico o usa y que tenfan 
	--fax

	select CompanyName , 
	Country, 
	city , 
	fax 
	from Customers
	where not ( Country ='Mexico' or Country = 'USA')
	and fax is not null


	--------------------------------------------------------------------------------

	-- Clausula IN (or)

	--------------------------------------------------------------------------------

	-- seleccionar los productos con cotegoria 1, 3 o 5
select 
ProductName,
CategoryID,
UnitPrice
from Products
where CategoryID = 1 or CategoryID = 3 or CategoryID = 5

	-- seleccionar los productos con cotegoria 1, 3 o 5 con IN
select 
ProductName,
CategoryID,
UnitPrice
from Products
where CategoryID in (1,3,5)


-- Selecionar todas las ordenes de RJ, tachira y las que no tengan 

select * from Orders
where ShipRegion IN ('RJ', 'T�chira') or ShipRegion is null

-- relecionar las oedenes que tengan cantidales de 12, 9, 40
-- y descuento de 0.15 y o.02 

select * from [Order Details]
where Quantity IN (12, 9,40) and Discount in(0.15, 0.05)

-- Clausula Betwen
