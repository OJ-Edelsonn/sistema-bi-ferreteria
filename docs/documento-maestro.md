# Documento maestro - Sistema de Business Intelligence – Ferretería

## 1. Objetivo

Diseñar y construir un sistema de Business Intelligence que permita monitorear ventas, inventario y desempeño de productos de una ferretería mediante un dashboard funcional en Power BI, con datos trazables, KPIs claros e insights útiles para tomar decisiones de negocio.

Resultado esperado: dashboard funcional con insights reales de negocio, documentado y versionado en GitHub.

Ruta local oficial del proyecto:

```text
C:\Users\EDELSON ORIHUELA\OneDrive\Documentos\PROYECTOS CV\GPT\Sistema de Business Intelligence – Ferretería
```

## 2. Alcance del proyecto

El proyecto incluirá:

- Dataset obligatorio con tablas `Ventas` y `Productos`.
- Modelo analítico para medir ventas, productos, margen e inventario.
- Consultas SQL de validación y análisis.
- Dashboard en Power BI con cuatro vistas mínimas:
  - Vista general.
  - Análisis de ventas en el tiempo.
  - Análisis de productos.
  - Inventario.
- Screenshots del dashboard.
- README y documentación técnica/funcional.

El proyecto no incluirá:

- Sistema transaccional de ventas.
- Integración en tiempo real con caja, ERP o POS.
- Predicción avanzada con machine learning.
- Gestión operativa de compras, proveedores o usuarios.

## 3. Tecnologías definidas y función de cada una

| Tecnología | Uso en el proyecto | Función específica |
|---|---|---|
| CSV / Excel | Fuente de datos y entregable | Almacenar las tablas `Ventas` y `Productos` en un formato simple, portable y evaluable. |
| SQL | Validación y análisis recomendado | Definir estructura lógica, revisar calidad de datos y calcular consultas base de KPIs. |
| SQLite | Motor SQL portable | Ejecutar scripts SQL localmente sin depender de servidores externos. La base `.db` será regenerable y no será el entregable principal. |
| Power BI Desktop | Dashboard final | Construir el modelo, relaciones, medidas DAX, visualizaciones y páginas del dashboard. |
| Power Query | Limpieza y transformación | Importar CSV/Excel, tipar columnas, corregir formatos y preparar tablas para el modelo. |
| DAX | KPIs y medidas | Calcular ventas totales, margen estimado, rotación, ranking y productos de baja rotación. |
| Git | Versionamiento local | Controlar cambios del dataset, SQL, documentación y entregables. |
| GitHub | Repositorio público y entrega | Publicar el proyecto, organizar evidencias, README, screenshots y futuras versiones. |
| Markdown | Documentación | Mantener README, documento maestro, diccionario de datos e insights. |

Nota: Python puede usarse solo como herramienta auxiliar para generar datos sintéticos o validar consistencia si no existe data real. No será dependencia principal del producto final.

## 4. Estructura mínima de datos

### Tabla Ventas

| Campo | Tipo esperado | Regla |
|---|---|---|
| `fecha` | Fecha ISO `YYYY-MM-DD` | Obligatoria. |
| `producto` | Texto | Debe coincidir con un producto existente. |
| `categoría` | Texto | Debe coincidir con la categoría del producto. |
| `cantidad` | Entero positivo | No puede ser cero ni negativo. |
| `precio_unitario` | Decimal positivo | Precio de venta unitario en PEN. |
| `total` | Decimal positivo | Debe ser `cantidad * precio_unitario`. |

### Tabla Productos

| Campo | Tipo esperado | Regla |
|---|---|---|
| `id_producto` | Texto o entero único | Identificador único del producto. |
| `nombre` | Texto | Nombre comercial del producto. |
| `categoría` | Texto | Categoría controlada. |
| `costo` | Decimal positivo | Costo unitario estimado en PEN. |
| `stock` | Entero igual o mayor a cero | Stock actual estimado. |

## 5. Categorías iniciales

Las categorías base del proyecto serán:

- Herramientas manuales.
- Herramientas eléctricas.
- Materiales de construcción.
- Pinturas.
- Electricidad.
- Gasfitería.
- Tornillería y fijaciones.
- Seguridad industrial.
- Jardinería.

## 6. Definición de KPIs

