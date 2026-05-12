# Medidas DAX - Fase 3

Este documento registra las medidas creadas en Power BI para el modelo inicial.

## Tabla auxiliar de medidas

```DAX
Medidas = DATATABLE("Medida", STRING, {{"KPIs"}})
```

La columna `Medida` puede ocultarse en la vista de informe. Su función es permitir que Power BI mantenga una tabla dedicada para organizar KPIs.

## Medidas principales

### Ventas Totales

```DAX
Ventas Totales = SUM(Ventas[total])
```

### Unidades Vendidas

```DAX
Unidades Vendidas = SUM(Ventas[cantidad])
```

### Transacciones

```DAX
Transacciones = COUNTROWS(Ventas)
```

### Margen Estimado

```DAX
Margen Estimado =
SUMX(
    Ventas,
    Ventas[cantidad] *
    (
        Ventas[precio_unitario] -
        RELATED(Productos[costo])
    )
)
```

### Margen Estimado %

```DAX
Margen Estimado % =
DIVIDE(
    [Margen Estimado],
    [Ventas Totales]
)
```

### Stock Actual

```DAX
Stock Actual = SUM(Productos[stock])
```

### Stock Inicial Estimado

```DAX
Stock Inicial Estimado =
[Stock Actual] + [Unidades Vendidas]
```

### Stock Promedio Estimado

```DAX
Stock Promedio Estimado =
DIVIDE(
    [Stock Inicial Estimado] + [Stock Actual],
    2
)
```

### Rotación Inventario

```DAX
Rotación Inventario =
DIVIDE(
    [Unidades Vendidas],
    [Stock Promedio Estimado]
)
```

### Productos Baja Rotación

```DAX
Productos Baja Rotación =
COUNTROWS(
    FILTER(
        VALUES(Productos[nombre]),
        [Rotación Inventario] < 0.30 &&
        [Stock Actual] > 0
    )
)
```

## Formatos recomendados

| Medida | Formato |
|---|---|
| `Ventas Totales` | Moneda PEN, 2 decimales |
| `Margen Estimado` | Moneda PEN, 2 decimales |
| `Margen Estimado %` | Porcentaje, 2 decimales |
| `Unidades Vendidas` | Número entero |
| `Transacciones` | Número entero |
| `Productos Baja Rotación` | Número entero |
| `Rotación Inventario` | Decimal, 2 a 4 decimales |

