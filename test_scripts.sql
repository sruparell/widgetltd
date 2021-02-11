SET SERVEROUTPUT ON SIZE UNLIMITED


-- Test Creating an Employee (Item 3)
begin
  dbms_output.put_line('Test Creating an Employee (Item 3)');
  dbms_output.put_line('----------------------------------');
  dbms_output.put_line('..');
end;
/

begin
  dbms_output.put_line('..');
  dbms_output.put_line('Test 1- invalid Manager');
  --
  db_manage_employees.create_employee( 
                    p_employee_id => 99,
                    p_employee_name => 'Tom Cruise',
                    p_job_title => 'Actor',
                    p_date_hired => '10/12/18',
                    p_salary => 125000, 
                    p_department_id => 2, 
                    p_manager_id => 9999 ); 
exception 
 when others then 
   dbms_output.put_line('Error '||sqlcode||' '||sqlerrm);
end;
/


begin
  dbms_output.put_line('..');
  dbms_output.put_line('Test 2 - Missing name');
  --
  db_manage_employees.create_employee( 
                    p_employee_id => 99,
                    p_employee_name => null,
                    p_job_title => 'Actor',
                    p_date_hired => '10/12/18',
                    p_salary => 123, 
                    p_department_id => 2, 
                    p_manager_id => null ); 
exception 
 when others then 
   dbms_output.put_line('Error '||sqlcode||' '||sqlerrm);
end;
/


begin
  dbms_output.put_line('..');
  dbms_output.put_line('Test 3 - Invalid Date format');
  --
  db_manage_employees.create_employee( 
                    p_employee_id => 99,
                    p_employee_name => 'Tom Criuse',
                    p_job_title => 'Actor',
                    p_date_hired => '10/12/1918',
                    p_salary => 123000, 
                    p_department_id => 2, 
                    p_manager_id => null ); 
exception 
 when others then 
   dbms_output.put_line('Error '||sqlcode||' '||sqlerrm);
end;
/


begin
  dbms_output.put_line('..');
  dbms_output.put_line('Test 4 - Invalid Department');
  --
  db_manage_employees.create_employee( 
                    p_employee_id => 99,
                    p_employee_name => 'Tom Criuse',
                    p_job_title => 'Actor',
                    p_date_hired => '10/12/18',
                    p_salary => 123000, 
                    p_department_id => 23, 
                    p_manager_id => null ); 
exception 
 when others then 
   dbms_output.put_line('Error '||sqlcode||' '||sqlerrm);
end;
/



begin
  dbms_output.put_line('..');
  dbms_output.put_line('Test 5 - Incorrect Field lenth');
  --
  db_manage_employees.create_employee( 
                    p_employee_id => 99,
                    p_employee_name => 'Tom Criuse',
                    p_job_title => 'ActorActorActorActorActorActorActorActorActorActorActor',
                    p_date_hired => '10/12/18',
                    p_salary => 123000, 
                    p_department_id => 2, 
                    p_manager_id => 132 ); 
exception 
 when others then 
   dbms_output.put_line('Error '||sqlcode||' '||sqlerrm);
end;
/



begin
  dbms_output.put_line('..');
  dbms_output.put_line('Test 6 - Invalid field format');
  --
  db_manage_employees.create_employee( 
                    p_employee_id => 99,
                    p_employee_name => 'Tom Criuse',
                    p_job_title => 'Actor',
                    p_date_hired => '10/12/18',
                    p_salary => 'ABC', 
                    p_department_id => 2, 
                    p_manager_id => null ); 
exception 
 when others then 
   dbms_output.put_line('Error '||sqlcode||' '||sqlerrm);
end;
/

begin
  dbms_output.put_line('..');
  dbms_output.put_line('Test 7 - Create valid employee');
  --
  db_manage_employees.create_employee( 
                    p_employee_id => 99,
                    p_employee_name => 'Tom Criuse',
                    p_job_title => 'Actor',
                    p_date_hired => '10/12/18',
                    p_salary => 12000, 
                    p_department_id => 2, 
                    p_manager_id => 90001 ); 
  dbms_output.put_line('Empoyee Created - see table');
exception 
 when others then 
   dbms_output.put_line('Error '||sqlcode||' '||sqlerrm);
end;
/


-- Validate new employee is in DB..
select * from employees emp where employee_id = 99;


begin
  dbms_output.put_line('..');
  dbms_output.put_line('Test 8 - Create valid employee without Id using overloaded function');
  --
  dbms_output.put_line('Created Employee Id: '
          ||db_manage_employees.create_employee( 
                    p_employee_id => null,
                    p_employee_name => 'Nicole Kidman',
                    p_job_title => 'Actor',
                    p_date_hired => '10/02/21',
                    p_salary => 13000, 
                    p_department_id => 2, 
                    p_manager_id => 90001 )); 
