DROP TABLE SCHOOL_PARENT_INFO CASCADE CONSTRAINTS;
DROP TABLE SEMESTER_GRADE CASCADE CONSTRAINTS;
DROP TABLE MOCK_TEST_GRADE CASCADE CONSTRAINTS;
DROP TABLE CLASS_DIVISION CASCADE CONSTRAINTS;
DROP TABLE TEACHER_INFO CASCADE CONSTRAINTS;
DROP TABLE CLASS_INFO CASCADE CONSTRAINTS;
DROP TABLE CA_INFO CASCADE CONSTRAINTS;
DROP TABLE DEPARTMENT_DIVISION_INFO CASCADE CONSTRAINTS;
DROP TABLE DEPARTMENT_PART_DIVISION_INFO CASCADE CONSTRAINTS;
DROP TABLE STUDENT_INFO CASCADE CONSTRAINTS;


CREATE TABLE CLASS_DIVISION
(
  DIVISION_NO NUMBER CONSTRAINT PK_DIVISION_NO PRIMARY KEY 
, DIVISION_NAME VARCHAR2(30) CONSTRAINT NN_DIVISION_NAME NOT NULL
, CONSTRAINT UK_DIVISION_NAME UNIQUE(DIVISION_NAME)
);

COMMENT ON COLUMN CLASS_DIVISION.DIVISION_NO IS '학년구분번호';
COMMENT ON COLUMN CLASS_DIVISION.DIVISION_NAME IS '구분 이름';

INSERT INTO CLASS_DIVISION VALUES (1, '1학년');
INSERT INTO CLASS_DIVISION VALUES (2, '1학년 진학반');
INSERT INTO CLASS_DIVISION VALUES (3, '2학년 문과');
INSERT INTO CLASS_DIVISION VALUES (4, '2학년 문과 진학반');
INSERT INTO CLASS_DIVISION VALUES (5, '2학년 이과');
INSERT INTO CLASS_DIVISION VALUES (6, '2학년 이과 진학반');
INSERT INTO CLASS_DIVISION VALUES (7, '3학년 문과');
INSERT INTO CLASS_DIVISION VALUES (8, '3학년 문과 진학반');
INSERT INTO CLASS_DIVISION VALUES (9, '3학년 이과');
INSERT INTO CLASS_DIVISION VALUES (10, '3학년 이과 진학반');
INSERT INTO CLASS_DIVISION VALUES (11, '졸업생');

CREATE TABLE TEACHER_INFO
(
  TEACHER_NO NUMBER CONSTRAINT PK_TEACHER_NO PRIMARY KEY
, TEACHER_NAME VARCHAR2(30) CONSTRAINT NN_TEACHER_NAME NOT NULL
, TEACHER_PHONE VARCHAR2(30) CONSTRAINT NN_TEACHER_PHONE NOT NULL
, TEACHER_YEARLY NUMBER CONSTRAINT NN_TEACHER_YEARLY NOT NULL
, TEACHER_DROP_YN VARCHAR2(3) DEFAULT 'N' CONSTRAINT NN_TEACHER_DROP_YN NOT NULL
, TEACHER_SALARY NUMBER CONSTRAINT NN_TEACHER_SALARY NOT NULL
, TEACHER_DIVISION_NO NUMBER CONSTRAINT NN_TEACHER_DIVISION_NO NOT NULL
, TEACHER_FART_DIVISION_NO NUMBER CONSTRAINT NN_TEACHER_FART_DIVISION_NO NOT NULL
, CONSTRAINT UK_TEACHER_PHONE UNIQUE (TEACHER_PHONE)
, CONSTRAINT CK_TEACHER_DROP_YN CHECK (TEACHER_DROP_YN IN ('Y','N'))
, CONSTRAINT CK_TEACHER_SALARY CHECK (TEACHER_SALARY > 0)
, CONSTRAINT FK_TEACHER_DIVISION_NO FOREIGN KEY (TEACHER_DEPARTMENT_NO)
                                    REFERENCES DEPARTMENT_PART_DIVISION_INFO 
                                    (DEPARTMENT_DIVISION_NO)
, CONSTRAINT FK_TEACHER_FART_DIVISION_NO FOREIGN KEY (TEACHER_DEPARTMENT_NO)
                                         REFERENCES DEPARTMENT_PART_DIVISION_INFO 
                                         (DEPARTMENT_PART_DIVISION_NO)                                      
);

