-- =============================================================================
-- Exercises: Advanced
-- Uses `parks_and_recreation`, `world_layoffs`, and `retail_sales`.
-- Run the relevant setup/portfolio-project scripts first:
--   sql/00_setup/01_create_parks_and_recreation_db.sql
--   sql/00_setup/03_create_world_layoffs_db.sql + 04_portfolio_projects/01_data_cleaning_world_layoffs.sql
--   sql/04_portfolio_projects/03_retail_sales_analysis/01_create_and_seed_retail_sales_db.sql
-- Write your own query/object under each prompt, then compare against
-- 03_advanced_solutions.sql when you're done.
-- =============================================================================

-- 1. Using a CTE against parks_and_recreation, calculate the total salary
--    per department (dept_id), then select only the departments where that
--    total exceeds 60000.


-- 2. Create a temporary table called temp_high_earners containing every row
--    from parks_and_recreation.employee_salary with a salary >= 60000.


-- 3. Write a stored procedure named employees_by_department that accepts a
--    single INT parameter (dept_id_param) and returns every employee in
--    parks_and_recreation.employee_salary belonging to that department.


-- 4. Using world_layoffs.layoffs_staging2, write a CTE that ranks companies
--    within each industry by total layoffs (SUM(total_laid_off)), then
--    return only the #1 ranked company per industry.


-- 5. Using retail_sales, add an index to speed up looking up orders by
--    customer_id, then use EXPLAIN to confirm the order_items table's
--    existing indexes are being used when joining to orders and products.


-- 6. Using REGEXP against parks_and_recreation.employee_demographics, find
--    every employee whose first_name contains a double letter (e.g. "nn",
--    "rr") anywhere in the name.


-- 7. Using retail_sales, write a query that finds each customer's most
--    recent order date and how many days ago that was relative to
--    '2023-01-01' (use that fixed date rather than CURDATE(), so results
--    are reproducible).


-- 8. Using retail_sales, write a CTE that computes total revenue per
--    product, then a second CTE that computes the overall average revenue
--    across all products, and finally select every product whose revenue is
--    above that overall average.
