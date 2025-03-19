
	select c.Categoriaid, 
	c.Nombre,
	p.Productoid,
	p.Nombre
	from Categorias as c
	inner join Productos as p
	on c.Categoriaid = p.Categoriaid



	select c.Categoriaid, 
	c.Nombre,
	p.Productoid,
	p.Nombre	
	from Categorias as c
	left join Productos as p
	on c.Categoriaid = p.Categoriaid


	select c.Categoriaid, 
	c.Nombre,p.Categoriaid,
	p.Productoid,
	p.Nombre
	
	from Productos as p
	left join Categorias  as c
	on c.Categoriaid = p.Categoriaid






	----------------------------		----------------------------		----------------------------
	EXEC sp_rename 'Products_nuw', 'Products_New';

	CREATE TABLE Products_nuw (
    ProductID INT,
    ProductName NVARCHAR(255),
    CompanyName NVARCHAR(255),
    CategoryName NVARCHAR(255),
    UnitPrice MONEY,
    Discontinued BIT,
    FechaRegistro DATETIME
);


INSERT INTO Products_nuw (ProductID, ProductName, CompanyName, CategoryName, UnitPrice, Discontinued, FechaRegistro)
SELECT 
    p.ProductID,
    p.ProductName,
    cu.CompanyName,
    c.CategoryName,
    od.UnitPrice,
    p.Discontinued,
    GETDATE()
FROM 
    Products AS p
    INNER JOIN Categories AS c ON p.CategoryID = c.CategoryID
    INNER JOIN [Order Details] AS od ON od.ProductID = p.ProductID
    INNER JOIN Orders AS o ON o.OrderID = od.OrderID
    INNER JOIN Customers AS cu ON cu.CustomerID = o.CustomerID;


	----------------------------		----------------------------		----------------------------

	select * from Products_nuw

	
use Northwind

select * from Products_neus

--	 Carga full
	
	select * from Products_neus

	select 
	p.ProductID ,
	p.ProductName ,
	cu.CompanyName,
	c.CategoryName ,
	od.UnitPrice ,
	p.Discontinued ,
	getdate()

	from Products as p
	inner join Categories as c
	on p.CategoryID = c.CategoryID

	inner join [Order Details] as od
	on od.ProductID = p.ProductID

	inner join Orders as o
	on o.OrderID = od.OrderID

	inner join Customers as cu
	on cu.CustomerID = o.CustomerID

