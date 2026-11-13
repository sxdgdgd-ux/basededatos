-- ====================================================================================================
-- Guía de Ejercicios : Indices no únicos y Funciones de una sola fila
-- Asignatura         : Bases de Datos Estructuradas
-- Profesor           : Patricio Briones Bonvallet
-- Inacap             : Temuco
-- Caso               : Gimnasio Cordillera
-- Script             : Preparación del ambiente (MySQL / MariaDB)
-- Tablas             : Las tablas están construidas con fines didácticos (no optimizadas técnicamente)
-- Datos              : Todos los datos son ficticios y solo con fines academicos
-- ====================================================================================================

DROP DATABASE IF EXISTS gimnasio_cordillera;

CREATE DATABASE gimnasio_cordillera
   CHARACTER SET utf8mb4
   COLLATE utf8mb4_spanish_ci;

USE gimnasio_cordillera;

-- ---------------------------------------------------------------------
-- Tabla t_plan : planes de membresía
-- ---------------------------------------------------------------------
CREATE TABLE t_plan
   (
   id INT AUTO_INCREMENT PRIMARY KEY,
   nombre VARCHAR (50),
   valor_mensual INT
   );

INSERT INTO t_plan
   (nombre, valor_mensual)
VALUES
   ('Básico',   19990),
   ('Estándar', 27990),
   ('Premium',  38990),
   ('Familiar', 49990);

-- ---------------------------------------------------------------------
-- Tabla t_socio : socios del gimnasio
-- (los datos de texto tienen espacios y mayúsculas/minúsculas irregulares
--  a propósito, tal como suele ocurrir con datos ingresados por digitadores)
-- ---------------------------------------------------------------------
CREATE TABLE t_socio
   (
   id INT AUTO_INCREMENT PRIMARY KEY,
   nombre VARCHAR (60),
   apellido VARCHAR (60),
   email VARCHAR (100),
   ciudad VARCHAR (50),
   plan_id INT,
   fecha_nacimiento DATE,
   fecha_inscripcion DATE,
   estado VARCHAR (10),
   peso_kg DECIMAL (5,2),
   altura_m DECIMAL (3,2),
   peso_objetivo_kg DECIMAL (5,2)
   );

INSERT INTO t_socio
   (nombre, apellido, email, ciudad, plan_id, fecha_nacimiento,
    fecha_inscripcion, estado, peso_kg, altura_m, peso_objetivo_kg)
