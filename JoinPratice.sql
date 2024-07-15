-- INNER JOIN
SELECT 
    *
FROM
    employees AS emp
        INNER JOIN
    dept_manager AS dm ON emp.emp_no = dm.emp_no;
    
SELECT 
    *
FROM
    dept_manager AS dm
        INNER JOIN
    employees AS emp ON emp.emp_no = dm.emp_no;

SELECT 
    employees.first_name,
    employees.last_name,
    employees.hire_date,
    titles.title,
    titles.from_date,
    departments.dept_name
FROM
    employees
        INNER JOIN
    titles ON employees.emp_no = titles.emp_no
        INNER JOIN
    dept_manager ON employees.emp_no = dept_manager.emp_no
        INNER JOIN
    departments ON dept_manager.dept_no = departments.dept_no
;

-- RIGHT JOIN
SELECT 
    *
FROM
    employees AS emp
        RIGHT JOIN
    dept_manager AS dm ON emp.emp_no = dm.emp_no;
    
    
-- LEFT JOIN
SELECT 
    *
FROM
    employees AS emp
        LEFT JOIN
    dept_manager AS dm ON emp.emp_no = dm.emp_no;
    
-- CROSS JOIN

SELECT 
    dm.*, dep.*
FROM
    dept_manager AS dm
        CROSS JOIN
    departments AS dep
WHERE
    dep.dept_no = 'd009'
ORDER BY dep.dept_no;

select @@global.sql_mode;
set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

SELECT 
    e.*, d.*
FROM
    employees AS e
        CROSS JOIN
    departments AS d
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no , d.dept_name
;

-- Extras
SELECT employees.gender, COUNT(*)
FROM employees
GROUP BY employees.gender;

