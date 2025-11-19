-- CONNECT BY 
SELECT LEVEL
    , employee_id
    , first_name
    , last_name
    , job_id
    , manager_id
FROM employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id;

-- 대댓글 예시
CREATE TABLE comments (
  comment_id NUMBER NOT NULL,
  board_no NUMBER NOT NULL,
  parent_comment_id NUMBER,
  writer VARCHAR2(100) NOT NULL,
  content VARCHAR2(1000) NOT NULL,
  reg_date DATE DEFAULT sysdate NOT NULL,
  PRIMARY KEY (comment_id),
  FOREIGN KEY (parent_comment_id) REFERENCES comments(comment_id)
);

-- 샘플 데이터
INSERT INTO comments (comment_id, board_no, parent_comment_id, writer, content) VALUES (1, 1, NULL, '사용자1', '첫 번째 댓글입니다.');
INSERT INTO comments (comment_id, board_no, parent_comment_id, writer, content) VALUES (2, 1, 1, '사용자2', '첫 번째 댓글에 대한 대댓글입니다.');
INSERT INTO comments (comment_id, board_no, parent_comment_id, writer, content) VALUES (3, 1, 1, '사용자3', '첫 번째 댓글에 대한 또 다른 대댓글입니다.');
INSERT INTO comments (comment_id, board_no, parent_comment_id, writer, content) VALUES (4, 1, 2, '사용자4', '대댓글에 대한 대댓글입니다.');
INSERT INTO comments (comment_id, board_no, parent_comment_id, writer, content) VALUES (5, 1, NULL, '사용자5', '두 번째 댓글입니다.');
INSERT INTO comments (comment_id, board_no, parent_comment_id, writer, content) VALUES (6, 1, 5, '사용자6', '두 번째 댓글에 대한 대댓글입니다.');
INSERT INTO comments (comment_id, board_no, parent_comment_id, writer, content) VALUES (7, 1, NULL, '사용자7', '세 번째 댓글입니다.');
INSERT INTO comments (comment_id, board_no, parent_comment_id, writer, content) VALUES (8, 1, 3, '사용자8', '첫 번째 댓글의 대댓글에 대한 답글입니다.');

-- 대댓글 조회 
SELECT LEVEL,
       LPAD(' ', (LEVEL-1)*4) || writer AS writer,
       comment_id,
       parent_comment_id,
       content,
       reg_date
FROM comments
WHERE board_no = 1
START WITH parent_comment_id IS NULL
CONNECT BY PRIOR comment_id = parent_comment_id
ORDER SIBLINGS BY comment_id;

-- SYS_CONNECT_BY_PATH
SELECT LEVEL,
       comment_id,
       parent_comment_id,
       writer,
       content,
       SYS_CONNECT_BY_PATH(writer, ' → ') AS path
FROM comments
WHERE board_no = 1
START WITH parent_comment_id IS NULL
CONNECT BY PRIOR comment_id = parent_comment_id
ORDER SIBLINGS BY comment_id;

-- CONNECT_BY_ROOT 
SELECT LEVEL,
       comment_id,
       parent_comment_id,
       writer,
       content,
       CONNECT_BY_ROOT comment_id AS root_comment_id,
       CONNECT_BY_ROOT writer AS root_writer
FROM comments
WHERE board_no = 1
START WITH parent_comment_id IS NULL
CONNECT BY PRIOR comment_id = parent_comment_id
ORDER SIBLINGS BY comment_id;

-- CONNECT_BY_ISLEAF
SELECT LEVEL,
       comment_id,
       parent_comment_id,
       writer,
       content,
       CONNECT_BY_ISLEAF AS is_leaf
FROM comments
WHERE board_no = 1
START WITH parent_comment_id IS NULL
CONNECT BY PRIOR comment_id = parent_comment_id
ORDER SIBLINGS BY comment_id;
