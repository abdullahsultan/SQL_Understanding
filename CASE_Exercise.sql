
-- Exercise 251
SELECT employees.emp_no, first_name, last_name,
CASE
	WHEN dept_manager.emp_no IS NOT NULL THEN "Manager" ELSE "Employee" 
END AS designation
FROM employees 
LEFT JOIN dept_manager ON  dept_manager.emp_no = employees.emp_no 
WHERE employees.emp_no > 109990;

-- Exercise 253

SELECT dept_manager.emp_no, first_name, last_name,
CASE
	WHEN salaries.salary > 30000 THEN "Yes" ELSE "NO" END AS above30k
FROM employees
INNER JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
INNER JOIN salaries ON salaries.emp_no = dept_manager.emp_no
GROUP BY dept_manager.emp_no;

-- Exercise 255
SELECT employees.emp_no, first_name, last_name,
CASE 
	WHEN dept_emp.to_date > CURDATE() THEN "PRESENT" ELSE "LEFT" END AS employment_status
FROM employees
INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
ORDER BY employees.emp_no ASC LIMIT 100;



