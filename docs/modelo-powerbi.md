# Modelo Power BI - Fase 3

La Fase 3 construye el modelo semántico inicial en Power BI Desktop para el proyecto **Sistema de Business Intelligence – Ferretería**.

## Archivo Power BI

```text
powerbi/ferreteria_bi.pbix
```

## Tablas cargadas

| Tabla | Origen | Descripción |
|---|---|---|
| `Productos` | `data/raw/productos.csv` | Catálogo de productos con categoría, costo y stock. |
| `Ventas` | `data/raw/ventas.csv` | Transacciones sintéticas de ventas. |
| `Calendario` | DAX | Tabla de fechas para análisis temporal. |
| `Medidas` | DAX | Tabla auxiliar para organizar KPIs. |

## Tipos de datos esperados

### Productos

| Columna | Tipo |
|---|---|
| `id_producto` | Texto |
| `nombre` | Texto |
| `categoría` | Texto |
| `costo` | Número decimal |
| `stock` | Número entero |

### Ventas

| Columna | Tipo |
|---|---|
| `fecha` | Fecha |
| `producto` | Texto |
| `categoría` | Texto |
| `cantidad` | Número entero |
| `precio_unitario` | Número decimal |
| `total` | Número decimal |

## Tabla calendario

Tabla creada con DAX:

```DAX
Calendario =
ADDCOLUMNS(
    CALENDAR(
        MIN(Ventas[fecha]),
        MAX(Ventas[fecha])
    ),
    "Año", YEAR([Date]),
    "Mes Número", MONTH([Date]),
    "Mes", FORMAT([Date], "MMMM"),
    "Año-Mes", FORMAT([Date], "YYYY-MM"),
    "Trimestre", "T" & FORMAT([Date], "Q"),
    "Día", DAY([Date])
)
```

## Relaciones del modelo

| Tabla origen | Columna | Tabla destino | Columna | Cardinalidad | Filtro |
|---|---|---|---|---|---|
| `Productos` | `nombre` | `Ventas` | `producto` | Uno a varios | Única |
| `Calendario` | `Date` | `Ventas` | `fecha` | Uno a varios | Única |

## Página de validación

Se creó la página `Validación KPIs` con tarjetas para comparar los KPIs de Power BI contra los resultados SQL.

## Validación contra SQL

| KPI | Valor SQL | Valor Power BI | Estado |
|---|---:|---:|---|
| Ventas totales | S/ 128,182.96 | S/ 128,182.96 | Validado |
| Unidades vendidas | 8,056 | 8,056 | Validado |
| Transacciones | 1,800 | 1,800 | Validado |
| Margen estimado | S/ 35,775.12 | S/ 35,775.12 | Validado |
| Margen estimado % | 27.91% | 27.91% | Validado |
| Productos baja rotación | 8 | 8 | Validado |

## Criterio de cierre

El modelo está funcional y las medidas principales fueron verificadas contra SQL.

