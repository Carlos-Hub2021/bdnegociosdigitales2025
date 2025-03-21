# Procedimiento Almacenado: `Realizar un Pedido`

## Descripción
Este procedimiento almacenado realiza un pedido validando que:
- Realizar un pedido
- Validar que el pedido no exista
- Validar que el cliente, el empleado y producto exista
- Validar que la cantidad a vender tenga suficiente stock
- Insertar el pedido y calcular el importe (multiplicando el precio del
- del producto por cantidad vendida)
- Actualizar el stock del producto(restando el stock menos la cantidad vendida)

## Código SQL

```sql
use BDEJEMPLO2;

create or alter procedure spu_realizar_pedido
    @NumPedido int, 
    @cliente int,
    @repre int,
    @fab char(3),
    @Producto char(5),
    @cantidad int
as 
begin 
    begin try
        -- validar que el pedido no exista
        if exists (select 1 from Pedidos where Num_Pedido = @NumPedido)
        begin 
            print 'el pedido ya existe';
            return;
        end

        -- validar que el cliente exista
        if not exists (select 1 from Clientes where Num_Cli = @cliente)
        begin 
            print 'el cliente no existe';
            return;
        end

        -- validar que el representante exista
        if not exists (select 1 from Representantes where Num_Empl = @repre)
        begin 
            print 'el representante no existe';
            return;
        end

        -- validar que el producto exista
        if not exists (select 1 from Productos where id_fab = @fab and id_producto = @Producto)
        begin
            print 'el producto no existe';
            return;
        end

        -- validar que la cantidad sea mayor que 0
        if @cantidad <= 0
        begin
            print 'la cantidad debe ser mayor que 0';
            return;
        end

        -- validar que haya suficiente stock
        declare @stockValido int;
        select @stockValido = Stock from Productos where id_fab = @fab and id_producto = @Producto;

        if @stockValido < @cantidad
        begin
            print 'no hay suficiente stock para el producto';
            return;
        end

        -- calcular el importe
        declare @precio money;
        select @precio = Precio from Productos where id_fab = @fab and id_producto = @Producto;

        declare @importe money;
        set @importe = @precio * @cantidad;

        -- insertar el pedido
        insert into Pedidos (Num_Pedido, Fecha, Cliente, Representante, Fab, Producto, Cantidad, Importe)
        values (@NumPedido, getdate(), @cliente, @repre, @fab, @Producto, @cantidad, @importe);

        -- actualizar el stock del producto
        update Productos
        set Stock = Stock - @cantidad
        where id_fab = @fab and id_producto = @Producto;

        print 'pedido realizado con éxito';
    end try
    begin catch 
        print 'error al actualizar datos';
        return;
    end catch
end;
```

## Notas
- **Revisar siempre el stock antes de realizar un pedido.**
- **Asegurar que los datos del cliente y representante estén registrados correctamente.**

## Ejemplos de ejecución del procedimiento almacenado

```sql
exec spu_Realizar_Pedido
@NumPedido = 112961,
@cliente= 2117,
@repre=106,
@Fab= 'ret',
@Producto = '2A44L',
@Cantidad = 20
```

--------

```sql
exec spu_Realizar_Pedido
@NumPedido = 112961,
@cliente= 2117,
@repre=111,
@Fab= 'ret',
@Producto = '2A44L',
@Cantidad = 20
```

--------

```sql
exec spu_Realizar_Pedido
@NumPedido = 113070,
@cliente= 2117,
@repre=101,
@Fab= 'ACI',
@Producto = '4100x',
@Cantidad = 2
```

## Consulta para verificar el stock de un producto

```sql
select * from Productos
where Id_fab ='ACI' and Id_producto ='4100x'
```

## Validar si un cliente existe

```sql
if not exists(select 1 from Clientes where Num_Cli = 2000) print ('ok')
```

## Consultas para verificar los datos

```sql
select * from Pedidos
select * from Representantes
