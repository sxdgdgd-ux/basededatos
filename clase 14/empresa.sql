-- Para crear una base de datos SQL, se utiliza la declaracion CREATE DATABASE.
CREATE DATABASE empresa;

-- El comando USE se utiliza para seleccionar la base de datos
USE empresa;

/*
El comando DROP DATABASE sirve para eliminar una base de datos. 
-- DROP DATABASE empresa;
*/

-- Para crear una tabla en SQL, se utiliza la declaracion CREATE TABLE.
CREATE TABLE t_personal
(
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    ciudad VARCHAR(100),
    salario INT,
    departamento VARCHAR(50),
    fecharegistro DATE
);

-- Creacioón de una tabla "productos" con valor por defecto.

CREATE TABLE t_productos
(
    id INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    fechacreacion DATETIME DEFAULT CURRENT_TIMESTAMP
);


/*
ALTER
Añadir la columna "telefono" a la tabla "t_personal"
*/
 ALTER TABLE t_personal
 ADD telefono VARCHAR(20);

/*
Eliminar la columna "fecharegistro" de la tabla "t_personal"
*/
 ALTER TABLE t_personal
 DROP COLUMN fecharegistro;

