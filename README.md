# Sistema de Business Intelligence – Ferretería

Sistema de Business Intelligence para monitorear ventas, inventario y desempeño de productos de una ferretería mediante un dashboard funcional en Power BI, con datos trazables, KPIs claros e insights útiles para tomar decisiones de negocio.

## Estado del proyecto

Fase actual: Fase 5 completada con insights, QA y screenshots finales.

## Documento principal

La planificación completa está en [docs/documento-maestro.md](docs/documento-maestro.md).

## Dataset inicial

La Fase 1 incluye datos sintéticos verosímiles para una ferretería:

- Productos: `data/raw/productos.csv`
- Ventas: `data/raw/ventas.csv`
- Diccionario de datos: `docs/diccionario-datos.md`
- Resumen preliminar: `docs/resumen-dataset.md`

Volumen inicial: 72 productos, 1,800 registros de ventas, 9 categorías y periodo de enero 2025 a abril 2026.

## SQL inicial

La Fase 2 incluye scripts SQL compatibles con SQLite:

- Schema: `sql/01_schema.sql`
- Validaciones: `sql/02_validaciones.sql`
- KPIs: `sql/03_kpis.sql`
- Resumen SQL: `docs/resumen-sql.md`
- Resultados SQL: `docs/resultados-sql.md`

Si no tienes `sqlite3` instalado, puedes validar los scripts con:

```bash
python scripts/validar_sql.py
```

## Modelo Power BI

La Fase 3 incluye el archivo base del modelo Power BI:

- Dashboard/modelo: `powerbi/ferreteria_bi.pbix`
- Documentación del modelo: `docs/modelo-powerbi.md`
- Medidas DAX: `docs/medidas-dax.md`

KPIs validados contra SQL:

- Ventas totales: `S/ 128,182.96`
- Unidades vendidas: `8,056`
- Transacciones: `1,800`
- Margen estimado: `S/ 35,775.12`
- Margen estimado %: `27.91%`
- Productos de baja rotación: `8`

## Dashboard Power BI

La Fase 4 incluye las vistas funcionales del dashboard:

- `Validación KPIs`
- `Vista General`
- `Ventas`
- `Productos`
- `Inventario`

Documentación de la fase: `docs/dashboard-powerbi.md`.

## Insights y QA

La Fase 5 incluye validación final, hallazgos de negocio y evidencia visual:

- Insights: `docs/insights.md`
- Checklist QA: `docs/qa-checklist.md`
- Screenshots:
  - `screenshots/01_validacion_kpis.png`
  - `screenshots/02_vista_general.png`
  - `screenshots/03_ventas.png`
  - `screenshots/04_productos.png`
  - `screenshots/05_inventario.png`

## Entregables previstos

- Dataset: `data/raw/ventas.csv` y `data/raw/productos.csv`
- SQL: scripts de estructura, validación y consultas KPI en `sql/`
- Dashboard Power BI: `powerbi/ferreteria_bi.pbix`
- Screenshots: `screenshots/`
- Documentación: `README.md` y documentos de soporte en `docs/`
