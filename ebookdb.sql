--회원 테이블 생성
DROP TABLE member CASCADE CONSTRAINTS;

CREATE TABLE member(
    id      VARCHAR2(20) NOT NULL PRIMARY KEY,
    pwd     VARCHAR2(20),
    name    VARCHAR2(40),
    email    VARCHAR2(40),
    zip_num VARCHAR2(7),
    address VARCHAR2(100),
    phone   VARCHAR2(20),
    useyn   CHAR(1) DEFAULT 'y',
    regdate DATE DEFAULT SYSDATE
);

--ebook 테이블 생성
DROP TABLE ebook CASCADE CONSTRAINTS;

CREATE TABLE ebook(
    bseq    NUMBER(5)   NOT NULL PRIMARY KEY,
    title   VARCHAR2(20),
    category CHAR(1),
    price   NUMBER(7),
    content VARCHAR2(1000) DEFAULT NULL,
    image   VARCHAR2(50),
    useyn   CHAR(1) DEFAULT 'y',
    bestyn  CHAR(1) DEFAULT 'n',
    likeyn  CHAR(1) DEFAULT 'n',
    regdate DATE DEFAULT SYSDATE
);

DROP SEQUENCE ebook_seq;
CREATE SEQUENCE ebook_seq START WITH 1 INCREMENT BY 1;


--관리자 테이블 생성
DROP TABLE manager CASCADE CONSTRAINTS;

CREATE TABLE manager(
    id  VARCHAR2(20) NOT NULL PRIMARY KEY,
    pwd VARCHAR2(20),
    name    VARCHAR2(20),
    phone   VARCHAR2(20)
);


--장바구니 테이블 생성
DROP TABLE cart CASCADE CONSTRAINTS;

CREATE TABLE cart(
    cseq    NUMBER(10)  NOT NULL PRIMARY KEY,
    id      VARCHAR2(20),
    bseq    NUMBER(5),
    result  CHAR(1) DEFAULT 'n',
    indate  DATE  DEFAULT SYSDATE,
    FOREIGN KEY (id) REFERENCES member(id),
    FOREIGN KEY (bseq) REFERENCES ebook(bseq)
);

DROP SEQUENCE cart_seq;
CREATE SEQUENCE cart_seq START WITH 1 INCREMENT BY 1;


--주문 테이블 생성
DROP TABLE orders CASCADE CONSTRAINTS;

CREATE TABLE orders(
    oseq    NUMBER(10)  NOT NULL PRIMARY KEY,
    id      VARCHAR2(20),
    indate  DATE    DEFAULT SYSDATE,
    FOREIGN KEY (id) REFERENCES member(id)
);

DROP SEQUENCE orders_seq;
CREATE SEQUENCE orders_seq START WITH 1 INCREMENT BY 1;


--주문 상세 테이블 생성
DROP TABLE order_detail;

CREATE TABLE order_detail(
    odseq   NUMBER(10) NOT NULL PRIMARY KEY,
    oseq    NUMBER(10)  ,
    bseq    NUMBER(10),
    result  DEFAULT 'n',
    FOREIGN KEY (oseq) REFERENCES orders(oseq),
    FOREIGN KEY (bseq) REFERENCES ebook(bseq)
);

DROP SEQUENCE order_detail_seq;
CREATE SEQUENCE order_detail_seq START WITH 1 INCREMENT BY 1;


-- QNA 테이블 생성
DROP TABLE qna;

CREATE TABLE qna(
    qseq    NUMBER(5) NOT NULL PRIMARY KEY,
    subject VARCHAR2(30), 
    content VARCHAR2(1000), 
    reply   VARCHAR2(1000), 
    id      VARCHAR2(20), 
    rep     CHAR(1) DEFAULT "n",
    indate  DATE DEFAULT SYSDATE,
    FOREIGN KEY (id) REFERENCES member(id)
);

DROP SEQUENCE qna_seq;
CREATE SEQUENCE qna_seq START WITH 1 INCREMENT BY 1;


--공지사항 테이블
DROP TABLE notice;

CREATE TABLE notice(
    nseq       NUMBER(5)  NOT NULL PRIMARY KEY,
    subject    VARCHAR2(30),
    content    VARCHAR2(1000),
    id      VARCHAR2(20), 
    indate     DATE DEFAULT SYSDATE,
    FOREIGN KEY (id) REFERENCES manager(id)
);

DROP SEQUENCE notice_seq;
CREATE SEQUENCE notice_seq START WITH 1 INCREMENT BY 1;