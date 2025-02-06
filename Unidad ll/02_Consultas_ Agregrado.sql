-- consutas de agregado 
-- Npota solo debuelven un  solo reguistro 
-- sum , avh, cont, count(*), max y min


-- Cuantos clientes tengo

select count(*) as [Numero de Clientes] from Customers  
-- cuantas regiones hay 

select count(*)
from Customers  
where region is null


-- Cuantas reguiones tengo--
select count (distinct region)
from Customers  

where region is not null

----
select 
COUNT(*)	-- Cuenta el numero de filas 
from Orders
-- 
-- seleciona el presio mas bajo de los producos
 select 
 min(UnitPrice) -- es para buscar el presio mas pequeño
 from Products


 
  select 
 min(UnitPrice),		-- es para buscar el presio mas pequeño
 max (UnitPrice),		-- busaca el precio mas grande
 avg (UnitsInStock),	-- la media
 sum (UnitPrice)		-- Es la suma de los datos 
 from Products

 ----			Seleccionar cuanto spedidos existen 

 select 
 COUNT(*) as [Numero de pedidos] 
 from Orders

 ----			calcula el total de dinero vendido

 
	select 
	sum (UnitPrice * Quantity)
	from [Order Details];
 

	
	select 
	sum (UnitPrice * Quantity - (UnitPrice * Quantity * Discount))	AS  total-- para sacar el descuento
	from [Order Details];

 ----			calcilar el total de unidades en stock 
 ---			de todos los productos

	select 
	sum (UnitsInStock)
	from Products


	select * from Orders


		--------------------------------------------------------------------------------

-- 		group by 

		--------------------------------------------------------------------------------

		select 		
		CategoryID, 
		COUNT(*)		-- numero de Productos
		
		from Products
		group by CategoryID


		select p.CategoryID ,COUNT(*) from
		Categories as c
		inner join Products as p
		on c.CategoryID = p.ProductID
		group by p.CategoryID
-----------------------------------------------------------------------------------------------
		select Categories.CategoryName,
		COUNT (*) as [Numero de productos]
		from
		Categories
		inner join Products as p
		on Categories.CategoryID  = p.CategoryID
		group by Categories.CategoryName


		-- calcular el (avg) promedio de los productos por cada categoria

		select * from Products


		select 	
		CategoryID,
		avg(UnitPrice )	as 'Precio promedio'	
		
		from Products
		group by CategoryID

		-----------------------------

		select 	
		CategoryID,
		avg(UnitPrice )	as 'Precio promedio'	
		
		from Products
		where CategoryID in (1,2,3)
		group by CategoryID

		-----------------------------
--		Selecionar el numero de pedidos realidsados por cada empleados

		select EmployeeID ,COUNT (*)  'Numero de orden por empleados' 
		from Orders
		group by EmployeeID

		-----------------------------
--		Selecionar el numero de pedidos realidsados por cada empleados por el ultimo trimestre de 1996

		select EmployeeID ,COUNT (*)
		from Orders
		group by EmployeeID
		or
		where OrderDate between  '1996-10-1' and '1996-12-31'
		
		



	-- Selecionar la suma total de unidades vendidas por acada producto

	select ProductID , sum (Quantity) as 'Numero de peroductos vendidos' 
	from [Order Details]
	group by ProductID
	order by 1 desc
	-- muestra cada producto
	select OrderID, ProductID , sum (Quantity) as 'Numero de peroductos '
	from [Order Details]
	group by OrderID ,ProductID
	order by 2 desc


		--------------------------------------------------------------------------------

--			havieng  

		--------------------------------------------------------------------------------


--			Selecionar Numero de prodectos por categoria 
		--	pero solo aquellos que tengan mas de 10 productos
-- paso 1 
	select distinct CategoryID from Products

-- paso 2
	select CategoryID, UnitsInStock from Products
	where CategoryID in (2,4,8)
	order by CategoryID


-- paso 3
	select CategoryID, SUM(UnitsInStock) from Products
	where CategoryID in (2,4,8)
	GROUP BY CategoryID
	order by CategoryID

-- paso 4
	select CategoryID, SUM(UnitsInStock) from Products
	where CategoryID in (2,4,8)
	GROUP BY CategoryID
	having count (*)>=10 
	order by CategoryID
	
	


	SELECT 
    CategoryID,                    -- ID de la categoría
    COUNT(ProductID) AS TotalProductos -- Número de productos en la categoría
	FROM Products
	GROUP BY CategoryID
	HAVING 
    COUNT(ProductID) > 10; -- Solo categorías con más de 10 productos
	
	-- Listar las ordenes agrupadas por empleado pero que solo muestre aqueloos que hayan 
	-- gestionado mas de 10 pedidos 

		