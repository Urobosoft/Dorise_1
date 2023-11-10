DROP DATABASE IF EXISTS doris;
CREATE DATABASE doris;
USE doris;

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

CREATE TABLE animales (
  IdMascota INT AUTO_INCREMENT PRIMARY KEY,
  Nombre VARCHAR(50) NOT NULL,
  Edad INT NOT NULL,
  InicioPeriodo DATE NULL,
  FinPeriodo DATE NULL,
  Especie VARCHAR(20) NOT NULL,
  Raza VARCHAR(50) NOT NULL,
  Sexo VARCHAR(10) NOT NULL
);

CREATE TABLE Lista_Mascotas (
  IdLista INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  IdUsuario INT NOT NULL,
  IdMascota INT NOT NULL,
  FOREIGN KEY (IdUsuario) REFERENCES usuarios(id),
  FOREIGN KEY (IdMascota) REFERENCES animales(IdMascota)
);

CREATE TABLE Direccion (
  idDireccion INT AUTO_INCREMENT PRIMARY KEY,
  Calle VARCHAR(30),
  NoExt INT,
  Noint INT,
  Colonia VARCHAR(30),
  Codigo_Postal INT,
  Municipio VARCHAR(50),
  Estado VARCHAR(30)
);

CREATE TABLE Lista_Direccion (
  idListaDir INT AUTO_INCREMENT PRIMARY KEY,
  idUsuario INT,
  idDireccion INT,
  FOREIGN KEY (idUsuario) REFERENCES usuarios(id),
  FOREIGN KEY (idDireccion) REFERENCES Direccion(idDireccion),
  UNIQUE KEY idx_usuario_direccion (idUsuario, idDireccion)
);
CREATE TABLE Adopcion (
  idAdopcion INT AUTO_INCREMENT PRIMARY KEY,
  idMascota INT,
  EdadMascota INT,
  NombreMascota VARCHAR(20),	
  Procedencia VARCHAR(30),
  Municipio VARCHAR(50),
  FOREIGN KEY (idMascota) REFERENCES animales(IdMascota)
);

CREATE TABLE Lista_Adopciones (
  idLista_Adopcion INT AUTO_INCREMENT PRIMARY KEY,
  idAdopcion INT,
  idUsuario INT,
  FOREIGN KEY (idAdopcion) REFERENCES Adopcion(idAdopcion),
  FOREIGN KEY (idUsuario) REFERENCES usuarios(id)
);


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

