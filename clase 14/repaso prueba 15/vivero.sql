-- =============================================================
-- Guía de Ejercicios
-- Escenario : Vivero Los Copihues
-- Script    : Creación y poblamiento de la base de datos "vivero"
-- Profesor : Patricio Briones Bonvallet
-- =============================================================

DROP DATABASE IF EXISTS vivero;
CREATE DATABASE vivero
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_spanish_ci;

USE vivero;

-- -------------------------------------------------------------
-- Tabla : t_categoria
-- -------------------------------------------------------------
CREATE TABLE t_categoria
(
    id           TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre       VARCHAR(50)      NOT NULL UNIQUE,
    descripcion  TEXT             NULL
) ENGINE = InnoDB;

-- -------------------------------------------------------------
-- Tabla : t_planta
-- -------------------------------------------------------------
CREATE TABLE t_planta
(
    id                 SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    codigo             CHAR(6)           NOT NULL UNIQUE,
    nombre             VARCHAR(80)       NOT NULL,
    nombre_cientifico  VARCHAR(120)      NULL,
    categoria_id       TINYINT UNSIGNED  NOT NULL,
    precio             DECIMAL(10,2)     NOT NULL,
    stock              SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    altura_cm          FLOAT             NULL,
    riego_semanal_lt   DOUBLE            NULL,
    tipo_luz           ENUM('Sol','Semisombra','Sombra') NOT NULL,
    apta_interior      BOOLEAN           NOT NULL DEFAULT FALSE,
    fecha_ingreso      DATE              NOT NULL DEFAULT (CURDATE()),
    CONSTRAINT fk_planta_categoria
        FOREIGN KEY (categoria_id) REFERENCES t_categoria (id)
) ENGINE = InnoDB;

-- -------------------------------------------------------------
-- Tabla : t_cliente
-- -------------------------------------------------------------
CREATE TABLE t_cliente
(
    id             INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    rut            VARCHAR(12)  NOT NULL UNIQUE,
    nombre         VARCHAR(60)  NOT NULL,
    apellido       VARCHAR(60)  NOT NULL,
    email          VARCHAR(150) NULL UNIQUE,
    telefono       CHAR(12)     NULL,
    ciudad         VARCHAR(60)  NOT NULL,
    anio_registro  YEAR         NOT NULL,
    preferencias   SET('Frutales','Ornamentales','Nativas','Suculentas','Huerta') NULL
) ENGINE = InnoDB;

-- -------------------------------------------------------------
-- Tabla : t_empleado
-- -------------------------------------------------------------
CREATE TABLE t_empleado
(
    id              MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(60)  NOT NULL,
    apellido        VARCHAR(60)  NOT NULL,
    cargo           ENUM('Vendedor','Jardinero','Bodeguero','Administrador') NOT NULL,
    sueldo          INT UNSIGNED NOT NULL,
    fecha_contrato  DATE         NOT NULL,
    hora_entrada    TIME         NOT NULL,
    activo          BOOLEAN      NOT NULL DEFAULT TRUE
) ENGINE = InnoDB;

-- -------------------------------------------------------------
-- Tabla : t_venta  (la numeración comienza en 5001)
-- -------------------------------------------------------------
CREATE TABLE t_venta
(
    id               BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cliente_id       INT UNSIGNED       NOT NULL,
    planta_id        SMALLINT UNSIGNED  NOT NULL,
    empleado_id      MEDIUMINT UNSIGNED NOT NULL,
    cantidad         TINYINT UNSIGNED   NOT NULL,
    precio_unitario  DECIMAL(10,2)      NOT NULL,
    fecha_hora       DATETIME           NOT NULL,
    registrado_en    TIMESTAMP          NOT NULL DEFAULT CURRENT_TIMESTAMP,
    observacion      VARCHAR(200)       NULL,
    CONSTRAINT fk_venta_cliente  FOREIGN KEY (cliente_id)  REFERENCES t_cliente (id),
    CONSTRAINT fk_venta_planta   FOREIGN KEY (planta_id)   REFERENCES t_planta (id),
    CONSTRAINT fk_venta_empleado FOREIGN KEY (empleado_id) REFERENCES t_empleado (id)
) ENGINE = InnoDB AUTO_INCREMENT = 5001;

-- =============================================================
-- Datos
-- =============================================================
INSERT INTO t_categoria (nombre, descripcion) VALUES
('Árboles nativos',  'Especies arbóreas nativas del sur de Chile'),
('Frutales',         'Árboles y arbustos productores de fruta'),
('Ornamentales',     'Plantas de exterior con fines decorativos'),
('Interior',         'Plantas adaptadas a espacios interiores'),
('Suculentas',       'Cactus y plantas crasas de bajo riego'),
('Huerta',           'Almácigos de hortalizas y hierbas aromáticas');

