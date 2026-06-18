/* ==========================================
SECTION 1: DATA VALIDATION
========================================== */
-- Confirm table structure

SELECT *
FROM hr.employee_attrition
LIMIT 10;

-- Verify total records

SELECT COUNT(*)
FROM hr.employee_attrition;

-- Verify total rows

SELECT COUNT(*) AS total_rows
FROM hr.employee_attrition;


-- Check for duplicates

SELECT employeenumber, COUNT(*)
FROM hr.employee_attrition
GROUP BY employeenumber
HAVING COUNT(*) > 1;

-- Check for NULL values

SELECT COUNT(*) 
FROM hr.employee_attrition
WHERE monthlyincome IS NULL;

-- Data distribution sanity check
--- Monthly Income

SELECT COUNT(*) 
FROM hr.employee_attrition
WHERE monthlyincome IS NULL;

--- Attrtition

SELECT COUNT(*) 
FROM hr.employee_attrition
WHERE attrition IS NULL;
--- Department
SELECT COUNT(*) 
FROM hr.employee_attrition
WHERE department IS NULL;


-- Data range validation
--- Attrition Distribution

SELECT attrition, COUNT(*) AS count
FROM hr.employee_attrition
GROUP BY attrition;

--- Department distribution

SELECT department, COUNT(*) 
FROM hr.employee_attrition
GROUP BY department;

--- Gender

SELECT gender, COUNT(*)
FROM hr.employee_attrition
GROUP BY gender;

--- Overtime

SELECT overtime, COUNT(*)
FROM hr.employee_attrition
GROUP BY overtime;

-- Data Range Validation

--- Age check

SELECT MIN(age), MAX(age)
FROM hr.employee_attrition;

--- Monthly income sanity
SELECT MIN(monthlyincome), MAX(monthlyincome)
FROM hr.employee_attrition
;

--- Years at company

SELECT MIN(yearsatcompany), MAX(yearsatcompany)
FROM hr.employee_attrition;

/* ==========================================
SECTION 2: ATTRITION KPI ANALYSIS
========================================== */

-- Overall attrition rate

SELECT
COUNT(*) AS total_employees,

SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,

ROUND(
100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
2
) AS attrition_rate
FROM hr.employee_attrition;

/* ==========================================
SECTION 3: DEPARTMENT ANALYSIS
========================================== */

SELECT
department,

COUNT(*) AS total_employees,

SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,

ROUND(
100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
2
) AS attrition_rate
FROM hr.employee_attrition
GROUP BY department
ORDER BY attrition_rate DESC;

/* ==========================================
SECTION 4: JOB ROLE ANALYSIS
========================================== */

SELECT
jobrole,

COUNT(*) AS total_employees,

SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,

ROUND(
100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
2
) AS attrition_rate
FROM hr.employee_attrition
GROUP BY jobrole
ORDER BY attrition_rate DESC;

/* ==========================================
SECTION 5: OVERTIME ANALYSIS
========================================== */

SELECT
overtime,

COUNT(*) AS total_employees,

SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,

ROUND(
100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
2
) AS attrition_rate
FROM hr.employee_attrition
GROUP BY overtime;

/* ==========================================
SECTION 6: INCOME GROUP ANALYSIS
========================================== */

SELECT
CASE
WHEN monthlyincome < 5000 THEN 'Low'
WHEN monthlyincome BETWEEN 5000 AND 10000 THEN 'Medium'
ELSE 'High'
END AS income_group,

COUNT(*) AS total_employees,

SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,

ROUND(
100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
2
) AS attrition_rate
FROM hr.employee_attrition
GROUP BY income_group
ORDER BY attrition_rate DESC;

/* ==========================================
SECTION 7: TENURE GROUP ANALYSIS
========================================== */

SELECT
CASE
    WHEN yearsatcompany BETWEEN 0 AND 2 THEN '0-2 Years (New Joiners)'
    WHEN yearsatcompany BETWEEN 3 AND 5 THEN '3-5 Years (Early Tenure)'
    WHEN yearsatcompany BETWEEN 6 AND 10 THEN '6-10 Years (Mid Tenure)'
    ELSE '10+ Years (Long Tenure)'
END AS tenure_group,
COUNT(*) AS total_employees,
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
ROUND(
100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
2) AS attrition_rate
FROM hr.employee_attrition
GROUP BY tenure_group
ORDER BY attrition_rate DESC;

/* ==========================================
SECTION 8: JOB SATISFACTION ANALYSIS
========================================== */

SELECT
jobsatisfaction,

COUNT(*) AS employees,

SUM(
CASE
WHEN attrition='Yes'
THEN 1
ELSE 0
END
) attrition_count,

ROUND(
100.0 *
SUM(CASE WHEN attrition='Yes' THEN 1 ELSE 0 END)
/
COUNT(*),
2
) attrition_rate

FROM hr.employee_attrition

GROUP BY jobsatisfaction

ORDER BY jobsatisfaction;