-- =============================================================================
-- Advanced: Triggers and Events
-- Run sql/00_setup/01_create_parks_and_recreation_db.sql first.
-- =============================================================================

USE parks_and_recreation;

-- ---------------------------------------------------------------------------
-- TRIGGERS
-- ---------------------------------------------------------------------------

-- A trigger is a block of code that automatically executes in response to an
-- event (INSERT, UPDATE, or DELETE) on a table.

-- Let's build an audit log: whenever a new employee is inserted into
-- employee_salary, automatically record that hire in a separate audit table.

CREATE TABLE IF NOT EXISTS employee_salary_audit (
    audit_id INT NOT NULL AUTO_INCREMENT,
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary INT,
    logged_at DATETIME,
    PRIMARY KEY (audit_id)
);

DROP TRIGGER IF EXISTS trg_employee_salary_insert;
DELIMITER $$
CREATE TRIGGER trg_employee_salary_insert
    -- We could also use BEFORE INSERT, but AFTER makes sense here since we
    -- only want to log rows that were actually saved successfully.
    AFTER INSERT ON employee_salary
    -- FOR EACH ROW means this fires once per inserted row. MySQL doesn't
    -- support statement-level (batch) triggers the way some other databases do.
    FOR EACH ROW
BEGIN
    -- NEW refers to the row that was just inserted. (There's also OLD,
    -- available in UPDATE/DELETE triggers, referring to the row before the change.)
    INSERT INTO employee_salary_audit (employee_id, first_name, last_name, salary, logged_at)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name, NEW.salary, NOW());
END $$
DELIMITER ;

-- Test it out: hire a new employee and check that the audit table picks it up
INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES (13, 'Jean-Ralphio', 'Saperstein', 'Entertainment 720 CEO', 1000000, NULL);

SELECT * FROM employee_salary_audit;

-- Clean up the test row
DELETE FROM employee_salary WHERE employee_id = 13;

-- ---------------------------------------------------------------------------
-- EVENTS
-- ---------------------------------------------------------------------------

-- An event is a task that runs automatically on a schedule (some other
-- databases, like SQL Server, call this a "job"). Events are great for
-- automation - scheduled imports, scheduled report exports, cleanup jobs, etc.
-- MySQL's event scheduler must be turned on for these to actually fire:
SET GLOBAL event_scheduler = ON;

-- Suppose Parks & Rec policy is that anyone 60 or older is automatically
-- retired (removed from the active demographics table).

SELECT * FROM employee_demographics;

SHOW EVENTS;

DROP EVENT IF EXISTS delete_retirees;
DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
    DELETE FROM employee_demographics
    WHERE age >= 60;
END $$
DELIMITER ;

-- Wait ~30 seconds, then check again - Jerry (age 61) should have been
-- automatically removed once the event fired.
SELECT * FROM employee_demographics;

-- When you're done experimenting, disable the event so it stops running:
-- DROP EVENT IF EXISTS delete_retirees;