COMMENT ON COLUMN TEACHER_INFO.TEACHER_NO IS '선생님번호';
COMMENT ON COLUMN TEACHER_INFO.TEACHER_NAME IS '선생님이름';
COMMENT ON COLUMN TEACHER_INFO.TEACHER_PHONE IS '선생님연락처';
COMMENT ON COLUMN TEACHER_INFO.TEACHER_YEARLY IS '근속년수';
COMMENT ON COLUMN TEACHER_INFO.TEACHER_DROP_YN IS '퇴직여부';
COMMENT ON COLUMN TEACHER_INFO.TEACHER_SALARY IS '선생님월급';
COMMENT ON COLUMN TEACHER_INFO.TEACHER_DIVISION_NO IS '담당과목';
COMMENT ON COLUMN TEACHER_INFO.TEACHER_FART_DIVISION_NO IS '담당상세과목';

DROP SEQUENCE SEQ_TEACHER_NO;
CREATE SEQUENCE SEQ_TEACHER_NO NOCACHE;

INSERT INTO TEACHER_INFO VALUES (SEQ_TEACHER_NO.NEXTVAL, '나큰솔', '010-7233-3385', 5, DEFAULT, 5500000, 2, 1);
INSERT INTO TEACHER_INFO VALUES (SEQ_TEACHER_NO.NEXTVAL, '김선생', '010-7233-1111', 8, DEFAULT, 8500000, 2, 3 );
INSERT INTO TEACHER_INFO VALUES (SEQ_TEACHER_NO.NEXTVAL, '나선생', '010-7233-1112', 1, DEFAULT, 1500000, 1, 1 );
INSERT INTO TEACHER_INFO VALUES (SEQ_TEACHER_NO.NEXTVAL, '다선생', '010-7233-1113', 3, DEFAULT, 3500000, 1, 4 );
INSERT INTO TEACHER_INFO VALUES (SEQ_TEACHER_NO.NEXTVAL, '마선생', '010-7233-1114', 7, DEFAULT, 7500000, 3, 6 );
INSERT INTO TEACHER_INFO VALUES (SEQ_TEACHER_NO.NEXTVAL, '바선생', '010-7233-1115', 6, DEFAULT, 6500000, 2, 7 );
INSERT INTO TEACHER_INFO VALUES (SEQ_TEACHER_NO.NEXTVAL, '사선생', '010-7233-1116', 12, DEFAULT, 12500000, 3, 2 );

CREATE TABLE CLASS_INFO
(
  CLASS_NO NUMBER 
, CLASS_DIVISION_NO NUMBER CONSTRAINT NN_CLASS_DIVISION_NO NOT NULL
, CLASS_TEACHER_NO  NUMBER CONSTRAINT NN_CLASS_TEACHER_NO NOT NULL
, CLASS_CAPACITY NUMBER CONSTRAINT NN_CLASS_CAPACITY NOT NULL
, CONSTRAINT FK_CLASS_DIVISION_NO FOREIGN KEY (CLASS_DIVISION_NO)
                                  REFERENCES CLASS_DIVISION(DIVISION_NO)
, CONSTRAINT PFK_CLASS_NO_CLASS_DIVISION_NO PRIMARY KEY(CLASS_NO, CLASS_DIVISION_NO)                                 
, CONSTRAINT FK_CLASS_TEACHER_NO FOREIGN KEY (CLASS_TEACHER_NO) 
                                 REFERENCES TEACHER_INFO(TEACHER_NO)
);

COMMENT ON COLUMN CLASS_INFO.CLASS_NO IS '반번호';
COMMENT ON COLUMN CLASS_INFO.CLASS_DIVISION_NO IS '반구분번호';
COMMENT ON COLUMN CLASS_INFO.CLASS_TEACHER_NO IS '담임교사번호';
COMMENT ON COLUMN CLASS_INFO.CLASS_CAPACITY IS '반정원';

INSERT INTO CLASS_INFO VALUES(1, 1, 1, 30);
INSERT INTO CLASS_INFO VALUES(2, 1, 2, 30);
INSERT INTO CLASS_INFO VALUES(3, 1, 3, 30);
INSERT INTO CLASS_INFO VALUES(4, 1, 4, 30);
INSERT INTO CLASS_INFO VALUES(5, 1, 5, 30);
INSERT INTO CLASS_INFO VALUES(6, 1, 6, 30);
INSERT INTO CLASS_INFO VALUES(7, 2, 7, 20);

