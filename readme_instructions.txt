Oracle Coding Challenge - Sanjay Ruparell
==========================================

Included Files
--------------

* create_emp_dept.ddl  
  - Create Employee and Departments tables and related items (Item 1)
  
* insert_data.sql 
  - Populate data into objects (Item 2)
  
* db_manage_employees.psp & db_manage_employees.pbd 
  - Package spec and body containing procedures to Create Employee, Update & Return Salary and Transfer Employee Department (Items 3, 4, 5 & 6 ) 
  
* employee_report.sql 
  - Report listing Employees for a Department (Item 7)
  
* dept_salary_report 
  - Report returning total salary for a department (Item 8)
  
* test_scripts.sql
  - Script to test above Items
  
* emp_dept_ERD.pdf
  -- Employee/Department ERD
  

Run Instructions
-----------------

I've assumed you're using SQL/PLUS.

First create the database objects, run in the following order:

create_emp_dept.ddl 
db_manage_employees.psp
db_manage_employees.pbd

To insert the Widget employee data, run:

insert_data.sql 


Notes: 

The Employee data has a reference to a manager record that is later in sequence to the actual manager record being created. 
By creating the Employees in a single transaction, this avoids the FK integrity constraint being violated. 
However, if I create individual records using separate insert statements, I can take advantage of deferring this constraint eg ..
   

set constraint emp_mgr_fk deferred;

insert into employees
( employee_id, employee_name, job_title, manager_id, date_hired, salary, department_id) 
values 
( 900012, 'Joe Bloggs', 'Salesperson', 123, to_date('01/01/95','DD/MM/RR'), 100000, 1 );


insert into employees
( employee_id, employee_name, job_title, manager_id, date_hired, salary, department_id) 
values 
( 123, 'New Manager', 'Manager', null, to_date('01/01/21','DD/MM/RR'), 200000, 1 );


set constraint emp_mgr_fk immediate;


Test Instructions
-----------------

Use script test_scripts.sql to test the package functions to create and employee, update a salary, get a salary or transfer an employee to a different department.

Notes:

I've output the results using dbms_output so there's a traceable log. 

I'm raising user friendly exceptions in the package when validation fails. An alternative would be to output the results either as an output paramater or return value.  
This could be useful when dealing with external interfaces.

Also, the validation is currently only reporting the first issue it encounters, this would be enhanced to pipe out multilple messages.

The reports for Items 7 and 8 are in scripts:

employee_report.sql
dept_salary_report.sql

These will prompt for a Department Id

To see all Departments..

select dept.department_id, dept.department_name, 
       sum(emp.salary) total_salary
from employees emp, departments dept
where emp.department_id = dept.department_id
group by dept.department_id, department_name;


A good practice is to audit changes that happen on a database table. 
There's 2 types are audit that would be useful 
- a row level audit to indicate when a record was created, last updated and by who;
- the other is to log individual column level changes to log a full history of changes to a record.  
This can be acheived by the use of a database trigger to capture this, with row-level being held on the record (using an Object like below) and a column changes logged to a generic log table.
 

CREATE OR REPLACE TYPE t_audit_data AS OBJECT (
  CREATED_BY VARCHAR2(100)
 ,DATE_CREATED DATE
 ,UPDATED_BY VARCHAR2(100)
 ,DATE_UPDATED DATE
 ,member procedure update_audit( self in out nocopy t_audit_data)
 ,member function last_updated_date return date
 ,member function last_updated_by   return varchar2
 ,order member function sort(p_audit_data t_bc_audit_data ) return integer
 ,constructor function t_audit_data(created_by    in varchar2  default null,
                                    date_created  in date      default null,
                                    updated_by    in varchar2  default null,
                                     date_updated  in date      default null )
  return self as result
);
/ 


   

    

 
  
    

 


