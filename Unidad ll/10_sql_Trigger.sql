-- Tablas magicas	Aplicar
-- inserted			Tablas 
-- deleted			views

--	create or alter trigger -- Nombre-Trigger
--	on Tabla
--	After | For			Insert | update | delate
--	As
--	begin
		--
		--
--		--
--	end;

use BDEJEMPLO2

-- realizar un trigger que se dispare cuando se innserte un pedido y que  modifique el estork del producto vedido
-- verificar si hay sufisiente stock sino se cansela el pedido
	
	select * from Pedidos

	create or alter trigger tg_pedidos_insertar
	
	on pedidos 
	after insert
	as
	begin 
		declare  @existencia int
		declare	 @fab char(3)
		declare	 @prod char(5)
		declare @cantidad int	

	select @fab = fab, @prod = Producto,
	@cantidad = Cantidad
	from inserted

--  Obtener el stock disponible

	select @existencia = Stock from Productos
	where Id_fab = @fab  and Id_producto = @prod


--  Verificar si hay suficiente stock

	if @existencia > (select cantidad from inserted)
	begin
	
--	Actualizar el stock
	
	update Productos
	set Stock = Stock - @cantidad
	where Id_fab = @fab and 
		  Id_producto = @prod;

	end 
	else
	begin
		raiserror('no hay suficiente stock para el pedido', 16,1)
		rollback;
		end
	end;

select max(Num_Pedido) from Pedidos
select * from Pedidos


declare @impote money
select @impote = (p.Cantidad * pr.Precio)
from Pedidos as p
inner join Productos as pr
on p.Fab = pr.Id_fab
and p.Producto = pr.Id_producto

insert Pedidos(Num_Pedido, Fecha_Pedido, Cliente, Rep, Fab, Producto, Cantidad, Importe)
values (113071, getdate (), 2103, 106, 'ACI', '41001', 77, @impote)

--crear un triger que cada vez que se elimine un pedido se debe actualidar el stock de los productos de la cantidad eliminada

	Create or alter trigger tg_ActualizarStockEliminar
	on pedidos
	after delete
	as
	begin
		 update p
		 set p.Stock = p.Stock + d.Cantidad
		 from Productos p
		 inner join deleted d ON p.id_fab = d.Fab and p.id_producto = d.Producto;
    
		 print 'Stock actualizado por eliminación de pedidos';
		 
	end;