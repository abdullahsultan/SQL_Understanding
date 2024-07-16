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


-- Exercise 210
CREATE TABLE emp_manager(
	emp_no INT(11) NOT NULL,
    dept_no CHAR(4),
    manager_no INT(11) NOT NULL
);