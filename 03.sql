-- ROLLUP
-- GROUP BY 절과 함께 사용
-- GROUP BY의 결과에 좀더 상세한 요약을 제공하는 기능 수행 (Item Subtotal)
-- 부서별 급여의 합계 추출(부서 아이디, job_id)
SELECT department_id,
    job_id,
    SUM(salary)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;

SELECT department_id,
    job_id,
    SUM(salary)
FROM employees
GROUP BY ROLLUP(department_id, job_id);


-- CUBE 함수
-- CrossTable에 대한 Summary를 함께 제공
-- Rollup 함수로 추출된 Subtotal에 
-- Column Total 값을 추출할 수 있다
SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY CUBE(department_id, job_id)
ORDER BY department_id;

----------
-- Subquery
----------
/* 
하나의 SQL이 다른 SQL 질의의 일부에 포함되는 경우
*/
-- 단일행 서브쿼리
--  서브쿼리의 결과과 단일행인 경우, 단일행 비교 연산자를 사용(=, >, >=, <, <=, <>)

-- 'Den' 보다 급여를 많이 받는 사원의 이름과 급여는?
-- 1. Den이 얼마나 급여를 받는지 - A
-- 2. A보다 많은 급여를 받는 사람은?
SELECT salary FROM employees WHERE first_name='Den';    --  11000 : 1
SELECT first_name, salary FROM employees WHERE salary > 11000;  -- : 2
-- 합친다
SELECT first_name, salary FROM employees
WHERE salary > (SELECT salary FROM employees WHERE first_name='Den');

-- 연습: 
-- 급여의 중앙값보다 많이 받는 직원
-- 1. 급여의 중앙값?
-- 2. 급여를 중앙값보다 많이 받는 직원
SELECT MEDIAN(salary) FROM employees;   --  6200 : 1
SELECT first_name, salary FROM employees WHERE salary > 6200;
-- 쿼리 합치기
SELECT first_name, salary FROM employees
WHERE salary > (SELECT MEDIAN(salary) FROM employees);

-- 급여를 가장 적게 받는 사람의 이름, 급여, 사원 번호를 출력하시오
SELECT MIN(salary) FROM employees;  --  2100
SELECT first_name, salary, employee_id
FROM employees
WHERE salary = 2100;
-- 쿼리 합치기
SELECT first_name, salary, employee_id
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

-- 다중행 서브쿼리
-- 서브쿼리 결과 레코드가 둘 이상인 경우, 단순 비교 불가능
-- 집합 연산에 관련된 IN, ANY, ALL, EXSIST 등을 이용해야 한다

-- 110번 부서의 직원이 받는 급여는?
SELECT salary FROM employees WHERE department_id = 110; -- 레코드 갯수 2
SELECT first_name, salary FROM employees
WHERE salary = (SELECT salary FROM employees WHERE department_id = 110);
-- Error: 서브쿼리의 결과 레코드는 2개 
--  2개의 결과와 단일행 salary의 값을 비교할 수 없다

-- Fix
SELECT first_name, salary FROM employees
WHERE salary IN (SELECT salary FROM employees WHERE department_id = 110); -- IN
SELECT first_name, salary FROM employees
WHERE salary = ANY (SELECT salary FROM employees WHERE department_id = 110); -- ANY

-- IN, =ANY -> OR와 비슷

SELECT first_name, salary FROM employees
WHERE salary > ALL (SELECT salary FROM employees WHERE department_id = 110); -- ALL
-- ALL: AND와 비슷

SELECT first_name, salary FROM employees
WHERE salary > ANY (SELECT salary FROM employees WHERE department_id = 110);
-- salary > 12008 OR salary > 8300 -> 동일

-- Correlated Query
-- 포함한 쿼리(Outer Query), 포함된 쿼리(Inner Query)가 서로 연관관계를 맺는 쿼리
SELECT first_name, salary, department_id
FROM employees outer -- Outer
WHERE salary > (SELECT AVG(salary) FROM employees
                WHERE department_id = outer.department_id);
-- 의미
-- 사원 목록을 추출하되
--  자신이 속한 부서의 평균 급여보다 많이 받는 직원을 추출하자는 의미
--   서브쿼리(INNER)가 수행되기 위해 OUTER의 컬럼값이 필요하고
--      OUTER 쿼리 수행이 완료되기 위해서는 서브쿼리(INNERT)의 결과 값이 필요한 쿼리

-- 서브쿼리 연습
-- 각 부서별로 최고 급여를 받는 사원을 출력
SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id;

