-- 01_schema.sql
-- Schema SQLite para el proyecto Sistema de Business Intelligence - Ferreteria.
-- Las columnas respetan el dataset CSV de la Fase 1.

PRAGMA foreign_keys = ON;

DROP VIEW IF EXISTS v_ventas_enriquecidas;
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;

CREATE TABLE productos (
    id_producto TEXT NOT NULL PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    "categoría" TEXT NOT NULL,
    costo REAL NOT NULL CHECK (costo > 0),
    stock INTEGER NOT NULL CHECK (stock >= 0)
);

CREATE TABLE ventas (
    fecha TEXT NOT NULL CHECK (
        length(fecha) = 10
        AND substr(fecha, 5, 1) = '-'
        AND substr(fecha, 8, 1) = '-'
    ),
    producto TEXT NOT NULL,
    "categoría" TEXT NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario REAL NOT NULL CHECK (precio_unitario > 0),
    total REAL NOT NULL CHECK (total >= 0),
    FOREIGN KEY (producto) REFERENCES productos(nombre)
);

CREATE INDEX idx_ventas_fecha ON ventas(fecha);
CREATE INDEX idx_ventas_producto ON ventas(producto);
CREATE INDEX idx_ventas_categoria ON ventas("categoría");
CREATE INDEX idx_productos_categoria ON productos("categoría");

CREATE VIEW v_ventas_enriquecidas AS
SELECT
    v.rowid AS id_venta,
    v.fecha,
    substr(v.fecha, 1, 7) AS periodo_mes,
    substr(v.fecha, 1, 4) AS periodo_anio,
    v.producto,
    v."categoría",
    v.cantidad,
    v.precio_unitario,
    v.total,
    p.id_producto,
    p.costo,
    p.stock,
    ROUND(v.cantidad * (v.precio_unitario - p.costo), 2) AS margen_estimado,
    ROUND((v.precio_unitario - p.costo) / v.precio_unitario, 4) AS margen_unitario_pct
FROM ventas v
JOIN productos p
    ON p.nombre = v.producto;

