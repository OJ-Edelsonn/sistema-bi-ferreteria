-- 03_kpis.sql
-- Consultas KPI para ventas, margen, productos e inventario.

PRAGMA foreign_keys = ON;

-- KPI 1: ventas totales y margen estimado general.
SELECT
    ROUND(SUM(total), 2) AS ventas_totales,
    SUM(cantidad) AS unidades_vendidas,
    COUNT(*) AS transacciones,
    ROUND(SUM(margen_estimado), 2) AS margen_estimado,
    ROUND(SUM(margen_estimado) / NULLIF(SUM(total), 0), 4) AS margen_estimado_pct
FROM v_ventas_enriquecidas;

-- KPI 2: ventas por periodo mensual.
SELECT
    periodo_mes,
    ROUND(SUM(total), 2) AS ventas_totales,
    SUM(cantidad) AS unidades_vendidas,
    COUNT(*) AS transacciones,
    ROUND(SUM(margen_estimado), 2) AS margen_estimado,
    ROUND(SUM(margen_estimado) / NULLIF(SUM(total), 0), 4) AS margen_estimado_pct
FROM v_ventas_enriquecidas
GROUP BY periodo_mes
ORDER BY periodo_mes;

-- KPI 3: ventas por categoria.
SELECT
    "categoría",
    ROUND(SUM(total), 2) AS ventas_totales,
    SUM(cantidad) AS unidades_vendidas,
    COUNT(*) AS transacciones,
    ROUND(SUM(margen_estimado), 2) AS margen_estimado,
    ROUND(SUM(margen_estimado) / NULLIF(SUM(total), 0), 4) AS margen_estimado_pct
FROM v_ventas_enriquecidas
GROUP BY "categoría"
ORDER BY ventas_totales DESC;

-- KPI 4: top 10 productos por ventas.
SELECT
    producto,
    "categoría",
    ROUND(SUM(total), 2) AS ventas_totales,
    SUM(cantidad) AS unidades_vendidas,
    COUNT(*) AS transacciones,
    ROUND(SUM(margen_estimado), 2) AS margen_estimado,
    ROUND(SUM(margen_estimado) / NULLIF(SUM(total), 0), 4) AS margen_estimado_pct
FROM v_ventas_enriquecidas
GROUP BY producto, "categoría"
ORDER BY ventas_totales DESC
LIMIT 10;

-- KPI 5: margen estimado por producto.
SELECT
    producto,
    "categoría",
    ROUND(SUM(total), 2) AS ventas_totales,
    ROUND(SUM(margen_estimado), 2) AS margen_estimado,
    ROUND(SUM(margen_estimado) / NULLIF(SUM(total), 0), 4) AS margen_estimado_pct
FROM v_ventas_enriquecidas
GROUP BY producto, "categoría"
ORDER BY margen_estimado DESC
LIMIT 10;

-- KPI 6: rotacion de inventario estimada por producto.
WITH ventas_producto AS (
    SELECT
        producto,
        SUM(cantidad) AS unidades_vendidas,
        ROUND(SUM(total), 2) AS ventas_totales
    FROM ventas
    GROUP BY producto
),
rotacion AS (
    SELECT
        p.id_producto,
        p.nombre AS producto,
        p."categoría",
        COALESCE(vp.unidades_vendidas, 0) AS unidades_vendidas,
        p.stock AS stock_actual,
        p.stock + COALESCE(vp.unidades_vendidas, 0) AS stock_inicial_estimado,
        ROUND(((p.stock + COALESCE(vp.unidades_vendidas, 0)) + p.stock) / 2.0, 2) AS stock_promedio_estimado,
        ROUND(
            COALESCE(vp.unidades_vendidas, 0) /
            NULLIF((((p.stock + COALESCE(vp.unidades_vendidas, 0)) + p.stock) / 2.0), 0),
            4
        ) AS rotacion_inventario,
        COALESCE(vp.ventas_totales, 0) AS ventas_totales
    FROM productos p
    LEFT JOIN ventas_producto vp
        ON vp.producto = p.nombre
)
SELECT *
FROM rotacion
ORDER BY rotacion_inventario DESC, ventas_totales DESC;

-- KPI 7: productos de baja rotacion.
WITH ventas_producto AS (
    SELECT
        producto,
        SUM(cantidad) AS unidades_vendidas,
        ROUND(SUM(total), 2) AS ventas_totales
    FROM ventas
    GROUP BY producto
),
rotacion AS (
    SELECT
        p.id_producto,
        p.nombre AS producto,
        p."categoría",
        COALESCE(vp.unidades_vendidas, 0) AS unidades_vendidas,
        p.stock AS stock_actual,
        ROUND(((p.stock + COALESCE(vp.unidades_vendidas, 0)) + p.stock) / 2.0, 2) AS stock_promedio_estimado,
        ROUND(
            COALESCE(vp.unidades_vendidas, 0) /
            NULLIF((((p.stock + COALESCE(vp.unidades_vendidas, 0)) + p.stock) / 2.0), 0),
            4
        ) AS rotacion_inventario,
        COALESCE(vp.ventas_totales, 0) AS ventas_totales
    FROM productos p
    LEFT JOIN ventas_producto vp
        ON vp.producto = p.nombre
)
SELECT *
FROM rotacion
WHERE stock_actual > 0
  AND COALESCE(rotacion_inventario, 0) < 0.30
ORDER BY rotacion_inventario ASC, stock_actual DESC;

