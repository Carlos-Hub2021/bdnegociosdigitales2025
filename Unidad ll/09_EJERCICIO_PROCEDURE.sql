-- Realizar un pedido
-- Validar que el pedido no exista
-- Validar que el cliente, el empleado y producto exista
-- Validar que la cantidad a vender tenga suficiente stock
-- Insertar el pedido y calcular el importe (multiplicando el precio del producto por cantidad vendida)
-- Actualizar el stock del producto(restando el stock menos la cantidad vendida)

use BDEJEMPLO2

create or alter procedure spu_realizar_pedido
@NumPedido int, @cliente int,
@repre int,
@fab char(3),
@Producto char (5),
@cantidad int 
as 
begin 
    begin try
        -- validar que el pedido no exista
        if exists (select 1 from Pedidos where Num_Pedido = @NumPedido)
        begin 
            print 'el pedido ya existe' 
            return
        end

        -- validar que el cliente exista
        if not exists (select 1 from Clientes where Num_Cli = @cliente)
        begin 
            print 'el cliente no existe'
            return
        end

        -- validar que el empleado exista
        if not exists (select 1 from Representantes where Num_Empl = @repre)
        begin 
            print 'el representante no existe'
            return
        end

        -- validar que el producto exista
        if not exists (select 1 from Productos where id_fab = @Fab and id_producto = @Producto)
        begin
            print 'el producto no existe.'
            return
        end

        -- validar que la cantidad sea mayor que 0
        if @cantidad <= 0
        begin
            print 'la cantidad debe ser mayor que 0.'
            return
        end

        -- validar que haya suficiente stock
        declare @StockValido int
        select @StockValido = Stock from Productos where id_fab = @Fab and id_producto = @Producto

        if @StockValido < @Cantidad
        begin
            print 'no hay suficiente stock para el producto.'
            return
        end

        -- calcular el importe
        declare @Precio money
        select @Precio = Precio from Productos where id_fab = @Fab and id_producto = @Producto

        declare @Importe money
        set @Importe = @Precio * @Cantidad

        -- insertar el pedido
        insert into Pedidos 
        values(@NumPedido, getDate(), @cliente, @repre, @Fab, @Producto, @Cantidad, @Importe);

        -- actualizar el stock del producto
        update Productos
        set Stock = Stock - @cantidad
        where Id_fab = @Fab and Id_producto = @Producto;

    end try
    begin catch 
        print 'error al actualizar datos'
        return;
    end catch
end;
------------------------------------------------------------------------------------------------------------------------

-- Ejemplos de ejecución del procedimiento almacenado

exec spu_Realizar_Pedido
@NumPedido = 112961,
@cliente= 2117,
@repre=106,
@Fab= 'ret',
@Producto = '2A44L',
@Cantidad = 20

--------

exec spu_Realizar_Pedido
@NumPedido = 112961,
@cliente= 2117,
@repre=111,
@Fab= 'ret',
@Producto = '2A44L',
@Cantidad = 20

--------

exec spu_Realizar_Pedido
@NumPedido = 113070,
@cliente= 2117,
@repre=101,
@Fab= 'ACI',
@Producto = '4100x',
@Cantidad = 2

-- Consulta para verificar el stock de un producto
select * from Productos
where Id_fab ='ACI' and Id_producto ='4100x'


-- Validar si un cliente existe
if not exists(select 1 from Clientes where Num_Cli = 2000)
print ('ok')

-- Consultas para verificar los datos
select * from Pedidos
select * from Representantes