-- =============================================================================
-- TABLA 1: CLIENTES (t_cliente)
-- =============================================================================

DROP TABLE IF EXISTS t_cliente;

CREATE TABLE t_cliente (
    id INT PRIMARY KEY,                            -- Entero estándar (4 bytes)
    rut VARCHAR(10) NOT NULL UNIQUE,              -- Cadena de longitud variable corta
    nombres VARCHAR(100) NOT NULL,                 -- Cadena de longitud variable
    apellidos VARCHAR(100) NOT NULL,               -- Cadena de longitud variable
    email VARCHAR(100) UNIQUE,                     -- Cadena de longitud variable
    telefono CHAR(9),                             -- Cadena de longitud fija (9 bytes)
    region TINYINT,                                -- Entero muy pequeño (1 byte)
    fecha_nacimiento DATE,                        -- Fecha (AAAA-MM-DD)
    cliente_frecuente BOOLEAN DEFAULT 0,           -- Tipo lógico (0 o 1)
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora con zona horaria
    observaciones TEXT                             -- Texto largo (hasta 65.535 bytes)
);

-- =============================================================================
-- TABLA 2: VEHÍCULOS (t_vehiculo)
-- =============================================================================

DROP TABLE IF EXISTS t_vehiculo;

CREATE TABLE t_vehiculo (
    id BIGINT PRIMARY KEY,                           -- Entero muy grande (8 bytes)
    patente VARCHAR(10) NOT NULL UNIQUE,             -- Cadena de longitud variable corta
    marca VARCHAR(50) NOT NULL,                      -- Cadena de longitud variable
    modelo VARCHAR(50) NOT NULL,                     -- Cadena de longitud variable
    year YEAR,                                       -- Año (AAAA)
    tipo_vehiculo VARCHAR(30),                       -- Cadena de longitud variable
    num_puertas TINYINT CHECK (num_puertas BETWEEN 2 AND 5), -- Entero muy pequeño (1 byte)
    kilometraje INT DEFAULT 0,                       -- Entero estándar (4 bytes)
    capacidad_estanque SMALLINT,                     -- Entero pequeño (2 bytes)
    precio_dia DECIMAL(10,2) NOT NULL,              -- Decimal exacto (Finanzas / Dinero)
    consumo_promedio DOUBLE,                         -- Decimal de mayor precisión (Aprox. doble)
    disponible BOOLEAN DEFAULT 1,                    -- Tipo lógico (0 o 1)
    descripcion MEDIUMTEXT,                          -- Texto muy largo (hasta 16 MB)
    fecha_ingreso DATETIME DEFAULT CURRENT_TIMESTAMP -- Fecha y hora combinadas
);

-- =============================================================================
-- TABLA 3: MANTENCIONES (t_mantencion)
-- =============================================================================

DROP TABLE IF EXISTS t_mantencion;

CREATE TABLE t_mantencion (
    id INT PRIMARY KEY,                              -- Entero estándar (4 bytes)
    id_vehiculo BIGINT,                              -- Referencia que coincide con BIGINT de t_vehiculo
    tipo_mantencion CHAR(3),                         -- Cadena de longitud fija (3 bytes)
    duracion_estimada TIME,                          -- Hora / Duración (HH:MM:SS)
    costo FLOAT NOT NULL,                            -- Decimal de aprox. simple
    hora_registro DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora combinadas
    resumen TINYTEXT,                                -- Texto corto (hasta 255 bytes)
    detalle LONGTEXT,                                -- Texto extremadamente largo (hasta 4 GB)
    calificacion_servicio MEDIUMINT CHECK (calificacion_servicio BETWEEN 1 AND 5) -- Entero mediano (3 bytes)
);

-------------
-- Consultas
-------------

-- =============================================================================
-- PARTE 3: MODIFICACIÓN DE ESTRUCTURA (ALTER TABLE)
-- =============================================================================

-- 3. Agregar columna email_verificado (tipo lógico, por defecto falso)
ALTER TABLE t_cliente 
ADD email_verificado BOOLEAN DEFAULT 0;

-- 4. Agregar columna color (texto corto)
ALTER TABLE t_vehiculo 
ADD color VARCHAR(30);

-- 5. Eliminar la columna observaciones de t_cliente (que actuaba como comentarios)
ALTER TABLE t_cliente 
DROP COLUMN observaciones;[cite: 1, 2]


-- =============================================================================
-- PARTE 4: MANIPULACIÓN DE DATOS (DML)
-- =============================================================================

-- 6. Insertar 5 registros en t_cliente especificando explícitamente las columnas
-- (Se omiten cliente_frecuente, fecha_registro y email_verificado para probar valores DEFAULT)
INSERT INTO t_cliente (id, rut, nombres, apellidos, email, telefono, region, fecha_nacimiento)
VALUES 
    (1, '18234567-8', 'Matías', 'Muñoz', 'matias.munoz@email.com', '987654321', 9, '1995-04-12'),
    (2, '19456789-1', 'María', 'González', 'maria.gonzalez@email.com', '912345678', 13, '1998-08-25'),
    (3, '15678901-2', 'Carlos', 'Rojas', 'carlos.rojas@email.com', '955554444', 8, '1985-11-30'),
    (4, '20123456-3', 'Marcelo', 'Soto', 'marcelo.soto@email.com', '966667777', 9, '2001-02-14'),
    (5, '17890123-4', 'Fernanda', 'Pérez', 'fernanda.perez@email.com', '933332222', 5, '1992-06-18');[cite: 2]

