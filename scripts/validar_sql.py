"""Valida los scripts SQL de Fase 2 contra los CSV de data/raw.

Este helper usa sqlite3 de la libreria estandar de Python para que el proyecto
pueda validarse incluso si el ejecutable sqlite3 no esta instalado.
"""

from __future__ import annotations

import csv
import sqlite3
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
CATEGORIA = "categor" + chr(0x00ED) + "a"


def split_sql(path: Path) -> list[str]:
    statements: list[str] = []
    current: list[str] = []

    for line in path.read_text(encoding="utf-8").splitlines():
        stripped = line.strip()
        if not stripped or stripped.startswith("--"):
            continue

        current.append(line)
        if stripped.endswith(";"):
            statement = "\n".join(current).strip().rstrip(";")
            statements.append(statement)
            current = []

    if current:
        statements.append("\n".join(current).strip())

    return statements


def read_csv(path: Path) -> list[dict[str, str]]:
    with path.open("r", encoding="utf-8-sig", newline="") as file:
        return list(csv.DictReader(file))


def load_database() -> sqlite3.Connection:
    conn = sqlite3.connect(":memory:")
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys = ON")
    conn.executescript((ROOT / "sql" / "01_schema.sql").read_text(encoding="utf-8"))

    productos = read_csv(ROOT / "data" / "raw" / "productos.csv")
    ventas = read_csv(ROOT / "data" / "raw" / "ventas.csv")

    conn.executemany(
        f'INSERT INTO productos (id_producto, nombre, "{CATEGORIA}", costo, stock) '
        "VALUES (?, ?, ?, ?, ?)",
        [
            (p["id_producto"], p["nombre"], p[CATEGORIA], float(p["costo"]), int(p["stock"]))
            for p in productos
        ],
    )
    conn.executemany(
        f'INSERT INTO ventas (fecha, producto, "{CATEGORIA}", cantidad, precio_unitario, total) '
        "VALUES (?, ?, ?, ?, ?, ?)",
        [
            (
                v["fecha"],
                v["producto"],
                v[CATEGORIA],
                int(v["cantidad"]),
                float(v["precio_unitario"]),
                float(v["total"]),
            )
            for v in ventas
        ],
    )
    conn.commit()
    return conn


def execute_script(conn: sqlite3.Connection, path: Path) -> list[list[sqlite3.Row]]:
    results: list[list[sqlite3.Row]] = []
    for statement in split_sql(path):
        if statement.upper().startswith("PRAGMA"):
            conn.execute(statement)
            continue

        cursor = conn.execute(statement)
        results.append(cursor.fetchall())

    return results


def md_table(rows: list[dict[str, object]], columns: list[str], max_rows: int | None = None) -> str:
    selected_rows = rows[:max_rows] if max_rows else rows
    header = "| " + " | ".join(columns) + " |"
    separator = "|" + "|".join(["---"] * len(columns)) + "|"
    body = [
        "| " + " | ".join(str(row.get(column, "")) for column in columns) + " |"
        for row in selected_rows
    ]
    return "\n".join([header, separator] + body)


def write_results(
    validation_rows: list[dict[str, object]],
    main_kpi: dict[str, object],
    monthly_rows: list[dict[str, object]],
    category_rows: list[dict[str, object]],
    top_rows: list[dict[str, object]],
    low_rotation_rows: list[dict[str, object]],
) -> None:
    metric = "M" + chr(0x00E9) + "trica"
    ultimo = "u" + chr(0x00FA) + "ltimo"
    categorias = "categor" + chr(0x00ED) + "as"
    rotacion = "rotaci" + chr(0x00F3) + "n"

    content = f"""# Resultados SQL - Fase 2

Estos resultados fueron generados ejecutando los scripts SQL contra los CSV de `data/raw` con SQLite.

## Validaciones

{md_table(validation_rows, ["validacion", "valor", "tipo"])}

## KPI general

| {metric} | Valor |
|---|---:|
| Ventas totales | S/ {main_kpi["ventas_totales"]:,.2f} |
| Unidades vendidas | {main_kpi["unidades_vendidas"]:,} |
| Transacciones | {main_kpi["transacciones"]:,} |
| Margen estimado | S/ {main_kpi["margen_estimado"]:,.2f} |
| Margen estimado % | {main_kpi["margen_estimado_pct"]:.2%} |

## Primer y {ultimo} periodo mensual

| Periodo | Ventas totales | Unidades vendidas | Transacciones | Margen estimado |
|---|---:|---:|---:|---:|
| {monthly_rows[0]["periodo_mes"]} | S/ {monthly_rows[0]["ventas_totales"]:,.2f} | {monthly_rows[0]["unidades_vendidas"]} | {monthly_rows[0]["transacciones"]} | S/ {monthly_rows[0]["margen_estimado"]:,.2f} |
| {monthly_rows[-1]["periodo_mes"]} | S/ {monthly_rows[-1]["ventas_totales"]:,.2f} | {monthly_rows[-1]["unidades_vendidas"]} | {monthly_rows[-1]["transacciones"]} | S/ {monthly_rows[-1]["margen_estimado"]:,.2f} |

## Top 5 {categorias} por ventas

{md_table(category_rows, [CATEGORIA, "ventas_totales", "unidades_vendidas", "margen_estimado"], 5)}

## Top 5 productos por ventas

{md_table(top_rows, ["producto", CATEGORIA, "ventas_totales", "unidades_vendidas", "margen_estimado"], 5)}

## Productos de baja {rotacion}

Productos detectados: {len(low_rotation_rows)}

{md_table(low_rotation_rows, ["id_producto", "producto", CATEGORIA, "unidades_vendidas", "stock_actual", "rotacion_inventario"], 8)}
"""

    (ROOT / "docs" / "resultados-sql.md").write_text(content, encoding="utf-8")


def main() -> None:
    conn = load_database()

    validation_results = execute_script(conn, ROOT / "sql" / "02_validaciones.sql")
    kpi_results = execute_script(conn, ROOT / "sql" / "03_kpis.sql")

    validation_rows = [dict(row) for row in validation_results[0]]
    error_rows = [
        row
        for row in validation_rows
        if row["tipo"] == "error" and int(row["valor"]) != 0
    ]
    if error_rows:
        raise SystemExit(f"Errores de validacion SQL: {error_rows}")

    main_kpi = dict(kpi_results[0][0])
    monthly_rows = [dict(row) for row in kpi_results[1]]
    category_rows = [dict(row) for row in kpi_results[2]]
    top_rows = [dict(row) for row in kpi_results[3]]
    low_rotation_rows = [dict(row) for row in kpi_results[6]]

    write_results(
        validation_rows,
        main_kpi,
        monthly_rows,
        category_rows,
        top_rows,
        low_rotation_rows,
    )

    print("Validacion SQL completada sin errores.")
    print(f"Ventas totales: S/ {main_kpi['ventas_totales']:,.2f}")
    print(f"Margen estimado: S/ {main_kpi['margen_estimado']:,.2f}")
    print(f"Productos de baja rotacion: {len(low_rotation_rows)}")


if __name__ == "__main__":
    main()

