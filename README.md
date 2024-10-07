# HR-DASHBOARD_MySQL-PowerBI

## Data Overview
This project involves the analysis of HR data from 2000 to 2020, comprising over 22,000 rows of employee records. The analysis focuses on various aspects of the workforce, including gender, age, ethnicity and turnover rates, while providing insights into the geographic distribution and employment tenure across departments.

#### *Dataset: HR data spanning 2000 to 2020 with over 22,000 records.*
#### *Data Cleaning & Analysis Tool: MySQL Workbench*
#### *Data Visualization Tool: Power BI*


## Analysis Questions
1. What is the gender distribution among employees?
2. What is the racial/ethnic composition of the workforce?
3. What is the age distribution of employees?
4. How many employees are based at headquarters versus remote locations?
5. What is the average employment tenure for terminated employees?
6. How does gender distribution differ across departments and job titles?
7. What is the distribution of job titles across the company?
8. Which department has the highest turnover rate?
9. What is the geographical distribution of employees by state?
10. How has the company's employee count evolved over time based on hire and termination dates?
11. What is the tenure distribution across departments?

## Summary of Key Findings:
1. Gender Distribution: There are more male employees overall.
2. Racial/Ethnic Composition: White employees dominate the workforce, while Native Hawaiian and American Indian employees are the least represented.
3. Age Distribution: Employees range in age from 20 to 57.
Five age groups were created (18-24, 25-34, 35-44, 45-54, 55-64), with the majority falling into the 25-34 group, followed by the 35-44 group. The smallest group was 55-64.
4. Work Location: A significantly larger number of employees work at headquarters compared to remote locations.
5. Average Tenure for Terminated Employees: The average employment tenure for terminated employees is approximately 7 years.
6. Gender Distribution Across Departments: Gender distribution is fairly balanced across departments, although males generally outnumber females.
7. Turnover Rates:The Marketing department has the highest turnover rate, followed by Training.
The lowest turnover rates are found in the Research & Development, Support, and Legal departments.
8. Geographical Distribution: The majority of employees are based in Ohio.
9. Employee Count Over Time: There has been a net increase in employee count over the years.
10. Departmental Tenure: The average tenure across departments is approximately 8 years, with Legal and Auditing departments having the longest tenures, while Services, Sales and Marketing have the shortest.

## Limitations:
- 967 records were excluded due to negative ages. Only employees aged 18 and above were considered in the analysis.
- 1,599 records with termination dates far into the future were omitted. Only term dates up to the current date were used in the analysis.
