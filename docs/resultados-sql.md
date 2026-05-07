# Resultados SQL - Fase 2

Estos resultados fueron generados ejecutando los scripts SQL contra los CSV de `data/raw` con SQLite.

## Validaciones

| validacion | valor | tipo |
|---|---|---|
| productos_total | 72 | informativo |
| ventas_total | 1800 | informativo |
| productos_id_duplicados | 0 | error |
| productos_nombre_duplicados | 0 | error |
| productos_con_costo_invalido | 0 | error |
| productos_con_stock_invalido | 0 | error |
| ventas_producto_inexistente | 0 | error |
| ventas_categoria_no_coincide | 0 | error |
| ventas_cantidad_invalida | 0 | error |
| ventas_precio_menor_o_igual_costo | 0 | error |
| ventas_total_mal_calculado | 0 | error |
| ventas_fecha_formato_invalido | 0 | error |
| ventas_fuera_periodo_esperado | 0 | advertencia |

## KPI general

| Métrica | Valor |
|---|---:|
| Ventas totales | S/ 128,182.96 |
| Unidades vendidas | 8,056 |
| Transacciones | 1,800 |
| Margen estimado | S/ 35,775.12 |
| Margen estimado % | 27.91% |

## Primer y uúltimo periodo mensual

| Periodo | Ventas totales | Unidades vendidas | Transacciones | Margen estimado |
|---|---:|---:|---:|---:|
| 2025-01 | S/ 6,208.13 | 464 | 94 | S/ 1,746.28 |
| 2026-04 | S/ 7,219.69 | 449 | 108 | S/ 2,102.47 |

## Top 5 categorías por ventas

| categoría | ventas_totales | unidades_vendidas | margen_estimado |
|---|---|---|---|
| Materiales de construcción | 41733.51 | 2512 | 8725.07 |
| Herramientas eléctricas | 19839.05 | 99 | 4802.05 |
| Herramientas manuales | 14020.88 | 667 | 4579.68 |
| Electricidad | 13953.82 | 1571 | 4488.02 |
| Pinturas | 10407.09 | 536 | 3380.39 |

## Top 5 productos por ventas

| producto | categoría | ventas_totales | unidades_vendidas | margen_estimado |
|---|---|---|---|---|
| Cemento bolsa 42.5 kg | Materiales de construcción | 20157.32 | 681 | 3813.32 |
| Pegamento cerámico 25 kg | Materiales de construcción | 8293.77 | 353 | 1869.17 |
| Taladro percutor 650W | Herramientas eléctricas | 5973.08 | 31 | 1478.08 |
| Amoladora angular 4.5 pulgadas | Herramientas eléctricas | 5220.52 | 34 | 1208.52 |
| Arena fina saco 40 kg | Materiales de construcción | 4261.74 | 447 | 864.54 |

## Productos de baja rotación

Productos detectados: 8

| id_producto | producto | categoría | unidades_vendidas | stock_actual | rotacion_inventario |
|---|---|---|---|---|---|
| P016 | Pistola de calor 1500W | Herramientas eléctricas | 0 | 17 | 0.0 |
| P063 | Botín de seguridad punta acero | Seguridad industrial | 0 | 14 | 0.0 |
| P047 | Válvula check 1/2 pulgada | Gasfitería | 4 | 20 | 0.1818 |
| P068 | Pala jardinera | Jardinería | 5 | 19 | 0.2326 |
| P031 | Lija al agua grano 220 | Pinturas | 98 | 320 | 0.2656 |
| P056 | Anclaje expansivo 3/8 unidad | Tornillería y fijaciones | 34 | 110 | 0.2677 |
| P015 | Compresora de aire 24 L | Herramientas eléctricas | 1 | 3 | 0.2857 |
| P071 | Maceta plastica mediana | Jardinería | 28 | 80 | 0.2979 |
