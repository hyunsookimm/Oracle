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
                  
-- 2. ANT 연산으로 구하기
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
