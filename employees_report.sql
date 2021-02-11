SET SERVEROUTPUT ON SIZE UNLIMITED
SET LINE 1000
SET SCAN ON
SET PAGES 1000

ACCEPT department_id NUMBER PROMPT 'Please Enter a Department Id:'

COLUMN employee_name FORMAT A20 
COLUMN job_title FORMAT A15 
COLUMN manager FORMAT A20 

select emp.employee_id, 
       emp.employee_name, 
       emp.job_title, 
       emp.date_hired, 
       emp.salary, 
       emp.department_id, 
       (select employee_name 
        from employees mgr 
        where mgr.employee_id = emp.manager_id) manager
from employees emp
where emp.department_id = &department_id;