INSERT INTO t_planta
(codigo, nombre, nombre_cientifico, categoria_id, precio, stock, altura_cm, riego_semanal_lt, tipo_luz, apta_interior, fecha_ingreso) VALUES
('AN-001', 'Araucaria',         'Araucaria araucana',        1, 45990.00,  6, 60.0, 3.0,  'Sol',        FALSE, '2025-03-10'),
('AN-002', 'Canelo',            'Drimys winteri',            1, 18990.00, 14, 80.0, 4.5,  'Semisombra', FALSE, '2025-03-10'),
('AN-003', 'Arrayán',           'Luma apiculata',            1, 15990.00,  9, 50.0, 4.0,  'Semisombra', FALSE, '2025-04-02'),
('AN-004', 'Notro',             'Embothrium coccineum',      1, 16990.00, 11, 55.0, 3.5,  'Sol',        FALSE, '2025-04-02'),
('FR-001', 'Manzano',           'Malus domestica',           2, 12990.00, 20, 90.0, 6.0,  'Sol',        FALSE, '2025-05-15'),
('FR-002', 'Cerezo',            'Prunus avium',              2, 14990.00,  4, 95.0, 6.0,  'Sol',        FALSE, '2025-05-15'),
('FR-003', 'Arándano',          'Vaccinium corymbosum',      2,  7990.00, 35, 40.0, 3.0,  'Sol',        FALSE, '2025-06-01'),
('FR-004', 'Murta',             'Ugni molinae',              2,  6990.00, 18, 35.0, 2.5,  'Semisombra', FALSE, '2025-06-01'),
('OR-001', 'Hortensia',         'Hydrangea macrophylla',     3,  9990.00, 22, 45.0, 5.0,  'Semisombra', FALSE, '2025-07-20'),
('OR-002', 'Copihue',           'Lapageria rosea',           3, 19990.00,  3, 30.0, 2.0,  'Sombra',     FALSE, '2025-07-20'),
('OR-003', 'Rosa',              'Rosa chinensis',            3,  8490.00, 27, 40.0, 4.0,  'Sol',        FALSE, '2025-08-05'),
('OR-004', 'Lavanda',           'Lavandula angustifolia',    3,  4990.00, 40, 30.0, 1.5,  'Sol',        FALSE, '2025-08-05'),
('IN-001', 'Monstera',          'Monstera deliciosa',        4, 21990.00,  8, 70.0, 1.0,  'Semisombra', TRUE,  '2025-09-12'),
('IN-002', 'Potus',             'Epipremnum aureum',         4,  5990.00, 30, 25.0, 0.5,  'Sombra',     TRUE,  '2025-09-12'),
('IN-003', 'Ficus lyrata',      'Ficus lyrata',              4, 29990.00,  5, 90.0, 1.2,  'Semisombra', TRUE,  '2025-10-01'),
('IN-004', 'Sansevieria',       'Dracaena trifasciata',      4,  8990.00, 16, 45.0, 0.3,  'Sombra',     TRUE,  '2025-10-01'),
('SU-001', 'Echeveria',         'Echeveria elegans',         5,  2990.00, 50, 8.0,  0.1,  'Sol',        TRUE,  '2025-11-03'),
('SU-002', 'Aloe vera',         'Aloe barbadensis',          5,  4490.00, 25, 30.0, 0.2,  'Sol',        TRUE,  '2025-11-03'),
('SU-003', 'Cactus bola',       NULL,                        5,  3490.00,  7, 12.0, 0.1,  'Sol',        TRUE,  '2025-11-20'),
('HU-001', 'Almácigo de tomate', 'Solanum lycopersicum',     6,  1490.00, 60, 10.0, 2.0,  'Sol',        FALSE, '2026-01-08'),
('HU-002', 'Albahaca',          'Ocimum basilicum',          6,  1990.00, 45, 15.0, 1.5,  'Sol',        TRUE,  '2026-01-08'),
('HU-003', 'Cilantro',          NULL,                        6,  1290.00,  2, 12.0, 1.5,  'Semisombra', FALSE, '2026-02-14');

