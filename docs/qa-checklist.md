# Checklist QA - Fase 5

## Validación de datos

- [x] `productos.csv` mantiene 72 productos.
- [x] `ventas.csv` mantiene 1,800 registros.
- [x] Las ventas cubren el periodo 2025-01 a 2026-04.
- [x] Los productos vendidos existen en la tabla Productos.
- [x] Las categorías coinciden entre Productos y Ventas.
- [x] El total de cada venta corresponde a `cantidad * precio_unitario`.

## Validación SQL vs Power BI

- [x] Ventas totales: S/ 128,182.96.
- [x] Unidades vendidas: 8,056.
- [x] Transacciones: 1,800.
- [x] Margen estimado: S/ 35,775.12.
- [x] Margen estimado %: 27.91%.
- [x] Productos de baja rotación: 8.

## Validación de modelo Power BI

- [x] Tabla `Productos` cargada.
- [x] Tabla `Ventas` cargada.
- [x] Tabla `Calendario` creada.
- [x] Relación `Productos[nombre]` con `Ventas[producto]` activa.
- [x] Relación `Calendario[Date]` con `Ventas[fecha]` activa.
- [x] Medidas DAX principales creadas.

## Validación de dashboard

- [x] Página `Vista General` construida.
- [x] Página `Ventas` construida.
- [x] Página `Productos` construida.
- [x] Página `Inventario` construida.
- [x] Página `Validación KPIs` conservada como respaldo técnico.
- [x] Screenshots finales guardados en `screenshots/`.
- [x] Revisión visual final completada.

## Revisión visual pendiente

- [x] Confirmar que todos los títulos sean consistentes.
- [x] Confirmar que las tarjetas usen formatos correctos.
- [x] Confirmar que los gráficos temporales estén ordenados por `Año-Mes` ascendente.
- [x] Confirmar que los segmentadores sean claros y compactos.
- [x] Confirmar que las tablas no oculten columnas críticas.

## Screenshots generados

- `screenshots/01_validacion_kpis.png`
- `screenshots/02_vista_general.png`
- `screenshots/03_ventas.png`
- `screenshots/04_productos.png`
- `screenshots/05_inventario.png`
