-- 계정(스키마) : JOEUN

-- 그룹 관련 함수
-- ROLLUP 미적용 
SELECT dept_code, job_code
      ,COUNT(*), MAX(salary), SUM(salary), TRUNC( AVG(salary), 2)
FROM employee
GROUP BY dept_code, job_code
ORDER BY dept_code, job_code
;


-- ROLLUP 적용 
SELECT dept_code, job_code
      ,COUNT(*), MAX(salary), SUM(salary), TRUNC( AVG(salary), 2)
FROM employee
GROUP BY ROLLUP(dept_code, job_code)
ORDER BY dept_code, job_code
;

-- CUBE
SELECT dept_code, job_code
      ,COUNT(*), MAX(salary), SUM(salary), TRUNC( AVG(salary), 2)
FROM employee
WHERE dept_code IS NOT NULL
  AND job_code IS NOT NULL
GROUP BY CUBE(dept_code, job_code)
ORDER BY dept_code, job_code
;

-- GROUPING SETS
-- 그룹기준 별도로 그룹
-- * ( 그룹기준 ) 괄호로 묶어서 별도로 그룹짓는다.
SELECT dept_code, job_code, COUNT(*)
FROM employee
GROUP BY GROUPING SETS( (dept_code), (job_code) )
ORDER BY dept_code, job_code
;

-- GROUPING
-- 그룹화여부
SELECT dept_code
      , job_code
      , COUNT(*)
      , MAX(salary)
      , SUM(salary)
      , TRUNC( AVG(salary), 2)
      , GROUPING(dept_code) "부서코드 그룹여부"
      , GROUPING(job_code) "직급코드 그룹여부"
FROM employee
WHERE dept_code IS NOT NULL
  AND job_code IS NOT NULL
GROUP BY CUBE(dept_code, job_code)
ORDER BY dept_code, job_code
;

-- LISGTAGG
SELECT dept_code 부서코드
      ,LISTAGG( emp_name, ', ')
       WITHIN GROUP(ORDER BY emp_name) "부서별 사원이름목록"
FROM employee
GROUP BY dept_code
ORDER BY dept_code
;

-- PIVOT
SELECT *
FROM (
        SELECT dept_code, job_code, salary
        FROM employee
     )
     PIVOT (
        MAX(salary)
        -- 열에 올릴 컬럼들
        FOR dept_code IN ('D1','D2','D3','D4','D5','D6','D7','D8','D9')
        /*
            SELECT LISTAGG(dept_id, ',')
            FROM department
        */
     )
ORDER BY job_code;

-- UNPIVOT
SELECT *
FROM (
        SELECT dept_code
              ,MAX( DECODE(job_code, 'J1', salary ) ) J1 
              ,MAX( DECODE(job_code, 'J2', salary ) ) J2 
              ,MAX( DECODE(job_code, 'J3', salary ) ) J3 
              ,MAX( DECODE(job_code, 'J4', salary ) ) J4 
              ,MAX( DECODE(job_code, 'J5', salary ) ) J5 
              ,MAX( DECODE(job_code, 'J6', salary ) ) J6 
              ,MAX( DECODE(job_code, 'J7', salary ) ) J7 
        FROM employee
        GROUP BY dept_code
        ORDER BY dept_code
     )
     UNPIVOT (
        salary
        FOR job_code IN (J1, J2, J3, J4, J5, J6, J7)
     )
;

