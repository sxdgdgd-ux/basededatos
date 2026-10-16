CREATE DATABASE farmavida;

USE farmavida;

CREATE TABLE t_cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    rut VARCHAR(12) NOT NULL,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefono CHAR(9) NOT NULL,
    comuna VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    cliente_frecuente BOOLEAN DEFAULT 0 NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    observaciones TEXT
);

CREATE TABLE t_medicamento (
    id_medicamento INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    laboratorio VARCHAR(100) NOT NULL,
    codigo_barra VARCHAR(20) NOT NULL UNIQUE,
    categoria ENUM('Analgesico', 'Antibiotico', 'Vitamina'),
    requiere_receta BOOLEAN DEFAULT 0 NOT NULL,
    stock INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    porcentaje_descuento DECIMAL(5,2) NOT NULL,
    descripcion MEDIUMTEXT,
    fecha_vencimiento DATE NOT NULL,
    fecha_ingreso DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE t_venta (
    id_venta INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_medicamento INT NOT NULL,
    tipo_pago ENUM('EFE', 'DEB', 'CRE') NOT NULL,
    hora_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    cantidad INT NOT NULL,
    numero_boleta BIGINT NOT NULL,
    monto_total DECIMAL(10,2) NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    venta_anulada BOOLEAN DEFAULT 0 NOT NULL,
    detalle_receta LONGTEXT
);


--- Modificaciones a las tablas ---
-- MODIFICACION TABLA t_cliente agregar columna region
ALTER TABLE t_cliente
ADD region VARCHAR(15) NOT NULL AFTER comuna;


-- MODIFICACION TABLA t_medicamento agregar columna es_generico
ALTER TABLE t_medicamento
ADD es_generico BOOLEAN DEFAULT 0 NOT NULL;

-- MODIFICACION TABLA t_venta eliminar la columna detalle_receta
ALTER TABLE t_venta
DROP COLUMN detalle_receta;

-- MANIPULACION DE DATOS 

-- INSERTAR 3 REGISTROS EN t_cliente ignorando las que poseen valor por defecto 
INSERT INTO t_cliente (rut, nombres, apellidos, email, telefono, comuna, fecha_nacimiento)
VALUES
('22.222.222-2', 'Juan', 'Perez', 'juan.perez@email.com', '123456789', 'Santiago', '1990-01-01'),
('33.333.333-3', 'Maria', 'Gonzalez', 'maria.gonzalez@email.com', '987654321', 'Valparaiso', '1985-05-15'),
('44.444.444-4', 'Pedro', 'Ramirez', 'pedro.ramirez@email.com', '555555555', 'Concepcion', '1992-12-10');

-- INSERTAR 3 REGISTROS EN t_medicamento
INSERT INTO t_medicamento (nombre, laboratorio, codigo_barra, categoria, requiere_receta, stock, precio_unitario, porcentaje_descuento, fecha_vencimiento)
VALUES
('Paracetamol', 'Laboratorio A', '123456789', 'Analgesico', 0, 10, 15.50, '100', '2026-12-24'),
('Ibuprofeno', 'Laboratorio B', '987654321', 'Analgesico', 0, 20, 12.75, '10.00', '2025-06-15'),
('Amoxicilina', 'Laboratorio C', '456789123', 'Antibiotico', 1, 5, 25.00, '5.00', '2024-09-30');

-- INSERTAR 3 REGISTROS EN t_venta
INSERT INTO t_venta (id_cliente, id_medicamento, tipo_pago, cantidad, numero_boleta, monto_total)
VALUES
(1, 1, 'EFE', 2, 1001, 31.00),
(2, 2, 'DEB', 1, 1002, 12.75),
(3, 3, 'CRE', 3, 1003, 75.00);

-- Actualiza el stock de un medicamento especifico y aumentarlo en un 10%
UPDATE t_medicamento
SET stock = stock * 1.10
WHERE id_medicamento = 1;

-- Eliminacion de un registro de t_venta segun alguna condicion especifica 
DELETE FROM t_venta
WHERE id_venta =2;

-- CONSULTAS SELECT


--Listamiento de los medicamentos cuyo stock sea menor a 20 unidades
SELECT * FROM t_medicamento
WHERE stock < 20;

--Listamiento de los clientes cuyo nombres comiencen con la letra 'C', utilizando LIKE.
SELECT * FROM t_cliente
WHERE nombres LIKE 'C%';

--Listamiento de los clientes ordenado de manera alfabética por apellidos y luego por sus nombres
SELECT * FROM t_cliente
ORDER BY apellidos ASC, nombres ASC;