-- SQL Project - Data Cleaning and Data Extraction


-- First, create a "staging table" and clean the data through it, in order to keep the raw data table without changes in case something happens...

CREATE TABLE layoffs_staging  
LIKE layoffs;

INSERT layoffs_staging 
SELECT * FROM layoffs;
 
SET SQL_SAFE_UPDATES = 0;

----- steps that are followed:
-- 1. check for duplicates and remove any 
-- 2. standardize data and fix errors
-- 3. Look at null values and see what 
-- 4. remove any columns and rows that are not necessary - few ways



-- 1. Check and Remove Duplicates

select *,
ROW_NUMBER() over(
partition BY COMPANY, location, INDUSTRY, TOTAL_LAID_OFF, percentage_laid_off, "DATE", stage, country, funds_raised) 
AS ROW_NUM
FROM LAYOFF_STAGING;

with dublicate_CTE as
(
select *,
ROW_NUMBER() over(
partition BY COMPANY, location, INDUSTRY, TOTAL_LAID_OFF, percentage_laid_off, "DATE", stage, country, funds_raised) 
AS ROW_NUM
FROM LAYOFF_STAGING
)
select *
from dublicate_CTE
where row_num > 1;

CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` text,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoff_staging2;

insert into layoff_staging2
(
select *,
ROW_NUMBER() over(
partition BY COMPANY, location, INDUSTRY, TOTAL_LAID_OFF, percentage_laid_off, "DATE", stage, country, funds_raised) 
AS ROW_NUM
FROM LAYOFF_STAGING
);

DELETE FROM layoff_staging2
WHERE ROW_NUM > 1;


SET SQL_SAFE_UPDATES = 0;

-- 2. standardize data

use project;
select company,
trim(company)
from layoff_staging2;

update layoff_staging2
set company = trim(company);

select distinct industry
from layoff_staging2
order by 1;

select *
from layoff_staging2
where industry like "crypto%";

update layoff_staging2
set industry = "crypto"
where industry like "crypto%";

select country
from layoff_staging2
where country like "united states%"
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like "united state%";

select *
from layoff_staging2;

select 'date',
str_to_date('date', '%m/%d/%Y')
from layoff_staging2;

update layoff_staging2
set `date` = str_to_date('date', '%m/%d/%y');

alter table layoff_staging2 modify column `date` date;
 
select * from layoff_staging2 where industry is null or industry = '';

-- 3. Look at Null Values, "so there isn't anything I want to change with the null values"

-- 4. remove any columns and rows we need to

SELECT *
FROM layoff_staging2
WHERE total_laid_off IS NULL;


SELECT *
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * 
FROM layoff_staging2;

ALTER TABLE layoff_staging2
DROP COLUMN row_num;


SELECT * 
FROM layoff_staging2;

-- Data cleaning is done!
-- -------------------------------------------------------------------------------------
-- Data Extraction
SELECT * 
FROM layoff_staging2;

SELECT MAX(total_laid_off)
FROM layoff_staging2;


-- Looking at Percentage & which is bigger
SELECT MAX(percentage_laid_off),  MIN(percentage_laid_off)
FROM layoff_staging2
WHERE  percentage_laid_off IS NOT NULL;

-- Which companies = 1, which is 100% of the company laid off
SELECT *
FROM layoff_staging2
WHERE  percentage_laid_off = 1;

/* first, sort Companies with the most Layoffs, if we order by funcs_raised_millions we can see how big some of these companies were */

SELECT *
FROM layoff_staging2
WHERE  percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Companies with the biggest single Layoff

SELECT company, total_laid_off
FROM layoff_staging2
ORDER BY 2 DESC
LIMIT 5;

-- Companies with the most Total Layoffs
SELECT company, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;

-- by location
SELECT location, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;

SELECT country, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(date), SUM(total_laid_off)
FROM layoff_staging2
GROUP BY YEAR(date)
ORDER BY 1 ASC;


SELECT industry, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY industry
ORDER BY 2 DESC;


SELECT stage, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- Now sort per year.

WITH Company_Year AS 
(
  SELECT company, 
  YEAR(date) AS years, 
  SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(date)
)
, Company_Year_Rank AS (
  SELECT company, years, total_laid_off, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;




-- Rolling Total of Layoffs Per Month
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY dates
ORDER BY dates ASC;

-- now use it in a CTE so we can query off of it
WITH DATE_CTE AS 
(
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY dates
ORDER BY dates ASC
)
SELECT dates, SUM(total_laid_off) OVER (ORDER BY dates ASC) as rolling_total_layoffs
FROM DATE_CTE
ORDER BY dates ASC;

