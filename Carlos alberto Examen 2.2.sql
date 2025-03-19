use BDEJEMPLO2
-- EXAMEN TIPO 2.2
-- 1.- 

    select p.Num_Pedido, p.Fecha_Pedido, c.Num_Cli , p.Importe 
    from  Pedidos as p
	inner join Clientes as c
	on p.Rep = c.Rep_Cli
	
	where p.Fecha_Pedido BETWEEN '1990-01-01' AND '1990-12-31'

-- 2.-

select r.Fecha_Contrato , 
r.Nombre ,o.Ciudad
from Representantes as r
inner join Oficinas as o
on r.Oficina_Rep = o.Oficina

where r.Fecha_Contrato BETWEEN '1988-01-01' AND '1990-12-31'

-- 3.-

select pr.Descripcion ,
pe.Producto
from Productos as pr
inner join Pedidos as pe
on pr.Id_producto = pe.Producto
where pe.Producto IN ('2A44L' ,'41004', '2A44G')

-- 4.-
 
select r.Nombre, o.Ciudad , sum (p.Importe) AS Ventas_Totales
from Oficinas as o 
inner join Representantes as r 
on o.Ventas = r.Ventas
inner join Pedidos as p
on r.Oficina_Rep = p.Rep
group by r.Nombre, o.Ciudad, p.Importe
having sum(p.Importe) > 10000 


-- 5.-

select * from Representantes
select * from Pedidos
select * from Clientes

select 
p.Num_Pedido,
c.Empresa,
r.Nombre


from Representantes as r
inner join Pedidos as p
on r.Oficina_Rep = p.Rep
inner join Clientes as c
on p.Cliente = c.Rep_Cli























