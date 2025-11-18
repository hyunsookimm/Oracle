-- 81. 
-- EMPLOYEE, DEPARTMENT, JOB 테이블을 사용하여
-- 스칼라 서브쿼리로 출력결과와 같이 조회하시오.
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;


-- 스칼라 서브쿼리
-- 사원번호, 직원명, 부서명, 직급명
SELECT e.EMP_ID  사원번호 
       ,e.EMP_NAME 직원명
       ,(SELECT DEPT_TITLE FROM DEPARTMENT d WHERE e.DEPT_CODE = d.DEPT_ID) 부서명
       ,(SELECT JOB_NAME FROM JOB j WHERE e.JOB_CODE = j.JOB_CODE) 직급명
FROM employee e;

-- 82.
-- 출력결과를 참고하여,
-- 인라인 뷰를 이용해 부서별로
-- 최고급여를 받는 직원을 조회하시오.

-- 1. 부서별 최고급여 조회 
SELECT DEPT_CODE 부서코드
      ,MAX(SALARY) 최고급여
      ,MIN(SALARY) 최저급여
      ,AVG(SALARY) 평균급여
      FROM EMPLOYEE
      GROUP BY DEPT_CODE 
;

SELECT * FROM EMPLOYEE;

-- 2. 부서별 최고급여 조회결과를 서브쿼리(인라인뷰)
SELECT EMP_ID 사원번호
      ,EMP_NAME 직원명
      ,SALARY 급여
      ,t.MAX_SAL 최고급여
      ,t.MIN_SAL 최저급여
      ,ROUND(t.AVG_SAL, 2) 평균급여
FROM 
    EMPLOYEE e, DEPARTMENT d,
    (
    SELECT DEPT_CODE 부서코드
      ,MAX(SALARY) MAX_SAL
      ,MIN(SALARY) MIN_SAL
      ,AVG(SALARY) AVG_SAL
      FROM EMPLOYEE
      GROUP BY DEPT_CODE
    ) t
WHERE e.DEPT_CODE = d.DEPT_ID
  AND e.salary = t.MAX_SAL;

-- 83. 
-- 서브쿼리를 이용하여,
-- 직원명이 '이태림' 인 사원과 같은 부서의 직원들을 조회하시오.
SELECT 
   EMP_ID 사원번호,
   EMP_NAME 직원명,
   (SELECT DEPT_TITLE FROM DEPARTMENT d WHERE d.DEPT_ID = e.DEPT_CODE) 부서명,
   EMAIL 이메일,
   PHONE 전화번호
FROM EMPLOYEE e
WHERE DEPT_CODE = (
                    SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '이태림'
                  )
;

-- 84. 
-- 사원 테이블에 존재하는 부서코드만 포함하는 부서를 조회하시오.
-- (사원이 존재하는 부서만 조회하시오.)

-- 1) 서브쿼리 
SELECT DEPT_ID 부서번호
      ,DEPT_TITLE 부서명
      ,LOCATION_ID 지역코드
FROM DEPARTMENT
WHERE DEPT_ID IN   (
                    SELECT DISTINCT DEPT_CODE
                    FROM EMPLOYEE
                   )   
;

-- 2) EXISTS
SELECT DEPT_ID 부서번호
      ,DEPT_TITLE 부서명
      ,LOCATION_ID 지역코드
FROM DEPARTMENT d
WHERE EXISTS  (
                SELECT * 
                FROM EMPLOYEE e
                WHERE d.DEPT_ID = e.DEPT_CODE
            )
ORDER BY 부서번호 ASC
;

-- 사원이 존재하는 부서 : D1 D2 D5 D6 D8 D9

-- 85.
-- 사원 테이블에 존재하지 않는 부서코드만 포함하는 부서를 조회하시오.
--(사원이 존재하지 않는 부서만 조회하시오.)

-- 사원이 존재하는 부서 : D1 D2 D5 D6 D8 D9
-- 사원이 없는 부서 : D3, D4, D7

-- 1) 서브쿼리 
SELECT DEPT_ID 부서번호
      ,DEPT_TITLE 부서명
      ,LOCATION_ID 지역코드
FROM DEPARTMENT
WHERE DEPT_ID  NOT IN   (
                    SELECT DISTINCT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE DEPT_CODE IS NOT NULL
                   )   
;

-- 2) EXISTS
SELECT DEPT_ID 부서번호
      ,DEPT_TITLE 부서명
      ,LOCATION_ID 지역코드
