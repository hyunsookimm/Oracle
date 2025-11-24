-- 그룹별 조건에 맞는 식당 목록 출력하기
-- 테이블
-- 1.MEMBER_PROFILE
-- 2. REST_REVIEW
-- 공통 컬럼 : MEMBER_ID

-- 1단계 : 가장 많이 작성한 리뷰 수
SELECT MAX ( COUNT(*) ) 
FROM REST_REVIEW
GROUP BY MEMBER_ID
;

-- 2단계 : 리뷰를 가장 많이 작성한 회원의 MEMBER_ID
SELECT MEMBER_ID
FROM REST_REVIEW
GROUP BY MEMBER_ID
HAVING COUNT(*) = (
                    SELECT MAX ( COUNT(*) ) 
                    FROM REST_REVIEW
                    GROUP BY MEMBER_ID
                  )
;
-- 3단계 : MEMBER_PROFILE, REST_REVIEW 조인하여
--        회원이름, 리뷰텍스트,리뷰작성일 조회
--        + 리뷰를 가장 많이 작성한 회원 
SELECT M.MEMBER_NAME,
       R.REVIEW_TEXT,
       TO_CHAR( R.REVIEW_DATE, 'YYYY-MM-DD' ) REVIEW_DATE
FROM MEMBER_PROFILE
     JOIN REST_REVIEW R 
     ON M.MEMBER_ID = R.MEMBER_ID
WHERE R.MEMBER_ID IN (   -- 리뷰를 가장 많이 작성한 회원 ID
                        SELECT MEMBER_ID
                        FROM REST_REVIEW
                        GROUP BY MEMBER_ID
                        HAVING COUNT(*) = (
                                            SELECT MAX ( COUNT(*) ) 
                                            FROM REST_REVIEW
                                            GROUP BY MEMBER_ID
                                          ) -- 리뷰 최대 개수 
                      )
ORDER BY R.REVIEW_DATE ASC, R.REVIEW_TEXT ASC
;