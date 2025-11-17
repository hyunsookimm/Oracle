-- 1  계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- 계정 생성
CREATE USER joeun IDENTIFIED BY 123456;
-- 테이블 스페이스 지정
ALTER USER joeun DEFAULT TABLESPACE users;
-- 용량 설정
ALTER USER joeun QUOTA UNLIMITED ON users;
-- 권한 부여 
GRANT DBA TO joeun;

-- 2 덤프 파일 가져오기 (CMD 에서 실행)
-- 덤프 파일 import 하기 
-- imp userid=관리자계정/비밀번호 file=덤프파일경로 fromuser=덤프소유계정 touser=임포트할계정
imp userid=system/123456 file=C:\Users\tj-bu-706-22\Oracle\CODE\실습\SQL\03.덤프\joeun.dmp fromuser=joeun touser=joeun
imp userid=system/123456 file=C:\Users\tj-bu-706-22\Oracle\CODE\실습\SQL\03.덤프\joeun.dmp fromuser=joeun touser=joeun
-- 3 덤프 파일 내보내기
-- joeun 계정의 데이터를 덤프파일로 export 하기
-- exp userid=덤프할계정/123456 file'경로\덤프파일명.dmp' log='경로\로그파일명.log'
exp userid=joeun/123456 ^
file='C:\Users\tj-bu-706-22\Oracle\CODE\실습\SQL\03.덤프\joeun.dmp' ^
log='C:\Users\tj-bu-706-22\Oracle\CODE\실습\SQL\03.덤프\joeun.log'