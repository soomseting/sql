--------------------------------------------------------------------------------
--문제 7.
--EMPLOYEES 테이블과 DEPARTMENTS 테이블의 부서번호를 조인하고 SA_MAN 사원만의 사원번호, 이름, 
--급여, 부서명, 근무지를 출력하세요. (Alias를 사용)
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

SELECT E.DEPARTMENT_ID AS 사원번호, 
        E.FIRST_NAME AS 이름, 
        E.SALARY AS 급여, 
        D.DEPARTMENT_NAME AS 부서명, 
        L.STREET_ADDRESS AS 근무지
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT OUTER JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
WHERE E.JOB_ID = 'SA_MAN';

SELECT * FROM LOCATIONS;

--문제 8.
--employees, jobs 테이블을 조인 지정하고 job_title이 'Stock Manager', 'Stock Clerk'인 직원 정보만
--출력하세요.
SELECT * FROM JOBS;
SELECT *
FROM EMPLOYEES E
JOIN JOBS J
ON E.JOB_ID = J.JOB_ID
WHERE J.JOB_TITLE LIKE 'Stock%';
-- WHERE J.JOB_TITLE IN ('Stock Manager', 'Stock Clerk');

--문제 9.
--departments 테이블에서 직원이 없는 부서를 찾아 출력하세요. LEFT OUTER JOIN 사용
SELECT * FROM DEPARTMENTS;
SELECT D1.DEPARTMENT_NAME
FROM DEPARTMENTS D1
LEFT OUTER JOIN DEPARTMENTS D2
ON D1.DEPARTMENT_ID = D2.MANAGER_ID
WHERE D2.MANAGER_ID IS NULL;
--문제 10. 
--join을 이용해서 사원의 이름과 그 사원의 매니저 이름을 출력하세요
--힌트) EMPLOYEES 테이블과 EMPLOYEES 테이블을 조인하세요.
SELECT * FROM EMPLOYEES;
SELECT E1.FIRST_NAME AS 사원,
        E2.FIRST_NAME AS 상급자
FROM EMPLOYEES E1
JOIN EMPLOYEES E2
ON E1.MANAGER_ID = E2.EMPLOYEE_ID;
--문제 11. 
--EMPLOYEES 테이블에서 left join하여 관리자(매니저)와, 매니저의 이름, 매니저의 급여 까지 출력하세요
--조건) 매니저 아이디가 없는 사람은 배제하고 급여는 역순으로 출력하세요
SELECT * FROM EMPLOYEES;

SELECT E1.FIRST_NAME,
        E1.SALARY,
        E2.FIRST_NAME,
        E2.SALARY
FROM EMPLOYEES E1
JOIN EMPLOYEES E2
ON E1.MANAGER_ID = E2.EMPLOYEE_ID
WHERE E2.MANAGER_ID IS NOT NULL
ORDER BY E2.SALARY DESC;
