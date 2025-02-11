-- INNER JOIN(내부조인)
SELECT * FROM INFO INNER JOIN AUTH ON INFO.AUTH_ID = AUTH.AUTH_ID; -- 붙을 수 없는 데이터는 안나옴

-- 컬럼 지정 - AUTH_ID는 양쪽에 다 있기 때문에, 출력할 때, 테이블명.컬럼명 으로 지정해야 합니다.
SELECT ID, TITLE, CONTENT, INFO.AUTH_ID, NAME, JOB
FROM INFO INNER JOIN AUTH ON INFO.AUTH_ID = AUTH.AUTH_ID;

-- 테이블 ALIAS
SELECT I.ID,
        I.AUTH_ID,
        A.NAME
FROM INFO I
INNER JOIN AUTH A
ON I.AUTH_ID = A.AUTH_ID;

-- USING절 - 양쪽 테이블에 동일 키 이름으로 연결할 때 사용이 가능합니다
SELECT * 
FROM INFO 
INNER JOIN AUTH A
USING (AUTH_ID);

--------------------------------------------------------------------------------
-- LEFT OUTER JOIN - 왼쪽 테이블이 기준이 되고, 왼쪽 테이블은 다 나옴
SELECT *
FROM INFO I
LEFT OUTER JOIN AUTH A
ON I.AUTH_ID = A.AUTH_ID;

-- RIGHT OUTER JOIN - 오른쪽 테이블이 기준이 되고, 오른쪽 테이블은 다 나옴
SELECT *
FROM INFO I
RIGHT OUTER JOIN AUTH A
ON I.AUTH_ID = A.AUTH_ID;

-- FULL OUTER JOIN - 양쪽 테이블이 누락 없이 다 나옴
SELECT *
FROM INFO I
FULL OUTER JOIN AUTH A
ON I.AUTH_ID = A.AUTH_ID;

-- 번외 CROSS JOIN - 잘못된 조인의 형태 (오라클에서 "CARTESIAN PRODUCT" 라고 부릅니다.)
SELECT *
FROM INFO I
CROSS JOIN AUTH A;
--------------------------------------------------------------------------------

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT *
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- 조인이 3개 이상도 될까요? -> ㅇㅇ 됨
SELECT *
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID;

--------------------------------------------------------------------------------
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
--문제 1.
--EMPLOYEES 테이블과, DEPARTMENTS 테이블은 DEPARTMENT_ID로 연결되어 있습니다.
--EMPLOYEES, DEPARTMENTS 테이블을 엘리어스를 이용해서 
--각각 INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER 조인 하세요. (달라지는 행의 개수 확인)

-- INNER JOIN = 106개
SELECT *
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- LEFT OUTER JOIN = 107개
SELECT *
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- RIGHT OUTER JOIN = 122개
SELECT *
FROM EMPLOYEES E
RIGHT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- FULL OUTER JOIN = 123개
SELECT *
FROM EMPLOYEES E 
FULL OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--문제 2.
--EMPLOYEES, DEPARTMENTS 테이블을 INNER JOIN하세요
--조건)employee_id가 200인 사람의 이름, department_id를 출력하세요
--조건)이름 컬럼은 first_name과 last_name을 합쳐서 출력합니다
SELECT CONCAT(E.FIRST_NAME,E.LAST_NAME), D.DEPARTMENT_ID
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.EMPLOYEE_ID = 200;

--문제 3.
--EMPLOYEES, JOBS테이블을 INNER JOIN하세요
--조건) 모든 사원의 이름과 직무아이디, 직무 타이틀을 출력하고, 이름 기준으로 오름차순 정렬
--HINT) 어떤 컬럼으로 서로 연결되 있는지 확인
SELECT * FROM EMPLOYEES;
SELECT * FROM JOBS;

SELECT E.FIRST_NAME, J.JOB_ID, J.JOB_TITLE
FROM EMPLOYEES E
INNER JOIN JOBS J
ON E.JOB_ID = J.JOB_ID
ORDER BY E.FIRST_NAME;

--문제 4.
--JOBS테이블과 JOB_HISTORY테이블을 LEFT_OUTER JOIN 하세요.
SELECT * FROM JOB_HISTORY;
SELECT * FROM JOBS;

SELECT *
FROM JOBS J
LEFT OUTER JOIN JOB_HISTORY JH
ON J.JOB_ID = JH.JOB_ID;
--문제 5.
--Steven King의 부서명을 출력하세요.
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

SELECT D.DEPARTMENT_NAME
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.FIRST_NAME = 'Steven' AND E.LAST_NAME = 'King';

--문제 6.
--EMPLOYEES 테이블과 DEPARTMENTS 테이블을 Cartesian Product(Cross join)처리하세요
SELECT *
FROM EMPLOYEES E
CROSS JOIN DEPARTMENTS D;

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
--WHERE E2.MANAGER_ID IS NOT NULL
ORDER BY E2.SALARY DESC;
