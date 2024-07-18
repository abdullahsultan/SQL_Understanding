 USE employees;
 
 DROP PROCEDURE IF EXISTS average_salay_of_employees;
 
 DELIMITER $$
 CREATE PROCEDURE average_salay_of_employees()
 BEGIN
	SELECT AVG(salary) FROM salaries ;
END$$
DELIMITER ;

CALL employees.average_salay_of_employees();
  
DELIMITER $$
CREATE PROCEDURE get_employee_number(IN in_first_name VARCHAR(225), IN in_last_name VARCHAR(225), OUT out_emp_no INT)
BEGIN
SELECT emp_no INTO out_emp_no
FROM employees  WHERE employees.first_name = in_first_name AND employees.last_name = in_last_name;
END$$
DELIMITER ;

-- Exercise 230 Variables

  SET @v_emp_no = 0;
  CALL employees.get_employee_number("Mary", "Sluis", @v_emp_no);
  SELECT @v_emp_no;
  
  -- Exercise 234 Functions
  
  DELIMITER $$
  CREATE FUNCTION emp_info (p_first_name VARCHAR(225), p_last_name VARCHAR(225)) RETURNS DECIMAL(10,2)
  DETERMINISTIC NO SQL READS SQL DATA
  BEGIN
  DECLARE v_salary DECIMAL(10,2);
  DECLARE v_date_latest DATE;
  SELECT MAX(from_date)  INTO v_date_latest FROM salaries
  INNER JOIN employees ON employees.emp_no = salaries.emp_no 
  WHERE employees.first_name = p_first_name AND employees.last_name = p_last_name;
  
  SELECT salary INTO v_salary FROM salaries 
  INNER JOIN employees ON employees.emp_no = salaries.emp_no 
  WHERE employees.first_name = p_first_name AND employees.last_name = p_last_name AND salaries.from_date = v_date_latest;
  RETURN v_salary;
  END$$
  DELIMITER ;
  
  DROP FUNCTION emp_info;
  SELECT EMP_INFO('Aruna', 'Journel');

  

  
  
  
  
  