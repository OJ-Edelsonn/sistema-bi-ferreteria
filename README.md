# Sistema de Business Intelligence – Ferretería

Sistema de Business Intelligence para monitorear ventas, inventario y desempeño de productos de una ferretería mediante un dashboard funcional en Power BI, con datos trazables, KPIs claros e insights útiles para tomar decisiones de negocio.

## Estado del proyecto

Fase actual: Fase 2 completada con scripts SQL de schema, validaciones y KPIs.

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

## Entregables previstos

- Dataset: `data/raw/ventas.csv` y `data/raw/productos.csv`
- SQL: scripts de estructura, validación y consultas KPI en `sql/`
- Dashboard Power BI: `powerbi/ferreteria_bi.pbix`
- Screenshots: `screenshots/`
- Documentación: `README.md` y documentos de soporte en `docs/`
