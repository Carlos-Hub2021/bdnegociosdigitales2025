

select 
CategoryName,
c.CategoryID,
p.CategoryID,
ProductName
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
where c.CategoryID = 'fas fut'

select * from Categories



-- categorias que no tienes productos asicnados 

select 
CategoryName,
c.CategoryID,
p.CategoryID,
ProductName
from Categories as c
left join Products as p
on c.CategoryID = p.CategoryID
where p.CategoryID is null 

select * from Products

insert into Products 
(ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
values ('Hamburgesas', 1, 9, 'xlx' , 68.8, 45, 12,2,0)

delete Products
where CategoryID =9

-- 1. listar los emleados y los pedidos que han registrado 
-- incluyendo los empleados que no an escho pedidos  

select CategoryName,
p.CategoryID,

c.CategoryID,
p.ProductName

from Products as p
left join Categories as c
on p.CategoryID = c.CategoryID




select * from Employees

select * from Orders
select * from [Order Details]
