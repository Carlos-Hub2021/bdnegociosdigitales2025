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

