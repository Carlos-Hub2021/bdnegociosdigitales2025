

--	Realizar un pedido
--	validas que el pedido que no exista 
-- validas que el cliente exista  , empleado exista y producto exista 
--	validar que la cantidad a vender tenga suficiente stock
--	insertar el pedido y calcular el importe 
-- importe (multiplicar el presio del producto por la cantidad vendida)
-- actualizar el stock del producto (restando el stock menos la cantidad vendida)
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

------------------------------------------------------------------------------------------------------------------------------------------------------
USE BDEJEMPLO2;
GO

CREATE OR ALTER PROCEDURE spu_Realizar_Pedido
    @NumPedido INT,
    @Cliente INT,
    @Repre INT,
    @Fab CHAR(3),
    @Producto CHAR(5),
    @Cantidad INT
AS
BEGIN
    BEGIN TRY
        -- Validar que el pedido no exista
        IF EXISTS (SELECT 1 FROM Pedidos WHERE Num_Pedido = @NumPedido)
        BEGIN
            PRINT 'El pedido ya existe.';
            RETURN;
        END

        -- Validar que el cliente exista
        IF NOT EXISTS (SELECT 1 FROM Clientes WHERE Num_Cli = @Cliente)
        BEGIN
            PRINT 'El cliente no existe.';
            RETURN;
        END

        -- Validar que el empleado exista
        IF NOT EXISTS (SELECT 1 FROM Representantes WHERE Num_Empl = @Repre)
        BEGIN
            PRINT 'El Representante no existe.';
            RETURN;
        END

        -- Validar que el producto exista
        IF NOT EXISTS (SELECT 1 FROM Productos WHERE id_fab = @Fab AND id_producto = @Producto)
        BEGIN
            PRINT 'El producto no existe.';
            RETURN;
        END

        -- Validar que la cantidad sea mayor que 0
        IF @Cantidad <= 0
        BEGIN
            PRINT 'La cantidad debe ser mayor que 0.';
            RETURN;
        END

        -- Validar que haya suficiente stock
        DECLARE @StockValido INT;
        SELECT @StockValido = Stock FROM Productos WHERE id_fab = @Fab AND id_producto = @Producto;

        IF @StockValido < @Cantidad
        BEGIN
            PRINT 'No hay suficiente stock para el producto.';
            RETURN;
        END

        -- Calcular el importe
        DECLARE @Precio MONEY;
        SELECT @Precio = Precio FROM Productos WHERE id_fab = @Fab AND id_producto = @Producto;

        DECLARE @Importe MONEY;
        SET @Importe = @Precio * @Cantidad;

        -- Insertar el pedido
        INSERT INTO Pedidos (Num_Pedido, Fecha_Pedido, Cliente, Rep, Fab, Producto, Cantidad, Importe)
        VALUES (@NumPedido, GETDATE(), @Cliente, @Repre, @Fab, @Producto, @Cantidad, @Importe);

        -- Actualizar el stock del producto
        UPDATE Productos
        SET Stock = Stock - @Cantidad
        WHERE id_fab = @Fab AND id_producto = @Producto;

        PRINT 'Pedido realizado con éxito.';
    END TRY
    BEGIN CATCH
        PRINT 'Error al actualizar datos: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END;
GO

--------------------------------------------------------------------------------------------------------------------------------------------------



















































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