CREATE TABLE CA_INFO
(
  CA_NO NUMBER CONSTRAINT PK_CA_NO PRIMARY KEY
, CA_NAME VARCHAR2(30) CONSTRAINT NN_CA_NAME NOT NULL
, CA_ADVISER_TEACHER_NO NUMBER CONSTRAINT NN_CA_ADVISER_TEACHER_NO NOT NULL
, CONSTRAINT UK_CA_NAME UNIQUE (CA_NAME)
, CONSTRAINT FK_CA_ADVISER_TEACHER_NO FOREIGN KEY (CA_ADVISER_TEACHER_NO)
                                      REFERENCES TEACHER_INFO(TEACHER_NO)
);

COMMENT ON COLUMN CA_INFO.CA_NO IS 'CA번호';
COMMENT ON COLUMN CA_INFO.CA_NAME IS 'CA이름';
COMMENT ON COLUMN CA_INFO.CA_ADVISER_TEACHER_NO IS 'CA담당선생님 번호';

DROP SEQUENCE SEQ_CA_NO;
CREATE SEQUENCE SEQ_CA_NO NOCACHE;

INSERT INTO CA_INFO VALUES (SEQ_CA_NO.NEXTVAL, '천체관측부', 1);
INSERT INTO CA_INFO VALUES (SEQ_CA_NO.NEXTVAL, '문예창작부', 2);
INSERT INTO CA_INFO VALUES (SEQ_CA_NO.NEXTVAL, '도서부', 3);
INSERT INTO CA_INFO VALUES (SEQ_CA_NO.NEXTVAL, '축구부', 4);
INSERT INTO CA_INFO VALUES (SEQ_CA_NO.NEXTVAL, '농구부', 5);
INSERT INTO CA_INFO VALUES (SEQ_CA_NO.NEXTVAL, '산악부', 6);
INSERT INTO CA_INFO VALUES (SEQ_CA_NO.NEXTVAL, '자율학습부', 7);



CREATE TABLE DEPARTMENT_DIVISION_INFO
(
  DEPARTMENT_DIVISION_NO NUMBER CONSTRAINT PK_DEPARTMENT_DIVISION_NO PRIMARY KEY
, DEPARTMENT_DIVISION_NAME VARCHAR2(30) CONSTRAINT NN_DEPARTMENT_DIVISION_NAME NOT NULL
, CONSTRAINT UK_DEPARTMENT_DIVISION_NAME UNIQUE (DEPARTMENT_DIVISION_NAME)
);

COMMENT ON COLUMN DEPARTMENT_DIVISION_INFO.DEPARTMENT_DIVISION_NO IS '대분류번호';
COMMENT ON COLUMN DEPARTMENT_DIVISION_INFO.DEPARTMENT_DIVISION_NAME IS '대분류이름';

INSERT INTO DEPARTMENT_DIVISION_INFO VALUES(1, '1학년 공통과목');
INSERT INTO DEPARTMENT_DIVISION_INFO VALUES(2, '2학년 공통과목');
INSERT INTO DEPARTMENT_DIVISION_INFO VALUES(3, '2학년 문과과목');
INSERT INTO DEPARTMENT_DIVISION_INFO VALUES(4, '2학년 이과과목');
INSERT INTO DEPARTMENT_DIVISION_INFO VALUES(5, '3학년 공통과목');
INSERT INTO DEPARTMENT_DIVISION_INFO VALUES(6, '3학년 문과과목');
INSERT INTO DEPARTMENT_DIVISION_INFO VALUES(7, '3학년 이과과목');

CREATE TABLE DEPARTMENT_PART_DIVISION_INFO
(
  DEPARTMENT_PART_DIVISION_NO NUMBER 
, DEPARTMENT_DIVISION_NO NUMBER
, DEPARTMENT_NAME VARCHAR2(30) CONSTRAINT NN_DEPARTMENT_NAME NOT NULL
, CONSTRAINT FK_DEPARTMENT_DIVISION_NO FOREIGN KEY (DEPARTMENT_DIVISION_NO)
                                       REFERENCES DEPARTMENT_DIVISION_INFO(DEPARTMENT_DIVISION_NO)
, CONSTRAINT PFK_DEPARTMENT_PART_DIVISION_NO_DIVISION_NO PRIMARY KEY(DEPARTMENT_PART_DIVISION_NO,DEPARTMENT_DIVISION_NO)
);

