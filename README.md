# Triggers
# Develop Triggers for Auditing Table Changes**

- WHAT I BUILT

I built a **database auditing system** using **MySQL triggers** that automatically tracks every change made to a main table.
The system records all **INSERT**, **UPDATE**, and **DELETE** operations performed on the `employees` table and logs them into an **audit table** called `employee_audit`.

This audit table stores details like:

* The type of action (INSERT / UPDATE / DELETE)
  
* The old and new data
  
* The employee ID
  
* The exact timestamp of the action



 - HOW I BUILT IT

1. Created the Main Table (`employees`)
   This table stores employee details such as ID, name, department, and salary.

   ```sql
   CREATE TABLE employees (
       emp_id INT AUTO_INCREMENT PRIMARY KEY,
       emp_name VARCHAR(100),
       department VARCHAR(50),
       salary DECIMAL(10,2)
   );
   ```

2. Created the Audit Table (`employee_audit`)
   This table records every change made to the `employees` table.

   ```sql
   CREATE TABLE employee_audit (
       audit_id INT AUTO_INCREMENT PRIMARY KEY,
       emp_id INT,
       action_type VARCHAR(10),
       old_data TEXT,
       new_data TEXT,
       action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );
   ```

3. Developed Triggers for INSERT, UPDATE, and DELETE

   * AFTER INSERT Trigger: Logs new records added.
   * AFTER UPDATE Trigger: Logs both old and new data when any field is modified.
   * AFTER DELETE Trigger: Logs data that has been deleted.



4. Tested with Example Operations

   ```sql
   INSERT INTO employees (emp_name, department, salary) VALUES ('Akanksha', 'HR', 50000);
   UPDATE employees SET salary = 55000 WHERE emp_id = 1;
   DELETE FROM employees WHERE emp_id = 1;
   ```

5. **Viewed the Audit Log**

   ```sql
   SELECT * FROM employee_audit;
   ```

   The output showed all three operations logged automatically.

 <img width="1362" height="727" alt="triggers" src="https://github.com/user-attachments/assets/049c39fd-7755-40b2-bd6b-be8f9dc2d71b" />


- WHY I BUILT IT

I built this system to demonstrate how triggers can automate auditing and data tracking in a database environment.
Manually tracking every data change can be error-prone and inefficient. By using triggers:

* Every modification is **logged automatically**, reducing human error.
* It enhances **security and accountability**, showing who and when changes were made.
* It helps in **troubleshooting**, **data recovery**, and **regulatory compliance** where audit trails are required.



