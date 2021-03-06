

CREATE TABLE departments (
    department_id     NUMBER(10)  GENERATED BY DEFAULT ON NULL AS IDENTITY NOT NULL,
    department_name   VARCHAR2(50) NOT NULL,
    location          VARCHAR2(50) NOT NULL
);

ALTER TABLE departments ADD CONSTRAINT dept_pk PRIMARY KEY ( department_id );

ALTER TABLE departments ADD CONSTRAINT dept_uk UNIQUE ( department_name );


CREATE TABLE employees (
    employee_id     NUMBER(10) GENERATED BY DEFAULT ON NULL AS IDENTITY NOT NULL,
    employee_name   VARCHAR2(50) NOT NULL,
    job_title       VARCHAR2(50),
    date_hired      DATE NOT NULL,
    salary          NUMBER(10) NOT NULL,
    department_id   NUMBER(10),
    manager_id      NUMBER(10)
);

ALTER TABLE employees ADD CONSTRAINT emp_pk PRIMARY KEY ( employee_id );


ALTER TABLE employees
    ADD CONSTRAINT emp_dept_fk FOREIGN KEY ( department_id )
        REFERENCES departments ( department_id );

ALTER TABLE employees
    ADD CONSTRAINT emp_mgr_fk FOREIGN KEY ( manager_id )
        REFERENCES employees ( employee_id )
        DEFERRABLE  INITIALLY IMMEDIATE;



