-- =============================================================================
-- Exercises: Advanced - SOLUTIONS
-- Try 03_advanced_exercises.sql yourself first!
-- =============================================================================

-- 1. Using a CTE against parks_and_recreation, calculate the total salary
--    per department (dept_id), then select only the departments where that
--    total exceeds 60000.
USE parks_and_recreation;

WITH dept_totals AS (
    SELECT dept_id, SUM(salary) AS total_salary
    FROM employee_salary
    GROUP BY dept_id
)
SELECT *
FROM dept_totals
WHERE total_salary > 60000;

-- 2. Create a temporary table called temp_high_earners containing every row
--    from parks_and_recreation.employee_salary with a salary >= 60000.
CREATE TEMPORARY TABLE temp_high_earners
SELECT *
FROM employee_salary
WHERE salary >= 60000;

SELECT * FROM temp_high_earners;

-- 3. Write a stored procedure named employees_by_department that accepts a
--    single INT parameter (dept_id_param) and returns every employee in
--    parks_and_recreation.employee_salary belonging to that department.
DROP PROCEDURE IF EXISTS employees_by_department;
DELIMITER $$
CREATE PROCEDURE employees_by_department(IN dept_id_param INT)
BEGIN
    SELECT *
    FROM employee_salary
    WHERE dept_id = dept_id_param;
END $$
DELIMITER ;

CALL employees_by_department(1);

-- 4. Using world_layoffs.layoffs_staging2, write a CTE that ranks companies
--    within each industry by total layoffs (SUM(total_laid_off)), then
--    return only the #1 ranked company per industry.
USE world_layoffs;

WITH company_industry_totals AS (
    SELECT industry, company, SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging2
    WHERE industry IS NOT NULL
    GROUP BY industry, company
),
ranked AS (
    SELECT industry, company, total_laid_off,
           RANK() OVER (PARTITION BY industry ORDER BY total_laid_off DESC) AS industry_rank
    FROM company_industry_totals
)
SELECT industry, company, total_laid_off
FROM ranked
WHERE industry_rank = 1;

-- 5. Using retail_sales, add an index to speed up looking up orders by
--    customer_id, then use EXPLAIN to confirm the order_items table's
--    existing indexes are being used when joining to orders and products.
USE retail_sales;

CREATE INDEX idx_orders_customer_id ON orders (customer_id);

EXPLAIN
SELECT o.order_id, oi.product_id, oi.quantity
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
WHERE o.customer_id = 1;

-- 6. Using REGEXP against parks_and_recreation.employee_demographics, find
--    every employee whose first_name contains a double letter (e.g. "nn",
--    "rr") anywhere in the name.
USE parks_and_recreation;

SELECT first_name
FROM employee_demographics
WHERE first_name REGEXP '(.)\\1';

-- 7. Using retail_sales, write a query that finds each customer's most
--    recent order date and how many days ago that was relative to
--    '2023-01-01' (use that fixed date rather than CURDATE(), so results
--    are reproducible).
USE retail_sales;

SELECT c.customer_id,
       c.first_name,
       MAX(o.order_date) AS most_recent_order,
       DATEDIFF('2023-01-01', MAX(o.order_date)) AS days_since_last_order
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name
ORDER BY days_since_last_order;

-- 8. Using retail_sales, write a CTE that computes total revenue per
--    product, then a second CTE that computes the overall average revenue
--    across all products, and finally select every product whose revenue is
--    above that overall average.
WITH product_revenue AS (
    SELECT p.product_id, p.product_name, SUM(oi.quantity * p.unit_price) AS total_revenue
    FROM order_items oi
    JOIN products p ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.product_name
),
overall_avg AS (
    SELECT AVG(total_revenue) AS avg_revenue
    FROM product_revenue
)
SELECT pr.product_name, pr.total_revenue
FROM product_revenue pr
JOIN overall_avg oa
    ON pr.total_revenue > oa.avg_revenue
ORDER BY pr.total_revenue DESC;
