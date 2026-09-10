CREATE DATABASE autoexpress;

CREATE TABLE t_cliente (
    id INT PRIMARY KEY,                            -- Llave primaria[cite: 1, 2]
    rut VARCHAR(10) NOT NULL UNIQUE,              -- Texto corto, obligatorio y único[cite: 1, 2]
    nombres VARCHAR(100) NOT NULL,                 -- Obligatorio[cite: 1, 2]
    apellidos VARCHAR(100) NOT NULL,               -- Obligatorio[cite: 1, 2]
    email VARCHAR(100) UNIQUE,                     -- Único[cite: 1, 2]
    telefono CHAR(9),                             -- Texto de largo fijo, 9 caracteres
    region TINYINT,                                -- Número entero pequeño (1 byte)
    fecha_nacimiento DATE,                        -- Solo fecha, sin hora
    cliente_frecuente BOOLEAN DEFAULT 0,           -- Verdadero/falso, por defecto 0 (falso)
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora actual del sistema[cite: 1, 2]
    observaciones TEXT                             -- Texto libre largo (hasta ~65.535 bytes/caracteres)
);

-- =============================================================================
-- TABLA 2: VEHÍCULOS (t_vehiculo)
-- =============================================================================

CREATE TABLE t_vehiculo (
    id INT PRIMARY KEY,                              -- Llave primaria[cite: 1, 2]
    patente VARCHAR(10) NOT NULL UNIQUE,             -- Texto corto, obligatorio y único[cite: 1, 2]
    marca VARCHAR(50) NOT NULL,                      -- Obligatorio[cite: 1, 2]
    modelo VARCHAR(50) NOT NULL,                     -- Obligatorio[cite: 1, 2]
    year YEAR,                                       -- Tipo pensado exclusivamente para años
    tipo_vehiculo VARCHAR(30),                       -- Ej: sedán, SUV, camioneta
    num_puertas TINYINT CHECK (num_puertas BETWEEN 2 AND 5), -- Entero rango pequeño (2 a 5)[cite: 1]
    kilometraje INT DEFAULT 0,                       -- Entero para valores grandes, por defecto 0[cite: 1, 2]
    capacidad_estanque SMALLINT,                     -- Entero de rango medio (2 bytes)[cite: 1]
    precio_dia DECIMAL(10,2) NOT NULL,              -- Valor exacto en pesos con 2 decimales, obligatorio[cite: 1, 2]
    consumo_promedio FLOAT,                          -- Decimal aproximado[cite: 1]
    disponible BOOLEAN DEFAULT 1,                    -- Verdadero/falso, por defecto 1 (disponible)[cite: 1]
    descripcion TEXT,                                -- Texto largo (varios párrafos posibles)[cite: 1]
    fecha_ingreso DATETIME DEFAULT CURRENT_TIMESTAMP -- Fecha y hora actual del sistema[cite: 1, 2]
);

-- =============================================================================
-- TABLA 3: MANTENCIONES (t_mantencion)
-- =============================================================================

CREATE TABLE t_mantencion (
    id INT PRIMARY KEY,                              -- Llave primaria[cite: 1, 2]
    id_vehiculo INT,                                 -- Referencia al vehículo (sin FK)[cite: 1]
    tipo_mantencion CHAR(3),                         -- Código de largo fijo, 3 caracteres (ej: PRE, COR, REV)[cite: 1]
    duracion_estimada TIME,                          -- Solo hora/duración (HH:MM:SS)[cite: 1]
    costo FLOAT NOT NULL,                            -- Valor decimal aproximado, obligatorio[cite: 1, 2]
    hora_registro DATETIME DEFAULT CURRENT_TIMESTAMP, -- Marca de fecha/hora del sistema al registrar[cite: 1, 2]
    resumen VARCHAR(255),                            -- Texto muy corto (hasta 255 bytes)[cite: 1]
    detalle LONGTEXT,                                -- Texto extremadamente largo (hasta 4 GB)[cite: 1]
    calificacion_servicio TINYINT CHECK (calificacion_servicio BETWEEN 1 AND 5) -- Entero muy pequeño (1 a 5)[cite: 1]
);