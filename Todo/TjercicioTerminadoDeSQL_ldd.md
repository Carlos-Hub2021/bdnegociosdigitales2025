# Ejercicio de creacion de BD con SQL-LDD
```` SQL
-- Creación de la base de datos tienda1

-- Crear la base de datos
CREATE DATABASE tienda1;

-- Utilizar la base de datos
USE tienda1;

-- Crear la tabla categoría
CREATE TABLE categoria (
    categoriaid INT NOT NULL PRIMARY KEY, -- Se define la clave primaria directamente aquí
    nombre VARCHAR(20) NOT NULL
);

-- Insertar datos en la tabla categoría
INSERT INTO categoria (categoriaid, nombre)
VALUES (1, 'Carnes Frías');


-- Consultar los datos de la tabla categoría
SELECT * FROM categoria;



INSERT INTO categoria (categoriaid, nombre)
values (2, 'linea blanca');


INSERT INTO categoria (categoriaid, nombre)
values (3, 'vinos y licores');

insert into categoria
values	(4,'Ropa'),
		(5,'Dulces'),
		(6,'lactios');


		-- Consultar los datos de la tabla categoría ordenados por categoriaid en orden ascendente
SELECT * 
FROM categoria
ORDER BY categoriaid ASC;

insert into categoria(nombre, categoriaid)
values ('Panaderia', 7),
		('Zapateria',8),
		('Jugeteria',9);

-- Renombrar la categoría con categoriaid = 6
UPDATE categoria
SET nombre = 'Lactios'
WHERE categoriaid = 6;


-- -- -- -- -- -- -- -- -- -- -- cerar la tabla de la categoria 5 de dulces -- -- - - -- - - - - - - - -- - - - - - - - - - - - - - - -- - - - - - - - - - -- 
create table producto1(
	productoid int not null,
	nombreProducto varchar(20) not null,
	descripion varchar (80),
	precio money not null,
	existencia int not null,
	categoriaid int null,

	constraint pk_producto1
	primary key (productoid),

	constraint unico_decripcion
	unique(nombreProducto),
	-------------esto es para el presio -----------------------------------
	constraint chk_precio
	check(precio>0.0 and precio<=1000),
	---------- productos en existencia limite de 200------------------------
	constraint check_existencia
	check(existencia>0 and existencia<=200),
	----------------------------------------------
	constraint fk_categoria_producto1
	foreign key  (categoriaid)
	references categoria(categoriaid)
);

select * from categoria 
---------- Esta se almacenan en la categoria 5 = Dulces
insert into producto1
values (1,'migelito', 'Dulces sanos',34.5, 45,5);

insert into producto1
values (2,'tupsi pop', 'Dulces sanos para el diente',35, 35,5);

-----------Esta se almacena el la categoria 2 = linea blanca
insert into producto1
values (3,'Plancha', 'para los trages', 123, 134, 2);
----------------------------------------------------------

-------------Esto es para llamar a todos los productos que estan en la categoria 5 = Dulces
select * from producto1
where categoriaid=5



--------------------crear una tabla de ---  C l i e n t e s --------------
create table cliente(

--- el de identity es cuando ingresamos un dato y se auto incrementa de uno a uno ---- en qsl workbech es: auto_increment  

	clienteid int not null identity(1,1),
	codigocliente varchar (15) not null,
	nombre varchar (30) not null,
	direccion varchar(100) not null,
	telefono varchar(19),
	constraint pk_cliente
	primary key (clienteid),
	constraint unico_codigocliente
	unique (codigocliente)
	
);





--

create table detalleorden(
	ordenfk int not null,
	prodectofk int not null,
	preciocompra money not null,
	cantidad int not null,

	constraint pk_detalleorden
	primary key (ordenfk,prodectofk ),

	constraint chk_preciocompra
	check(preciocompra>0.0 and preciocompra<=20000),
	constraint chk_cantidad
	check (cantidad>0),

	constraint fk_detalleorden_prodecto
	foreign key (prodectofk)
	references producto1(productoid)

);


create table ordencompra(
	oerdenid int not null identity(1,1),
	fechacompra date not null,
	cliente int not null
	constraint pk_ordencompra
	primary key (oerdenid)
	constraint pk_ordencompra_cliente
	foreign key (cliente)
	references cliente (clienteid)
	);

	alter table detalleorden
	add constraint fk_detalleorden_ordencompra
	foreign key (ordenfk)
	references ordencompra(oerdenid);
    


