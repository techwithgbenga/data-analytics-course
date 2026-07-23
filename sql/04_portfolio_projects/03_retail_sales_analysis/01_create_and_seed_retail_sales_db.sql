-- =============================================================================
-- Portfolio Project 2: Retail Sales Analysis - Setup
-- A fully self-contained dataset (no external download needed) that ties
-- together joins, CTEs, window functions, and date functions from every
-- earlier lesson into one end-to-end analysis.
-- =============================================================================

DROP DATABASE IF EXISTS `retail_sales`;
CREATE DATABASE `retail_sales`;
USE `retail_sales`;

CREATE TABLE customers (
    customer_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    signup_date DATE,
    country VARCHAR(50),
    PRIMARY KEY (customer_id)
);

CREATE TABLE products (
    product_id INT NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10, 2),
    PRIMARY KEY (product_id)
);

CREATE TABLE orders (
    order_id INT NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

CREATE TABLE order_items (
    order_item_id INT NOT NULL AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_item_id),
    FOREIGN KEY (order_id) REFERENCES orders (order_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id)
);

INSERT INTO customers (first_name, last_name, signup_date, country) VALUES
('Leslie', 'Knope', '2022-01-15', 'USA'),
('Ron', 'Swanson', '2022-01-20', 'USA'),
('Tom', 'Haverford', '2022-02-02', 'USA'),
('April', 'Ludgate', '2022-02-10', 'USA'),
('Ben', 'Wyatt', '2022-03-01', 'USA'),
('Ann', 'Perkins', '2022-03-15', 'Canada'),
('Chris', 'Traeger', '2022-04-05', 'Canada'),
('Donna', 'Meagle', '2022-05-12', 'USA'),
('Andy', 'Dwyer', '2022-06-01', 'USA'),
('Craig', 'Middlebrooks', '2022-07-18', 'UK');

INSERT INTO products (product_name, category, unit_price) VALUES
('Waffle Iron', 'Kitchen', 39.99),
('Camping Tent', 'Outdoor', 129.99),
('Yoga Mat', 'Fitness', 24.99),
('Desk Lamp', 'Home Office', 22.50),
('Bluetooth Speaker', 'Electronics', 59.99),
('Running Shoes', 'Fitness', 84.99),
('Coffee Grinder', 'Kitchen', 34.99),
('Standing Desk', 'Home Office', 249.99),
('Hiking Backpack', 'Outdoor', 74.99),
('Wireless Mouse', 'Electronics', 19.99);

INSERT INTO orders (customer_id, order_date) VALUES
(1, '2022-02-01'), (1, '2022-03-15'), (1, '2022-06-20'), (1, '2022-11-05'),
(2, '2022-02-05'), (2, '2022-05-01'), (2, '2022-09-14'),
(3, '2022-03-01'), (3, '2022-03-02'), (3, '2022-08-19'),
(4, '2022-03-11'), (4, '2022-07-07'),
(5, '2022-04-01'), (5, '2022-04-28'), (5, '2022-10-10'),
(6, '2022-04-01'), (6, '2022-06-15'),
(7, '2022-05-01'), (7, '2022-12-01'),
(8, '2022-06-01'), (8, '2022-06-02'), (8, '2022-09-30'),
(9, '2022-07-01'),
(10, '2022-08-01'), (10, '2022-08-15'), (10, '2022-12-20');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1), (1, 4, 2),
(2, 2, 1),
(3, 3, 2), (3, 6, 1),
(4, 8, 1),
(5, 5, 1), (5, 10, 1),
(6, 7, 1),
(7, 9, 1), (7, 2, 1),
(8, 1, 1),
(9, 4, 1), (9, 10, 3),
(10, 6, 2),
(11, 3, 1),
(12, 8, 1), (12, 4, 1),
(13, 5, 2),
(14, 9, 1),
(15, 7, 1), (15, 6, 1),
(16, 2, 1),
(17, 10, 4),
(18, 1, 2),
(19, 8, 1),
(20, 3, 1), (20, 5, 1),
(21, 6, 1),
(22, 9, 2),
(23, 4, 1),
(24, 7, 1), (24, 2, 1),
(25, 10, 2),
(26, 1, 1), (26, 8, 1);

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;