-- 7. Insertar 6 registros en t_vehiculo
INSERT INTO t_vehiculo (id, patente, marca, modelo, year, tipo_vehiculo, num_puertas, kilometraje, capacidad_estanque, precio_dia, consumo_promedio, disponible, descripcion, color)
VALUES 
    (101, 'BBCL10', 'Toyota', 'RAV4', 2022, 'SUV', 5, 35000, 55, 45000.00, 14.5, 1, 'SUV amplio en excelente estado.', 'Gris'),
    (102, 'FJKW82', 'Hyundai', 'Tucson', 2021, 'SUV', 5, 48000, 62, 42000.00, 13.2, 1, 'Ideal para viajes largos.', 'Blanco'),
    (103, 'GHRT55', 'Chevrolet', 'Sail', 2020, 'Sedán', 4, 62000, 42, 25000.00, 16.8, 1, 'Económico y de fácil manejo.', 'Negro'),
    (104, 'KLPW34', 'Suzuki', 'Swift', 2023, 'Hatchback', 5, 15000, 37, 28000.00, 18.2, 1, 'Compacto de bajo consumo.', 'Rojo'),
    (105, 'PPTR90', 'Toyota', 'Hilux', 2022, 'Camioneta', 4, 55000, 80, 65000.00, 11.0, 1, 'Tracción 4x4 equipada para trabajo.', 'Azul'),
    (106, 'ZZXX11', 'Nissan', 'Kicks', 2023, 'SUV', 5, 12000, 41, 38000.00, 15.0, 1, 'Crossover urbano de bajo kilometraje.', 'Plata');[cite: 2]

-- 8. Insertar 4 registros en t_mantencion asociados a distintos id_vehiculo (101, 102, 103, 105)
INSERT INTO t_mantencion (id, id_vehiculo, tipo_mantencion, duracion_estimada, costo, resumen, detalle, calificacion_servicio)
VALUES 
    (1, 101, 'PRE', '02:30:00', 85000.0, 'Cambio de aceite y filtros', 'Se realizó cambio de aceite sintético 5W30 y reemplazo de filtro de aire.', 5),
    (2, 102, 'REV', '01:00:00', 35000.0, 'Revisión técnica periódica', 'Chequeo general de frenos, suspensión y luces sin hallazgos negativos.', 4),
    (3, 103, 'COR', '04:00:00', 150000.0, 'Reemplazo de pastillas de freno', 'Cambio de pastillas traseras y rectificación de discos delanteros.', 5),
    (4, 105, 'PRE', '03:00:00', 110000.0, 'Mantención de 50.000 KM', 'Revisión completa de tracción 4x4 y engrase general de transmisión.', 4);[cite: 2]

-- 9. Actualizar el kilometraje de un vehículo específico (id = 101)
UPDATE t_vehiculo 
SET kilometraje = 36500 
WHERE id = 101;[cite: 2]

-- 10. Actualizar el precio_dia de todos los vehículos de un tipo determinado ('SUV') aumentándolo en un 8%
UPDATE t_vehiculo 
SET precio_dia = precio_dia * 1.08 
WHERE tipo_vehiculo = 'SUV';[cite: 2]

-- 11. Eliminar un registro de t_mantencion según una condición específica (id = 3)
DELETE FROM t_mantencion 
WHERE id = 3;[cite: 2]


-- =============================================================================
-- PARTE 5: CONSULTAS SELECT
-- =============================================================================

-- 12. Listar todos los clientes registrados (todas las columnas)
SELECT * 
FROM t_cliente;[cite: 2]

-- 13. Listar solo el nombre, apellido y teléfono de todos los clientes
SELECT nombres, apellidos, telefono 
FROM t_cliente;[cite: 2]

-- 14. Listar los vehículos cuyo tipo_vehiculo sea 'SUV'
SELECT * 
FROM t_vehiculo 
WHERE tipo_vehiculo = 'SUV';[cite: 2]

-- 15. Listar vehículos cuyo precio_dia esté entre dos valores dados (BETWEEN)
SELECT * 
FROM t_vehiculo 
WHERE precio_dia BETWEEN 25000 AND 45000;[cite: 2]

-- 16. Listar clientes cuyo nombre comience con la letra 'M' (LIKE)
SELECT * 
FROM t_cliente 
WHERE nombres LIKE 'M%';[cite: 2]

-- 17. Listar vehículos cuya marca esté dentro de un conjunto dado (IN)
SELECT * 
FROM t_vehiculo 
WHERE marca IN ('Toyota', 'Hyundai', 'Chevrolet');[cite: 2]

-- 18. Listar vehículos ordenados por precio_dia de forma descendente (ORDER BY DESC)
SELECT * 
FROM t_vehiculo 
ORDER BY precio_dia DESC;[cite: 2]

-- 19. Listar clientes ordenados alfabéticamente por apellidos y luego por nombres
SELECT * 
FROM t_cliente 
ORDER BY apellidos ASC, nombres ASC;[cite: 2]

-- 20. Obtener las distintas regiones registradas entre los clientes sin repeticiones (DISTINCT)
SELECT DISTINCT region 
FROM t_cliente;[cite: 2]

-- 21. Obtener los distintos tipo_mantencion registrados sin repeticiones (DISTINCT)
SELECT DISTINCT tipo_mantencion 
FROM t_mantencion;[cite: 2]