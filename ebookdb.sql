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

---------------샘플데이터-----------------------

--관리자
insert into manager values('admin', '1234', '관리자', '010-1111-1111');


--사용자
insert into member(id, pwd, name, email, zip_num, address, phone) values
('one', '1111', '김형주', '06129', '서울특별시 강남구 강남대로96길 16', '017-777-7777');
insert into member(id, pwd, name, zip_num, address, phone) values
('two', '2222', '김민진', '06129', '서울특별시 강남구 역삼동 818-3', '011-123-4567');

--책
insert into product(bseq, title, category, price, content, image) values(
product_seq.nextval, '책1', '2', '4000', '책 샘플1 입니다.', 'book1.jpg');
insert into product(bseq, title, category, price, content, image, bestyn) values(
product_seq.nextval, '책2', '2', '5000','책 샘플2 입니다.', 'book2.jpg', 'n');
insert into product(bseq,  title, category, price, content, image, bestyn) values( 
product_seq.nextval, '책3', '1', '10000', '책 샘플3 입니다.', 'book3.jpg', 'n');
insert into product(bseq,  title, category, price, content, image, bestyn) values(
product_seq.nextval, '책4', '4', '1200', '책 샘플4 입니다.', 'book4.jpg', 'y');
insert into product(bseq,  title, category, price, content, image, bestyn) values(
product_seq.nextval, '책5', '1', '1500', '책 샘플5 입니다.', 'book5.jpg', 'n');
insert into product(bseq,  title, category, price, content, image) values(
product_seq.nextval, '책6', '6', '2100', '책 샘플6 입니다.', 'book6.jpg');
insert into product(bseq,  title, category, price, content, image, bestyn) values(
product_seq.nextval, '책7', '3', '5500', '책 샘플7 입니다.', 'book7.jpg', 'y');
insert into product(bseq,  title, category, price, content, image, bestyn) values(
product_seq.nextval, '책8', '3', '6000', '책 샘플8 입니다.', 'book8.jpg', 'y');
insert into product(bseq,  title, category, price, content, image) values(
product_seq.nextval,  '책9', '4', '15000', '책 샘플9 입니다.', 'book9.jpg');
insert into product(bseq,  title, category, price, content, image, bestyn) values(
product_seq.nextval, '책10', '6', '3000', '책 샘플10 입니다.', 'book10.jpg','n');
insert into product(bseq,  title, category, price, content, image, bestyn) values(
product_seq.nextval, '책11', '5', '11000', '책 샘플11 입니다.', 'book11.jpg','n');
insert into product(bseq,  title, category, price, content, image, bestyn) values(
product_seq.nextval, '책12', '5', '12000', '책 샘플12 입니다.', 'book11.jpg','n');

-- 장바구니
insert into cart(cseq, id, bseq) values(cart_seq.nextval, 'one', 1);

-- 주문
insert into orders(oseq, id) values(orders_seq.nextval, 'one');
insert into orders(oseq, id) values(orders_seq.nextval, 'one');
insert into orders(oseq, id) values(orders_seq.nextval, 'two');

-- 주문 상세
insert into order_detail(odseq, oseq, bseq) 
values(order_detail_seq.nextval, 1, 1);
insert into order_detail(odseq, oseq, bseq) 
values(order_detail_seq.nextval, 1, 2);
insert into order_detail(odseq, oseq, bseq) 
values(order_detail_seq.nextval, 2,  4);
insert into order_detail(odseq, oseq, bseq) 
values(order_detail_seq.nextval, 3, 3);
insert into order_detail(odseq, oseq, bseq) 
values(order_detail_seq.nextval, 3, 2);
insert into order_detail(odseq, oseq, bseq) 
values(order_detail_seq.nextval, 3, 6);
insert into order_detail(odseq, oseq, bseq) 
values(order_detail_seq.nextval, 3, 1);

-- QnA
insert into qna (qseq, subject, content, id)
values(qna_seq.nextval, '테스트', '질문내용1', 'one');
update qna SET reply='답변내용', rep='y';

insert into qna (qseq, subject, content, id)
values(qna_seq.nextval, '테스트2', '질문내용2', 'one');

-- notice
insert into qna (nseq, subject, content, id)
values(notice_seq.nextval, '공지1', '공지사항 샘플1', 'admin');
update qna SET reply='답변내용', rep='y';

insert into qna (nseq, subject, content, id)
values(notice_seq.nextval, '공지2', '공지사항 샘플2', 'admin');
commit;


--------------------------------------------------