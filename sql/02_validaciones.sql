-- 02_validaciones.sql
-- Consultas de control de calidad para productos.csv y ventas.csv.
-- Resultado esperado: los controles de error deben devolver 0.

PRAGMA foreign_keys = ON;

SELECT
    'productos_total' AS validacion,
    COUNT(*) AS valor,
    'informativo' AS tipo
FROM productos
UNION ALL
SELECT
    'ventas_total',
    COUNT(*),
    'informativo'
FROM ventas
UNION ALL
SELECT
    'productos_id_duplicados',
    COUNT(*),
    'error'
FROM (
    SELECT id_producto
    FROM productos
    GROUP BY id_producto
    HAVING COUNT(*) > 1
)
UNION ALL
SELECT
    'productos_nombre_duplicados',
    COUNT(*),
    'error'
FROM (
    SELECT nombre
    FROM productos
    GROUP BY nombre
    HAVING COUNT(*) > 1
)
UNION ALL
SELECT
    'productos_con_costo_invalido',
    COUNT(*),
    'error'
FROM productos
WHERE costo <= 0 OR costo IS NULL
UNION ALL
SELECT
    'productos_con_stock_invalido',
    COUNT(*),
    'error'
FROM productos
WHERE stock < 0 OR stock IS NULL
UNION ALL
SELECT
    'ventas_producto_inexistente',
    COUNT(*),
    'error'
FROM ventas v
LEFT JOIN productos p
    ON p.nombre = v.producto
WHERE p.nombre IS NULL
UNION ALL
SELECT
    'ventas_categoria_no_coincide',
    COUNT(*),
    'error'
FROM ventas v
JOIN productos p
    ON p.nombre = v.producto
WHERE v."categoría" <> p."categoría"
UNION ALL
SELECT
    'ventas_cantidad_invalida',
    COUNT(*),
    'error'
FROM ventas
WHERE cantidad <= 0 OR cantidad IS NULL
UNION ALL
SELECT
    'ventas_precio_menor_o_igual_costo',
    COUNT(*),
    'error'
FROM ventas v
JOIN productos p
    ON p.nombre = v.producto
WHERE v.precio_unitario <= p.costo
UNION ALL
SELECT
    'ventas_total_mal_calculado',
    COUNT(*),
    'error'
FROM ventas
WHERE ROUND(cantidad * precio_unitario, 2) <> ROUND(total, 2)
UNION ALL
SELECT
    'ventas_fecha_formato_invalido',
    COUNT(*),
    'error'
FROM ventas
WHERE NOT (
    length(fecha) = 10
    AND substr(fecha, 5, 1) = '-'
    AND substr(fecha, 8, 1) = '-'
    AND date(fecha) IS NOT NULL
)
UNION ALL
SELECT
    'ventas_fuera_periodo_esperado',
    COUNT(*),
    'advertencia'
FROM ventas
WHERE fecha < '2025-01-01'
   OR fecha > '2026-04-30';

SELECT
    MIN(fecha) AS fecha_inicio,
    MAX(fecha) AS fecha_fin,
    COUNT(DISTINCT substr(fecha, 1, 7)) AS meses_con_ventas,
    COUNT(DISTINCT producto) AS productos_con_ventas,
    COUNT(DISTINCT "categoría") AS categorias_con_ventas
FROM ventas;

SELECT
    "categoría",
    COUNT(*) AS productos
FROM productos
GROUP BY "categoría"
ORDER BY "categoría";

