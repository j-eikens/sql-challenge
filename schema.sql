-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/Lxuosf
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" varchar(30)   NOT NULL,
    "dept_name" varchar(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(30)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(30)   NOT NULL,
    "emp_no" int   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar(30)   NOT NULL,
    "birth_date" varchar(30)   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar(30)   NOT NULL,
    "sex" varchar(30)   NOT NULL,
    "hire_date" varchar(30)   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL
);

CREATE TABLE "titles" (
    "emp_title_id" varchar(30)   NOT NULL,
    "title" varchar(30)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "emp_title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("emp_title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-- query for employee: employee number, last name, first name, sex, salary
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from employees as e
join salaries as s
on (e.emp_no = s.emp_no);

-- change hire date to datetime
alter table employees
alter column hire_date type date using hire_date::date;

--query for employees hired in 1986: first name, last name, hire date
select first_name, last_name, hire_date
from employees
where hire_date between '1986-01-01' and '1986-12-31';

--query for manager of each department: department number, department name, managers employee number, last name, first name
select m.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name  
from dept_manager as m
join departments as d
on (m.dept_no = d.dept_no)
join employees as e
on (m.emp_no = e.emp_no);


-- List the department of each employee with the following information: employee number, last name, first name, and department name.
select de.emp_no, e.last_name, e.first_name, d.dept_name
from dept_emp as de
join departments as d
on (de.dept_no = d.dept_no)
join employees as e
on (de.emp_no = e.emp_no);

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select first_name, last_name, sex
from employees
where first_name = 'Hercules' and last_name like 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
select d.dept_name, de.emp_no, e.first_name, e.last_name
from departments as d
join dept_emp as de
on (d.dept_no = de.dept_no)
join employees as e
on (de.emp_no = e.emp_no)
where d.dept_name = 'Sales';

--List all employees in the Sales and Development departments:
--including their employee number, last name, first name, and department name.
select d.dept_name, de.emp_no, e.first_name, e.last_name
from departments as d
join dept_emp as de
on (d.dept_no = de.dept_no)
join employees as e
on (de.emp_no = e.emp_no)
where d.dept_name in ('Sales', 'Development');

--List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.
select last_name, count(distinct last_name) as last_name_count
from employees
group by last_name;
