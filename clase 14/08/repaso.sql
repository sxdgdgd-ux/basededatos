CREATE DATABASE autoexpress;

create table t_cliente(
    Id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    Rut VARCHAR(12) NOT NULL UNIQUE,
    Nombres varchar(50) NOT NULL,
    Apellidos varchar(50) NOT NULL,
    Email varchar(50) NOT NULL UNIQUE,
    Telefono varchar(12) NOT NULL UNIQUE,
    Region TINYINT NOT NULL,
    Fecha_nacimiento DATE NOT NULL,
    Cliente_frecuente BOOLEAN NOT NULL DEFAULT 0
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    Observaciones TEXT
);

create table t_vehiculo(
    Id_vehiculo INT PRIMARY KEY AUTO_INCREMENT,
    Patente VARCHAR(10) NOT NULL UNIQUE,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    year YEAR NOT NULL,
    tipo_vehiculo ENUM('Sedan', 'SUV', 'Camioneta', 'Deportivo'),
    num_puertas INT TINYINT NOT NULL,
    Kilometraje INT NOT NULL,
    Capacidad_estanque SMALLINT NOT NULL,
    precio_dia DECIMAL(10,2) NOT NULL,
    consumo_promedio FLOAT NOT NULL,
    Disponible BOOLEAN NOT NULL DEFAULT 1,
    Descripcion TEXT,
    fecha_ingreso TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

create table t_mantencion(
    id_mantencion INT PRIMARY KEY AUTO_INCREMENT,
    id_vehiculo INT NOT NULL,
    tipo_mantencion ENUM('PRE', 'COR', 'REV') NOT NULL,
    duracion_estimada TIME NOT NULL,
    Costo FLOAT NOT NULL,
    hora_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Resumen VARCHAR(225) NOT NULL,
    Detalle LONGTEXT NOT NULL,
    calificacion_servicio TINYINT NOT NULL CHECK (calificacion_servicio BETWEEN 1 AND 5)
);




