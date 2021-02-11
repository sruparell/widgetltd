SET SERVEROUTPUT ON SIZE UNLIMITED
SET SCAN ON

ACCEPT department_id NUMBER PROMPT 'Please Enter a Department Id:'


select sum(emp.salary) total_salary
from employees emp
where emp.department_id = &department_id;