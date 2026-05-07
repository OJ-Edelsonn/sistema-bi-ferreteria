# Diccionario de datos - Fase 1

Este documento describe los archivos CSV sintéticos creados para el proyecto **Sistema de Business Intelligence – Ferretería**.

## Fuente de datos

Los datos son sintéticos y fueron diseñados para representar una ferretería minorista con ventas, inventario, productos de alta demanda, productos premium y productos de baja rotación.

Periodo cubierto: `2025-01-01` a `2026-04-30`.

## Archivo `data/raw/productos.csv`

| Campo | Tipo | Descripción | Regla |
|---|---|---|---|
| `id_producto` | Texto | Identificador único del producto. | No se repite. |
| `nombre` | Texto | Nombre comercial del producto. | Debe coincidir con `ventas.producto`. |
| `categoría` | Texto | Categoría del producto. | Debe pertenecer al catálogo de categorías del proyecto. |
| `costo` | Decimal | Costo unitario estimado en PEN. | Debe ser mayor que 0. |
| `stock` | Entero | Stock actual estimado. | Debe ser mayor o igual que 0. |

## Archivo `data/raw/ventas.csv`

| Campo | Tipo | Descripción | Regla |
|---|---|---|---|
| `fecha` | Fecha | Fecha de venta. | Formato ISO `YYYY-MM-DD`. |
| `producto` | Texto | Producto vendido. | Debe existir en `productos.csv`. |
| `categoría` | Texto | Categoría del producto vendido. | Debe coincidir con la categoría del producto. |
| `cantidad` | Entero | Unidades vendidas. | Debe ser mayor que 0. |
| `precio_unitario` | Decimal | Precio de venta unitario en PEN. | Debe ser mayor que el costo estimado. |
| `total` | Decimal | Importe total de la línea de venta. | Debe ser `cantidad * precio_unitario`. |

## Categorías incluidas

- Electricidad
- Gasfitería
- Herramientas eléctricas
- Herramientas manuales
- Jardinería
- Materiales de construcción
- Pinturas
- Seguridad industrial
- Tornillería y fijaciones

## Volumen del dataset

- Productos: 72
- Registros de ventas: 1800
- Categorías: 9
- Moneda: PEN

## Notas de diseño

- El dataset incluye estacionalidad por mes y diferencias de demanda por categoría.
- Algunos productos fueron diseñados con alta venta y stock bajo para habilitar análisis de reposición.
- Algunos productos tienen stock y baja venta para habilitar análisis de baja rotación.
- Los precios de venta tienen pequeñas variaciones para simular descuentos y promociones.
