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