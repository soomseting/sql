--제약조건 - 컬럼에 원치않는 데이터가 입력, 삭제, 수정되는 것을 방지하기 위한 조건
-- PRIMARY KEY - 테이블의 고유 키, 중복 X, NULL X, PK는 테이블에 1개
-- UNIQUE - 중복 X , NULL O, 고유한 녀석
-- NOT NULL - NULL을 허용하지 않음.
-- FOREIGN KEY - 참조하는 테이블의 PK를 넣어놓은 컬럼, 중복 O, NULL O
-- CHECK - 컬럼에 대한 데이터 제한(WHERE절과 유사)

-- 제약조건을 확인하는 명령문 OR 마우스로 확인
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMPLOYEES';

--1ST (열레벨)
DROP TABLE DEPTS;
CREATE TABLE DEPTS (
    DEPT_NO NUMBER(2)       CONSTRAINT DEPTS_DEPT_NO_PK PRIMARY KEY,
    DEPT_NAME VARCHAR2(30)  CONSTRAINT DEPTS_DEPT_NAME_NN NOT NULL,
    DEPT_DATE DATE          DEFAULT SYSDATE, --값이 들어가지 않을 때 자동으로 지정되는 기본값
    DEPT_PHONE VARCHAR2(30) CONSTRAINT DEPTS_DEPT_PHONE_UK UNIQUE,
    DEPT_GENDER CHAR(1)     CONSTRAINT DEPTS_DEPT_GENDER_CHECK CHECK (DEPT_GENDER IN ('F','M')),
    LOCA_ID NUMBER(4)       CONSTRAINT DEPTS_LOCA_ID_FK REFERENCES LOCATIONS (LOCATION_ID)
);
-- (CONSTRAINT는 생략가능) - 이름이 자동생성
DROP TABLE DEPTS;
CREATE TABLE DEPTS (
    DEPT_NO NUMBER(2)       PRIMARY KEY,
    DEPT_NAME VARCHAR2(30)  NOT NULL,
    DEPT_DATE DATE          DEFAULT SYSDATE, --값이 들어가지 않을 때 자동으로 지정되는 기본값
    DEPT_PHONE VARCHAR2(30) UNIQUE,
    DEPT_GENDER CHAR(1)     CHECK (DEPT_GENDER IN ('F','M')),
    LOCA_ID NUMBER(4)       REFERENCES LOCATIONS (LOCATION_ID)
);
DESC DEPTS;
INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES (1, NULL, '010....', 'F',1700); -- NOT NULL 제약 위배
INSERT INTO DEPTS (DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES (1, 'HONG', '010....', 'X',1700); -- CHECK 제약 위배
INSERT INTO DEPTS (DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES (1, 'HONG', '010....', 'F',100); -- FK 제약 위배
INSERT INTO DEPTS (DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES (1, 'HONG', '010....', 'F',1700);
INSERT INTO DEPTS (DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES (2, 'HONG', '010....', 'F',1700); -- UNIQUE 제약 위배
-- 개체 무결성 : 기본키에 NOT NULL일 수 없고, 중복될 수 없다. 규칙.
-- 참조 무결성 : 참조하는 테이블의 PK만 FK컬럼에 들어갈 수 있다. 규칙.
-- 도메인 무결성 : CHECK, UNIQUE 제약 안에서만 데이터가 들어갈 수 있다. 규칙.