COMMENT ON COLUMN DEPARTMENT_PART_DIVISION_INFO.DEPARTMENT_PART_DIVISION_NO IS '과목소분류번호';
COMMENT ON COLUMN DEPARTMENT_PART_DIVISION_INFO.DEPARTMENT_DIVISION_NO IS '과목대분류번호';
COMMENT ON COLUMN DEPARTMENT_PART_DIVISION_INFO.DEPARTMENT_NAME IS '과목이름';

INSERT INTO DEPARTMENT_PART_DIVISION_INFO VALUES(1, 1, '국어');
INSERT INTO DEPARTMENT_PART_DIVISION_INFO VALUES(2, 1, '수학');
INSERT INTO DEPARTMENT_PART_DIVISION_INFO VALUES(3, 1, '영어');
INSERT INTO DEPARTMENT_PART_DIVISION_INFO VALUES(4, 1, '사회');
INSERT INTO DEPARTMENT_PART_DIVISION_INFO VALUES(5, 1, '과학');
INSERT INTO DEPARTMENT_PART_DIVISION_INFO VALUES(6, 1, '음악');
INSERT INTO DEPARTMENT_PART_DIVISION_INFO VALUES(7, 1, '체육');
INSERT INTO DEPARTMENT_PART_DIVISION_INFO VALUES(1, 2, '국어');
INSERT INTO DEPARTMENT_PART_DIVISION_INFO VALUES(2, 2, '수학');
INSERT INTO DEPARTMENT_PART_DIVISION_INFO VALUES(3, 2, '영어');
INSERT INTO DEPARTMENT_PART_DIVISION_INFO VALUES(4, 2, '수학');

CREATE TABLE STUDENT_INFO
(
  STUDENT_NO NUMBER CONSTRAINT PK_STUDENT_NO PRIMARY KEY
, STUDENT_CLASS_NO NUMBER CONSTRAINT NN_STUDENT_CLASS_NO NOT NULL
, STUDENT_DIVISION_NO NUMBER CONSTRAINT NN_STUDENT_DIVISION_NO NOT NULL
, STUDENT_CA_NO NUMBER
, STUDENT_NAME VARCHAR2(30) CONSTRAINT NN_STUDENT_NAME NOT NULL
, STUDENT_SSN VARCHAR2(30) CONSTRAINT NN_STUDENT_SSN NOT NULL
, STUDENT_PHONE VARCHAR2(30) CONSTRAINT NN_STUDENT_PHONE NOT NULL
, STUDENT_ADDRESS VARCHAR2(90) CONSTRAINT NN_STUDENT_ADDRESS NOT NULL
, STUDENT_GRADUATION_YN VARCHAR2(3) DEFAULT 'N' CONSTRAINT NN_STUDENT_GRADUATION_YN NOT NULL
, STUDENT_DAY_OF_ENTRANCE DATE DEFAULT SYSDATE CONSTRAINT NN_STUDENT_DAY_OF_ENTRANCE NOT NULL
, CONSTRAINT FK_STUDENT_CLASS_NO_DIVISION_NO FOREIGN KEY (STUDENT_CLASS_NO, STUDENT_DIVISION_NO)
                                             REFERENCES CLASS_INFO(CLASS_NO, CLASS_DIVISION_NO) 
, CONSTRAINT FK_STUDENT_CA_NO FOREIGN KEY (STUDENT_CA_NO)
                              REFERENCES CA_INFO(CA_NO)
, CONSTRAINT UK_STUDENT_SSN UNIQUE(STUDENT_SSN)
, CONSTRAINT UK_STUDENT_PHONE UNIQUE(STUDENT_PHONE)
, CONSTRAINT CK_STUDENT_GRADUATION_YN CHECK(STUDENT_GRADUATION_YN IN ('Y','N'))
);

