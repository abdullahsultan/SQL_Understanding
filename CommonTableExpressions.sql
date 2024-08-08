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
