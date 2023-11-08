create database doris;
use doris;
CREATE TABLE usuarios (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  contrasenia VARCHAR(50) NOT NULL,
  sexo VARCHAR(10) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  correo_electronico VARCHAR(50) NOT NULL,
  telefono_celular VARCHAR(20) NOT NULL,
  PRIMARY KEY (id)
);

	create TABLE animales (
        IdMascota INT auto_increment PRIMARY KEY,
        Nombre VARCHAR(50) NOT NULL,
        Edad INT NOT NULL,
        InicioPeriodo DATE NULL,
        FinPeriodo DATE NULL,
        Especie VARCHAR(20) NOT NULL,
        Raza VARCHAR(50) NOT NULL,
        Sexo VARCHAR(10) NOT NULL
);

    
    create table Lista_Mascotas(
								IdLista int NOT NULL AUTO_INCREMENT primary key,
                                IdUsuario int not null,
                                IdMascota int not null,
                                foreign key(IdUsuario) references usuarios(id),
                                foreign key(IdMascota) references animales(IdMascota)
    );
    create table Direccion(
							idDireccion int auto_increment primary key,
                            Calle varchar(30),
                            NoExt int,
                            Noint int,
                            Colonia varchar(30),
                            Codigo_Postal int,
                            Municipio varchar(50),
                            Estado varchar(30)
    );
		create table Lista_Direccion(
									 idListaDir int auto_increment primary key,
                                     idUsuario int,
                                     idDireccion int,
                                     foreign key(IdUsuario) references usuarios(id),
                                     foreign key(idDireccion) references Direccion(idDireccion),
                                     unique key idx_usuario_direccion (idUsuario, idDireccion)
    );
    create table Lista_Adopciones(idLista_Adopcion int auto_increment primary key,
								  idAdopcion INT,
								  idUsuario INT,
                                  foreign key(idAdopcion) references Adopcion(idAdopcion),
								  foreign key(idUsuario) references usuarios(id));
    create table Adopcion(idAdopcion int primary key auto_increment,
						  idMascota int,
                          EdadMascota int,
						  NombreMascota varchar(20),	
						  Procedencia varchar(30),
                          Municipio varchar(50),
						  foreign key (idMascota) references A(idMascota));
select * from direccion inner join Lista_Direccion on direccion.idDireccion=Lista_Direccion.idDireccion where idUsuario;
select * from Lista_Adopciones;
select * from Adopcion;
select * from usuarios;
select * from Direccion;
select idLista, idUsuario, Lista_Mascotas.idMascota, Nombre from Lista_Mascotas inner join animales on Lista_Mascotas.idMascota=animales.idMascota;
select * from animales;
SELECT animales.Especie, animales.Raza, animales.Edad, Lista_Mascotas.idUsuario
    FROM animales
    INNER JOIN Lista_Mascotas ON animales.IdMascota = Lista_Mascotas.IdMascota
    ;
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar`(
    IN var1 VARCHAR(50),
    IN var2 VARCHAR(50),
    IN var3 VARCHAR(10),
    IN var4 DATE,
    IN var5 VARCHAR(50),
    IN var6 VARCHAR(20),
    OUT var7 INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SET var7 = -1;
    END;

    START TRANSACTION;
    INSERT INTO usuarios (nombre, contrasenia, sexo, fecha_nacimiento, correo_electronico, telefono_celular)
    VALUES (var1, var2, var3, var4, var5, var6);
    SET var7 = LAST_INSERT_ID();
    COMMIT;
END$$

DELIMITER ;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarAdopcion`(
    IN var1 INT,
    IN var2 INT,
    IN var3 VARCHAR(20),
    IN var4 INT,
    IN var5 VARCHAR(20),
    IN var6 VARCHAR(40)
)
BEGIN
    DECLARE last_id INT;
    START TRANSACTION;
    
    INSERT INTO Adopcion (idMascota, EdadMascota, NombreMascota, Procedencia, Municipio)
    VALUES (var1, var4, var3, var5, var6);
    
    SELECT LAST_INSERT_ID() INTO last_id;
    
    INSERT INTO Lista_Adopciones (idAdopcion, idUsuario)
    VALUES (last_id, var2);
    
    COMMIT;
END$$

