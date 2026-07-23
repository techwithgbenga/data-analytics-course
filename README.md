# SQL Data Analysis Course

A hands-on, self-contained SQL course for data analysis, built around MySQL.
It goes from the absolute basics (`SELECT`) through joins, window functions,
CTEs, stored procedures, triggers, indexing, and finishes with two full
portfolio projects modeled on real data-analyst workflows.

Originally based on Alex The Analyst's MySQL YouTube series, this version has
been rewritten, reorganized, and extended: every lesson runs cleanly against
the included setup scripts, several bugs in the original queries have been
fixed, and new lessons/exercises/projects have been added to make it a
complete, standalone course.

## Who this is for

Anyone learning SQL for data analysis - no prior database experience
required. Some comfort with spreadsheets or basic programming helps but
isn't necessary.

## What you'll need

- [MySQL Community Server](https://dev.mysql.com/downloads/mysql/) (8.0+)
- [MySQL Workbench](https://dev.mysql.com/downloads/workbench/) (or any SQL
  client you're comfortable with)

## Getting started

1. Clone this repo and open the `sql/` folder in MySQL Workbench (or your
   client of choice).
2. Run the setup scripts in `sql/00_setup/` **in order** - they create the
   sample databases every lesson depends on.
3. Work through the lessons in order: `01_beginner` → `02_intermediate` →
   `03_advanced` → `04_portfolio_projects`.
4. Test yourself with `sql/05_exercises/` before checking the solutions.

Each `.sql` file is meant to be run top to bottom, statement by statement,
reading the comments as you go - they explain *why*, not just *what*.

## Course outline

### `sql/00_setup/` - sample databases

| Script | Creates |
|---|---|
| `01_create_parks_and_recreation_db.sql` | `parks_and_recreation` - employee, salary, department, and customer data (Parks and Recreation themed) |
| `02_create_bakery_db.sql` | `bakery` - a small customer table used for string-function practice |
| `03_create_world_layoffs_db.sql` | `world_layoffs` - loads `datasets/world_layoffs.csv` for the first portfolio project |

### `sql/01_beginner/`

1. `01_select_statement.sql` - SELECT, column math, DISTINCT
2. `02_where_clause.sql` - WHERE, comparison operators, LIKE wildcards
3. `03_group_by_and_order_by.sql` - GROUP BY, aggregate functions, ORDER BY
4. `04_having_vs_where.sql` - filtering rows vs. filtering groups
5. `05_limit_and_aliasing.sql` - LIMIT with offsets, column/table aliases

### `sql/02_intermediate/`

1. `01_joins.sql` - INNER, LEFT, RIGHT, and self joins; joining 3+ tables
2. `02_unions.sql` - UNION, UNION ALL, UNION DISTINCT
3. `03_string_functions.sql` - LENGTH, UPPER/LOWER, TRIM, LEFT/RIGHT, SUBSTRING, REPLACE, LOCATE, CONCAT
4. `04_case_statements.sql` - CASE for labeling and calculated columns
5. `05_subqueries.sql` - subqueries in WHERE, SELECT, and FROM
6. `06_window_functions.sql` - OVER(), PARTITION BY, ROW_NUMBER, RANK, DENSE_RANK
7. `07_date_and_time_functions.sql` **(new)** - CURDATE, DATEDIFF, TIMESTAMPDIFF, DATE_ADD, DATE_FORMAT
8. `08_views.sql` **(new)** - CREATE VIEW, querying and layering views

### `sql/03_advanced/`

1. `01_ctes.sql` - single and multiple CTEs, renaming CTE columns
2. `02_temp_tables.sql` - session-scoped temporary tables
3. `03_stored_procedures.sql` - DELIMITER, multi-statement procedures, parameters
4. `04_triggers_and_events.sql` - audit-log trigger on INSERT, scheduled events
5. `05_indexes_and_query_performance.sql` **(new)** - EXPLAIN, single/composite indexes
6. `06_regular_expressions.sql` **(new)** - REGEXP, REGEXP_REPLACE, REGEXP_LIKE

### `sql/04_portfolio_projects/`

1. **World Layoffs (2022-2023)** - a real dataset ([source](https://www.kaggle.com/datasets/swaptr/layoffs-2022), included in `datasets/world_layoffs.csv`)
   - `01_data_cleaning_world_layoffs.sql` - de-duplication, standardization, NULL handling
   - `02_exploratory_data_analysis_world_layoffs.sql` - trends by company, industry, country, and time
2. **Retail Sales Analysis** **(new)** - a fully self-contained, seeded dataset (no download required)
   - `03_retail_sales_analysis/01_create_and_seed_retail_sales_db.sql` - customers, products, orders, order_items
   - `03_retail_sales_analysis/02_retail_sales_eda.sql` - revenue trends, running totals, top products, customer lifetime value - combining joins, CTEs, and window functions end to end

### `sql/05_exercises/` **(new)**

Practice prompts with separate solution files, split by level:

- `01_beginner_exercises.sql` / `01_beginner_solutions.sql`
- `02_intermediate_exercises.sql` / `02_intermediate_solutions.sql`
- `03_advanced_exercises.sql` / `03_advanced_solutions.sql`

Try each prompt yourself before peeking at the solution file.

## Datasets

- `datasets/world_layoffs.csv` - layoffs data used in portfolio project 1. All
  other datasets (Parks and Recreation, bakery, retail sales) are generated
  entirely by the setup/project scripts - no other downloads needed.

## Notes on this rewrite

- Renamed and renumbered every file so the intended learning order is
  explicit from the filesystem alone.
- Fixed several bugs inherited from the original scripts, including: a
  `SELECT` referencing a `customers` table that was never created, a
  `department_id` column name that didn't match the actual schema
  (`dept_id`), a stored-procedure `CALL` targeting a procedure name that was
  never defined, a temp-table example querying the wrong table name, and a
  mismatched trigger example (originally written against an unrelated
  invoice/payments schema).
- Added two new intermediate lessons (date/time functions, views), two new
  advanced lessons (indexes/performance, regular expressions), a full second
  portfolio project (retail sales), and a full exercises/solutions section.
