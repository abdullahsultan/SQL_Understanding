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


















