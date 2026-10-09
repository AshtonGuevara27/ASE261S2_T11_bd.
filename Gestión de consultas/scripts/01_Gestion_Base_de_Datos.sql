-- -----------------------------------------------------------------
-- Tema     : Creación de Base de Datos y Estructura de Tablas
-- Proyecto : Asociación Distrital de Apicultores de Matapalo (ADAM)
-- Equipo   : T11
-- SGBD     : MySQL 8.x / 5.x
-- -----------------------------------------------------------------

-- =================================================================
-- 1. CREACIÓN Y SELECCIÓN DE LA BASE DE DATOS PRO
-- =================================================================
CREATE DATABASE IF NOT EXISTS db_adam_apicultores 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE db_adam_apicultores;

-- =================================================================
-- 2. TABLAS DEL SISTEMA
-- =================================================================

-- Tabla: Usuarios (General / Tipos de usuario)
CREATE TABLE IF NOT EXISTS usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo ENUM('usuario', 'mayorista', 'empresa') NOT NULL,
    correo VARCHAR(120) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    nombre_completo VARCHAR(120),
    telefono VARCHAR(20),
    direccion VARCHAR(255),
    nombre_negocio_mayorista VARCHAR(150),
    ruc_mayorista VARCHAR(20),
    volumen_compra_estimado VARCHAR(100),
    razon_social VARCHAR(150),
    ruc_empresa VARCHAR(20),
    representante_legal VARCHAR(120),
    cantidad_empleados INT,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_correo (correo),
    INDEX idx_tipo (tipo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: Usuario Cliente (Clientes Regulares)
CREATE TABLE IF NOT EXISTS usuario_cliente (
    id INT PRIMARY KEY AUTO_INCREMENT,
    correo VARCHAR(120) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    nombre_completo VARCHAR(120) NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(255),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_correo (correo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: Productos (Catálogo Apícola)
CREATE TABLE IF NOT EXISTS productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio_base DECIMAL(10, 2) NOT NULL,
    precio_mayorista DECIMAL(10, 2),
    precio_empresa DECIMAL(10, 2),
    cantidad_disponible INT DEFAULT 100,
    sku VARCHAR(50) UNIQUE,
    categoria VARCHAR(100),
    activo INT DEFAULT 1,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_activo (activo),
    INDEX idx_categoria (categoria),
    INDEX idx_sku (sku)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: Newsletter (Suscriptores Novedades)
CREATE TABLE IF NOT EXISTS newsletter (
    id INT PRIMARY KEY AUTO_INCREMENT,
    correo VARCHAR(120) NOT NULL UNIQUE,
    suscrito BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_suscripcion DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_correo (correo),
    INDEX idx_suscrito (suscrito)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: Contactos (Gestión de Consultas)
CREATE TABLE IF NOT EXISTS contactos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(120) NOT NULL,
    email VARCHAR(120) NOT NULL,
    telefono VARCHAR(20),
    empresa VARCHAR(150),
    asunto VARCHAR(200),
    mensaje TEXT NOT NULL,
    estado VARCHAR(20) DEFAULT 'pendiente',
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_respuesta DATETIME,
    INDEX idx_email (email),
    INDEX idx_estado (estado),
    INDEX idx_fecha_creacion (fecha_creacion)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla: Carrito Cliente (Compras)
CREATE TABLE IF NOT EXISTS carrito_cliente (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    fecha_agregado DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario_cliente(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE,
    INDEX idx_usuario_id (usuario_id),
    INDEX idx_producto_id (producto_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =================================================================
-- 3. VISTAS PARA REPORTES
-- =================================================================

-- Vista para consultar la gestión de reportes de clientes
CREATE OR REPLACE VIEW vw_reporte_consultas AS
SELECT 
    id,
    nombre AS cliente,
    email AS correo,
    telefono,
    empresa,
    asunto,
    mensaje,
    estado,
    fecha_creacion AS fecha_consulta
FROM contactos;