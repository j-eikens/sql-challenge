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
