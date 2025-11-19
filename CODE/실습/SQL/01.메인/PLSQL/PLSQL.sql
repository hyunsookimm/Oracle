/*
    106.
    변수 num1, num2 변수를 선언하여 각각 10, 20을 대입하고 
    IF 문으로 크기를 비교한 결과를 출력하는 PL/SQL 블록을 작성하시오.
*/
SET SERVEROUTPUT ON;
DECLARE 
    -- 선언부 
     num1 NUMBER := 10;
     num2 NUMBER := 20;
BEGIN
    -- 실행부
    IF num1 > num2 THEN 
        DBMS_OUTPUT.PUT_LINE('num1 이 더 큽니다');     
    ELSIF num1 < num2 THEN 
        DBMS_OUTPUT.PUT_LINE('num2 가 더 큽니다');    
    ELSE 
        DBMS_OUTPUT.PUT_LINE('값이 같습니다.');    
    END IF;
END;
/

/*
    107.
    테이블 department 의 부서코드(dept_id) 컬럼을 참조하는 
    변수 vn_dept_code 를 선언하고, 
    최대급여를 조회하여 저장할 변수 vn_salary 를 선언하시오. 
    테이블 employee 에서 최대 급여를 조회하여 vn_salary 에 대입 한 뒤, 
    100~200만원인지 
    200~300만원인지 
    조건을 확인하는 PL/SQL 코드를 작성하시오.
    * IF
*/
SET SERVEROUTPUT ON;
DECLARE
    -- 테이블명.컬럼%TYPE : 컬럼의 데이터타입을 참조하여 지정
    vn_dept_code department.dept_id%TYPE;
    vn_salary    employee.salary%TYPE;
