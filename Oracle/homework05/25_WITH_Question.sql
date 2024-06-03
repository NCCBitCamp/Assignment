--1) WITH 절을 이용하여 정교수만 모여있는 가상테이블 하나와 일반과목(과목명에 일반이 포함되는)들이 모여있는 가상테이블 하나를 생성하여 
--   일반과목들을 강의하는 교수의 정보 조회하세요.(과목번호, 과목명, 교수번호, 교수이름)
WITH
	ONLYPROFFESOR AS (
		SELECT *
			FROM PROFESSOR
			WHERE ORDERS = '정교수'
	),
	NORMALCOURSE AS (
		SELECT *
			FROM COURSE
			WHERE CNAME LIKE '%일반%'
	)
SELECT NC.CNO
	 , NC.CNAME
	 , OP.PNO
	 , OP.PNAME
	FROM NORMALCOURSE NC
	JOIN ONLYPROFFESOR OP
	  ON NC.PNO = OP.PNO;

--2) WITH 절을 이용하여 급여가 3000이상인 사원정보를 갖는 가상테이블 하나와 보너스가 500이상인 사원정보를 갖는 가상테이블 하나를 생성하여
--   두 테이블에 모두 속해있는 사원의 정보를 모두 조회하세요.
WITH
	OVER3000 AS(
		SELECT *
			FROM EMP
			WHERE SAL >= 3000
	),
	OVER500 AS(
		SELECT *
			FROM EMP
			WHERE COMM >= 500
	)
SELECT OV3.ENO
	 , OV3.ENAME
	 , OV3.JOB
	 , OV3.MGR
	 , OV3.HDATE
	 , OV3.SAL
	 , OV5.COMM
	 , OV5.DNO
	FROM OVER3000 OV3
	JOIN OVER500 OV5
	  ON OV3.ENO = OV5.ENO;

--3) WITH 절을 이용하여 평점이 3.3이상인 학생의 목록을 갖는 가상테이블 하나와 학생별 기말고사 평균점수를 갖는 가상테이블 하나를 생성하여
--   평점이 3.3이상인 학생의 기말고사 평균 점수를 조회하세요.
WITH
	OVER3POINT3 AS (
		SELECT *
			FROM STUDENT
			WHERE AVR >= 3.3
	),
	AVGRESULT AS (
		SELECT SNO
			 , AVG(RESULT) AS AVG_RESULT
			FROM SCORE
			GROUP BY SNO
	)
SELECT AVGRES.AVG_RESULT
	FROM OVER3POINT3 OV3
	JOIN AVGRESULT AVGRES
	  ON OV3.SNO = AVGRES.SNO;


--4) WITH 절을 이용하여 부임일자가 25년이상된 교수정보를 갖는 가상테이블 하나와 과목번호, 과목명, 학생번호, 학생이름, 교수번호, 기말고사성적을
--   갖는 가상테이블 하나를 생성하여 기말고사 성적이 90이상인 과목번호, 과목명, 학생번호, 학생이름, 교수번호, 교수이름, 기말고사성적을 조회하세요.
WITH
	PROFESSOR25YEARS AS (
		SELECT *
			FROM PROFESSOR
			WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE) >= 300 
	),
	TOTALINFO AS (
		SELECT C.CNO
			 , C.CNAME
			 , ST.SNO
			 , ST.SNAME
			 , C.PNO
			 , SC.RESULT
			FROM COURSE C
			JOIN SCORE SC
			  ON C.CNO = SC.CNO
			JOIN STUDENT ST
			  ON ST.SNO = SC.SNO
	)
SELECT TI.CNO
	 , TI.CNAME
	 , TI.SNAME
	 , P25.PNO
	 , P25.PNAME
	 , TI.RESULT
	FROM PROFESSOR25YEARS P25
	JOIN TOTALINFO TI
	  ON P25.PNO = TI.PNO
	WHERE TI.RESULT >= 90;
	 
	 
	 