CREATE DATABASE projects;

USE projects;

SELECT * FROM hr;

ALTER TABLE hr
CHANGE column ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE hr;

SELECT birthdate FROM hr;

-- sql_safe_updates is used to set/ disable the safe update mode 1 is enable 0 is disable
SET sql_safe_updates = 0; 

SELECT * FROM hr
WHERE (birthdate LIKE '%/%' AND STR_TO_DATE(birthdate, '%m/%d/%Y') IS NULL)
   OR (birthdate LIKE '%-%' AND STR_TO_DATE(birthdate, '%m-%d-%Y') IS NULL);
   
   SELECT birthdate
FROM hr
WHERE (birthdate LIKE '%/%' AND STR_TO_DATE(birthdate, '%m/%d/%Y') IS NULL)
   OR (birthdate LIKE '%-%' AND STR_TO_DATE(birthdate, '%m-%d-%Y') IS NULL);
   
   ALTER TABLE hr MODIFY birthdate VARCHAR(50);
   ALTER TABLE hr MODIFY birthdate DATE;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SELECT termdate from hr;

SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

-- get the age and the aggregate function's
ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT birthdate, age, avg(age)
FROM hr;

SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM hr;

SELECT count(*)
FROM hr
WHERE age < 18;

-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
SELECT gender, count(gender) AS count
FROM hr 
WHERE AGE >= 18 AND termdate = 0000-00-00
GROUP BY gender;
-- Explanation: you need include the where clause to answer the question of "....employees in the company" as underage and those whose term as expired cannot still be company employee

-- 2. What is the race/ethnicity breakdown of employees in the company?
SELECT race, count(race) AS count
FROM hr 
WHERE AGE >= 18 AND termdate = 0000-00-00
GROUP BY race
ORDER BY count desc;

-- 3. What is the age distribution of employees in the company?
SELECT min(age) AS youngest,
max(age) AS oldest 
FROM hr
WHERE AGE >= 18 AND termdate = 0000-00-00;

SELECT
	CASE
		WHEN age >= 18 AND age<=24 THEN '18-24'
        WHEN age >= 25 AND age<=34 THEN '25-34'
        WHEN age >= 35 AND age<=44 THEN '35-44'
        WHEN age >= 45 AND age<=54 THEN '45-54'
        WHEN age >= 55 AND age<=64 THEN '55-64'
        ELSE '65+' 
	END AS age_group, gender,
    count(*) AS count
FROM hr
WHERE AGE >= 18 AND termdate = 0000-00-00
GROUP BY age_group,gender
ORDER BY age_group,gender;

-- 4. How many employees work at headquarters versus remote locations?
SELECT location, count(*) AS count
FROM hr
WHERE AGE >= 18 AND termdate = 0000-00-00
GROUP BY location;

-- 5. What is the average length of employment for employees who have been terminated?
SELECT 
	avg(datediff(termdate, hire_date))/365 AS avg_employement_length 
FROM hr
WHERE AGE >= 18 AND termdate <> 0000-00-00 AND termdate <= curdate();
-- you may choose to round your answer using round round(avg(datediff(termdate, hire_date))/365,0) AS avg_employement_length

-- 6. How does the gender distribution vary across departments and job titles?
SELECT department, gender, count(*) AS count
FROM hr
WHERE AGE >= 18 AND termdate = 0000-00-00
GROUP BY department, gender
ORDER BY department, gender;

-- 7. What is the distribution of job titles across the company?
SELECT jobtitle, count(*) AS count
FROM hr
WHERE AGE >= 18 AND termdate = 0000-00-00
GROUP BY jobtitle;

-- 8. Which department has the highest turnover rate?
SELECT department,
	total_count,
    terminated_count,
    terminated_count/total_count AS termination_rate
FROM (
		SELECT department,
        count(*) AS total_count,
        SUM(CASE WHEN termdate <> 0000-00-00 AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
        FROM hr
        WHERE AGE >= 18
		GROUP BY department
		)AS subquery
        ORDER BY termination_rate DESC;        

-- 9. What is the distribution of employees across locations by city and state?
SELECT location_state, count(*) AS count
FROM hr
WHERE AGE >= 18 AND termdate = 0000-00-00
GROUP BY location_state;

-- 10. How has the company's employee count changed over time based on hire and term dates?
SELECT 
year, hires, terminations,
hires - terminations AS net_change, 
round((hires - terminations)/hires * 100,2) AS net_change_percent
FROM(
	SELECT
		YEAR(hire_date) AS year,
			count(*) AS hires,
            SUM(CASE WHEN termdate <> 0000-00-00 AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
            FROM hr
			WHERE AGE >= 18
			GROUP BY YEAR(hire_date)
            ) AS subquery
ORDER BY year ASC;

-- 11. What is the tenure distribution for each department?
SELECT department, round(avg(datediff(termdate,hire_date)/365)) AS avg_tenure
FROM hr
WHERE termdate <= curdate()	AND termdate <> 0000-00-00 AND age >= 18 
GROUP BY department;


