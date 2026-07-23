-- =============================================================================
-- Intermediate: Date and Time Functions  (NEW LESSON)
-- Run sql/00_setup/01_create_parks_and_recreation_db.sql first.
-- =============================================================================

-- Date/time functions come up constantly in real analysis work: calculating
-- ages, tenure, cohorts, reporting periods, and rolling windows all rely on them.

USE parks_and_recreation;

-- CURDATE() / NOW() return the current date / current date-time
SELECT CURDATE() AS today, NOW() AS right_now;

-- YEAR / MONTH / DAY pull individual date parts out of a date column
SELECT first_name, birth_date,
       YEAR(birth_date) AS birth_year,
       MONTH(birth_date) AS birth_month,
       DAY(birth_date) AS birth_day
FROM employee_demographics;

-- DATEDIFF gives the number of days between two dates
SELECT first_name, birth_date,
       DATEDIFF(CURDATE(), birth_date) AS days_alive
FROM employee_demographics;

-- TIMESTAMPDIFF lets you get the difference in units other than days -
-- here, calculating each employee's current age in years directly from
-- their birth_date (rather than relying on the stored `age` column):
SELECT first_name, birth_date,
       TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS calculated_age
FROM employee_demographics;

-- DATE_ADD / DATE_SUB shift a date forward or backward
SELECT first_name, birth_date,
       DATE_ADD(birth_date, INTERVAL 65 YEAR) AS retirement_eligible_date
FROM employee_demographics;

SELECT CURDATE(),
       DATE_SUB(CURDATE(), INTERVAL 30 DAY) AS thirty_days_ago;

-- DATE_FORMAT reformats a date for display - very useful for reports
SELECT first_name, birth_date,
       DATE_FORMAT(birth_date, '%M %d, %Y') AS pretty_birth_date
FROM employee_demographics;

-- Grouping by a date part is a common reporting pattern - e.g. counting
-- employees by birth decade:
SELECT FLOOR(YEAR(birth_date) / 10) * 10 AS birth_decade,
       COUNT(*) AS employee_count
FROM employee_demographics
GROUP BY birth_decade
ORDER BY birth_decade;
