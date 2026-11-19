USE HR1;
SHOW TABLES;
SELECT (SELECT COUNT(*) FROM hr1) AS hr1_rows;
SELECT * FROM HR1;

USE HR2;
SELECT * FROM HR2;

USE hr_analytics;

-- Q1. Average Attrition Rate for all Departments
SELECT
    Department,
    COUNT(*)                                            AS headcount,
    SUM(CASE 
		WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)  AS attrition_count,
    ROUND(100.0 * SUM(CASE 
					  WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2)                 
                      AS attrition_rate_pct
FROM hr1
GROUP BY Department
ORDER BY attrition_rate_pct DESC;



-- Q2. Average Hourly Rate of Male Research Scientists
SELECT
    COUNT(*)                       AS headcount,
    ROUND(AVG(HourlyRate), 2)      AS avg_hourly_rate
FROM hr1
WHERE Gender = 'Male'
  AND JobRole = 'Research Scientist';
  
  
  
  
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------


  
SELECT EmployeeNumber FROM hr1 LIMIT 5;
 SELECT "Employee ID" FROM hr2 LIMIT 5;
 
 Describe hr2;

SELECT "Employee ID", MonthlyIncome FROM hr2 LIMIT 5;
SELECT COUNT(*) FROM hr2;
DESCRIBE hr2;
SELECT "Employee ID", MonthlyIncome FROM hr2 LIMIT 5;

DROP TABLE IF EXISTS hr2;
describe hr1;
ALTER TABLE hr1
ADD PRIMARY KEY (EmployeeNumber);

SELECT EmployeeNumber, COUNT(*)
FROM hr1
GROUP BY EmployeeNumber
HAVING COUNT(*) > 0;

CREATE TABLE hr2 (
    EmployeeID                INT PRIMARY KEY,
    MonthlyIncome              INT,
    MonthlyRate                 INT,
    NumCompaniesWorked         INT,
    Over18                     VARCHAR(3),
    OverTime                   VARCHAR(3),
    PercentSalaryHike          INT,
    PerformanceRating          INT,
    RelationshipSatisfaction   INT,
    StandardHours              INT,
    StockOptionLevel           INT,
    TotalWorkingYears          INT,
    TrainingTimesLastYear      INT,
    WorkLifeBalance            INT,
    YearsAtCompany              INT,
    YearsInCurrentRole          INT,
    YearsSinceLastPromotion     INT,
    YearsWithCurrManager        INT,
    CONSTRAINT fk_hr2_employee FOREIGN KEY (EmployeeID) REFERENCES hr1(EmployeeNumber)
);

select * from hr2;
SELECT EmployeeID, MonthlyIncome FROM hr2 LIMIT 5;
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------



-- Q3. Attrition Rate vs Monthly Income stats
SELECT
    h1.Attrition,
    COUNT(*)                              AS headcount,
    ROUND(AVG(h2.MonthlyIncome), 2)       AS avg_monthly_income,
    MIN(h2.MonthlyIncome)                 AS min_monthly_income,
    MAX(h2.MonthlyIncome)                 AS max_monthly_income
FROM hr1 h1
JOIN hr2 h2 ON h1.EmployeeNumber = h2.EmployeeID
GROUP BY h1.Attrition;




-- Q4. Average Working Years for each Department
SELECT
    h1.Department,
    COUNT(*)                                   AS headcount,
    ROUND(AVG(h2.TotalWorkingYears), 2)        AS avg_total_working_years
FROM hr1 h1
JOIN hr2 h2 ON h1.EmployeeNumber = h2.EmployeeID
GROUP BY h1.Department
ORDER BY avg_total_working_years DESC;


-- Q5. Job Role vs Work Life Balance
SELECT
    h1.JobRole,
    COUNT(*)                                AS headcount,
    ROUND(AVG(h2.WorkLifeBalance), 3)       AS avg_work_life_balance
FROM hr1 h1
JOIN hr2 h2 ON h1.EmployeeNumber = h2.EmployeeID
GROUP BY h1.JobRole
ORDER BY avg_work_life_balance DESC;



-- Q6. Attrition Rate vs Years Since Last Promotion relation
SELECT
    h1.Attrition,
    COUNT(*)                                          AS headcount,
    ROUND(AVG(h2.YearsSinceLastPromotion), 3)         AS avg_years_since_last_promotion
FROM hr1 h1
JOIN hr2 h2 ON h1.EmployeeNumber = h2.EmployeeID
GROUP BY h1.Attrition;




