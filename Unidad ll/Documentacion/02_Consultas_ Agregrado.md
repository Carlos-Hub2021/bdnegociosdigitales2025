# Consultas de Agregado
Estas consultas devuelven un solo registro utilizando funciones de agregación como SUM, AVG, COUNT, MAX y MIN.

---

### Cuántos clientes tengo
```sql
select count(*) as [Numero de Clientes] 
from Customers;
```

### Cuántas regiones hay
```sql
select count(*) 
from Customers  
where region is null;
```

### Cuántas regiones tengo
```sql
select count (distinct region) 
from Customers  
where region is not null;
```

---

### Contar el número de filas en Orders
```sql
select 
    COUNT(*) -- Cuenta el número de filas 
from Orders;
```

### Seleccionar el precio más bajo de los productos
```sql
select 
    min(UnitPrice) -- Busca el precio más bajo
from Products;
```

### Obtener valores de productos (mínimo, máximo, promedio y suma)
```sql
select 
    min(UnitPrice),		-- Busca el precio más bajo
    max (UnitPrice),		-- Busca el precio más alto
    avg (UnitsInStock),	-- Promedio de unidades en stock
    sum (UnitPrice)		-- Suma de precios
from Products;
```

---

### Contar el número de pedidos
```sql
select 
    COUNT(*) as [Numero de pedidos] 
from Orders;
```

### Calcular el total de dinero vendido
```sql
select 
    sum (UnitPrice * Quantity)
from [Order Details];
```

### Calcular el total de dinero vendido con descuento
```sql
select 
    sum (UnitPrice * Quantity - (UnitPrice * Quantity * Discount)) AS total -- Aplica el descuento
from [Order Details];
```

### Calcular el total de unidades en stock de todos los productos
```sql
select 
    sum (UnitsInStock)
from Products;
```

---

### Consultar todas las órdenes
```sql
select * 
from Orders;
```

---

# Uso de GROUP BY
Agregar y agrupar los resultados por categorías, empleados, productos, etc.

---

### Contar el número de productos por categoría
```sql
select 
    CategoryID, 
    COUNT(*)		-- Número de productos por categoría
from Products
group by CategoryID;
```

### Contar el número de productos por categoría utilizando un JOIN con Categories
```sql
select 
    p.CategoryID, 
    COUNT(*) 
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
group by p.CategoryID;
```

---

### Contar productos por nombre de categoría
```sql
select 
    Categories.CategoryName, 
    COUNT (*) as [Numero de productos]
from Categories
inner join Products as p
on Categories.CategoryID  = p.CategoryID
group by Categories.CategoryName;
```

### Calcular el promedio de precios de productos por categoría
```sql
select 
    CategoryID,
    avg(UnitPrice ) as 'Precio Promedio'
from Products
group by CategoryID;
```

---

### Calcular el promedio de precios solo para ciertas categorías
```sql
select 
    CategoryID,
    avg(UnitPrice ) as 'Precio Promedio'
from Products
where CategoryID in (1,2,3)
group by CategoryID;
```

---

### Contar el número de pedidos realizados por cada empleado
```sql
select 
    EmployeeID, 
    COUNT(*) as 'Número de ordenes por empleados'
from Orders
group by EmployeeID;
```

---

### Contar el número de pedidos realizados por cada empleado en el último trimestre de 1996
```sql
select 
    EmployeeID, 
    COUNT(*) 
from Orders
where OrderDate between '1996-10-01' and '1996-12-31'
group by EmployeeID;
```

---

### Calcular el total de unidades vendidas por cada producto
```sql
select 
    ProductID, 
    sum (Quantity) as 'Número de productos vendidos' 
from [Order Details]
group by ProductID
order by 1 desc;
```

### Mostrar cada producto con la cantidad vendida
```sql
select 
    OrderID, 
    ProductID, 
    sum (Quantity) as 'Número de productos vendidos'
from [Order Details]
group by OrderID, ProductID
order by 2 desc;
```

---

# Uso de HAVING
Filtrar resultados después de aplicar GROUP BY.

---

### Seleccionar productos por categoría, pero solo aquellos que tengan más de 10 productos
```sql
-- Paso 1: Consultar categorías disponibles
select distinct CategoryID 
from Products;
```

```sql
-- Paso 2: Mostrar unidades en stock por categoría
select 
    CategoryID, 
    UnitsInStock 
from Products
where CategoryID in (2,4,8)
order by CategoryID;
```

```sql
-- Paso 3: Calcular la suma de unidades en stock por categoría
select 
    CategoryID, 
    sum(UnitsInStock) 
from Products
where CategoryID in (2,4,8)
group by CategoryID
order by CategoryID;
```

```sql
-- Paso 4: Filtrar categorías con más de 10 productos en stock
select 
    CategoryID, 
    sum(UnitsInStock) 
from Products
where CategoryID in (2,4,8)
group by CategoryID
having count(*) >= 10 
order by CategoryID;
```

### Seleccionar las categorías con más de 10 productos
```sql
select 
    CategoryID, 
    COUNT(ProductID) AS TotalProductos
from Products
group by CategoryID
having COUNT(ProductID) > 10;
```

---

### Listar las órdenes agrupadas por empleado, pero solo aquellas que hayan gestionado más de 10 pedidos
```sql
select 
    EmployeeID, 
    COUNT(*) as 'Número de órdenes por empleado'
from Orders
group by EmployeeID
having COUNT(*) > 10;
```