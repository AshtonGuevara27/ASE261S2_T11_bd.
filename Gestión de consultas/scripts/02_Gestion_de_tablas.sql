-- -----------------------------------------------------------------
-- Tema     : Inserción y Gestión de Datos (DML)
-- Proyecto : Asociación Distrital de Apicultores de Matapalo (ADAM)
-- Equipo   : T11
-- SGBD     : MySQL 8.x / 5.x
-- -----------------------------------------------------------------

USE db_adam_apicultores;

-- =================================================================
-- GESTIÓN DE REGISTROS (DML)
-- 1. La sentencia INSERT permite registrar nuevas filas en las tablas.
-- 2. La sentencia SELECT permite consultar e inspeccionar los datos.
-- =================================================================

-- 1. INSERCIÓN DE DATOS EN LA TABLA: contactos (Consultas de clientes)
INSERT INTO contactos (nombre, email, telefono, empresa, asunto, mensaje, estado)
VALUES 
('Carlos Mendoza', 'carlos.mendoza@gmail.com', '987654321', 'Apícola del Norte', 'Consulta sobre Miel de Abeja', 'Deseo solicitar catálogo e información de precios al por mayor.', 'pendiente'),
('Ana Torres', 'ana.torres@hotmail.com', '912345678', NULL, 'Inscripción a capacitación', 'Consulta sobre las fechas del próximo taller de apicultura en Matapalo.', 'atendido'),
('Luis Lévano', 'llevano@gmail.com', '955443322', 'Distribuidora Lévano', 'Pedido de Polen', 'Buenas tardes, quisiera consultar la disponibilidad de polen por saco de 10kg.', 'pendiente');

-- 2. INSERCIÓN DE DATOS EN LA TABLA: productos (Catálogo Apícola)
INSERT INTO productos (nombre, descripcion, precio_base, precio_mayorista, precio_empresa, cantidad_disponible, sku, categoria)
VALUES 
('Miel de Abeja 1Kg', 'Miel pura 100% de floración silvestre de Matapalo.', 35.00, 28.00, 25.00, 150, 'MEL-001', 'Miel'),
('Polen Granulado 250g', 'Polen multifloral recolectado en Tumbes.', 25.00, 20.00, 18.00, 80, 'POL-001', 'Derivados'),
('Propóleo en Gotas 30ml', 'Extracto concentrado de propóleo natural.', 20.00, 15.00, 12.00, 200, 'PRO-001', 'Salud');

-- 3. INSERCIÓN DE DATOS EN LA TABLA: usuarios
INSERT INTO usuarios (tipo, correo, contraseña, nombre_completo, telefono, direccion)
VALUES 
('usuario', 'ashton.guevara@adam.pe', '$2a$12$eImiTXuWVxfM37uY4JANjO', 'Ashton Guevara', '944332211', 'Av. Principal Matapalo - Tumbes'),
('mayorista', 'cliente.mayorista@gmail.com', '$2a$12$eImiTXuWVxfM37uY4JANjO', 'Juan Pérez', '988776655', 'Jr. Comercio 123');

-- 4. INSERCIÓN DE DATOS EN LA TABLA: newsletter
INSERT INTO newsletter (correo, suscrito)
VALUES 
('suscriptor1@gmail.com', TRUE),
('suscriptor2@hotmail.com', TRUE);

-- =================================================================
-- CONSULTA Y VERIFICACIÓN DE DATOS ESTRUCTURADOS
-- =================================================================

-- Consultar la Vista de Reporte de Consultas generada (Entregable final)
SELECT * FROM vw_reporte_consultas;

-- Consultar catálogo de productos
SELECT id, nombre, precio_base, cantidad_disponible FROM productos;