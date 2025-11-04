-- Step 1: Create main table (for example: employees)
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

-- Step 2: Create audit log table
CREATE TABLE employee_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    action_type VARCHAR(10),
    old_data TEXT,
    new_data TEXT,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Step 3: Trigger for INSERT
DELIMITER //
CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit(emp_id, action_type, old_data, new_data)
    VALUES (NEW.emp_id, 'INSERT', NULL,
            CONCAT('Name: ', NEW.emp_name, ', Dept: ', NEW.department, ', Salary: ', NEW.salary));
END;
//
DELIMITER ;

-- Step 4: Trigger for UPDATE
DELIMITER //
CREATE TRIGGER after_employee_update
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit(emp_id, action_type, old_data, new_data)
    VALUES (NEW.emp_id, 'UPDATE',
            CONCAT('Old -> Name: ', OLD.emp_name, ', Dept: ', OLD.department, ', Salary: ', OLD.salary),
            CONCAT('New -> Name: ', NEW.emp_name, ', Dept: ', NEW.department, ', Salary: ', NEW.salary));
END;
//
DELIMITER ;

-- Step 5: Trigger for DELETE
DELIMITER //
CREATE TRIGGER after_employee_delete
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit(emp_id, action_type, old_data, new_data)
    VALUES (OLD.emp_id, 'DELETE',
            CONCAT('Deleted -> Name: ', OLD.emp_name, ', Dept: ', OLD.department, ', Salary: ', OLD.salary),
            NULL);
END;
//
DELIMITER ;

-- Step 6: Test data operations
INSERT INTO employees (emp_name, department, salary) VALUES ('Akanksha', 'HR', 50000);
UPDATE employees SET salary = 55000 WHERE emp_id = 1;
DELETE FROM employees WHERE emp_id = 1;

-- Step 7: View audit log
SELECT * FROM employee_audit;
