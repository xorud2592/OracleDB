--테이블간 조인(JOIN) SQL 문제입니다.
--문제1.
--직원들의 사번(employee_id), 이름(firt_name), 성(last_name)과 부서명(department_name)을
--조회하여 부서이름(department_name) 오름차순, 사번(employee_id) 내림차순 으로 정렬하세요.
--(106건)
SELECT employee_id 사번, first_name 이름, 
    last_name 성, department_id 부서명
FROM employees
WHERE department_id is not null
ORDER BY 부서명, 사번 DESC;

SELECT emp.employee_id, emp.first_name, emp.last_name, dept.department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id
ORDER BY dept.department_name,
    emp.department_id DESC;

SELECT emp.employee_id, emp.first_name, emp.last_name, dept.department_name
FROM employees emp NATURAL JOIN departments dept
ORDER BY dept.department_name,
    emp.department_id DESC;
    
--문제2.
--employees 테이블의 job_id는 현재의 업무아이디를 가지고 있습니다.
--직원들의 사번(employee_id), 이름(firt_name), 급여(salary), 부서명(department_name), 현
--재업무(job_title)를 사번(employee_id) 오름차순 으로 정렬하세요.
--부서가 없는 Kimberely(사번 178)은 표시하지 않습니다.
--(106건)

SELECT employees.employee_id 사번, employees.first_name 이름, 
    employees.salary 급여, departments.department_id 부서명,
    jobs.job_id 현재업무
FROM employees, departments, jobs
WHERE employees.department_id = departments.department_id AND 
    employees.job_id = jobs.job_id;

--문제2-1.
--문제2에서 부서가 없는 Kimberely(사번 178)까지 표시해 보세요
--(107건)
SELECT employee_id 사번, first_name 이름, 
    salary 급여, department_id 부서명,
    job_id 현재업무
FROM employees
ORDER BY 사번;

SELECT employees.employee_id 사번, employees.first_name 이름, 
    employees.salary 급여, departments.department_id 부서명,
    jobs.job_id 현재업무
FROM employees, departments, jobs
WHERE employees.department_id = departments.department_id (+) AND 
    employees.job_id = jobs.job_id;
    
SELECT emp.employee_id 사번, emp.first_name 이름, 
emp.salary 급여, dept.department_id 부서명,
jobs.job_id 현재업무
FROM employees emp LEFT OUTER JOIN departments dept ON emp.department_id = dept.department_id, jobs
WHERE emp.job_id = jobs.job_id;

--문제3.
--도시별로 위치한 부서들을 파악하려고 합니다.
--도시아이디, 도시명, 부서명, 부서아이디를 도시아이디(오름차순)로 정렬하여 출력하세요
--부서가 없는 도시는 표시하지 않습니다.
--(27건)

SELECT dep.location_id 도시아이디, loc.city 도시명, dep.department_name 부서명, dep.department_id 부서아이디
FROM departments dep JOIN locations loc ON dep.location_id = loc.location_id
ORDER BY 도시아이디;

SELECT dep.location_id 도시아이디, loc.city 도시명, dep.department_name 부서명, dep.department_id 부서아이디
FROM departments dep JOIN locations loc ON dep.location_id = loc.location_id
ORDER BY 도시아이디;
--문제3-1.
--문제3에서 부서가 없는 도시도 표시합니다.
--(43건)

SELECT loc.location_id 도시아이디, city 도시명, department_name 부서명, dep.department_id 부서아이디
FROM departments dep RIGHT OUTER JOIN locations loc ON  loc.location_id = dep.location_id
ORDER BY 도시아이디;

SELECT loc.location_id 도시아이디, city 도시명, department_name 부서명, dep.department_id 부서아이디
FROM departments dep, locations loc 
WHERE loc.location_id = dep.location_id(+)
ORDER BY 도시아이디;


--문제4.
--지역(regions)에 속한 나라들을 지역이름(region_name), 나라이름(country_name)으로 출력하되 지역이름(오름차순), 나라이름(내림차순) 으로 정렬하세요.
--(25건)

SELECT reg.region_name 지역이름, con.country_name 나라이름
FROM countries con JOIN regions reg ON con.region_id = reg.region_id
ORDER BY 지역이름, 나라이름 DESC;

--문제5.
--자신의 매니저보다 채용일(hire_date)이 빠른 사원의
--사번(employee_id), 이름(first_name)과 채용일(hire_date), 매니저이름(first_name), 매니저입
--사일(hire_date)을 조회하세요.
--(37건)
SELECT emp.employee_id, emp.first_name, emp.hire_date,
    man.first_name, man.hire_date
FROM employees emp, employees man
WHERE emp.manager_id = man.employee_id AND
    emp.hire_date < man.hire_date;

--문제6.
--나라별로 어떠한 부서들이 위치하고 있는지 파악하려고 합니다.
--나라명, 나라아이디, 도시명, 도시아이디, 부서명, 부서아이디를 나라명(오름차순)로 정렬하여
--출력하세요.
--값이 없는 경우 표시하지 않습니다.
--(27건)
SELECT con.country_name , con.country_id, loc.city, loc.location_id, dept.department_name, dept.department_id
FROM departments dept JOIN locations loc on dept.location_id = loc.location_id, countries con
WHERE loc.country_id = con.country_id
ORDER BY con.country_name;

SELECT con.country_name , con.country_id, loc.city, loc.location_id, dept.department_name, dept.department_id
FROM departments dept, locations loc, countries con
WHERE dept.location_id = loc.location_id AND loc.country_id = con.country_id
ORDER BY con.country_name;

--문제7.
--job_history 테이블은 과거의 담당업무의 데이터를 가지고 있다.
--과거의 업무아이디(job_id)가 ‘AC_ACCOUNT’로 근무한 사원의 사번, 이름(풀네임), 업무아이
--디, 시작일, 종료일을 출력하세요.
--이름은 first_name과 last_name을 합쳐 출력합니다.
--(2건)
SELECT employees.department_id 사번, 
    CONCAT(CONCAT(employees.first_name, ' '), employees.last_name) 이름, 
    job_history.start_date 업무시작일, 
    job_history.end_date 업무종료일
FROM job_history, employees
WHERE job_history.employee_id = employees.employee_id AND job_history.job_id = 'AC_ACCOUNT';

--문제8.
--각 부서(department)에 대해서 부서번호(department_id), 부서이름(department_name),
--매니저(manager)의 이름(first_name), 위치(locations)한 도시(city), 나라(countries)의 이름
--(countries_name) 그리고 지역구분(regions)의 이름(resion_name)까지 전부 출력해 보세요.
--(11건)
SELECT dep.department_id, dep.department_name, emp.first_name, loc.city, con.country_name, reg.region_name
FROM employees emp, departments dep, locations loc, countries con, regions reg
WHERE dep.manager_id = emp.employee_id AND 
    dep.location_id = loc.location_id AND
    loc.country_id = con.country_id AND
    con.region_id = reg.region_id;

--문제9.
--각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명
--(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
--부서가 없는 직원(Kimberely)도 표시합니다.
--(106명)
SELECT emp.employee_id 사번, emp.first_name 이름,
    dep.department_name 부서명, 
    man.first_name "매니저 이름"
FROM employees emp, departments dep, employees man
WHERE emp.department_id = dep.department_id (+) AND
    emp.manager_id = man.employee_id;