DELIMITER ;
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarAnimal`(
    IN var1 VARCHAR(50),
    IN var2 INT,
    IN var3 DATE,
    IN var4 DATE,
    IN var5 VARCHAR(20),
    IN var6 VARCHAR(50),
    IN var7 VARCHAR(10),
    IN var8 INT
)
BEGIN
    DECLARE last_id INT;
    START TRANSACTION;
    
    INSERT INTO animales(Nombre, Edad, InicioPeriodo, FinPeriodo, Especie, Raza, Sexo)
    VALUES (var1, var2, var3, var4, var5, var6, var7);
    
    SELECT LAST_INSERT_ID() INTO last_id;
    
    INSERT INTO Lista_Mascotas(IdUsuario, IdMascota)
    VALUES (var8, last_id);
    
    COMMIT;
END$$

DELIMITER ;
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarDir`(
    IN var1 VARCHAR(30),
    IN var2 INT,
    IN var3 INT,
    IN var4 INT,
    IN var5 VARCHAR(50),
    IN var6 VARCHAR(50),
    IN var7 VARCHAR(50),
    IN var8 INT
)
BEGIN
    DECLARE last_id INT;
    START TRANSACTION;
    
    INSERT INTO Direccion(Calle, NoExt, Noint, Codigo_Postal, Colonia, Estado, Municipio)
    VALUES(var1, var2, var3, var4, var5, var6, var7);
    
    SELECT LAST_INSERT_ID() INTO last_id;
    
    INSERT INTO Lista_Direccion(idUsuario, idDireccion)
    VALUES(var8, last_id)
    ON DUPLICATE KEY UPDATE idUsuario = var8;
    
    COMMIT;
END$$

DELIMITER ;
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarAnimal`(
    IN var1 INT
)
BEGIN
    SELECT * FROM animales WHERE idMascota = var1;
END$$

DELIMITER ;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarCruza`(
    IN id_usuario INT
)
BEGIN
    -- Verificar si el usuario tiene mascotas de ambos sexos
    SELECT COUNT(DISTINCT Sexo) INTO @num_sexos FROM animales 
    INNER JOIN Lista_Mascotas ON animales.IdMascota = Lista_Mascotas.IdMascota 
    WHERE Lista_Mascotas.IdUsuario = id_usuario;

    -- Buscar mascotas compatibles de otros usuarios
    SELECT 
        animales.*, 
        usuarios.nombre AS nombre_usuario, 
        animales.Nombre AS nombre_mascota, 
        animales.Sexo AS sexo_mascota,
        direccion.Colonia, 
        direccion.Codigo_Postal, 
        direccion.Municipio AS Municipio, 
        direccion.Estado
    FROM 
        animales
    INNER JOIN Lista_Mascotas ON animales.IdMascota = Lista_Mascotas.IdMascota
    INNER JOIN usuarios ON Lista_Mascotas.IdUsuario = usuarios.id
    INNER JOIN Lista_Direccion ON Lista_Direccion.idUsuario = usuarios.id
    INNER JOIN Direccion ON Lista_Direccion.idDireccion = Direccion.idDireccion
    WHERE 
        animales.Especie IN (SELECT Especie FROM animales
            INNER JOIN Lista_Mascotas ON animales.IdMascota = Lista_Mascotas.IdMascota
            WHERE Lista_Mascotas.IdUsuario = id_usuario)
        AND animales.Raza IN (SELECT Raza FROM animales
            INNER JOIN Lista_Mascotas ON animales.IdMascota = Lista_Mascotas.IdMascota
            WHERE Lista_Mascotas.IdUsuario = id_usuario)
        AND (
            (animales.Edad - 3) <= (
                SELECT MAX(Edad) FROM animales
                INNER JOIN Lista_Mascotas ON animales.IdMascota = Lista_Mascotas.IdMascota
                WHERE Lista_Mascotas.IdUsuario = id_usuario
            )
            AND (animales.Edad + 3) >= (
                SELECT MIN(Edad) FROM animales
                INNER JOIN Lista_Mascotas ON animales.IdMascota = Lista_Mascotas.IdMascota
                WHERE Lista_Mascotas.IdUsuario = id_usuario
            )
        )
        AND (
            (@num_sexos = 1 AND animales.Sexo != (
                SELECT Sexo FROM animales
                INNER JOIN Lista_Mascotas ON animales.IdMascota = Lista_Mascotas.IdMascota
                WHERE Lista_Mascotas.IdUsuario = id_usuario LIMIT 1
            ))
            OR @num_sexos > 1
        )
        AND Direccion.Municipio IN (
            SELECT direccion.Municipio FROM Direccion
            INNER JOIN Lista_Direccion ON Direccion.idDireccion = Lista_Direccion.idDireccion
            WHERE Lista_Direccion.idUsuario = id_usuario
        )
        AND Lista_Mascotas.IdUsuario != id_usuario;