FROM DEPARTMENT d
WHERE  NOT EXISTS  (
                SELECT * 
                FROM EMPLOYEE e
                WHERE d.DEPT_ID = e.DEPT_CODE
            )
ORDER BY 부서번호 ASC
;

-- 86.
-- EMPLOYEE 테으블의 DEPT_CODE 가 'D1' 인 부서의 최대급여 보다
-- 더 큰 급여를 받는 사원을 조회하시오.

-- 1) 최대급여를 구하여 비교
SELECT MAX(salary)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- 2) 급여가 D1 최대급여보다 큰 사원 조회
SELECT 
     e.EMP_ID 사원번호
    ,e.EMP_NAME 직원명
    ,d.DEPT_ID 부서번호 
    ,d.DEPT_TITLE 부서명
    ,e.SALARY 급여
FROM EMPLOYEE e, DEPARTMENT d 
WHERE e.DEPT_CODE = d.DEPT_ID
  AND SALARY > 3660000;

-- 3) 최대급여 자리에 1번 쿼리 대입
SELECT 
     e.EMP_ID 사원번호
    ,e.EMP_NAME 직원명
    ,d.DEPT_ID 부서번호 
    ,d.DEPT_TITLE 부서명
    ,e.SALARY 급여
FROM EMPLOYEE e, DEPARTMENT d 
WHERE e.DEPT_CODE = d.DEPT_ID
  AND SALARY > (
                  SELECT MAX(salary)
                  FROM EMPLOYEE
                  WHERE DEPT_CODE = 'D1'
               );

-- 2) ALL 연산으로 구하기
SELECT 
     e.EMP_ID 사원번호
    ,e.EMP_NAME 직원명
    ,d.DEPT_ID 부서번호 
    ,d.DEPT_TITLE 부서명
    ,e.SALARY 급여
FROM EMPLOYEE e, DEPARTMENT d 
WHERE e.DEPT_CODE = d.DEPT_ID
  AND SALARY >  ALL (
                     SELECT MAX(salary)
                     FROM EMPLOYEE
                     WHERE DEPT_CODE = 'D1'
                    );

-- 87.
-- EMPOLYEE 테이블의 DEPT_CODE 가 'D9' 인 부서의 최저급여 보다 
-- 더 큰 급여를 받는 사원을 조회하시오.

-- 1. 
SELECT MIN(salary)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 2) 
SELECT 
     e.EMP_ID 사원번호
    ,e.EMP_NAME 직원명
    ,d.DEPT_ID 부서번호 
    ,d.DEPT_TITLE 부서명
    ,e.SALARY 급여
FROM EMPLOYEE e, DEPARTMENT d 
WHERE e.DEPT_CODE = d.DEPT_ID
  AND e.SALARY > (
                  SELECT MIN(salary)
                  FROM EMPLOYEE
                  WHERE DEPT_CODE = 'D9'
                  );
                  
-- 2. ANY 연산으로 구하기
SELECT 
     e.EMP_ID 사원번호
    ,e.EMP_NAME 직원명
    ,d.DEPT_ID 부서번호 
    ,d.DEPT_TITLE 부서명
    ,e.SALARY 급여
FROM EMPLOYEE e, DEPARTMENT d 
WHERE e.DEPT_CODE = d.DEPT_ID
  AND e.SALARY > ANY (
                      SELECT MIN(salary)
                      FROM EMPLOYEE
                      WHERE DEPT_CODE = 'D9'
                     );

-- 88.
-- 테이블 EMPLOYEE 와 DEPARTMENT를 조인하여 출력하되
-- 부서가 없는 직원도 포함하여 출력하는 SQL 문을 작성하시오.

-- 사원번호, 직원명, 부서번호, 부서명
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,NVL(d.dept_id,'(없음)') 부서번호
      ,NVL(d.dept_title,'(없음)') 부서명
FROM employee e 
     LEFT JOIN DEPARTMENT d 
     ON (e.dept_code = d.dept_id)
;
    
-- 89.
-- 테이블 EMPLOYEE 와 DEPARTMENT를 조인하여 출력하되
-- 직원이 없는 부서도 포함하여 출력하시오.
SELECT NVL (e.emp_id, '(없음)') 사원번호
      ,NVL (e.emp_name, '(없음)') 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
FROM employee e 
     RIGHT JOIN DEPARTMENT d 
     ON (e.dept_code = d.dept_id)
;

-- 90.
-- 직원 및 부서 유무에 상관없이 출력하는 SQL문을 작성하시오.
SELECT NVL (e.emp_id, '(없음)') 사원번호
      ,NVL (e.emp_name, '(없음)') 직원명
      ,NVL (d.dept_id, '(없음)') 부서번호
      ,NVL (d.dept_title, '(없음)') 부서명