exception 
 when others then 
   dbms_output.put_line('Error '||sqlcode||' '||sqlerrm);
end;
/


-- Test Returning a Salary (Item 6) and updating a salary (item 4)

begin
  dbms_output.put_line('..');
  dbms_output.put_line(' Test Returning a Salary (Item 6) and updating a salary (item 4)');
  dbms_output.put_line('----------------------------------------------------------------');
end;
/


begin
  dbms_output.put_line('..');
  dbms_output.put_line('Test 9 - Valid Increase of Salary');
  --
  dbms_output.put_line('..');
  dbms_output.put_line('Current Salary of Employee 90001 before increase'||db_manage_employees.get_employee_salary( p_employee_id => 90001 )); 
  dbms_output.put_line('..');
  dbms_output.put_line('Increase Salary of Employee 90001 by 12.5%');
  db_manage_employees.update_employee_salary( p_employee_id => 90001, p_pct_increase => 12.5); 
  dbms_output.put_line('New Salary of Employee 90001 after increase '||db_manage_employees.get_employee_salary( p_employee_id => 90001 )); 
exception 
 when others then 
   dbms_output.put_line('Error '||sqlcode||' '||sqlerrm);
end;
/


begin
  dbms_output.put_line('..');
  dbms_output.put_line('Test 10 - Valid Decrease of Salary');
  --
  dbms_output.put_line('..');
  dbms_output.put_line('Current Salary of Employee 90001 before decrease'||db_manage_employees.get_employee_salary( p_employee_id => 90001 )); 
  dbms_output.put_line('..');
  dbms_output.put_line('Decrease Salary of Employee 90001 by 12.5%');
  db_manage_employees.update_employee_salary( p_employee_id => 90001, p_pct_increase => -12.5); 
  dbms_output.put_line('New Salary of Employee 90001 after decrease '||db_manage_employees.get_employee_salary( p_employee_id => 90001 )); 
exception 
 when others then 
   dbms_output.put_line('Error '||sqlcode||' '||sqlerrm);
end;
/


begin
  dbms_output.put_line('..');
  dbms_output.put_line('Test 11 - Invalid Employee Id in get salary');
  --
  dbms_output.put_line('Current Salary of Employee 123 '||db_manage_employees.get_employee_salary( p_employee_id => 132 )); 
exception 
 when others then 
   dbms_output.put_line('Error '||sqlcode||' '||sqlerrm);
end;
/

begin
  dbms_output.put_line('..');
  dbms_output.put_line('Test 12 - Invalid Employee Id in Increase salary');
  --
  db_manage_employees.update_employee_salary( p_employee_id => 123, p_pct_increase => -12.5); 
exception 
 when others then 
   dbms_output.put_line('Error '||sqlcode||' '||sqlerrm);
end;
/

begin
  dbms_output.put_line('..');
  dbms_output.put_line('Test 13 - Invalid Pct Increase ');
  --
  db_manage_employees.update_employee_salary( p_employee_id => 90001, p_pct_increase => null); 
exception 
 when others then 
   dbms_output.put_line('Error '||sqlcode||' '||sqlerrm);
end;
/


-- Test Transfering Employee to another dept (Item 5) 

begin
  dbms_output.put_line('..');
  dbms_output.put_line(' Test Transfering Employee to another dept (Item 5) ');
  dbms_output.put_line('----------------------------------------------------');
end;
/


begin
  dbms_output.put_line('..');
  dbms_output.put_line('Test 14 - Invalid Employee ');
  --
  db_manage_employees.transfer_employee( p_employee_id => 123, p_department_id => null); 
exception 
 when others then 
   dbms_output.put_line('Error '||sqlcode||' '||sqlerrm);
end;
/

begin
  dbms_output.put_line('..');
  dbms_output.put_line('Test 15 - Invalid Dept ');
  --
  db_manage_employees.transfer_employee( p_employee_id => 90001, p_department_id => 132); 
exception 
 when others then 
   dbms_output.put_line('Error '||sqlcode||' '||sqlerrm);
end;
/


begin
  dbms_output.put_line('..');
  dbms_output.put_line('Test 16 - Valid Transfer of Employee 99');
  --
  db_manage_employees.transfer_employee( p_employee_id => 99, p_department_id => 4); 
  dbms_output.put_line('Employee Transferred - see table');
exception 
 when others then 
   dbms_output.put_line('Error '||sqlcode||' '||sqlerrm);
end;
/


-- Validate employee Transferred in DB..
select * from employees emp where employee_id = 99;




