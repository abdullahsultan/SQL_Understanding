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

