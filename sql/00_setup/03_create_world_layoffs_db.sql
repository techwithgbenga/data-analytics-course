-- =============================================================================
-- Setup: World Layoffs sample database
-- Used by: sql/04_portfolio_projects/01_data_cleaning_world_layoffs.sql
--          sql/04_portfolio_projects/02_exploratory_data_analysis_world_layoffs.sql
--
-- Source data: datasets/world_layoffs.csv
-- Original dataset: https://www.kaggle.com/datasets/swaptr/layoffs-2022
-- =============================================================================

DROP DATABASE IF EXISTS `world_layoffs`;
CREATE DATABASE `world_layoffs`;
USE `world_layoffs`;

CREATE TABLE layoffs (
  company TEXT,
  location TEXT,
  industry TEXT,
  total_laid_off INT,
  percentage_laid_off TEXT,
  `date` TEXT,
  stage TEXT,
  country TEXT,
  funds_raised_millions INT
);

-- ---------------------------------------------------------------------------
-- Load the CSV data. Pick ONE of the two options below.
-- ---------------------------------------------------------------------------

-- Option A (recommended): MySQL Workbench "Table Data Import Wizard"
--   1. Right-click `world_layoffs` > layoffs table in the Navigator > "Table Data Import Wizard"
--   2. Point it at datasets/world_layoffs.csv and let it map columns automatically.

-- Option B: LOAD DATA INFILE (faster, but requires the file to be readable by
-- the MySQL server process and `secure_file_priv` to allow it). Replace the
-- path below with the absolute path to datasets/world_layoffs.csv on your
-- machine, then uncomment:

-- LOAD DATA INFILE '/absolute/path/to/datasets/world_layoffs.csv'
-- INTO TABLE layoffs
-- FIELDS TERMINATED BY ','
-- OPTIONALLY ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

SELECT * FROM layoffs;