BEGIN
    -- 부서코드 : 10
    vn_dept_code := 10;

    -- 최대급여
    -- : 조회한 최대급여를 vn_salary 변수에 저장
    SELECT MAX(salary)    INTO vn_salary
    FROM employee;        

    -- 조건 
    IF vn_salary BETWEEN 1000000 AND 2000000 THEN
         DBMS_OUTPUT.PUT_LINE('최대급여는 100~200만원 사이입니다.');
    ELSIF vn_salary BETWEEN 2000000 AND 3000000 THEN 
         DBMS_OUTPUT.PUT_LINE('최대급여는 200~300만원 사이입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('최대급여는 300만원 초과입니다.');
    END IF;
END;
/

/*
    108.
    테이블 department 의 부서코드(dept_id) 컬럼을 참조하는 
    변수 vn_dept_code 를 선언하고, 
    최대급여를 조회하여 저장할 변수 vn_salary 를 선언하시오. 
    테이블 employee 에서 최대 급여를 조회하여 vn_salary 에 대입 한 뒤, 
    100~200만원인지 
    200~300만원인지 
    조건을 확인하는 PL/SQL 코드를 작성하시오.
    * CASE
*/

DECLARE
    -- 테이블명.컬럼%TYPE : 컬럼의 데이터타입을 참조하여 지정
    vn_dept_code department.dept_id%TYPE;
    vn_salary    employee.salary%TYPE;
BEGIN
    -- 부서코드 : 10
    vn_dept_code := 10;

    -- 최대급여
    -- : 조회한 최대급여를 vn_salary 변수에 저장
    SELECT MAX(salary)    INTO vn_salary
    FROM employee;        

    -- 조건 
    CASE
       WHEN vn_salary BETWEEN 1000000 AND 2000000 THEN
         DBMS_OUTPUT.PUT_LINE('최대급여는 100~200만원 사이입니다.');
       WHEN vn_salary BETWEEN 2000000 AND 3000000 THEN 
         DBMS_OUTPUT.PUT_LINE('최대급여는 200~300만원 사이입니다.');
       ELSE
        DBMS_OUTPUT.PUT_LINE('최대급여는 300만원 초과입니다.');
    END CASE;
END;
/

-- 109. LOOP 문을 이용하여 구구단을 출력하는 PL/SQL 블록을 작성하시오
DECLARE
    dan NUMBER := 2;       -- 단
    i   NUMBER := 1;       -- 곱하는 수
BEGIN 
    LOOP 
        EXIT WHEN i > 9;   -- 종료조건
        DBMS_OUTPUT.PUT_LINE(dan || ' x ' || i || ' = ' || (dan * i));
        i := i + 1;
    END LOOP;
END;
/

-- 110. WHILE LOOP 문을 이용하여 구구단을 출력하는 PL/SQL 블록을 작성하시오
DECLARE
    dan NUMBER := 2;       -- 단
    i   NUMBER := 1;       -- 곱하는 수
BEGIN 
    WHILE i <= 9 LOOP-- 종료조건
        DBMS_OUTPUT.PUT_LINE(dan || ' x ' || i || ' = ' || (dan * i));
        i := i + 1;
    END LOOP;
END;
/

-- 111. FOR LOOP 문을 이용하여 구구단을 출력하는 PL/SQL 블록을 작성하시오
DECLARE
    dan NUMBER := 2;       -- 단
    i   NUMBER := 1;       -- 곱하는 수
BEGIN 
    FOR i IN 1..9 LOOP-- 종료조건
        DBMS_OUTPUT.PUT_LINE(dan || ' x ' || i || ' = ' || (dan * i));
    END LOOP;
END;
/

/*
   112.
   반복문을 활용하여 1~20 사이의 정수 중 홀수만 출력하는 PL/SQL 문을 작성하시오
*/
DECLARE
    i NUMBER := 1;
BEGIN
    WHILE i <= 20 LOOP
       IF MOD(i, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE(i); 
       END IF;
       i := i + 1;
    END LOOP;
END;
/

/*
  113. 
  테이블 employee와 department를 조인하여,
  사원명과 부서명을 각각 vs_emp_name, vs_dept_name 변수에 대입하고
  출력하는 PL/SQL 블록을 작성하시오.
*/
DECLARE
    vs_emp_name     employee.emp_name%TYPE;      -- 사원명
    vs_dept_name    department.dept_title%TYPE;   -- 부서명
BEGIN 
    SELECT 
         e.emp_name, d.dept_title
    INTO vs_emp_name, vs_dept_name 
    FROM employee e 
        JOIN department d ON e.dept_code = d.dept_id
    WHERE e.emp_id = 200;

    DBMS_OUTPUT.PUT_LINE('사원명 : ' ||  vs_emp_name);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' ||  vs_dept_name);
END;
/

/* 114.
  사원번호로 부서명을 구하는 함수를 정의하는 PL/SQL 을 작성하시오.
*/

-- 함수 생성 
CREATE OR REPLACE FUNCTION get_dept_title( p_emp_id NUMBER )
RETURN VARCHAR2
IS
   out_title  department.dept_title%TYPE;    -- 부서명
BEGIN
   SELECT dept_title
   INTO out_title
   FROM employee e
       ,department d 
WHERE  e.dept_code = d.dept_id
  AND  e.emp_id = p_emp_id;         -- 사원번호(파라미터)
 
  RETURN out_title;
END;
/ 

-- SELECT 문에서 함수 실행
SELECT emp_name
      ,get_dept_title( emp_id ) 부서명
FROM employee;

-- 블록에서 함수 실행
DECLARE
     result department.dept_title%TYPE;
BEGIN
     result := get_dept_title( 204 );
     DBMS_OUTPUT.PUT_LINE(result);
END;
/

-- 함수 생성2
-- 세후 급여
CREATE OR REPLACE FUNCTION sal_tax (
    IN_SALARY IN NUMBER
)
RETURN NUMBER
IS
    tax NUMBER := 0.10;
    result NUMBER;
BEGIN
    result := TRUNC( IN_SALARY - (IN_SALARY * tax), 2);
    return result;
END;
/

SELECT emp_id, emp_name,
       salary 세전급여,
       sal_tax( salary ) 세후급여
FROM employee;

-- 매니저 사원 구분 함수 
CREATE OR REPLACE FUNCTION get_emp_type( p_emp_id NUMBER )
RETURN VARCHAR2
IS
    result VARCHAR2(10);
BEGIN
    -- 직원 타입 조회
    SELECT
        CASE
            WHEN EXISTS (SELECT 1 FROM employee WHERE manager_id = p_emp_id)
            THEN '매니저'
            ELSE '사원'
        END
    INTO result
    FROM dual;
    RETURN result;
END;
/

SELECT emp_id
      ,emp_name
      ,get_dept_title( emp_id ) 부서명
      ,get_emp_type( emp_id ) 구분
FROM employee;

