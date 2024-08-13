SELECT * FROM male_max_salaries;
drop table male_max_salaries;
CREATE TEMPORARY TABLE male_max_salaries
SELECT
    s.emp_no, MAX(s.salary), dates.* FROM salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND e.gender = 'M'
GROUP BY s.emp_no;

-- Horizontal Join
WITH cte AS
(SELECT 
    NOW() AS current_date_and_time,
    DATE_SUB(NOW(), INTERVAL 2 MONTH) AS two_months_earlier,
    DATE_SUB(NOW(), INTERVAL -2 YEAR) AS two_years_later)
SELECT * FROM dates JOIN cte;

-- Vertical
WITH cte AS 
(SELECT 
    NOW() AS current_date_and_time,
    DATE_SUB(NOW(), INTERVAL 2 MONTH) AS two_months_earlier,
    DATE_SUB(NOW(), INTERVAL -2 YEAR) AS two_years_later)
SELECT * FROM dates UNION ALL SELECT * FROM cte;