| KPI | Definición fija |
|---|---|
| Ventas totales | `SUM(Ventas[total])`. |
| Ventas por periodo | Ventas totales filtradas por día, mes, trimestre o año. |
| Top productos | Ranking por ventas totales y, como vista secundaria, por cantidad vendida. |
| Margen estimado | `SUMX(Ventas, Ventas[cantidad] * (Ventas[precio_unitario] - Productos[costo]))`. |
| Margen estimado % | `Margen estimado / Ventas totales`. |
| Stock inicial estimado | `Productos[stock] + unidades vendidas del periodo`. |
| Stock promedio estimado | `(stock inicial estimado + stock actual) / 2`. |
| Rotación de inventario | `unidades vendidas del periodo / stock promedio estimado`. |
| Productos de baja rotación | Productos con `rotación < 0.30` en el periodo seleccionado y `stock > 0`, o productos sin ventas y con stock. |

## 7. Requerimientos funcionales

RF-01. El sistema debe cargar las tablas `Ventas` y `Productos` desde archivos CSV o Excel.

RF-02. El sistema debe relacionar ventas con productos mediante el nombre del producto y/o `id_producto` cuando esté disponible.

RF-03. El dashboard debe mostrar ventas totales, margen estimado, rotación de inventario y productos destacados.

RF-04. El dashboard debe permitir analizar ventas por tiempo, categoría y producto.

RF-05. El dashboard debe mostrar un ranking de productos más vendidos.

RF-06. El dashboard debe identificar productos de baja rotación.

RF-07. El dashboard debe mostrar productos con stock crítico o exceso de stock cuando aplique.

RF-08. El proyecto debe incluir consultas SQL que validen totales, duplicados, datos nulos y KPIs principales.

RF-09. El proyecto debe incluir screenshots finales de cada vista del dashboard.

RF-10. El README debe explicar objetivo, tecnologías, estructura, KPIs, insights y decisiones recomendadas.

## 8. Requerimientos no funcionales

RNF-01. Reproducibilidad: cualquier persona debe poder entender y reconstruir el dataset y las consultas desde el repositorio.

RNF-02. Trazabilidad: los campos, fórmulas y supuestos deben estar documentados.

RNF-03. Simplicidad: se priorizará una arquitectura portable y fácil de evaluar.

RNF-04. Rendimiento: el dashboard debe responder de forma fluida con el volumen de datos del proyecto.

RNF-05. Mantenibilidad: nombres de archivos, tablas, columnas y medidas deben ser consistentes.

RNF-06. Calidad visual: el dashboard debe tener diseño limpio, jerarquía clara y filtros comprensibles.

RNF-07. Integridad: no se deben publicar datos personales, sensibles o privados.

RNF-08. Versionamiento: todo cambio importante debe quedar en Git y publicarse en GitHub.

## 9. Roadmap

### Fase 0 - Preparación y reglas

- Definir tecnologías, alcance, estructura y reglas inmodificables.
- Crear documento maestro.
- Crear estructura base del repositorio.
- Configurar repositorio público en GitHub.

Criterio de cierre: documento maestro aprobado y estructura inicial lista.

### Fase 1 - Dataset

- Crear tabla `Productos`.
- Crear tabla `Ventas`.
- Garantizar consistencia de categorías, precios, costos, cantidades y totales.
- Documentar diccionario de datos.

Criterio de cierre: CSV/Excel válidos, con datos suficientes para generar insights.

### Fase 2 - SQL

- Crear script de schema.
- Crear consultas de validación.
- Crear consultas KPI para ventas, margen, top productos y rotación.

Criterio de cierre: scripts SQL ejecutables y resultados coherentes con el dataset.

### Fase 3 - Modelo Power BI

- Importar datos.
- Crear tabla calendario.
- Definir relaciones.
- Crear medidas DAX.
- Validar KPIs contra SQL.

Criterio de cierre: modelo funcional y medidas verificadas.

### Fase 4 - Dashboard

- Construir vista general.
- Construir análisis de ventas.
- Construir análisis de productos.
- Construir inventario.
- Agregar filtros por fecha, categoría y producto.

Criterio de cierre: dashboard navegable, claro y completo.

### Fase 5 - Insights y QA

- Extraer hallazgos de negocio.
- Revisar consistencia visual y numérica.
- Exportar screenshots.
- Completar README.

Criterio de cierre: entregables listos para evaluación.

### Fase 6 - GitHub

- Subir dataset, SQL, screenshots y documentación.
- Agregar `.pbix` si el tamaño es aceptable para GitHub.
- Crear versión final o release si corresponde.

Criterio de cierre: repositorio público con entregables completos.

