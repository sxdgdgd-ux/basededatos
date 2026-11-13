-- ============================================================
-- Guía de ejercicios : Funciones de conversión (CAST)
-- Script de creación : base de datos, tablas y datos.
-- Escenario : Café Ñielol
-- Asignatura : Bases de Datos Estructuradas
-- Profesor : Patricio Briones Bonvallet
-- ============================================================

DROP DATABASE IF EXISTS cafe_nielol;
CREATE DATABASE cafe_nielol
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_spanish_ci;
USE cafe_nielol;

-- ------------------------------------------------------------
-- Tabla con los datos importados desde la caja antigua.
-- El sistema antiguo exportaba TODO como texto.
-- ------------------------------------------------------------
CREATE TABLE t_venta_caja (
  id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nro_boleta      VARCHAR(8)  NOT NULL,
  producto        VARCHAR(40) NOT NULL,
  precio_txt      VARCHAR(12) NOT NULL,
  cantidad_txt    VARCHAR(4)  NOT NULL,
  descuento_txt   VARCHAR(5)  NOT NULL,
  fecha_hora_txt  VARCHAR(19) NOT NULL
) ENGINE = InnoDB;

INSERT INTO t_venta_caja
  (nro_boleta, producto, precio_txt, cantidad_txt, descuento_txt, fecha_hora_txt)
VALUES
('000981', 'Espresso',            '1900',  '2',  '0',    '2025-10-01 08:12:45'),
('000982', 'Café de grano 1 kg',  '24990', '1',  '0.10', '2025-10-01 09:40:10'),
('000983', 'Medialuna',           '950',   '12', '0',    '2025-10-02 10:05:00'),
('000984', 'Cappuccino',          '2800',  '3',  '0.05', '2025-10-04 16:30:20'),
('000985', 'Torta de murta',      '3500',  '4',  '0',    '2025-09-28 18:45:00'),
('000986', 'Café de grano 250 g', '7490',  '10', '0.15', '2025-10-07 11:20:35'),
('000987', 'Té de maqui',         '1500',  '5',  '0',    '2025-09-30 07:55:15'),
('000988', 'Prensa francesa',     '15990', '1',  '0.20', '2025-10-15 13:10:00');

-- ------------------------------------------------------------
-- Tabla de productos del sistema nuevo (tipos de datos correctos).
-- ------------------------------------------------------------
CREATE TABLE t_cafe (
  id                  SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre              VARCHAR(50)  NOT NULL,
  origen              ENUM('Colombia', 'Brasil', 'Etiopía', 'Perú', 'Honduras')
                      NOT NULL,
  precio              INT UNSIGNED NOT NULL,
  peso_gr             SMALLINT UNSIGNED NOT NULL,
  stock               TINYINT UNSIGNED NOT NULL,
  puntaje_cata        DECIMAL(4,2) NOT NULL,
  humedad             FLOAT        NOT NULL,
  anio_cosecha        YEAR         NOT NULL,
  fecha_hora_tostado  DATETIME     NOT NULL,
  tiempo_tueste       TIME         NOT NULL,
  organico            BOOLEAN      NOT NULL DEFAULT FALSE,
  descripcion         TEXT,
  actualizado         TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;

INSERT INTO t_cafe
  (nombre, origen, precio, peso_gr, stock, puntaje_cata, humedad,
   anio_cosecha, fecha_hora_tostado, tiempo_tueste, organico, descripcion)
VALUES
('Huila Supremo',     'Colombia', 8990,  250, 18, 86.75, 11.2, 2024,
 '2025-10-02 07:30:00', '00:11:45', TRUE,  'Notas a caramelo y frutos rojos'),
('Cerrado Mineiro',   'Brasil',   6490,  250, 25, 82.40, 10.8, 2024,
 '2025-09-25 15:10:00', '00:13:20', FALSE, 'Cuerpo alto, notas a chocolate'),
('Yirgacheffe',       'Etiopía',  11990, 250,  7, 89.50, 10.5, 2025,
 '2025-10-09 08:45:00', '00:10:30', TRUE,  'Floral, notas cítricas'),
('Cajamarca Natural', 'Perú',     7990,  500, 12, 84.20, 11.6, 2023,
 '2025-10-14 10:20:00', '00:12:10', TRUE,  'Dulce, notas a panela'),
('Marcala Honey',     'Honduras', 9490,  250,  4, 85.60, 11.0, 2025,
 '2025-09-30 16:55:00', '00:12:50', FALSE, 'Notas a miel y durazno');

 -- Ejer