# Ejercicio de pedidos con estor PROCEDURE


-	Realizar un pedido
-	validas que el pedido que no exista 
- validas que el cliente exista  , empleado exista y producto exista 
-	validar que la cantidad a vender tenga suficiente stock
-	insertar el pedido y calcular el importe 
- importe (multiplicar el presio del producto por la cantidad vendida)
- actualizar el stock del producto (restando el stock menos la cantidad vendida)

```sql
use BDEJEMPLO2

create or alter PROCEDURE spu_Realizar_Pedido
@NumPedido int, @cliente int,
@repre int,
@fab char(3),
@Producto char (5),
@cantidad int 
as 
begin 

-- Validar que el pedido no exista
	if exists (select 1 from Pedidos where Num_Pedido = @NumPedido)
	begin 
	print 'El pedido ya existe' 
	return
	end

-- Validar que el cliente exista
	if not exists (select 1 from Pedidos where Cliente = @cliente )
	begin 
	print 'El clinete no existe'
	return
	end

-- Validar que el empleado exista
	if not exists (select 1 from Representantes where Num_Empl = @repre )
	begin 
	print 'El Representante no existe'
	return
	end

-- Validar que el producto exista
    IF NOT EXISTS (SELECT 1 FROM Productos WHERE id_fab = @Fab AND id_producto = @Producto)
    BEGIN
        print'El producto no existe.'
        RETURN
    END
	
	IF @cantidad <=0
	BEGIN;
	RETURN
	END

	  DECLARE @StockValido INT
	  select @StockValido=Stock from Productos  WHERE id_fab = @Fab AND id_producto = @Producto

	  if @StockValido < @Cantidad
    BEGIN
        print  'No hay suficiente stock para el producto.'
        RETURN
    END
-- Calcular el importe
    DECLARE @Precio MONEY
    SELECT @Precio = Precio FROM Products WHERE id_fab = @Fab AND id_producto = @Producto

    DECLARE @Importe MONEY
    SET @Importe = @Precio * @Cantidad

	insert into pedidos
	values (@NumPedido, getDate (),@cliente, @repre,@Fab, @Producto, @Cantidad,@Importe  );



	update Productos
	set Stock = Stock - @cantidad
	where Id_fab = @fab and Id_producto = @Producto;

	end try
	begin catch
	print 'Eroor al actualizar datos'
	RETURN;
	end catch
	end;

```

# Pruevas 

```sql


	exec spu_Realizar_Pedido
	@NumPedido = 112961,
	@cliente= 2117,
	@repre=106,
	@fab= 'ret',
	@producto = '2A44L',
	@cantidad = 20

	--------

	exec spu_Realizar_Pedido
	@NumPedido = 112961,
	@cliente= 2117,
	@repre=111,
	@fab= 'ret',
	@producto = '2A44L',
	@cantidad = 20

	--------

	exec spu_Realizar_Pedido
	@NumPedido = 113070,
	@cliente= 2117,
	@repre=101,
	@fab= 'ACI',
	@producto = '4100x',
	@cantidad = 2

	select * from Productos
	where Id_fab ='ACI' and Id_producto ='4100x'



-- Validar que haya suficiente stock
    DECLARE @StockActual INT
    SELECT @StockActual = Stock FROM Productos WHERE id_fab = @Fab AND id_producto = @Producto

    IF @StockActual < @Cantidad
    BEGIN
        RAISERROR('No hay suficiente stock para el producto.', 16, 1)
        RETURN
    END

```