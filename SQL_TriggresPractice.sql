USE employees;

DELIMITER $$
CREATE TRIGGER set_employee_hire_date_to_current
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
      IF NEW.hire_date > CURDATE()
	  THEN SET NEW.hire_date = CURDATE();
      END IF;
END $$
DELIMITER ;

INSERT employees VALUES(999904, '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');

SELECT * FROM employees ORDER BY emp_no DESC;


