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
DROP TABLE emp_manager, emp_managerDUP;
CREATE TABLE emp_manager(
	emp_no INT(11) NOT NULL,
    dept_no CHAR(4),
    manager_no INT(11) NOT NULL
);

CREATE TABLE emp_managerDUP(
	emp_no INT(11) NOT NULL,
    dept_no CHAR(4),
    manager_no INT(11) 
);

-- MY SOLUTION
INSERT INTO emp_managerDUP(
SELECT A.* FROM(
SELECT employees.emp_no AS employee_id, departments.dept_no AS department_code,  
(SELECT emp_no FROM dept_manager WHERE dept_manager.emp_no = 110022) AS manager_ID
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no WHERE employees.emp_no BETWEEN 10001 AND 10020) AS A
UNION
SELECT B.* FROM(
SELECT employees.emp_no AS employee_id, departments.dept_no AS department_code,  
(SELECT emp_no FROM dept_manager WHERE dept_manager.emp_no = 110039) AS manager_ID
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no WHERE employees.emp_no BETWEEN 10021 AND 10040) AS B
UNION
SELECT C.* FROM(
SELECT employees.emp_no AS employee_id, departments.dept_no AS department_code,  
(SELECT emp_no FROM dept_manager WHERE dept_manager.emp_no = 110039) AS manager_ID
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no WHERE employees.emp_no = 110022) AS C
UNION
SELECT D.* FROM(
SELECT employees.emp_no AS employee_id, departments.dept_no AS department_code,  
(SELECT emp_no FROM dept_manager WHERE dept_manager.emp_no = 110022) AS manager_ID
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no WHERE employees.emp_no = 110039) AS D
) ORDER BY employee_id ASC;

-- COMPARING MY AND INSRUCTOR SOLUTION
SELECT * FROM emp_manager CROSS JOIN emp_managerDUP ON emp_manager.emp_no = emp_managerDUP.emp_no ORDER BY emp_manager.emp_no ASC;






-- --------------------------------------------------------------------------------------------------------------------------------------------------------------
-- INSTRUCTOR SOLUTION 
INSERT INTO emp_manager
SELECT 
    u.*
FROM
    (SELECT 
        a.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS a UNION SELECT 
        b.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b UNION SELECT 
        c.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS c UNION SELECT 
        d.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS d) as u;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------






