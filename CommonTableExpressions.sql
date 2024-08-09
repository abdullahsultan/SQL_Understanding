-- Exercise 289
WITH cte AS (SELECT AVG(salary) AS avg_salary FROM salaries)
SELECT COUNT(employees.emp_no)
FROM employees 
INNER JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE salaries.salary < (SELECT avg_salary FROM cte) AND employees.gender = 'M';


WITH cte AS (SELECT AVG(salary) AS avg_salary FROM salaries)
SELECT
COUNT(CASE WHEN s.salary < c.avg_salary THEN s.salary ELSE NULL END) AS no_salaries_below_avg_w_count,
COUNT(s.salary) AS no_of_salary_contracts
FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' JOIN cte c;

-- Exercise 293

WITH cte AS (SELECT AVG(salary) AS avg_salary FROM salaries),
cte1 AS (SELECT MAX(salary) AS highest_salary FROM salaries
    JOIN employees ON employees.emp_no = salaries.emp_no AND gender = 'M' GROUP BY employees.emp_no)
SELECT SUM(CASE WHEN cte1.highest_salary < cte.avg_salary THEN 1 ELSE 0 END) FROM cte1 JOIN cte ;


WITH cte AS (SELECT AVG(salary) AS avg_salary FROM salaries),
cte1 AS (SELECT MAX(salary) AS highest_salary FROM salaries
    JOIN employees ON employees.emp_no = salaries.emp_no AND gender = 'M' GROUP BY employees.emp_no)
SELECT COUNT(CASE WHEN cte1.highest_salary < cte.avg_salary THEN 1 ELSE NULL END) FROM cte1 JOIN cte ;

-- Exercise 109 # 3
WITH avg_salary_cte AS (SELECT AVG(salary) AS avg_salary FROM salaries),
max_f_salaries AS(SELECT MAX(salary) AS mx FROM salaries JOIN employees ON employees.emp_no = salaries.emp_no AND gender='F' GROUP BY employees.emp_no),
above_avg_f_salary AS (SELECT COUNT(CASE WHEN mx < avg_salary_cte.avg_salary THEN 1 ELSE NULL END) AS highest_f_salaries_below_total_avg FROM max_f_salaries 
JOIN avg_salary_cte)
SELECT * FROM above_avg_f_salary 
 ;











