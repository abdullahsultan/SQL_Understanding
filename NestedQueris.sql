SELECT 
    *
FROM
    employees
WHERE
    (employees.hire_date BETWEEN '1990-01-01' AND '1995-01-01')
        AND (employees.emp_no IN (SELECT 
            emp_no
        FROM
            dept_manager));


SELECT * FROM employees
WHERE EXISTS(SELECT * FROM titles WHERE titles.emp_no = employees.emp_no AND titles.title="Assistant Engineer") ORDER BY employees.emp_no ASC;
  -- ^
  -- |
  -- |
  -- This Gourp by is confirm result of above query :P      
SELECT * FROM employees
INNER JOIN titles ON titles.emp_no = employees.emp_no WHERE titles.title = "Assistant Engineer" ORDER BY employees.emp_no ASC;


-- LECTURE 209
SELECT A.* FROM(
SELECT employees.emp_no AS employee_id, departments.dept_no AS department_code,  
(SELECT emp_no FROM dept_manager WHERE dept_manager.emp_no = 110022) AS manager_ID
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no WHERE employees.emp_no BETWEEN 10000 AND 10020) AS A
UNION
SELECT B.* FROM(
SELECT employees.emp_no AS employee_id, departments.dept_no AS department_code,  
(SELECT emp_no FROM dept_manager WHERE dept_manager.emp_no = 110022) AS manager_ID
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no WHERE employees.emp_no BETWEEN 10021 AND 10040) AS B
ORDER BY employee_id ASC;


-- Exercise 210
CREATE TABLE emp_manager(
	emp_no INT(11) NOT NULL,
    dept_no CHAR(4),
    manager_no INT(11) NOT NULL
);


