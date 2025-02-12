-- Crear la base de datos si no existe
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'TiendaVideojuegos')
BEGIN
    CREATE DATABASE TiendaVideojuegos;
END
GO

-- Usar la base de datos
USE TiendaVideojuegos;
GO

-- Tabla Distribuidor
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Distribuidor')
BEGIN
    CREATE TABLE Distribuidor (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Marca NVARCHAR(50) NOT NULL,
        Descripcion NVARCHAR(200) NULL
    );
END
GO

-- Tabla Genero
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Genero')
BEGIN
    CREATE TABLE Genero (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Nombre NVARCHAR(50) NOT NULL,
        CompId INT NOT NULL
    );
END
GO

-- Tabla Plataforma
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Plataforma')
BEGIN
    CREATE TABLE Plataforma (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Nombre NVARCHAR(50) NOT NULL
    );
END
GO

-- Tabla VideoJuego
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'VideoJuego')
BEGIN
    CREATE TABLE VideoJuego (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Nombre NVARCHAR(30) NOT NULL,
        FechaLanzamiento DATE NOT NULL,
        UnidadesDisponibles INT NOT NULL,
        Descripcion NVARCHAR(200) NULL,
		Precio DECIMAL(10,2) NOT NULL, 
        DistribuidorId INT NOT NULL,
        GeneroId INT NOT NULL,
        PlataformaId INT NOT NULL,
        CONSTRAINT fk_Videojuego_Distribuidor FOREIGN KEY (DistribuidorId) REFERENCES Distribuidor(Id) ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT fk_videojuegos_Genero FOREIGN KEY (GeneroId) REFERENCES Genero(Id) ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT fk_videojuegos_plataforma FOREIGN KEY (PlataformaId) REFERENCES Plataforma(Id) ON DELETE NO ACTION ON UPDATE NO ACTION
    );
END
GO
USE TiendaVideojuegos;
GO

-- Insertar en la tabla Distribuidor
INSERT INTO Distribuidor (Marca, Descripcion) VALUES
('Nintendo', 'Empresa japonesa de videojuegos'),
('Sony', 'Empresa creadora de PlayStation'),
('Microsoft', 'Empresa creadora de Xbox'),
('Ubisoft', 'Desarrolladora de videojuegos'),
('Electronic Arts', 'Empresa de videojuegos EA Sports'),
('Rockstar Games', 'Creador de GTA y Red Dead'),
('Capcom', 'Desarrollador de Resident Evil'),
('Square Enix', 'Creador de Final Fantasy'),
('Activision', 'Empresa creadora de Call of Duty'),
('SEGA', 'Empresa de Sonic y otros clásicos');

-- Insertar en la tabla Genero
INSERT INTO Genero (Nombre, CompId) VALUES
('Acción', 1),
('Aventura', 2),
('RPG', 3),
('Estrategia', 4),
('Deportes', 5),
('Shooter', 6),
('Survival Horror', 7),
('Plataformas', 8),
('Carreras', 9),
('Peleas', 10);

-- Insertar en la tabla Plataforma
INSERT INTO Plataforma (Nombre) VALUES
('PC'),
('PlayStation 5'),
('Xbox Series X'),
('Nintendo Switch'),
('PlayStation 4'),
('Xbox One'),
('PlayStation 3'),
('Xbox 360'),
('Nintendo 3DS'),
('VR - Realidad Virtual');

-- Insertar en la tabla VideoJuego
INSERT INTO VideoJuego (Nombre, FechaLanzamiento, UnidadesDisponibles, Descripcion, Precio, DistribuidorId, GeneroId, PlataformaId) VALUES
('The Legend of Zelda: BOTW', '2017-03-03', 500, 'Aventura épica en un mundo abierto', 1299.99, 1, 2, 4),
('God of War Ragnarök', '2022-11-09', 300, 'Kratos regresa en una nueva batalla nórdica', 1399.99, 2, 1, 2),
('Halo Infinite', '2021-12-08', 400, 'El Jefe Maestro regresa en una nueva historia', 999.99, 3, 6, 3),
('Assassin’s Creed Valhalla', '2020-11-10', 350, 'Vive la era vikinga en esta aventura', 1199.99, 4, 2, 2),
('FIFA 23', '2022-09-30', 1000, 'El simulador de fútbol más realista', 899.99, 5, 5, 2),
('GTA V', '2013-09-17', 600, 'Mundo abierto con acción y crimen', 799.99, 6, 1, 5),
('Resident Evil 4 Remake', '2023-03-24', 450, 'Revive el clásico de horror y acción', 1199.99, 7, 7, 2),
('Final Fantasy XVI', '2023-06-22', 500, 'Nueva entrega del aclamado RPG', 1299.99, 8, 3, 2),
('Call of Duty: MW2', '2022-10-28', 700, 'Shooter bélico con campaña y multijugador', 1099.99, 9, 6, 2),
('Sonic Frontiers', '2022-11-08', 350, 'Sonic en un mundo abierto de plataformas', 999.99, 10, 8, 4);
GO
