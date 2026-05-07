# Resumen SQL - Fase 2

La Fase 2 agrega scripts SQL compatibles con SQLite para estructurar, validar y analizar el dataset sintético de ferretería.

## Scripts creados

- `sql/01_schema.sql`: crea las tablas `productos` y `ventas`, índices y la vista `v_ventas_enriquecidas`.
- `sql/02_validaciones.sql`: revisa calidad de datos, duplicados, productos inexistentes, categorías inconsistentes, totales mal calculados y fechas fuera de periodo.
- `sql/03_kpis.sql`: calcula ventas totales, ventas mensuales, ventas por categoría, top productos, margen estimado, rotación de inventario y productos de baja rotación.

## Motor recomendado

SQLite. Es portable, no requiere servidor y permite validar el proyecto localmente antes de construir el dashboard en Power BI.

## Ejecución recomendada

Si tienes el ejecutable `sqlite3`, el flujo conceptual es:

```bash
sqlite3 data/processed/ferreteria_bi.sqlite < sql/01_schema.sql
```

Luego se cargan los CSV en las tablas `productos` y `ventas`, y se ejecutan:

```bash
sqlite3 data/processed/ferreteria_bi.sqlite < sql/02_validaciones.sql
sqlite3 data/processed/ferreteria_bi.sqlite < sql/03_kpis.sql
```

Como en este entorno no está instalado `sqlite3`, se agregó el helper:

```bash
python scripts/validar_sql.py
```

Ese helper crea una base SQLite temporal en memoria, carga los CSV, ejecuta los tres scripts y genera `docs/resultados-sql.md`.

## Relación principal

La relación analítica usada en SQL es:

```text
ventas.producto = productos.nombre
```

## Resultados esperados de validación

Los controles marcados como `error` deben devolver `0`. Los controles informativos devuelven conteos de filas, rango de fechas y distribución por categorías.

## KPIs cubiertos

- Ventas totales.
- Ventas por periodo mensual.
- Ventas por categoría.
- Top productos.
- Margen estimado.
- Margen estimado porcentual.
- Rotación de inventario.
- Productos de baja rotación.
