# SQL Portfolio — Nischith R

Two end-to-end SQL projects that turn raw business data into decisions. Each project goes from basic queries to joins, CTEs and window functions, and ends with findings, business impact and limitations.

| Project | Domain | Data | SQL skills shown |
|---|---|---|---|
| [US Hospital Quality Analysis](./Project_Hospital_Operations) | Healthcare | 5,432 US hospitals (CMS Hospital General Information) | Data cleaning with `NULLIF`/`CAST`, `CASE WHEN`, CTEs, `DENSE_RANK`, `NTILE`, `CROSS JOIN` benchmarks |
| [Amazon Brazil → India Market Analysis](./Project_Amazon_Market_Analysis) | E-commerce | ~99,000 orders across 6 related tables (2016–2018) | Multi-table joins, segmentation, CTEs, window functions, recursive CTE, month-over-month growth |

## Headline findings

- **Hospitals:** Veterans Health hospitals average **4.16** stars, voluntary non-profit **3.31**, government **2.91** and for-profit **2.80** (rated hospitals only).
- **Hospitals:** hospitals that report more readmission measures do **not** have lower ratings (quartile averages 3.18–3.25).
- **E-commerce:** **17 of 78** product categories bring in 80% of item revenue, a clear Pareto pattern.
- **E-commerce:** only **3.3%** of customers placed more than one order, so retention is the biggest growth gap.

## Tools

PostgreSQL (pgAdmin) · SQL · Excel for some charts

