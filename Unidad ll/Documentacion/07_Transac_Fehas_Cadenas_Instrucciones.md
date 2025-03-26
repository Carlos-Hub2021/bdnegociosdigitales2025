
## Funcione sde cadena Fecha instrucciones de contol 

## V ariables
```sql
---------------------------------------------------------------
--						Funciones de Cadena
---------------------------------------------------------------
```
## Las funciones de casdena permite manipular tipos de datos como varchar , nvarchar , char, nchar

### funcion len devuelve la lonjitud de una cadena 

### Declaracion de una variable 

```sql
-- Declare @Texto varchar(50) = 'Hola, Mundo!'		-- un dato con su valor 

Declare @numero int ;							-- un dato sin numero 
set @numero = 10;								-- sele agrega un valor 

print @numero
```

## quiero el tama�o de la cadena almacenada en texto en la variable texto

```sql
Declare @Texto varchar(50) = 'Hola, Mundo!'		-- un dato con su valor 
```
```sql
select LEN(@Texto) as 'Longitud'

select CompanyName,  len (CompanyName) from Customers  
```
```sql
-- funcion left extrae un mumero expoecifico de carateres desde el inicio de la cadena 

select LEFT (@Texto, 4) as inicio
```
```sql
-- RIGTH Eztrae un determinado numero de carateres de la cadena 

select right(@Texto, 6) as final 
```
```sql
-- substring -> Exta una parte de la cadena 
Declare @Texto2 varchar(50) = 'Hola, Mundo!' -- donde el primeer parametro es la ocicion inicial 
-- 
select SUBSTRING(@Texto2, 6, 6) as Mundo 

select CompanyName,  len (CompanyName) as 'Numero de carateres',
LEFT(CompanyName, 4) as inicio,
right(CompanyName, 6) as final,
SUBSTRING(CompanyName, 7,4) as subCadena
from Customers  
```

### Replace
## la funcion Recplace , remplasa un asub cadena por otra 

```sql
-- REPLACE ( string_expression , string_pattern , string_replacement )

-- declare @Texto3 varchar(50) = 'Hola, Mundo!'
select REPLACE(@Texto3,'Mundo','Amigo')
```
```sql

-- charindex
select CHARINDEX('Mundo', @Texto3) -- te da la pocicion de donde inicia 

-- upper -> combirte una cadena en mayusculas 

-- declare @Texto3 varchar(50) = 'Hola, Mundo!'

select CONCAT(
				LEFT(@Texto3,6),
				upper( SUBSTRING(@Texto3, 6,6)),
				right (@Texto3, 1)
				) as TextoNuevo


update Customers
set CompanyName = upper (CompanyName)
where Country in ('Mexico', 'Germany')

select * from Customers
```

### Trin quita espacion de una cadena
```sql
SELECT TRIM( '     test    ') AS Result;

declare @Texto3 varchar(50) = '         Hola, Mundo!    '

SELECT TRIM(@Texto3) AS RESULTADO;
```

### crearte un stort para selecionar todos los crientes
```sql
create or alter procedure spu_mostrar_clientes
as
begin
select * from Customers
end;
go
```
## ejecute un stor
```sql
exec spu_mostrar_clientes
```





