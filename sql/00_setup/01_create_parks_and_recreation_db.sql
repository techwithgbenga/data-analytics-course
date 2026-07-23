-- =============================================================================
-- Setup: Parks and Recreation sample database
-- Used by: sql/01_beginner, sql/02_intermediate, sql/03_advanced
-- Run this once before working through those lessons.
-- =============================================================================

DROP DATABASE IF EXISTS `parks_and_recreation`;
CREATE DATABASE `parks_and_recreation`;
USE `parks_and_recreation`;

-- ---------------------------------------------------------------------------
-- employee_demographics: personal details for each employee
-- ---------------------------------------------------------------------------
CREATE TABLE employee_demographics (
  employee_id INT NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  age INT,
  gender VARCHAR(10),
  birth_date DATE,
  PRIMARY KEY (employee_id)
);

INSERT INTO employee_demographics (employee_id, first_name, last_name, age, gender, birth_date)
VALUES
(1, 'Leslie', 'Knope', 44, 'Female', '1979-09-25'),
(3, 'Tom', 'Haverford', 36, 'Male', '1987-03-04'),
(4, 'April', 'Ludgate', 29, 'Female', '1994-03-27'),
(5, 'Jerry', 'Gergich', 61, 'Male', '1962-08-28'),
(6, 'Donna', 'Meagle', 46, 'Female', '1977-07-30'),
(7, 'Ann', 'Perkins', 35, 'Female', '1988-12-01'),
(8, 'Chris', 'Traeger', 43, 'Male', '1980-11-11'),
(9, 'Ben', 'Wyatt', 38, 'Male', '1985-07-26'),
(10, 'Andy', 'Dwyer', 34, 'Male', '1989-03-25'),
(11, 'Mark', 'Brendanawicz', 40, 'Male', '1983-06-14'),
(12, 'Craig', 'Middlebrooks', 37, 'Male', '1986-07-27');

-- Note: Ron Swanson (employee_id 2) is intentionally missing here. He refused
-- to give up his birth date, age, or gender - this makes him a useful example
-- later on for JOINs, since he has salary data but no demographic data.

-- ---------------------------------------------------------------------------
-- employee_salary: job/compensation details for each employee
-- ---------------------------------------------------------------------------
CREATE TABLE employee_salary (
  employee_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  occupation VARCHAR(50),
  salary INT,
  dept_id INT,
  PRIMARY KEY (employee_id)
);

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES
(1, 'Leslie', 'Knope', 'Deputy Director of Parks and Recreation', 75000, 1),
(2, 'Ron', 'Swanson', 'Director of Parks and Recreation', 70000, 1),
(3, 'Tom', 'Haverford', 'Entrepreneur', 50000, 1),
(4, 'April', 'Ludgate', 'Assistant to the Director of Parks and Recreation', 25000, 1),
(5, 'Jerry', 'Gergich', 'Office Manager', 50000, 1),
(6, 'Donna', 'Meagle', 'Office Manager', 60000, 1),
(7, 'Ann', 'Perkins', 'Nurse', 55000, 4),
(8, 'Chris', 'Traeger', 'City Manager', 90000, 3),
(9, 'Ben', 'Wyatt', 'State Auditor', 70000, 6),
(10, 'Andy', 'Dwyer', 'Shoe Shiner and Musician', 20000, NULL),
(11, 'Mark', 'Brendanawicz', 'City Planner', 57000, 3),
(12, 'Craig', 'Middlebrooks', 'Parks Director', 65000, 1);

-- ---------------------------------------------------------------------------
-- parks_departments: department lookup table
-- ---------------------------------------------------------------------------
CREATE TABLE parks_departments (
  department_id INT NOT NULL AUTO_INCREMENT,
  department_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (department_id)
);

INSERT INTO parks_departments (department_name)
VALUES
('Parks and Recreation'),
('Animal Control'),
('Public Works'),
('Healthcare'),
('Library'),
('Finance');

-- ---------------------------------------------------------------------------
-- customers: Pawnee Parks & Rec gift-shop customers
-- Added so the beginner SELECT / ORDER BY lessons (which reference a
-- `customers` table) actually run out of the box.
-- ---------------------------------------------------------------------------
CREATE TABLE customers (
  customer_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  state VARCHAR(2),
  total_money_spent DECIMAL(10, 2),
  PRIMARY KEY (customer_id)
);

INSERT INTO customers (first_name, last_name, state, total_money_spent)
VALUES
('Tammy', 'Swanson', 'IN', 540.00),
('Shauna', 'Malwae-Tweep', 'IN', 120.50),
('Perd', 'Hapley', 'IN', 75.25),
('Joan', 'Callamezzo', 'IN', 310.00),
('Dennis', 'Feinstein', 'IN', 45.00),
('Sheila', 'Butz', 'IN', 210.75),
('Ethel', 'Beavers', 'IN', 15.00),
('Bobby', 'Newport', 'RI', 980.00),
('Jean-Ralphio', 'Saperstein', 'IN', 0.00),
('Shauna', 'Tate', 'IN', 275.30);
