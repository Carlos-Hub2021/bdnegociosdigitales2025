use Northwind



----------------------------------------------------------------------------------------------------
--						storet procedurces
----------------------------------------------------------------------------------------------------


-- crearte un stort para selecionar todos los crientes
create or alter procedure spu_mostrar_clientes
as
begin
select * from Customers
end;
go

-- ejecute un stor
exec spu_mostrar_clientes


-- crear un sp que muestre los clientes por pais 
-- parametros de entrada

create or alter proc spu_Customers_pais
-- Parametos
@pais nvarchar (15)		-- parameto de entrada
as 
begin
	select * from Customers
	where Country = @pais;
end;

exec spu_Customers_pais 'Germany'   


---------------------------------------------------
-- crear un sp
---------------------------------------------------

create or alter proc spu_Customers_pais
-- Parametos
@pais nvarchar (15),
@pais2 nvarchar (15)-- parameto de entrada
as 
begin
	select * from Customers
	where Country in (@pais,@pais2);
end;

---------------------------------------------------
declare @p1 nvarchar (15) = 'spain';

declare @p2 nvarchar (15) = 'Germany';

exec spu_Customers_pais @p1, @p2;
go

-- generer un reporte que permita visualizar los datos de compra de un determinado de clinte 
-- mostrando , el monto total de compras por producto mediante un sp

select * from vistaOedenesCompras


CREATE OR ALTER PROC spu_informe_ventas
    @nombres NVARCHAR(40) = 'Berglunds snabbkop',
    @fechaInicial DATETIME,
    @fechaFinal DATETIME
AS
BEGIN
    -- Verificar que las fechas no sean nulas
    IF @fechaInicial IS NULL OR @fechaFinal IS NULL
    BEGIN
        PRINT 'Las fechas inicial y final no pueden ser nulas.'
        RETURN
    END

    -- Verificar que la fecha inicial no sea mayor que la fecha final
    IF @fechaInicial > @fechaFinal
    BEGIN
        PRINT 'La fecha inicial no puede ser mayor que la fecha final.'
        RETURN
    END

    -- Consulta para obtener el informe de ventas
    SELECT 
        [Nombre de producto], 
        [Nombre del clinte],
        SUM(importe) AS [Monto Total]
    FROM 
        vistaOedenesCompras
    WHERE 
        [Nombre del clinte] = @nombres
        AND [Fecha de requerimiento] BETWEEN @fechaInicial AND @fechaFinal
    GROUP BY 
        [Nombre de producto], [Nombre del clinte]
    ORDER BY 
        [Monto Total] DESC;
END;
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



go
-- store procedues con parametros de salida

create or alter proc spu_obtener_numero_clientes
@customerid nchar (5),
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





-- crear un sp para 
-- veric¿ficar si un cliente existe antes de debolver su informacion 

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
--CREAR UN SP QUE PERMITA INSERTAR UN CLINTE PERO PRIMERO SE TIENE QUE VERIFICAR QUE NO EXISTA

CREATE OR ALTER PROC spu_existenciaCliente
@cliente nchar(5),
@nombreCliente nvarchar(40),
@nombreContacto nvarchar(30),
@tituloContacto nvarchar(30),
@direccion nvarchar(60),
@ciudad nvarchar(30), -- Falta la ciudad en la tabla Customers
@region nvarchar(15),
@codigoPostal nvarchar(10), -- Corregido el nombre del parámetro
@pais nvarchar(15),
@telefono nvarchar(24),
@faxCliente nvarchar(24)
AS
BEGIN

    IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @cliente)
    BEGIN
        INSERT INTO Customers (CustomerID, CompanyName, ContactName, ContactTitle, [Address], City, Region, PostalCode, Country, Phone, Fax)
        VALUES (@cliente, @nombreCliente, @nombreContacto, @tituloContacto, @direccion, @ciudad, @region, @codigoPostal, @pais, @telefono, @faxCliente);
        PRINT 'Cliente insertado correctamente.';
    END
    ELSE 
    BEGIN
        PRINT 'El cliente ya existe.';
    END
END
GO


CREATE OR ALTER PROC spu_existenciaCliente_Try_Catch
    @cliente nchar(5),
    @nombreCliente nvarchar(40),
    @nombreContacto nvarchar(30),
    @tituloContacto nvarchar(30),
    @direccion nvarchar(60),
    @ciudad nvarchar(30), -- Falta la ciudad en la tabla Customers
    @region nvarchar(15),
    @codigoPostal nvarchar(10), -- Corregido el nombre del parámetro
    @pais nvarchar(15),
    @telefono nvarchar(24),
    @faxCliente nvarchar(24)
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @cliente)
        BEGIN
            INSERT INTO Customers (CustomerID, CompanyName, ContactName, ContactTitle, [Address], City, Region, PostalCode, Country, Phone, Fax)
            VALUES (@cliente, @nombreCliente, @nombreContacto, @tituloContacto, @direccion, @ciudad, @region, @codigoPostal, @pais, @telefono, @faxCliente);
            PRINT 'Cliente insertado correctamente.';
        END
        ELSE 
        BEGIN
            PRINT 'El cliente ya existe.';
        END
    END TRY
    BEGIN CATCH
        -- Captura el error y muestra un mensaje
        PRINT 'Error: ' + ERROR_MESSAGE();
        PRINT 'Número de error: ' + CAST(ERROR_NUMBER() AS VARCHAR);
        PRINT 'Estado de error: ' + CAST(ERROR_STATE() AS VARCHAR);
        PRINT 'Procedimiento que causó el error: ' + ERROR_PROCEDURE();
        PRINT 'Línea del error: ' + CAST(ERROR_LINE() AS VARCHAR);
    END CATCH
END
GO

-- Manejo de ciclos en stores
--Imprimir el número de veces que indique el usuario
CREATE OR ALTER PROCEDURE spu_Imprimir
    @numero INT
AS
BEGIN

    IF @numero <= 0
    BEGIN
        PRINT 'El número debe ser mayor que 0.';
        RETURN; -- SALE DEL PROCEDIMIENTO SI EL RETURN NO ES VÁLIDO
    END

    DECLARE @i INT = 1;

    WHILE @i <= @numero
    BEGIN
        PRINT @i; 
        SET @i = @i + 1;
    END
END;
GO

exec spu_Imprimir @numero = 10


