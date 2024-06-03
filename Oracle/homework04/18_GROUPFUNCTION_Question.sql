--1) 화학과를 제외하고 학과별로 학생들의 평점 평균을 검색하세요
SELECT MAJOR
	 , AVG(AVR)
	FROM STUDENT
	GROUP BY MAJOR
	HAVING MAJOR != '화학';

--2) 화학과를 제외한 각 학과별 평균 평점 중에 평점이 2.0 이상인 정보를 검색하세요
SELECT MAJOR
	 , AVG(AVR)
	FROM STUDENT
	GROUP BY MAJOR
	HAVING AVG(AVR) >= 2.0
	   AND MAJOR != '화학';

--3) 기말고사 평균이 60점 이상인 학생의 정보를 검색하세요
SELECT A.SNO
	 , A.SNAME
	 , ST.SEX
	 , ST.SYEAR 
	 , ST.MAJOR 
	 , ST.AVR 
	 , A.AVG_RESULT
	FROM STUDENT ST
	JOIN (
		SELECT ST2.SNO
			 , ST2.SNAME
			 , AVG(SC.RESULT) AS AVG_RESULT
			FROM STUDENT ST2
			JOIN SCORE SC
			  ON ST2.SNO = SC.SNO
			GROUP BY ST2.SNO, ST2.SNAME
			HAVING AVG(SC.RESULT) >= 60
	) A
	ON ST.SNO = A.SNO;

--4) 강의 학점이 3학점 이상인 교수의 정보를 검색하세요
SELECT P.*
	FROM COURSE C
	JOIN PROFESSOR P
	  ON C.PNO = P.PNO
	WHERE C.ST_NUM >= 3;

--5) 기말고사 평균 성적이 핵 화학과목보다 우수한 과목의 과목명과 담당 교수명을 검색하세요
SELECT C.CNAME
	 , P.PNAME
	 , A.AVG_RESULT
	FROM COURSE C
	JOIN (
		SELECT C2.CNAME
			 , AVG(SC.RESULT) AS AVG_RESULT
			FROM COURSE C2
			JOIN SCORE SC
			  ON C2.CNO = SC.CNO
			GROUP BY C2.CNAME
			HAVING AVG(SC.RESULT) > (
									 SELECT AVG(SC2.RESULT)
									 FROM COURSE C3
									 JOIN SCORE SC2
			  						   ON C3.CNO = SC2.CNO
			  						 GROUP BY C3.CNAME
			  						 HAVING C3.CNAME = '핵화학'
			)
	)A
	  ON C.CNAME = A.CNAME
	JOIN PROFESSOR P
	  ON C.PNO = P.PNO;
	 
	
--6) 근무 중인 직원이 4명 이상인 부서를 검색하세요(부서번호, 부서명, 인원수)
SELECT D.DNO
	 , D.DNAME
	 , COUNT(*)
	FROM DEPT D
	JOIN EMP E
	  ON D.DNO = E.DNO
	GROUP BY D.DNO, D.DNAME
	HAVING COUNT(*) >= 4;

--7) 업무별 평균 연봉이 3000 이상인 업무를 검색하세요
SELECT JOB
	 , AVG(SAL)
	FROM EMP
	GROUP BY JOB
	HAVING AVG(SAL) >= 3000;

--8) 각 학과의 학년별 인원중 인원이 5명 이상인 학년을 검색하세요
SELECT MAJOR
	 , SYEAR
	 , COUNT(*)
	FROM STUDENT
	GROUP BY MAJOR, SYEAR
	HAVING COUNT(*) >= 5; 