COMMENT ON COLUMN STUDENT_INFO.STUDENT_NO IS '학생번호';
COMMENT ON COLUMN STUDENT_INFO.STUDENT_CLASS_NO IS '학생반번호';
COMMENT ON COLUMN STUDENT_INFO.STUDENT_DIVISION_NO IS '학생분류번호';
COMMENT ON COLUMN STUDENT_INFO.STUDENT_CA_NO IS '학생CA번호';
COMMENT ON COLUMN STUDENT_INFO.STUDENT_NAME IS '학생이름';
COMMENT ON COLUMN STUDENT_INFO.STUDENT_SSN IS '학생주민번호';
COMMENT ON COLUMN STUDENT_INFO.STUDENT_PHONE IS '학생연락처';
COMMENT ON COLUMN STUDENT_INFO.STUDENT_ADDRESS IS '학생주소';
COMMENT ON COLUMN STUDENT_INFO.STUDENT_GRADUATION_YN IS '졸업생여부';
COMMENT ON COLUMN STUDENT_INFO.STUDENT_DAY_OF_ENTRANCE IS' 입학년도';

DROP SEQUENCE SEQ_STUDENT_INFO_NO;
CREATE SEQUENCE SEQ_STUDENT_INFO_NO NOCACHE;

INSERT 
  INTO STUDENT_INFO 
VALUES 
( SEQ_STUDENT_INFO_NO.NEXTVAL, 1, 1, NULL,'김보통','910101-1010111'
, '010-3221-1234', '서울시구로구', DEFAULT, DEFAULT
);
INSERT 
  INTO STUDENT_INFO 
VALUES 
( SEQ_STUDENT_INFO_NO.NEXTVAL, 1, 1, 1,'김학생','910101-1010112'
, '010-3221-1235', '서울시구로구', DEFAULT, DEFAULT
);
INSERT 
  INTO STUDENT_INFO 
VALUES 
( SEQ_STUDENT_INFO_NO.NEXTVAL, 1, 1, 1,'나학생','910101-1010113'
, '010-3221-1236', '서울시구로구', DEFAULT, DEFAULT
);
INSERT 
  INTO STUDENT_INFO 
VALUES 
( SEQ_STUDENT_INFO_NO.NEXTVAL, 1, 1, 2,'다학생','910101-1010114'
, '010-3221-1237', '서울시구로구', DEFAULT, DEFAULT
);

CREATE TABLE SCHOOL_PARENT_INFO
(
  SP_INFO NUMBER CONSTRAINT PK_SP_INFO PRIMARY KEY
, SP_CHILD_NO NUMBER CONSTRAINT NN_SP_CHILD_NO NOT NULL
, SP_NAME VARCHAR2(30) CONSTRAINT NN_SP_NAME NOT NULL
, SP_PHONE VARCHAR2(30) CONSTRAINT NN_SP_PHONE NOT NULL
, CONSTRAINT FK_SP_SHILD_NO FOREIGN KEY (SP_CHILD_NO)
                            REFERENCES STUDENT_INFO(STUDENT_NO)
, CONSTRAINT UK_SP_PHONE UNIQUE(SP_PHONE)
);

COMMENT ON COLUMN SCHOOL_PARENT_INFO.SP_INFO IS '학부모번호';
COMMENT ON COLUMN SCHOOL_PARENT_INFO.SP_CHILD_NO IS '학생번호';
COMMENT ON COLUMN SCHOOL_PARENT_INFO.SP_NAME IS '학부모이름';
COMMENT ON COLUMN SCHOOL_PARENT_INFO.SP_PHONE IS '학부모전화번호';

INSERT INTO SCHOOL_PARENT_INFO VALUES (1, 1, '김철수', '010-2321-1264');
INSERT INTO SCHOOL_PARENT_INFO VALUES (2, 1, '김영희', '010-2321-1265');
INSERT INTO SCHOOL_PARENT_INFO VALUES (3, 2, '김철수', '010-2321-1266');
INSERT INTO SCHOOL_PARENT_INFO VALUES (4, 2, '김철수', '010-2321-1267');
INSERT INTO SCHOOL_PARENT_INFO VALUES (5, 3, '김철수', '010-2321-1268');

CREATE TABLE SEMESTER_GRADE
(
  SEMESTER_NO NUMBER CONSTRAINT PK_SEMESTER_NO PRIMARY KEY
, STUDENT_NO NUMBER CONSTRAINT NN_STUDENT_NO NOT NULL
, DEPARTMENT_PART_DIVISION_NO NUMBER CONSTRAINT NN_DEPARTMENT_PART_DIVISION_NO NOT NULL
, DEPARTMENT_DIVISION_NO NUMBER CONSTRAINT NN_DEPARTMENT_DIVISION_NO NOT NULL
, SEMESTER_TERM VARCHAR2(30) CONSTRAINT NN_SEMESTER_TERM NOT NULL
, SEMESTER_GRADE NUMBER CONSTRAINT NN_SEMESTER_GRADE NOT NULL
, SEMESTER_RATING NUMBER CONSTRAINT NN_SEMESTER_RATING NOT NULL
, CONSTRAINT FK_STUDENT_NO FOREIGN KEY (STUDENT_NO)
                           REFERENCES STUDENT_INFO(STUDENT_NO)
, CONSTRAINT FK_DEPARTMENT_PART_DIVISION_NO FOREIGN KEY (DEPARTMENT_PART_DIVISION_NO, DEPARTMENT_DIVISION_NO)
                                            REFERENCES DEPARTMENT_PART_DIVISION_INFO(DEPARTMENT_PART_DIVISION_NO, DEPARTMENT_DIVISION_NO)
);