VALUES
   (' Camila ', 'Rojas', 'Camila.Rojas@Mail.com', 'Temuco', 2,
    '1995-03-14', '2022-01-10', 'Activo', 62.50, 1.65, 60.00),
   ('Matías   ', ' MUÑOZ', 'MATIAS.MUNOZ@mail.com', 'Temuco', 1,
    '1990-11-02', '2021-06-01', 'Activo', 85.30, 1.78, 78.00),
   ('Fernanda ', '  Contreras', 'fcontreras@Mail.com', 'Villarrica', 3,
    '1988-03-27', '2023-03-15', 'Activo', 70.20, 1.60, 65.00),
   ('Sebastián ', 'sepúlveda', 'SSepulveda@mail.com', 'Pucón', 2,
    '2001-07-19', '2024-02-01', 'Activo', 78.90, 1.82, 75.00),
   (' Valentina', 'Peña', 'vpena@mail.com', 'Temuco', 4,
    '1999-12-05', '2024-03-04', 'Inactivo', 58.00, 1.58, 58.00),
   ('    Nicolás', 'Alarcón ', 'nalarcon@Mail.com', 'Padre Las Casas', 1,
    '1985-05-30', '2022-08-22', 'Activo', 92.40, 1.75, 82.00),
   ('Javiera', 'Figueroa    ', 'jfigueroa@mail.com', 'Angol', 3,
    '1993-09-09', '2025-01-13', 'Activo', 66.10, 1.68, 63.00),
   ('Cristóbal', 'Henríquez', 'CHENRIQUEZ@MAIL.COM', 'Temuco', 2,
    '1997-03-03', '2023-11-06', 'Activo', 81.75, 1.80, 80.00),
   ('Daniela', 'Vidal', 'dvidal@mail.com', 'Lautaro', 1,
    '2000-01-21', '2021-09-13', 'Inactivo', 55.60, 1.62, 55.00),
   (' Ignacio ', ' Saavedra ', 'isaavedra@mail.com', 'Villarrica', 4,
    '1982-10-15', '2022-05-02', 'Activo', 98.20, 1.83, 85.00),
   ('Constanza', 'Bravo   ', 'cbravo@mail.com', 'Temuco', 3,
    '1996-06-28', '2025-06-16', 'Activo', 60.30, 1.63, 60.00),
   ('Tomás', 'Espinoza', 'tespinoza@mail.com', 'Nueva Imperial', 1,
    '1992-04-11', '2024-09-02', 'Activo', 74.50, 1.74, 72.00),
   ('Antonia', 'Ñancupil', 'anancupil@Mail.com', 'Temuco', 2,
    '2003-08-08', '2025-03-03', 'Activo', 57.40, 1.61, 57.00),
   ('Benjamín', 'Carrasco', 'bcarrasco@mail.com', 'Pucón', 3,
    '1994-02-17', '2023-01-09', 'Inactivo', 88.00, 1.79, 80.00),
   ('Martina', 'Ulloa', 'mulloa@mail.com', 'Villarrica', 1,
    '1998-12-24', '2025-08-11', 'Activo', 63.90, 1.66, 62.00),
   ('Joaquín', '   Reyes', 'jreyes@mail.com', 'Temuco', 4,
    '1987-07-07', '2021-03-01', 'Activo', 90.10, 1.85, 84.00),
   ('Catalina', 'Marín', 'cmarin@mail.com', 'Padre Las Casas', 2,
    '1991-01-30', '2024-05-20', 'Activo', 67.80, 1.64, 64.00),
   ('Felipe', 'Quezada ', 'fquezada@mail.com', 'Angol', 1,
    '1989-09-01', '2023-07-24', 'Inactivo', 79.30, 1.77, 76.00),
   ('Paulina   ', 'Manríquez', 'pmanriquez@mail.com', 'Temuco', 3,
    '2002-03-22', '2026-02-02', 'Activo', 61.20, 1.70, 61.00),
   ('Rodrigo', ' Sáez', 'rsaez@mail.com', 'Lautaro', 2,
    '1984-11-18', '2026-05-18', 'Activo', 84.60, 1.72, 78.00);

-- ---------------------------------------------------------------------
-- Tabla t_pago : pagos mensuales de los socios
-- ---------------------------------------------------------------------
CREATE TABLE t_pago
   (
   id INT AUTO_INCREMENT PRIMARY KEY,
   socio_id INT,
   fecha_vencimiento DATE,
   fecha_pago DATE,
   monto INT,
   medio_pago VARCHAR (20)
   );

INSERT INTO t_pago
   (socio_id, fecha_vencimiento, fecha_pago, monto, medio_pago)
VALUES
   (1,  '2026-08-05', '2026-08-05', 27990, 'Débito'),
   (2,  '2026-08-05', '2026-08-09', 19990, 'Transferencia'),
   (3,  '2026-08-10', '2026-08-10', 38990, 'Crédito'),
   (4,  '2026-08-10', '2026-08-18', 27990, 'Efectivo'),
   (6,  '2026-08-15', '2026-08-15', 19990, 'Débito'),
   (7,  '2026-08-15', '2026-08-14', 38990, 'Crédito'),
   (8,  '2026-08-20', '2026-08-27', 27990, 'Transferencia'),
   (10, '2026-08-20', '2026-08-20', 49990, 'Crédito'),
   (11, '2026-09-01', '2026-09-01', 38990, 'Débito'),
   (12, '2026-09-01', '2026-09-11', 19990, 'Efectivo'),
   (13, '2026-09-05', '2026-09-05', 27990, 'Transferencia'),
   (15, '2026-09-05', '2026-09-06', 19990, 'Débito'),
   (16, '2026-09-10', '2026-09-10', 49990, 'Crédito'),
   (17, '2026-09-10', '2026-09-10', 27990, 'Débito'),
   (20, '2026-09-15', '2026-09-15', 27990, 'Efectivo'),
   (1,  '2026-09-05', '2026-09-05', 27990, 'Débito'),
   (2,  '2026-09-05', '2026-09-12', 19990, 'Transferencia');