END$$

DELIMITER ;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `desplegarAdopciones`(
    IN var1 INT
)
BEGIN
    SELECT 
        Adopcion.idMascota, 
        Adopcion.idAdopcion, 
        EdadMascota AS Edad, 
        NombreMascota, 
        Procedencia, 
        Adopcion.Municipio 
    FROM 
        Adopcion 
        INNER JOIN Lista_Adopciones ON Adopcion.idAdopcion = Lista_Adopciones.idAdopcion
        INNER JOIN usuarios ON Lista_Adopciones.idUsuario = usuarios.id 
    WHERE 
        var1 != usuarios.id;
END$$

DELIMITER ;
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `desplegarAnimal`(
    IN var1 INT
)
BEGIN
    SELECT 
        animales.Nombre, 
        animales.idMascota, 
        Edad, 
        InicioPeriodo, 
        FinPeriodo, 
        Especie, 
        Raza, 
        animales.Sexo 
    FROM 
        Lista_Mascotas 
        INNER JOIN usuarios ON Lista_Mascotas.idUsuario = usuarios.id
        INNER JOIN animales ON Lista_Mascotas.idMascota = animales.idMascota 
    WHERE 
        idUsuario = var1;
END$$

DELIMITER ;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `desplegarDir`(
    IN var1 INT
)
BEGIN
    SELECT 
        Direccion.idDireccion, 
        Direccion.Estado, 
        Direccion.Municipio, 
        Direccion.Colonia, 
        Direccion.Codigo_Postal
    FROM 
        Direccion 
        INNER JOIN Lista_Direccion ON Direccion.idDireccion = Lista_Direccion.idDireccion
    WHERE 
        Lista_Direccion.idUsuario = var1;
END$$

DELIMITER ;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `desplegarMisAdopciones`(
    IN var1 INT
)
BEGIN
    SELECT 
        Adopcion.idMascota, 
        Adopcion.idAdopcion, 
        EdadMascota AS Edad, 
        NombreMascota, 
        Procedencia, 
        Adopcion.Municipio 
    FROM 
        Adopcion 
        INNER JOIN Lista_Adopciones ON Adopcion.idAdopcion = Lista_Adopciones.idAdopcion
        INNER JOIN usuarios ON Lista_Adopciones.idUsuario = usuarios.id 
    WHERE 
        var1 = usuarios.id;
END$$

DELIMITER ;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EditarMascota`(
    IN var1 INT,
    IN var2 VARCHAR(20),
    IN var3 INT,
    IN var4 VARCHAR(20),
    IN var5 DATE,
    IN var6 DATE
)
BEGIN
    UPDATE animales 
    SET 
        Nombre = var2, 
        Edad = var3, 
        Sexo = var4, 
        InicioPeriodo = var5, 
        FinPeriodo = var6 
    WHERE 
        idMascota = var1;
END$$

DELIMITER ;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarAdopcion`(
    IN var1 INT
)
BEGIN
    DELETE FROM Lista_Adopciones WHERE idAdopcion = var1;
    DELETE FROM Adopcion WHERE idAdopcion = var1;
END$$

DELIMITER ;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarAnimal`(
    IN var1 INT
)
BEGIN
    DELETE FROM Lista_Mascotas WHERE IdMascota = var1;
    DELETE FROM animales WHERE IdMascota = var1;
END$$

DELIMITER ;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarDir`(
    IN var1 INT
)
BEGIN
    DELETE FROM Lista_Direccion WHERE idDireccion = var1;
    DELETE FROM Direccion WHERE idDireccion = var1;
END$$

DELIMITER ;