FROM employee e 
     FULL JOIN DEPARTMENT d 
     ON (e.dept_code = d.dept_id)
;

-- 91.
-- 사원번호, 직원명, 부서번호, 지역명, 국가명, 급여, 입사일자를 출력하시오.

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;
SELECT * FROM NATIONAL;

SELECT E.EMP_ID 사원번호,
       E.EMP_NAME 직원명,
       D.DEPT_ID 부서번호,
       D.DEPT_TITLE 부서명,
       L.LOCAL_NAME 지역명,
       N.NATIONAL_NAME 국가명,
       E.SALARY 급여
FROM EMPLOYEE E
     LEFT JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
     LEFT JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
     LEFT JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE
;

-- 92.
-- 사원들 중 매니저를 출력하시오.
-- 사원번호, 직원명, 부서명, 직급, 구분('매니저')
-- * MANAGER_ID : 해당 사원의 매니저 사원번호

SELECT * FROM EMPLOYEE;

--1. 
-- MANAGER_ID 컬럼이 NULL 아닌 사원을 중복없이 조회
-- -> 매니저들의 사원 번호
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;

-- 2. 
-- EMPLOYEE, DEPARAMENT, JOB 테이블을 조인하여 조회
SELECT * 
FROM EMPLOYEE E 
    LEFT JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
;

-- 3. 조인 결과 중 , EMP_ID 가 매니저 사원번호인 경우만 조회
SELECT 
     E.EMP_ID 사원번호,
     E.EMP_NAME 직원명,
     D.DEPT_TITLE 부서명,
     JOB_NAME 직급명,
     '매니저' 구분
     
FROM EMPLOYEE E 
    LEFT JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE E.EMP_ID IN (
                   SELECT DISTINCT MANAGER_ID
                   FROM EMPLOYEE
                   WHERE MANAGER_ID IS NOT NULL
                )
;          

-- 93.
-- 사원(매니저가 아닌)만 조회하시오.
SELECT 
     E.EMP_ID 사원번호,
     E.EMP_NAME 직원명,
     D.DEPT_TITLE 부서명,
     JOB_NAME 직급명,
     '사원' 구분
     
FROM EMPLOYEE E 
    LEFT JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE E.EMP_ID NOT IN (
                   SELECT DISTINCT MANAGER_ID
                   FROM EMPLOYEE
                   WHERE MANAGER_ID IS NOT NULL
                  )
;          


-- 94.
-- UNION 키워드를 사용하여,
-- 매니저와 사원 구분하여 조회하시오.

SELECT 
     E.EMP_ID 사원번호,
     E.EMP_NAME 직원명,
     D.DEPT_TITLE 부서명,
     JOB_NAME 직급명,
     '매니저' 구분
     
FROM EMPLOYEE E 
    LEFT JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE E.EMP_ID IN (
                   SELECT DISTINCT MANAGER_ID
                   FROM EMPLOYEE
                   WHERE MANAGER_ID IS NOT NULL
                )
UNION
SELECT 
     E.EMP_ID 사원번호,
     E.EMP_NAME 직원명,
     D.DEPT_TITLE 부서명,
     JOB_NAME 직급명,
     '사원' 구분
     
FROM EMPLOYEE E 
    LEFT JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE E.EMP_ID NOT IN (
                   SELECT DISTINCT MANAGER_ID
                   FROM EMPLOYEE
                   WHERE MANAGER_ID IS NOT NULL
                  )    
;            

-- 95.
-- CASE 키워드를 사용하여,
-- 매니저와 사원을 구분하여 출력하시오
SELECT 
     E.EMP_ID 사원번호,
     E.EMP_NAME 직원명,
     D.DEPT_TITLE 부서명,
     JOB_NAME 직급명,
      CASE 
         WHEN EMP_ID IN (
                   SELECT DISTINCT MANAGER_ID
                   FROM EMPLOYEE
                   WHERE MANAGER_ID IS NOT NULL
                )
         THEN '매니저'
         ELSE '사원'        
      END 구분
FROM EMPLOYEE E 
    LEFT JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
;    

