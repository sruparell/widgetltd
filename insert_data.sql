set scan off;

insert into departments
( department_id, department_name, location )
select 1,'Management','London' from dual
union all 
select 2,'Engineering','Cardif' from dual
union all 
select 3,'Research & Development','Edinburgh' from dual
union all 
select 4,'Sales','Belfast' from dual;


insert into employees
( employee_id, employee_name, job_title, manager_id, date_hired, salary, department_id)        
select 90001, 'John Smith', 'CEO', null, to_date('01/01/95','DD/MM/RR'), 100000, 1 from dual
union all
select 90002, 'Jimmy Willis', 'Manager', 90001, to_date('23/09/03','DD/MM/RR'), 52500, 4 from dual
union all
select 90003, 'Roxy Jones', 'Salesperson', 90002,to_date('11/02/17','DD/MM/RR'), 35000, 4 from dual
union all
select 90004, 'Selwyn Field', 'Salesperson', 90003, to_date('20/05/15','DD/MM/RR'), 32000, 4 from dual
union all
select 90005, 'David Hallett', 'Engineer', 90006, to_date('17/04/18','DD/MM/RR'), 40000, 2 from dual
union all
select 90006, 'Sarah Phelps','Manager', 90001, to_date('21/03/15','DD/MM/RR'), 45000, 2 from dual
union all
select 90007, 'Louise Harper', 'Engineer', 90006, to_date('01/01/13','DD/MM/RR'), 47000, 2 from dual
union all
select 90008, 'Tina Hart','Engineer', 90009, to_date('28/07/14','DD/MM/RR'), 45000, 3 from dual
union all
select 90009, 'Gus Jones','Manager', 90001, to_date('15/05/18','DD/MM/RR'), 50000, 3 from dual
union all
select 90010, 'Mildred Hall','Secretary', 90001, to_date('12/10/96','DD/MM/RR'), 35000, 1 from dual;