## 10. Vista general de carpetas

```text
.
|-- README.md
|-- docs/
|   |-- documento-maestro.md
|   |-- diccionario-datos.md
|   |-- insights.md
|-- data/
|   |-- raw/
|   |   |-- ventas.csv
|   |   |-- productos.csv
|   |-- processed/
|       |-- ventas_limpias.csv
|       |-- productos_limpios.csv
|-- sql/
|   |-- 01_schema.sql
|   |-- 02_validaciones.sql
|   |-- 03_kpis.sql
|-- powerbi/
|   |-- ferreteria_bi.pbix
|-- screenshots/
|   |-- 01_vista_general.png
|   |-- 02_ventas_tiempo.png
|   |-- 03_productos.png
|   |-- 04_inventario.png
```

## 11. Reglas inmodificables del proyecto

Estas reglas se respetarán hasta la finalización del proyecto:

1. Las tablas obligatorias serán `Ventas` y `Productos`.
2. No se eliminarán campos obligatorios definidos en el enunciado.
3. La moneda del proyecto será PEN.
4. Las fechas se manejarán en formato ISO `YYYY-MM-DD`.
5. `Ventas[total]` siempre será `cantidad * precio_unitario`.
6. El dashboard final se entregará en Power BI Desktop como archivo `.pbix`.
7. El dashboard tendrá como mínimo cuatro vistas: general, ventas, productos e inventario.
8. Los KPIs obligatorios no se reemplazarán por otros: ventas totales, ventas por periodo, top productos, rotación, margen estimado y baja rotación.
9. Las fórmulas de KPIs definidas en este documento serán la referencia oficial.
10. Cualquier dato sintético deberá ser verosímil y documentado como sintético.
11. No se presentarán datos sintéticos como datos reales de una empresa.
12. No se publicará información sensible o privada.
13. La estructura de carpetas base se mantendrá.
14. Los archivos finales deben poder revisarse desde GitHub.
15. Los cambios importantes se documentarán en Git antes de cerrar una fase.

## 12. Convenciones de GitHub

- Cuenta conectada: `OJ-Edelsonn`.
- Nombre definido del repositorio: `sistema-bi-ferreteria`.
- Repositorio esperado: `OJ-Edelsonn/sistema-bi-ferreteria`.
- Visibilidad del repositorio: público.
- Rama principal recomendada: `main`.
- Ramas de trabajo recomendadas: `codex/<descripcion-corta>`.
- Commits recomendados:
  - `docs: define project master document`
  - `data: add hardware store dataset`
  - `sql: add validation and kpi queries`
  - `bi: add power bi dashboard`
  - `docs: add screenshots and insights`

## 13. Supuestos iniciales confirmados

- No se entregará data real porque aún no existe. Por lo tanto, se construirá un dataset sintético pero coherente con una ferretería.
- El periodo recomendado del dataset será de 12 a 18 meses para permitir análisis temporal.
- El dataset tendrá suficientes productos y ventas para que los rankings, márgenes y baja rotación sean significativos.
- El dashboard será pensado para gerencia o administración de tienda, no para operación de caja.

## 14. Insights que el sistema debe permitir explicar

El dashboard debe permitir responder preguntas como:

- Qué meses concentran mayor venta.
- Qué categorías generan más ingresos.
- Qué productos venden mucho pero dejan bajo margen.
- Qué productos tienen buen margen pero poca rotación.
- Qué productos tienen stock detenido.
- Qué categorías podrían requerir reposición.
- Qué decisiones de compra, promoción o liquidación se pueden tomar.

## 15. Decisiones cerradas y pendientes

Decisiones cerradas:

1. Nombre oficial del proyecto: `Sistema de Business Intelligence – Ferretería`.
2. Ruta local oficial: `C:\Users\EDELSON ORIHUELA\OneDrive\Documentos\PROYECTOS CV\GPT\Sistema de Business Intelligence – Ferretería`.
3. Usuario GitHub: `OJ-Edelsonn`.
4. Repositorio GitHub: `sistema-bi-ferreteria`.
5. Visibilidad del repositorio: público.
6. Dataset del proyecto: sintético, verosímil y coherente con una ferretería.
7. Periodo analítico del dataset: 12 a 18 meses.
8. Audiencia del dashboard: gerencia o administración de tienda.

Decisiones pendientes:

1. Confirmar si el archivo `.pbix` se subirá directamente o se usará Git LFS si el tamaño crece demasiado.
