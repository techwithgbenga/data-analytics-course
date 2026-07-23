-- =============================================================================
-- Setup: Bakery sample database
-- Used by: sql/02_intermediate/03_string_functions.sql
-- =============================================================================

DROP DATABASE IF EXISTS `bakery`;
CREATE DATABASE `bakery`;
USE `bakery`;

CREATE TABLE customers (
  customer_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(100),
  phone VARCHAR(20),
  favorite_item VARCHAR(50),
  PRIMARY KEY (customer_id)
);

INSERT INTO customers (first_name, last_name, email, phone, favorite_item)
VALUES
('Alexander', 'Freberg', 'alex.freberg@example.com', '  555-201-0110  ', 'Sourdough Loaf'),
('Michaela', 'Torres', 'michaela.t@example.com', '555-201-0111', 'Cinnamon Roll'),
('Micah', 'Owens', 'micah.owens@example.com', '555-201-0112', 'Croissant'),
('Amanda', 'Reyes', 'amanda.reyes@example.com', '555-201-0113', 'Baguette'),
('Alicia', 'Nguyen', 'alicia.n@example.com', '555-201-0114', 'Bagel'),
('Ana', 'Delgado', 'ana.delgado@example.com', '555-201-0115', 'Muffin'),
('Andre', 'Walsh', 'andre.walsh@example.com', '555-201-0116', 'Danish'),
('Sky', 'Larson', 'sky.larson@example.com', '555-201-0117', 'Cupcake'),
('Marcus', 'Alvarez', 'marcus.a@example.com', '555-201-0118', 'Scone'),
('Priya', 'Alexander', 'priya.alexander@example.com', '555-201-0119', 'Eclair');
