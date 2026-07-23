-- =============================================================================
-- Portfolio Project 2: Retail Sales Analysis - EDA
-- Run 01_create_and_seed_retail_sales_db.sql first.
--
-- This project deliberately combines everything from the course - joins,
-- CTEs, window functions, date functions, and subqueries - into one
-- realistic, end-to-end analysis.
-- =============================================================================

USE retail_sales;

-- ---------------------------------------------------------------------------
-- Warm-up: revenue per order line, and per order
-- ---------------------------------------------------------------------------

SELECT oi.order_item_id,
       oi.order_id,
       p.product_name,
       oi.quantity,
       p.unit_price,
       oi.quantity * p.unit_price AS line_revenue
FROM order_items oi
JOIN products p
    ON p.product_id = oi.product_id;

SELECT o.order_id,
       o.order_date,
       c.first_name,
       c.last_name,
       SUM(oi.quantity * p.unit_price) AS order_total
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
GROUP BY o.order_id, o.order_date, c.first_name, c.last_name
ORDER BY o.order_date;

-- ---------------------------------------------------------------------------
-- Revenue by month (uses date functions + GROUP BY)
-- ---------------------------------------------------------------------------

SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
       SUM(oi.quantity * p.unit_price) AS monthly_revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
GROUP BY order_month
ORDER BY order_month;

-- Running (cumulative) revenue total by month - a window function over the
-- monthly aggregate above.
WITH monthly_revenue AS (
    SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
           SUM(oi.quantity * p.unit_price) AS revenue
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    JOIN products p ON p.product_id = oi.product_id
    GROUP BY order_month
)
SELECT order_month,
       revenue,
       SUM(revenue) OVER (ORDER BY order_month) AS running_total_revenue
FROM monthly_revenue
ORDER BY order_month;

-- ---------------------------------------------------------------------------
-- Top products by revenue and by units sold
-- ---------------------------------------------------------------------------

SELECT p.product_name,
       p.category,
       SUM(oi.quantity) AS units_sold,
       SUM(oi.quantity * p.unit_price) AS total_revenue
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
GROUP BY p.product_name, p.category
ORDER BY total_revenue DESC;

-- Best-selling product PER CATEGORY, using a window function to rank within
-- each category without collapsing rows
WITH product_revenue AS (
    SELECT p.category,
           p.product_name,
           SUM(oi.quantity * p.unit_price) AS total_revenue
    FROM order_items oi
    JOIN products p ON p.product_id = oi.product_id
    GROUP BY p.category, p.product_name
)
SELECT category, product_name, total_revenue
FROM (
    SELECT category, product_name, total_revenue,
           RANK() OVER (PARTITION BY category ORDER BY total_revenue DESC) AS category_rank
    FROM product_revenue
) ranked
WHERE category_rank = 1;

-- ---------------------------------------------------------------------------
-- Customer analysis: lifetime value, order count, and repeat customers
-- ---------------------------------------------------------------------------

SELECT c.customer_id,
       c.first_name,
       c.last_name,
       c.country,
       COUNT(DISTINCT o.order_id) AS order_count,
       SUM(oi.quantity * p.unit_price) AS lifetime_value
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.country
ORDER BY lifetime_value DESC;

-- Customers who placed more than one order (repeat customers) - subquery in
-- the WHERE clause via HAVING on a derived count.
SELECT customer_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
HAVING order_count > 1;

-- Days between each customer's signup and their first order - combines a
-- correlated aggregate subquery with date functions.
SELECT c.customer_id,
       c.first_name,
       c.signup_date,
       MIN(o.order_date) AS first_order_date,
       DATEDIFF(MIN(o.order_date), c.signup_date) AS days_to_first_order
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.signup_date
ORDER BY days_to_first_order;

-- ---------------------------------------------------------------------------
-- Revenue by country
-- ---------------------------------------------------------------------------

SELECT c.country,
       SUM(oi.quantity * p.unit_price) AS total_revenue
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
GROUP BY c.country
ORDER BY total_revenue DESC;
