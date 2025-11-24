SELECT * 
FROM USER_TABLES;              -- 테이블정보 

SELECT * 
FROM USER_TAB_COLUMNS          -- 컬럼정보 
WHERE column_name LIKE '%EMPLOYEE%'
;