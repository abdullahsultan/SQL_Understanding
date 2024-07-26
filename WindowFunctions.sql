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

SELECT dept_emp.emp_no, dept_emp.from_date, dept_emp.to_date, MAX(salaries.salary),
(
	SELECT dept_no FROM departments 
    JOIN departments ON departments.dept_no = dept_emp.dept_no
    WHERE YEAR(dept_emp.to_date) <= 2002 AND dept_emp.to_date = YEAR(MAX(dept_emp.to_date)) 
    
) AS latest_department
FROM dept_emp 
JOIN salaries ON salaries.emp_no = dept_emp.emp_no 

 WHERE YEAR(dept_emp.from_date) >= 2000 AND YEAR(dept_emp.to_date) <= 2002
 GROUP BY dept_emp.emp_no
 ORDER BY emp_no;






















