
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