--



-- crear una tabla a partir de una consulta

CREATE TABLE ProductsNew (
    productpk INT IDENTITY(1,1) PRIMARY KEY, -- Clave primaria autoincremental
    productid INT NOT NULL,
    productName NVARCHAR(40) NOT NULL,
    Customer NVARCHAR(40) NOT NULL,
    Category NVARCHAR(15) NOT NULL,
    UnitPrice MONEY NOT NULL,
    discontinued BIT NOT NULL,
    Fecha_Date DATETIME NOT NULL
);

	----------------------------		----------------------------		----------------------------
-- insertar 

INSERT INTO ProductsNew (productid, productName, Customer, Category, UnitPrice, discontinued, Fecha_Date)
SELECT 
    p.ProductID AS productid,
    p.ProductName AS productName,
    cu.CompanyName AS Customer,
    c.CategoryName AS Category,
    od.UnitPrice AS UnitPrice,
    p.Discontinued AS discontinued,
    GETDATE() AS insertDate
FROM 
    Products AS p
    INNER JOIN Categories AS c ON p.CategoryID = c.CategoryID
    INNER JOIN [Order Details] AS od ON od.ProductID = p.ProductID
    INNER JOIN Orders AS o ON o.OrderID = od.OrderID
    INNER JOIN Customers AS cu ON cu.CustomerID = o.CustomerID;

	select * from ProductsNew
--  	drop table -- esliminar una tabla