INSERT INTO t_cliente
(rut, nombre, apellido, email, telefono, ciudad, anio_registro, preferencias) VALUES
('12345678-5', 'Carolina',  'Muñoz',      'cmunoz@correo.cl',     '+56911112222', 'Temuco',          2021, 'Nativas,Ornamentales'),
('13456789-2', 'Rodrigo',   'Painemal',   'rpainemal@correo.cl',  '+56922223333', 'Padre Las Casas', 2022, 'Huerta'),
('14567890-K', 'Valentina', 'Soto',       'vsoto@correo.cl',      '+56933334444', 'Temuco',          2023, 'Suculentas,Ornamentales'),
('15678901-7', 'Matías',    'Huenchullán', NULL,                  '+56944445555', 'Villarrica',      2023, 'Frutales'),
('16789012-4', 'Javiera',   'Rojas',      'jrojas@correo.cl',     NULL,           'Pucón',           2024, NULL),
('17890123-1', 'Felipe',    'Contreras',  'fcontreras@correo.cl', '+56966667777', 'Temuco',          2024, 'Frutales,Huerta'),
('18901234-9', 'Camila',    'Lienlaf',    'clienlaf@correo.cl',   '+56977778888', 'Angol',           2024, 'Nativas'),
('19012345-6', 'Ignacio',   'Fuentes',    NULL,                   NULL,           'Temuco',          2025, NULL),
('20123456-3', 'Antonia',   'Catrileo',   'acatrileo@correo.cl',  '+56999990000', 'Victoria',        2025, 'Suculentas'),
('11234567-0', 'Sebastián', 'Morales',    'smorales@correo.cl',   '+56910101010', 'Padre Las Casas', 2025, 'Ornamentales,Huerta'),
('10987654-3', 'Fernanda',  'Quilaqueo',  'fquilaqueo@correo.cl', '+56920202020', 'Temuco',          2026, 'Nativas,Frutales'),
('21098765-8', 'Tomás',     'Sandoval',   NULL,                   '+56930303030', 'Pucón',           2026, 'Huerta');

INSERT INTO t_empleado
(nombre, apellido, cargo, sueldo, fecha_contrato, hora_entrada, activo) VALUES
('Patricia', 'Alarcón',  'Administrador', 1450000, '2019-03-01', '08:30:00', TRUE),
('Luis',     'Ancamil',  'Vendedor',       680000, '2021-06-15', '09:00:00', TRUE),
('Daniela',  'Vergara',  'Vendedor',       650000, '2023-01-10', '09:00:00', TRUE),
('Hernán',   'Curiqueo', 'Jardinero',      720000, '2020-09-01', '08:00:00', TRUE),
('Marcela',  'Toledo',   'Bodeguero',      600000, '2022-04-04', '08:00:00', TRUE),
('Jorge',    'Millán',   'Vendedor',       640000, '2024-02-19', '14:00:00', TRUE),
('Paula',    'Neculmán', 'Jardinero',      700000, '2018-11-05', '08:00:00', FALSE),
('Cristián', 'Bravo',    'Vendedor',       630000, '2026-03-02', '14:00:00', TRUE);

INSERT INTO t_venta
(cliente_id, planta_id, empleado_id, cantidad, precio_unitario, fecha_hora, observacion) VALUES
( 1,  1, 2, 1, 45990.00, '2026-03-05 10:15:00', NULL),
( 1, 10, 2, 2, 19990.00, '2026-03-05 10:15:00', 'Cliente solicita envoltorio de regalo'),
( 2, 20, 3, 6,  1490.00, '2026-03-12 11:40:00', NULL),
( 2, 22, 3, 4,  1290.00, '2026-03-12 11:40:00', NULL),
( 3, 17, 6, 5,  2990.00, '2026-04-02 15:20:00', NULL),
( 3, 13, 6, 1, 21990.00, '2026-04-02 15:20:00', NULL),
( 4,  5, 2, 3, 12990.00, '2026-04-18 09:50:00', 'Despacho a domicilio en Villarrica'),
( 4,  6, 2, 2, 14990.00, '2026-04-18 09:50:00', 'Despacho a domicilio en Villarrica'),
( 5, 14, 3, 2,  5990.00, '2026-05-07 12:05:00', NULL),
( 6,  7, 6, 4,  7990.00, '2026-05-21 16:30:00', NULL),
( 6, 21, 6, 3,  1990.00, '2026-05-21 16:30:00', NULL),
( 7,  2, 2, 1, 18990.00, '2026-06-03 10:00:00', NULL),
( 7,  3, 2, 1, 15990.00, '2026-06-03 10:00:00', NULL),
( 8, 15, 8, 1, 29990.00, '2026-06-20 17:45:00', 'Paga con transferencia'),
( 9, 18, 3, 2,  4490.00, '2026-07-01 11:10:00', NULL),
( 9, 19, 3, 3,  3490.00, '2026-07-01 11:10:00', NULL),
(10,  9, 6, 2,  9990.00, '2026-07-15 15:00:00', NULL),
(10, 12, 6, 6,  4990.00, '2026-07-15 15:00:00', NULL),
(11,  4, 8, 2, 16990.00, '2026-08-08 14:25:00', NULL),
(11,  8, 8, 5,  6990.00, '2026-08-08 14:25:00', NULL),
(12, 20, 2, 10, 1490.00, '2026-08-22 09:35:00', 'Compra para huerta escolar'),
( 1, 16, 3, 1,  8990.00, '2026-09-04 12:50:00', NULL),
( 3, 11, 6, 3,  8490.00, '2026-09-18 16:05:00', NULL),
( 6, 13, 8, 1, 21990.00, '2026-10-01 15:40:00', NULL),
( 8, 17, 2, 8,  2990.00, '2026-10-06 10:20:00', NULL);