-- 96.
-- EMPLOYEE, DEPARTMENT, JOB 테이블을 조인하여 조회하시오
-- 사원의 나이와 성별을 구하여 출력하고,
-- 주민등록번호 뒷자리 첫글자를 제외하고 마스킹하여 출력하시오.
SELECT  E.EMP_ID 사원번호,
        E.EMP_NAME 직원명,
        D.DEPT_TITLE 부서명,
        J.JOB_NAME 직급,
      CASE 
         WHEN EMP_ID IN (
                   SELECT DISTINCT MANAGER_ID
                   FROM EMPLOYEE
                   WHERE MANAGER_ID IS NOT NULL
                )
      THEN '매니저'
      ELSE '사원'        
      END 구분,
      -- 성별
      -- * 주민등록번호 (EMP_NO) 뒷자리 첫글자
      -- 1,3 (남자) 2,4(여자)
      CASE
         WHEN SUBSTR(EMP_NO, 8, 1) IN ('1','3') THEN '남자'
         WHEN SUBSTR(EMP_NO, 8, 1) IN ('2','4') THEN '여자'
      END 성별,
      -- 나이 
      TRUNC(
        MONTHS_BETWEEN(
            SYSDATE,
            TO_DATE(
            CASE
                WHEN SUBSTR(EMP_NO, 8, 1) IN ('1','2') THEN '19'
                WHEN SUBSTR(EMP_NO, 8, 1) IN ('3','4') THEN '20'
            END || SUBSTR(EMP_NO, 1, 6)
            ,
            'YYYYMMDD'
           )   
         ) / 12
      ) 나이,
      -- 주민번호 마스킹
      -- 850101-1******
      RPAD( SUBSTR (EMP_NO, 1, 8), 14, '*')주민등록번호
FROM EMPLOYEE E 
     JOIN  DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
     JOIN JOB J USING (JOB_CODE)
;

-- 97.
-- 96번 조회결과에 
-- 순번, 만나이, 근속연수, 입사일자, 연봉을 추가하시오.

SELECT  ROWNUM 순번,
        E.EMP_ID 사원번호,
        E.EMP_NAME 직원명,
        D.DEPT_TITLE 부서명,
        J.JOB_NAME 직급,
      CASE 
         WHEN EMP_ID IN (
                   SELECT DISTINCT MANAGER_ID
                   FROM EMPLOYEE
                   WHERE MANAGER_ID IS NOT NULL
                )
      THEN '매니저'
      ELSE '사원'        
      END 구분,
      -- 성별
      -- * 주민등록번호 (EMP_NO) 뒷자리 첫글자
      -- 1,3 (남자) 2,4(여자)
      CASE
         WHEN SUBSTR(EMP_NO, 8, 1) IN ('1','3') THEN '남자'
         WHEN SUBSTR(EMP_NO, 8, 1) IN ('2','4') THEN '여자'
      END 성별,
      -- 현재나이 
      TRUNC(
        MONTHS_BETWEEN(
            SYSDATE,
            TO_DATE(
            CASE
                WHEN SUBSTR(EMP_NO, 8, 1) IN ('1','2') THEN '19'
                WHEN SUBSTR(EMP_NO, 8, 1) IN ('3','4') THEN '20'
            END || SUBSTR(EMP_NO, 1, 2) || '0101'
            ,
            'YYYYMMDD'
           )   
         ) / 12
      ) + 1 현재나이,
      -- 만나이
      TRUNC(
        MONTHS_BETWEEN(
            SYSDATE,
            TO_DATE(
            CASE
                WHEN SUBSTR(EMP_NO, 8, 1) IN ('1','2') THEN '19'
                WHEN SUBSTR(EMP_NO, 8, 1) IN ('3','4') THEN '20'
            END || SUBSTR(EMP_NO, 1, 6)
            ,
            'YYYYMMDD'
           )   
         ) / 12
      ) 만나이,
      TRUNC(
           MONTHS_BETWEEN(
            SYSDATE,
            HIRE_DATE
           ) / 12
      ) 근속연수,
      -- 주민번호 마스킹
      -- 850101-1******
      RPAD( SUBSTR (EMP_NO, 1, 8), 14, '*')주민등록번호,
      -- 입사일자
      TO_CHAR(HIRE_DATE, 'YYYY.MM.DD') 입사일자, 
      -- 연봉 (급여 + ( 급여*보너스 )) * 12
      TO_CHAR(
      ( SALARY + (SALARY * NVL(BONUS, 0)) ) * 12
      ,
      '999,999,999,999'
      ) 연봉 
FROM EMPLOYEE E 
     JOIN  DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
     JOIN JOB J USING (JOB_CODE)
;

