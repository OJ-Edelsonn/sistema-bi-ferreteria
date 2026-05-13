# Dashboard Power BI - Fase 4

La Fase 4 construye las vistas funcionales del dashboard en Power BI Desktop.

Archivo principal:

```text
powerbi/ferreteria_bi.pbix
```

## Objetivo de la fase

Convertir el modelo validado de la Fase 3 en un dashboard funcional que permita monitorear ventas, productos e inventario con visuales claros y filtros interactivos.

## Páginas del dashboard

### Validación KPIs

Página técnica usada para validar los KPIs principales contra SQL.

Visuales principales:

- Tarjeta de ventas totales.
- Tarjeta de unidades vendidas.
- Tarjeta de transacciones.
- Tarjeta de margen estimado.
- Tarjeta de margen estimado porcentual.
- Tarjeta de productos de baja rotación.

### Vista General

Página ejecutiva para leer el estado general del negocio.

Responde preguntas como:

- ¿Cuánto vendimos?
- ¿Cuánto margen generamos?
- ¿Cuántas unidades vendimos?
- ¿Qué productos y categorías lideran?
- ¿Cómo evolucionaron las ventas?

Visuales principales:

- Tarjetas de KPIs generales.
- Gráfico de ventas mensuales.
- Gráfico de ventas por categoría.
- Tabla de top productos.
- Segmentadores de año y categoría.

### Ventas

Página enfocada en análisis temporal.

Responde preguntas como:

- ¿Cómo evolucionaron las ventas?
- ¿Qué meses tuvieron mayor venta?
- ¿Cómo evolucionó el margen?
- ¿El ticket promedio es saludable?
- ¿Qué periodos conviene reforzar?

Visuales principales:

- Tarjetas de ventas, margen, margen porcentual y ticket promedio.
- Línea de evolución de ventas mensuales.
- Línea de evolución de margen mensual.
- Columnas de ventas por año-mes.
- Tabla de resumen mensual.
- Segmentadores de año y categoría.

### Productos

Página enfocada en desempeño de productos y categorías.

Responde preguntas como:

- ¿Qué productos venden más?
- ¿Qué productos generan más margen?
- ¿Qué categorías lideran?
- ¿Qué productos tienen alta venta y bajo margen?
- ¿Qué productos conviene priorizar?

Visuales principales:

- Tarjetas de productos vendidos, ventas, margen y margen porcentual.
- Top productos por ventas.
- Top productos por margen.
- Ventas por categoría.
- Tabla de detalle de productos.
- Segmentadores de año y categoría.

### Inventario

Página enfocada en stock, valor de inventario y rotación.

Responde preguntas como:

- ¿Cuánto stock tenemos?
- ¿Cuál es el valor del inventario?
- ¿Qué productos tienen baja rotación?
- ¿Qué productos tienen stock crítico?
- ¿Qué categorías concentran más inventario?

Visuales principales:

- Tarjetas de stock actual, valor de inventario, productos de baja rotación, stock crítico y rotación de inventario.
- Tabla de productos de baja rotación.
- Gráfico de stock actual por categoría.
- Gráfico de valor de inventario por categoría.
- Tabla de detalle de inventario.
- Segmentadores de año y categoría.

## Estado funcional

El dashboard ya cuenta con las vistas mínimas solicitadas:

1. Vista general.
2. Análisis de ventas.
3. Análisis de productos.
4. Inventario.

La página `Validación KPIs` se conserva como respaldo técnico para demostrar que los cálculos de Power BI coinciden con SQL.

## Pendiente para Fase 5

- Pulido visual final.
- Revisión de consistencia visual.
- Captura de screenshots.
- Redacción de insights.
- Actualización final del README.

