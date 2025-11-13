
-- 1. 시스템 계정 접속
conn system/123456;

-- 2. ALL_USERS 에서 HR 계정 조회
SELECT user_id, username
FROM ALL_USERS
WHERE users = 'HR'
;

-- 3. employees 테이블 구조를 조회하는 명령 
desc employees;

-- * employees 테이블의 employee_id, first_name 조회
SELECT employee_id, first_name
FROM employees;

-- 4. employees 테이블에서 사원번호, 이름, 성, 이메일, 전화번호, 입사일자, 급여로 조회
-- AS (alias) :출력되는 컬럼명에 별명을 짓는 명령어
-- * 생략가능
-- AS 사원번호      : 별칭 그대로 작성
-- AS "사원 번호"   : 띄어쓰기가 있으면 ""로 감싸서 작성
-- AS '사원 번호'   : (에러)
SELECT employee_id AS "사원 번호"
      ,first_name AS 이름
      ,last_name AS 성
      ,email AS 이메일
      ,phone_number 전화번호
      ,hire_date AS 입사일자
      ,salary 급여
FROM employees;

-- 모든 컬럼(속성) 조회 : (*) 에스터리크
SELECT * 
FROM employees;

-- 5. employees 테이블에서 JOB_ID 중복 없이 조회하기
SELECT DISTINCT job_id
FROM employees;

-- 6. 
-- 테이블 EMPLOYEES 의 SALARY(급여)가 6000을 초과하는 사원의 모든 컬럼을 
-- 조회하는 SQL 문을 작성하시오.
SELECT * 
FROM employees
WHERE salary > 6000;

-- 7. 
-- 테이블 EMPLOYEES 의 SALARY(급여)가 10000인 사원의 모든 컬럼을 
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees 
WHERE salary = 10000;

-- 8. 
-- 테이블 EMPLOYEES 의 모든 속성들을 
-- SALARY 를 기준으로 내림차순 정렬하고, 
-- FIRST_NAME 을 기준으로 오름차순 정렬하여 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
ORDER BY salary DESC, first_name ASC;

-- 정렬
-- ORDER BY 컬럼명 [ASC/DESC];
-- * ASC         : 오름차순
-- * DESC        : 내림차순
-- * (생략)       : 오름차순이 기본 값

-- 9.
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 인 
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 조건 연산
-- OR 연산 : ~또는, ~이거나
-- WHERE A OR B;
SELECT * 
FROM employees 
WHERE job_id = 'FI_ACCOUNT'
   OR job_id = 'IT_PROG'
;

-- 10.
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 인 
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 단, IN 키워드를 사용하시오.
SELECT * 
FROM employees 
WHERE job_id IN ('FI_ACCOUNT','IT_PROG')
;

-- 11.
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 아닌
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 단, IN 키워드를 사용하시오.
SELECT * 
FROM employees 
WHERE job_id NOT IN ('FI_ACCOUNT','IT_PROG')
;

-- 12.
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘IT_PROG’ 이면서 SALARY 가 6000 이상인 
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees 
WHERE job_id = 'IT_PROG'
  AND salary >= 6000
;

-- 13.
-- 테이블 EMPOLYEES  의 FIRST_NAME 이 'S'로 시작하는 
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees 
WHERE first_name LIKE 'S%';

-- LIKE '';
-- %  : 빈 문자열, 1글자 이상의 문자열 대체 
-- _  : 1글자 대체

--  14.
-- 's' 로 끝나는
SELECT * 
FROM employees 
WHERE first_name LIKE '%s';

-- 15.
-- 's' 가 포함되는 
SELECT * 
FROM employees 
WHERE first_name LIKE '%s%';

-- 16.
-- 테이블 EMPLOYEES 의 FIRST_NAME 이 5글자인 
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 1) LIKE 키워드 사용
SELECT *
FROM employees 
WHERE first_name LIKE '_____'; -- 언더바 5개 

-- 2) LENGTH()
-- * LENGTH(컬럼명) : 글자 수 반환하는 함수
SELECT * 
FROM employees 
WHERE LENGTH(first_name) = 5;

-- 17.
-- 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL 인 
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT * 
FROM employees 
WHERE commission_pct IS NULL;

-- 18.
-- 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL 이 아닌 
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT * 
FROM employees 
WHERE commission_pct IS  NOT NULL;

-- 19.
-- 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년 이상인
-- 모든 컬럼을 조회하는 SQL 문을 작성하시오.

