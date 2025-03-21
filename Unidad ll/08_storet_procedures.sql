use Northwind



----------------------------------------------------------------------------------------------------
--						storet procedurces
----------------------------------------------------------------------------------------------------


-- crearte un stort para selecionar todos los crientes
create or alter procedure spu_mostrar_clientes
AS
begin
   select * from Customers;
end;
GO

-- Ejecutar un store en transact
exec spu_mostrar_clientes


-- crear un sp que muestre los clientes por pais 
-- parametros de entrada

create or alter proc spu_Customers_pais
-- Parametros
@pais nvarchar(15),
@pais2 nvarchar(15)
                     -- Parametro de entrada 
AS
begin

    select * from customers
	where country in (@pais, @pais2);
end;
-- Fin del store

---------------------------------------------------
-- crear un sp
---------------------------------------------------

create or alter proc spu_Customers_pais
-- Parametos
@pais nvarchar (15),
@pais2 nvarchar (15)-- parameto de entrada
AS
begin

    select * from customers
	where country in (@pais, @pais2);
end;


-- Fin del store
DEclare @p1 nvarchar(15) = 'mexico';
DEclare @p2 nvarchar(15) = 'germany';

exec spu_customersporpais @p1, @p2;
go

-- Generar un reporte que permita visualizar los datos de compra de un
-- determinado cliente, en un rango de fechas, mostrando, 
-- el monto total de compras por producto, mediante un sp.

use northwind;
GO


---------------------------------------------------


reate or alter proc spu_informe_ventas_clientes
-- Parametros
@nombre nvarchar(40) = 'Berglunds snabbk�p', -- Parametro de entrada con valor por default 
@fechaInicial DateTime, 
@fechaFinal Datetime
AS

begin

select 
[Nombre Producto],
[Nombre del Cliente],  
sum(importe) AS [Monto Total]

from vistaordenescompra

where [Nombre del Cliente] = @nombre 

and [Fecha de Orden] between @fechaInicial and @fechaFinal
group by
 [Nombre Producto], [Nombre del Cliente]
end;
GO



-- ejecutar de un estor con parametros de estrada
EXEC spu_informe_ventas 'Berglunds snabbkop',
								'1996-07-04',
								'1997-01-01'

-- ejecutor de spu con parametros diferentes
EXEC spu_informe_ventas @fechaFinal ='1997-01-01',
						@nombres = 'Berglunds snabbkop',
						@fechaFinal = '1996-07-04'

-- ejecutor de un spu con parametros de estrada con un
-- compo que tiene un valor por defaul

exec spu_informe_ventas_clientes @fechaInicial ='1996-07-04', 
                                 @FechaFinal='1997-01-01' 


go
-- store procedues con parametros de salida

create or alter proc spu_obtener_numero_clientes
@customerid nchar (5),-- Parametro de entrada
@totalCustomers int output -- parametro de salida

as 

begin

	select @totalCustomers =COUNT (*) from Customers;
	where customerID = @customerid;
end;
go


declare @numero int;

exec  spu_obtener_numero_clientes @customerid = 'ANATR',
								  @totalCustomers = @numero OUTPUT;
print @numero;
go


-- CREAR UN PS QUE PERMITA SAVER SI UN ALUMNO APROBO O REPROBO

create or alter proc spu_comparar_calificacion
@califi decimal (10,2) -- parametro de entrada
as 
begin
	if @califi>=0 and @califi<=10
	begin
	if @califi>= 8
	print 'la calificasion aprobatoria'
	else
	print 'reprobo'

	end 
	else
	print 'calificacion no valida'
end;
go


exec spu_comparar_calificacion @califi = -11

go



-- crear un sp para 
-- veric�ficar si un cliente existe antes de debolver su informacion 

go
create or alter proc spu_obtener_clinte_siexiste
@numeroCliente NCHAR(5)
as 
begin
	if exists (select 1 from Customers where CustomerID = @numeroCliente)
		select * from Customers where CustomerID = @numeroCliente;
	else
	Print 'El cliente no existe'
end;
go


select 1 from Customers where CustomerID = 'AROUT'

exec spu_obtener_clinte_siexiste @numeroCliente= 'AROUT'

--




-- Crear un store procedure que permita insertar un cliente, 
-- pero se debe verificar primero que no exista



create or alter procedure spu_agregar_cliente 

   @id nchar(5), 
   @nombre nvarchar(40), 
   @city nvarchar(15) = 'San Miguel'
as
begin
     if exists (select 1 from Customers where CustomerID = @id)
	 begin
	     print ('El cliente ya existe')
	     return 1
	 end

	 insert into customers(customerid, companyname)
	 values(@id, @nombre);
	 print('Cliente insertado exitosamente');
	 return 0;

end;
go


exec spu_agregar_cliente 'AlFKI', 'Patito de Hule'
exec spu_agregar_cliente 'AlFKC', 'Patito de Hule'
go

create or alter procedure spu_agregar_cliente_try_catch
 @id nchar(5), 
 @nombre nvarchar(40), 
 @city nvarchar(15) = 'San Miguel'
 AS
 begin 
	begin try
	  insert into customers(customerid, companyname)
	  values(@id, @nombre);
	  print('Cliente insertado exitosamente');
	end try
	begin catch
		  print ('El cliente ya existe')
	end catch
 end;
 Go
 exec spu_agregar_cliente 'AlFKD', 'Mu�eca Vieja'




-- Manejo de ciclos en stores
--Imprimir el n�mero de veces que indique el usuario

 create or alter procedure spu_imprimir
 @numero int
 AS
 begin 

    if @numero<=0
	begin
	  print('El numero no puede ser 0 o negativo')
	  return
    end 

	declare @i int
	SET @i = 1
	while(@i<=@numero)
	begin 
	  print concat('Numero ' , @i)
	  set @i = @i + 1
	end

 end;
 GO
 exec spu_imprimir 0

