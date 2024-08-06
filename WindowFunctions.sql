-- Exercise 258
SELECT employees.emp_no,
ROW_NUMBER() OVER (PARTITION BY employees.emp_no ORDER BY employees.emp_no) AS row_num 
FROM employees
INNER JOIN dept_manager ON dept_manager.emp_no = employees.emp_no;

SELECT first_name, last_name,
ROW_NUMBER() OVER (PARTITION BY employees.first_name ORDER BY employees.last_name) AS row_num
FROM employees;

-- Exercise 262
SELECT salaries.emp_no,salary,
ROW_NUMBER() OVER () AS emp_index,
ROW_NUMBER() OVER (PARTITION BY salaries.emp_no ORDER BY salaries.salary ASC) AS sal_emp_index
FROM salaries
RIGHT JOIN dept_manager ON dept_manager.emp_no = salaries.emp_no ORDER BY salaries.emp_no ;

SELECT salaries.emp_no,salary,
ROW_NUMBER() OVER (PARTITION BY salaries.emp_no ORDER BY salaries.salary ASC) AS sal_emp_index,
ROW_NUMBER() OVER (PARTITION BY salaries.emp_no ORDER BY salaries.salary DESC) AS inv_nsal_emp_index
FROM salaries
RIGHT JOIN dept_manager ON dept_manager.emp_no = salaries.emp_no ORDER BY salaries.emp_no ;

-- Exercise 268

SELECT emp_no,
(SELECT MIN(salary) FROM salaries) AS min_salary 
FROM salaries 
GROUP BY emp_no;

SELECT a.emp_no, salary AS min_sal FROM
(SELECT emp_no, salary,
ROW_NUMBER() OVER w AS row_num 
FROM salaries 
WINDOW w AS(PARTITION BY salary ORDER BY salary ASC )) AS a
WHERE a.row_num = 2;
-- SAME
SELECT a.emp_no, a.salary AS min_sal FROM
(SELECT emp_no, salary,
ROW_NUMBER() OVER (PARTITION BY salary ORDER BY salary ASC) AS row_num 
FROM salaries 
) AS a
WHERE a.row_num = 2;

-- Exercise 274
SELECT a.emp_no, a.salary, a.emp_rank FROM
	( 
		SELECT emp_no, salary, 
        RANK() OVER (PARTITION BY emp_no ORDER BY salary) AS emp_rank FROM salaries
        WHERE emp_no BETWEEN 10500 AND 10600 
	) AS a;


SELECT a.emp_no, a.salary, a.emp_rank, a.date_diff FROM
	( 
		SELECT employees.emp_no, salary, 
        YEAR(dept_emp.to_date) - YEAR(dept_emp.from_date) AS date_diff,
        DENSE_RANK() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS emp_rank FROM salaries
        JOIN employees ON employees.emp_no = salaries.emp_no
        JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
        WHERE employees.emp_no BETWEEN 10500 AND 10600 AND YEAR(dept_emp.to_date) - YEAR(dept_emp.from_date) > 4
        GROUP BY salaries.salary
	) AS a;

-- Exercise 274

SELECT emp_no,salary,
LAG(salary) OVER (PARTITION BY emp_no ORDER BY salary) AS  previous_salary,
LEAD(salary) OVER (PARTITION BY emp_no ORDER BY salary) AS  next_salary,
LEAD(salary) OVER(PARTITION BY emp_no ORDER BY salary) - salary AS diff_previous_current_salary,
salary - LAG(salary) OVER(PARTITION BY emp_no ORDER BY salary) AS diff_previous_current_salary
FROM salaries 
WHERE salaries.emp_no BETWEEN 10500 AND 10600 AND salaries.salary > 80000
ORDER BY emp_no;

SELECT emp_no,salary,
LAG(salary) OVER (PARTITION BY emp_no ORDER BY salary) AS  previous_salary,
LAG(salary,2) OVER (PARTITION BY emp_no ORDER BY salary) AS  previous_salary,
LEAD(salary) OVER (PARTITION BY emp_no ORDER BY salary) AS  next_salary,
LEAD(salary,2) OVER (PARTITION BY emp_no ORDER BY salary) AS  next_salary
FROM salaries 
ORDER BY emp_no ASC
LIMIT 1000;

-- Exercise 283
USE employees;


SELECT de2.emp_no, dept.dept_name, s3.salary, AVG(s3.salary) OVER (PARTITION BY dept.dept_name) AS verage_salary_per_department
FROM
(SELECT de.emp_no, de.from_date, de.to_date, de.dept_no FROM dept_emp AS de
JOIN
(SELECT emp_no, MAX(from_date) AS from_date FROM dept_emp GROUP BY emp_no) AS de1 ON de.emp_no = de1.emp_no   WHERE de.from_date > '2000-01-01' AND de.to_date < '2002-01-01' AND de.from_date = de1.from_date) AS de2
JOIN
(SELECT dept_name, dept_no FROM departments) AS dept ON de2.dept_no = dept.dept_no
JOIN
(SELECT s.emp_no, salary FROM salaries AS s
JOIN 
(SELECT emp_no, MAX(from_date) AS from_date FROM salaries GROUP BY emp_no) AS s2 ON s2.emp_no = s.emp_no  WHERE s.from_date > '2000-01-01' AND s.to_date < '2002-01-01' AND s.from_date = s2.from_date) AS s3 ON s3.emp_no = de2.emp_no
ORDER BY de2.emp_no, s3.salary
;



