-- 1) 문자열 --> 암시적 형변환하여 조회
SELECT * 
FROM employees 
WHERE hire_date >= '04/01/01';

-- 2) TO_DATE 함수로 변환하여 조회  
SELECT * 
FROM employees 
WHERE hire_date >= TO_DATE('04/01/01', 'YY/MM/DD');

-- 20.
-- 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년도부터 05년도인 
-- 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 1) 문자열 --> 암시적 형변환하여 조회
SELECT * 
FROM employees 
WHERE hire_date >= '04/01/01'
  AND hire_date <= '05/12/31'
;

-- 2) TO_DATE 함수로 변환하여 조회 
SELECT * 
FROM employees 
WHERE hire_date >= TO_DATE('04/01/01', 'YY/MM/DD')
  AND hire_date <= TO_DATE('05/12/31', 'YY/MM/DD')
;

-- 3) BETWEEN AND 연산으로 조회
SELECT * 
FROM employees 
WHERE hire_date BETWEEN TO_DATE('04/01/01', 'YY/MM/DD')
                AND TO_DATE('05/12/31', 'YY/MM/DD')
;

-- 21. 
-- 12.45, -12.45 보다 크거나 같은 정수 중 제일 작은 수를 
-- 계산하는 SQL 문을 각각 작성하시오.
-- * dual ?
-- : 산술 연산, 함수 결과 등을 확인해볼 수 있는 임시 테이블
SELECT CEIL(12.45), CEIL(-12.45)
FROM dual;

-- 22.
-- 12.55와 -12.55 보다 작거나 같은 정수 중 가장 큰 수를 
-- 계산하는 SQL 문을 각각 작성하시오.
SELECT FLOOR(12.45), FLOOR(-12.45)
FROM dual;

-- 23.
-- ROUND(값, 자리수)
-- : 지정한 값을, 해당 자리수에서 반올림하는 함수
-- a a a a a.bbbb
-- ...  -2-1.0123=

-- 0.54를 소수점 아래 첫째 자리에서 반올림하시오 
SELECT ROUND(0.54, 0) FROM dual;

-- 0.54를 소수점 아래 둘째 자리에서 반올림하시오 
SELECT ROUND(0.54, 1) FROM dual;

-- 125.67 을 일의 자리에서 반올림하시오.
SELECT ROUND(125.67, -1) FROM dual;

-- 125.67 을 십의 자리에서 반올림하시오.
SELECT ROUND(125.67, -2) FROM dual;

-- 24.
-- 각 소문제에 제시된 두 수를 이용하여 나머지를 구하는 SQL문을 작성하시오.
-- MOD( A, B )
-- : A를 B로 나눈 나머지를 구하는 함수

-- 3을 8로 나눈 나머지
SELECT MOD(3, 8) FROM dual;

-- 30을 4로 나눈 나머지
SELECT MOD(30, 4) FROM dual;

-- 25. 제곱수 구하기
-- POWER( A, B )
-- : A 의 B 제곱을 구하는 함수

-- 2의 10 제곱을 구하시오.
SELECT POWER(2, 10)
FROM dual;

-- 2의 31 제곱을 구하시오.
SELECT POWER(2, 31)
FROM dual;

-- 26. 제곱근 구하기
-- SQRT( A )
-- : A의 제곱근을 구하는 함수
--   A는 양의 정수와 실수만 사용 가능

-- 2의 제곱근을 구하시오.
SELECT SQRT(2)
FROM dual;

-- 100의 제곱근을 구하시오.
SELECT SQRT(100)
FROM dual;

-- 27.
-- TRUNC(실수, 자리수) 
-- : 해당 수를 절삭하는 함수

-- 527425.1234 소수점 아래 첫째 자리에서 절삭
SELECT TRUNC(527425.1234, 0) FROM dual;

-- 527425.1234 소수점 아래 둘째 자리에서 절삭
SELECT TRUNC(527425.1234, 1) FROM dual;

-- 527425.1234 일의 자리에서 절삭
SELECT TRUNC(527425.1234, -1) FROM dual;

-- 527425.1234 십의 자리 자리에서 절삭
SELECT TRUNC(527425.1234, -2) FROM dual;

-- 28. 절댓값 구하기
-- ABS( A )
-- : 값 A 의 절댓값을 구하여 변환하는 함수

-- -20 의 절댓값을 구하기
SELECT ABS(-20) FROM dual;

-- -12.456 의 절댓값을 구하기 
SELECT ABS(12.456) FROM dual;