-- 98.
-- employee, department 테이블을 조인하여,
-- 사원번호, 직원명, 부서번호, 부서명, 이메일, 전화번호
-- 주민번호, 입사일자, 급여, 연봉을 조회하시오.
-- CREATE OR REPLACE 객체
-- - 없으면, 새로 생성
-- - 있으면, 대체 (기존에 생성 되어 있어도 에러발생X) 
CREATE OR REPLACE VIEW VE_EMP_DEPT AS
SELECT e.emp_id
      ,e.emp_name
      ,d.dept_id
      ,d.dept_title
      ,e.email
      ,e.phone
      -- 주민등록번호
      ,RPAD( SUBSTR(emp_no, 1, 8), 14, '*' ) emp_no
      -- 입사일자
      ,TO_CHAR( hire_date, 'YYYY.MM.DD' ) hire_date
      -- 급여
      ,TO_CHAR( salary, '999,999,999' ) salary
      -- 연봉
      ,TO_CHAR( (salary + NVL( salary*bonus, 0)) * 12, '999,999,999,999') yr_salary
FROM employee e
     LEFT JOIN department d ON (e.dept_code = d.dept_id)
;

-- 뷰 조회
SELECT * 
FROM VE_EMP_DEPT
;

-- 99.
-- 시퀀스를 생성하시오.
-- SEQ_MS_USER
-- SEQ_MS_BOARD
-- SEQ_MS_FILE
-- SEQ_MS_REPLY
-- (시작: 1, 증가값: 1, 최솟값: 1, 최댓값: 1000000)
-- 시퀀스 생성

CREATE SEQUENCE SEQ_MS_USER
INCREMENT BY 1                -- 증가값
START WITH 1                  -- 시작값
MINVALUE 1                    -- 최솟값
MAXVALUE 1000000;             -- 최댓값

CREATE SEQUENCE SEQ_MS_BOARD
INCREMENT BY 1                -- 증가값
START WITH 1                  -- 시작값
MINVALUE 1                    -- 최솟값
MAXVALUE 1000000;             -- 최댓값

CREATE SEQUENCE SEQ_MS_FILE
INCREMENT BY 1                -- 증가값
START WITH 1                  -- 시작값
MINVALUE 1                    -- 최솟값
MAXVALUE 1000000;             -- 최댓값

CREATE SEQUENCE SEQ_MS_REPLY
INCREMENT BY 1                -- 증가값
START WITH 1                  -- 시작값
MINVALUE 1                    -- 최솟값
MAXVALUE 1000000;             -- 최댓값

-- 100.
-- SEQ_MS_USER 의 다음 번화와 현재 번호를 출력하시오.

-- 다음 시퀀스 번호
SELECT SEQ_MS_USER.NEXTVAL FROM DUAL;

-- 현재 시퀀스 번호
SELECT SEQ_MS_USER.CURRVAL FROM DUAL;

-- 101.
-- SEQ_MS_USER 를 삭제하시오.
DROP SEQUENCE SEQ_MS_USER;

-- 102.
-- SEQ_MS_USER 를 이용하여, MS_USER 의 user_no 가
-- 시퀀스 번호로 적용될 수 있도록 데이터를 추가해보시오.
INSERT INTO MS_USER (USER_NO, USER_ID, USER_PW, USER_NAME ,
                     BIRTH, TEL, ADDRESS, REG_DATE, UPD_DATE
                     )
VALUES (
      SEQ_MS_USER.NEXTVAL,'ALOHA', '123456', '김조은',
      '2024/03/06', '010-1234-1234', '인천 부평구', SYSDATE, SYSDATE
);

INSERT INTO MS_USER ( USER_NO, USER_ID, USER_PW, USER_NAME,
                      BIRTH, TEL, ADDRESS, REG_DATE, UPD_DATE
                      )
VALUES (
      SEQ_MS_USER.NEXTVAL, 'JOEUN', '123456', '박조은',
      '2024/03/06', '010-1234-1234', '서울 구로구', SYSDATE, SYSDATE
);

-- 103.
-- 시퀀스 SEQ_MS_USER 의 최댓값을 100,000,000 으로 수정하시오.
ALTER SEQUENCE SEQ_MS_USER MAXVALUE 100000000;

-- 104.
-- USER_IND_COLUMNS 테이블을 조회하시오.
-- * 사용자가 정의한 인덱스 정보가 들어있다.
SELECT INDEX_NAME, TABLE_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS;

-- 105.
-- MS_USER 테이블의 USER_NAME 에 대한
-- 인덱스 IDX_MS_USER_NAME 을 생성하시오.

-- 인덱스 생성
CREATE INDEX IDX_MS_USER_NAME ON MS_USER(USER_NAME);

-- 인덱스 삭제
DROP INDEX IDX_MS_USER_NAME;