-- 1. 조건절에서 비교
SELECT department_id, employee_id, first_name, salary
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, MAX(salary) 
                                    FROM employees
                                    GROUP BY department_id)
ORDER BY department_id;

-- SUBQUERY: 임시테이블을 생성
-- 2. 부서별 최고 급여 테이블을 임시로 생성해서 테이블과 조인하는 방법
SELECT emp.department_id, employee_id, first_name, emp.salary
FROM employees emp, (SELECT department_id, MAX(salary) salary
                        FROM employees
                        GROUP BY department_id) sal -- 임시테이블을 만들어서 sal 별칭의 부여
WHERE emp.department_id = sal.department_id AND
    emp.salary = sal.salary
ORDER BY emp.department_id;

-- 3. Correlated Query 활용
SELECT emp.department_id, employee_id, first_name, emp.salary
FROM employees emp
WHERE emp.salary = (SELECT MAX(salary) FROM employees
                    WHERE department_id = emp.department_id)
ORDER BY department_id;                    

----------
-- TOP K Query
----------
-- Oracle은 질의 수행 결과의 행번호를 확인할 수 있는 가상 컬럼 rownum을 제공

-- 2007년 입사자 중에서 급여 순위 5위까지 뽑아봅시다
SELECT rownum, first_name, salary
FROM employees; --  OK

SELECT rownum, first_name, salary
FROM employees
WHERE hire_date LIKE '07%' AND rownum <= 5; 

SELECT rownum, first_name, salary
FROM employees
WHERE hire_date LIKE '07%' AND rownum <= 5
ORDER BY salary DESC;   --  rownum이 정해진 이후 정렬을 수행

-- TOP K 쿼리
SELECT rownum, first_name, salary 
FROM (SELECT * FROM employees
        WHERE hire_date LIKE '07%'
        ORDER BY salary DESC)
WHERE rownum <= 5;

-- SET (집합)
-- UNION(합집합: 중복제거), UNION ALL(합집합: 중복제거 안함)
-- INTERSECT(교집합), MINUS(차집합)
SELECT first_name, salary, hire_date FROM employees WHERE hire_date < '05/01/01';   -- 24
SELECT first_name, salary, hire_date FROM employees WHERE salary > 12000;   -- 8

-- 교집합
SELECT first_name, salary, hire_date FROM employees WHERE hire_date < '05/01/01'
INTERSECT
SELECT first_name, salary, hire_date FROM employees WHERE salary > 12000;

-- 위의 것과 같은 의미
SELECT first_name, salary, hire_date FROM employees
WHERE hire_date < '05/01/01' AND
    salary > 12000;

-- 합집합: UNION
SELECT first_name, salary, hire_date FROM employees WHERE hire_date < '05/01/01'
UNION
SELECT first_name, salary, hire_date FROM employees WHERE salary > 12000;  -- 26

-- 위의 것은 아래와 같은 의미
SELECT first_name, salary, hire_date 
FROM employees 
WHERE hire_date < '05/01/01' OR salary > 12000;

-- 차집합: MINUS
SELECT first_name, salary, hire_date FROM employees WHERE hire_date < '05/01/01'
MINUS
SELECT first_name, salary, hire_date FROM employees WHERE salary > 12000;

-- 입사일이 05/01/01 이전인 사람들 중, 급여가 12000이하인 직원들
SELECT first_name, salary, hire_date
FROM employees
WHERE hire_date < '05/01/01' AND
    NOT (salary > 12000);
    
-- RANK 함수
SELECT salary, first_name,
    RANK() OVER (ORDER BY salary DESC) as rank, --  중복된 순위를 건너뛰고 순위 부여
    DENSE_RANK() OVER (ORDER BY salary DESC) as dense_rank, -- 중복순위 상관 없이 다음 순위 부여
    ROW_NUMBER() OVER (ORDER BY salary DESC) as row_number, -- 중복 여부 관계없이 차례대로 순위 부여
    rownum  --  정렬되기 이전의 레코드 순서
FROM employees;

-- Hierarchical Query : 트리 형태의 구조를 추출
--  ROOT 노드: 조건 START WITH로 설정
--  가지: 연결하기 위한 조건을 CONNECT BY PROIR 로 설정
-- employees 테이블로 조직도 그려봅시다.
--  level(깊이)이라는 가상 컬럼을 사용할수 있다
SELECT level, first_name, manager_id, employee_id
FROM employees
START WITH manager_id IS NULL   -- ROOT 노드의 조건
CONNECT BY PRIOR employee_id = manager_id
ORDER BY level;