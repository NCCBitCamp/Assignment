--1) 전공과 전공별 기말고사 평균 점수를 갖는 테이블
--   T_MAJOR_AVG_RES를 생성하고 SCORE테이블과 STUDENT테이블을 참조해서
--   T_MAJOR_AVG_RES에 데이터를 저장하는 프로시저 P_MAJOR_AVG_RES를 생성하세요.

CREATE TABLE T_MAJOR_AVG_RES( -- 빈테이블로 만들어야 저장가능
    MAJOR VARCHAR2(20),
    AVG_R NUMBER(5, 2)
);

CREATE OR REPLACE PROCEDURE P_MAJOR_AVG_RES
IS
    CURSOR CS IS
        SELECT ST.MAJOR
             , ROUND(AVG(S.RESULT), 2) AS AVG_R
             FROM SCORE S
             JOIN STUDENT ST
               ON S.SNO = ST.SNO
            GROUP BY ST.MAJOR;
BEGIN
    FOR ROW IN CS LOOP
        INSERT INTO T_MAJOR_AVG_RES -- 이 테이블에 저장!
        VALUES ROW; -- 데이터는 커서에 있는 로우 (?) 맞나?
    END LOOP;
END;
/

EXEC P_MAJOR_AVG_RES; --PROCEDURE 실행

SELECT * -- PROCEDURE로 저장이 되는지 조회
    FROM T_MAJOR_AVG_RES;
    
--2) 교수들은 부임일로부터 5년마다 안식년을 갖습니다.
--   교수들의 오늘날짜까지의 안식년 횟수를 리턴하는 함수 F_GET_VACATION_CNT를 구현하세요.
CREATE OR REPLACE FUNCTION F_GET_VACATION_CNT(VD DATE)
RETURN NUMBER
IS          -- 필요없어짐 VDCNT NUMBER; -- 안식년 횟수 값을 받아줄 변수
BEGIN
    RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, VD) / 60, 0);
END;
/

SELECT PNAME -- 리턴식 참고
     , TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE) / 60, 0)
     FROM PROFESSOR;
    