COMMENT ON COLUMN SEMESTER_GRADE.SEMESTER_NO IS '학교성적번호';
COMMENT ON COLUMN SEMESTER_GRADE.STUDENT_NO IS '학생번호';
COMMENT ON COLUMN SEMESTER_GRADE.DEPARTMENT_PART_DIVISION_NO IS '소분류번호';
COMMENT ON COLUMN SEMESTER_GRADE.DEPARTMENT_DIVISION_NO IS '대분류번호';
COMMENT ON COLUMN SEMESTER_GRADE.SEMESTER_TERM IS '학기';
COMMENT ON COLUMN SEMESTER_GRADE.SEMESTER_GRADE IS '점수';
COMMENT ON COLUMN SEMESTER_GRADE.SEMESTER_RATING IS '등급';

DROP SEQUENCE SEQ_SEMESTER_GRADE;
CREATE SEQUENCE SEQ_SEMESTER_GRADE NOCACHE;
INSERT INTO SEMESTER_GRADE VALUES (SEQ_SEMESTER_GRADE.NEXTVAL, 1, 1, 1, '2022/01', '100', 1);

CREATE TABLE MOCK_TEST_GRADE
(
  MT_NO NUMBER CONSTRAINT PK_MT_NO PRIMARY KEY
, STUDENT_NO NUMBER CONSTRAINT NN_STUDENT_NO2 NOT NULL
, DEPARTMENT_PART_DIVISION_NO NUMBER CONSTRAINT NN_DEPARTMENT_PART_DIVISION_NO2 NOT NULL
, DEPARTMENT_DIVISION_NO NUMBER CONSTRAINT NN_DEPARTMENT_DIVISION_NO2 NOT NULL
, MT_GRADE NUMBER CONSTRAINT NN_MT_GRADE NOT NULL
, MT_TERM VARCHAR2(30) CONSTRAINT NN_MT_TERM NOT NULL
, MT_RATING NUMBER CONSTRAINT NN_MT_RATING NOT NULL
, CONSTRAINT FK_STUDENT_NO2 FOREIGN KEY (STUDENT_NO)
                           REFERENCES STUDENT_INFO(STUDENT_NO)
, CONSTRAINT FK_DEPARTMENT_PART_DIVISION_NO2 FOREIGN KEY (DEPARTMENT_PART_DIVISION_NO, DEPARTMENT_DIVISION_NO)
                                             REFERENCES DEPARTMENT_PART_DIVISION_INFO(DEPARTMENT_PART_DIVISION_NO, DEPARTMENT_DIVISION_NO)
);

COMMENT ON COLUMN MOCK_TEST_GRADE.MT_NO IS '모의고사성적번호';
COMMENT ON COLUMN MOCK_TEST_GRADE.STUDENT_NO IS '학생번호';
COMMENT ON COLUMN MOCK_TEST_GRADE.DEPARTMENT_PART_DIVISION_NO IS '소분류번호';
COMMENT ON COLUMN MOCK_TEST_GRADE.DEPARTMENT_DIVISION_NO IS '대분류번호';
COMMENT ON COLUMN MOCK_TEST_GRADE.MT_GRADE IS '성적';
COMMENT ON COLUMN MOCK_TEST_GRADE.MT_TERM IS '기간';
COMMENT ON COLUMN MOCK_TEST_GRADE.MT_RATING IS '등급';

DROP SEQUENCE SEQ_MOCK_TEST_GRADE;
CREATE SEQUENCE SEQ_MOCK_TEST_GRADE NOCACHE;

INSERT INTO MOCK_TEST_GRADE VALUES(1, 1, 1, 1, 90, '2022/01', 1);

COMMIT;