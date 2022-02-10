--ȸ�� ���̺� ����
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

--ebook ���̺� ����
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


--������ ���̺� ����
DROP TABLE manager CASCADE CONSTRAINTS;

CREATE TABLE manager(
    id  VARCHAR2(20) NOT NULL PRIMARY KEY,
    pwd VARCHAR2(20),
    name    VARCHAR2(20),
    phone   VARCHAR2(20)
);


--��ٱ��� ���̺� ����
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


--�ֹ� ���̺� ����
DROP TABLE orders CASCADE CONSTRAINTS;

CREATE TABLE orders(
    oseq    NUMBER(10)  NOT NULL PRIMARY KEY,
    id      VARCHAR2(20),
    indate  DATE    DEFAULT SYSDATE,
    FOREIGN KEY (id) REFERENCES member(id)
);

DROP SEQUENCE orders_seq;
CREATE SEQUENCE orders_seq START WITH 1 INCREMENT BY 1;


--�ֹ� �� ���̺� ����
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


-- QNA ���̺� ����
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


--�������� ���̺�
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

---------------���õ�����-----------------------

--������
insert into manager values('admin', '1234', '������', '010-1111-1111');


--�����
insert into member(id, pwd, name, email, zip_num, address, phone) values
('one', '1111', '������', '06129', '����Ư���� ������ �������96�� 16', '017-777-7777');
insert into member(id, pwd, name, zip_num, address, phone) values
('two', '2222', '�����', '06129', '����Ư���� ������ ���ﵿ 818-3', '011-123-4567');

--å
insert into product(bseq, title, category, price, content, image) values(
product_seq.nextval, 'å1', '2', '4000', 'å ����1 �Դϴ�.', 'book1.jpg');
insert into product(bseq, title, category, price, content, image, bestyn) values(
product_seq.nextval, 'å2', '2', '5000','å ����2 �Դϴ�.', 'book2.jpg', 'n');
insert into product(bseq,  title, category, price, content, image, bestyn) values( 
product_seq.nextval, 'å3', '1', '10000', 'å ����3 �Դϴ�.', 'book3.jpg', 'n');
insert into product(bseq,  title, category, price, content, image, bestyn) values(
product_seq.nextval, 'å4', '4', '1200', 'å ����4 �Դϴ�.', 'book4.jpg', 'y');
insert into product(bseq,  title, category, price, content, image, bestyn) values(
product_seq.nextval, 'å5', '1', '1500', 'å ����5 �Դϴ�.', 'book5.jpg', 'n');
insert into product(bseq,  title, category, price, content, image) values(
product_seq.nextval, 'å6', '6', '2100', 'å ����6 �Դϴ�.', 'book6.jpg');
insert into product(bseq,  title, category, price, content, image, bestyn) values(
product_seq.nextval, 'å7', '3', '5500', 'å ����7 �Դϴ�.', 'book7.jpg', 'y');
insert into product(bseq,  title, category, price, content, image, bestyn) values(
product_seq.nextval, 'å8', '3', '6000', 'å ����8 �Դϴ�.', 'book8.jpg', 'y');
insert into product(bseq,  title, category, price, content, image) values(
product_seq.nextval,  'å9', '4', '15000', 'å ����9 �Դϴ�.', 'book9.jpg');
insert into product(bseq,  title, category, price, content, image, bestyn) values(
product_seq.nextval, 'å10', '6', '3000', 'å ����10 �Դϴ�.', 'book10.jpg','n');
insert into product(bseq,  title, category, price, content, image, bestyn) values(
product_seq.nextval, 'å11', '5', '11000', 'å ����11 �Դϴ�.', 'book11.jpg','n');
insert into product(bseq,  title, category, price, content, image, bestyn) values(
product_seq.nextval, 'å12', '5', '12000', 'å ����12 �Դϴ�.', 'book11.jpg','n');

-- ��ٱ���
insert into cart(cseq, id, bseq) values(cart_seq.nextval, 'one', 1);

-- �ֹ�
insert into orders(oseq, id) values(orders_seq.nextval, 'one');
insert into orders(oseq, id) values(orders_seq.nextval, 'one');
insert into orders(oseq, id) values(orders_seq.nextval, 'two');

-- �ֹ� ��
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
values(qna_seq.nextval, '�׽�Ʈ', '��������1', 'one');
update qna SET reply='�亯����', rep='y';

insert into qna (qseq, subject, content, id)
values(qna_seq.nextval, '�׽�Ʈ2', '��������2', 'one');

-- notice
insert into qna (nseq, subject, content, id)
values(notice_seq.nextval, '����1', '�������� ����1', 'admin');
update qna SET reply='�亯����', rep='y';

insert into qna (nseq, subject, content, id)
values(notice_seq.nextval, '����2', '�������� ����2', 'admin');
commit;


--------------------------------------------------

--�����ȣ ���̺� ���� �� ������ insert
@zip;

DROP VIEW best_book_view;
--��ȸ�� �����ϰ� ��ȸ�ϱ����� ��� ����
--����Ʈ ��ǰ ��ȸ ��
CREATE OR REPLACE VIEW best_book_view AS
SELECT bseq, title, price, image
FROM (SELECT row_number() OVER(ORDER BY regdate)row_num, bseq, title, price, image
      FROM ebook
      WHERE bestyn = 'y')
WHERE row_num <= 4 ;


DROP VIEW new_book_view;
--�Ż�ǰ ��ȸ ��
CREATE OR REPLACE VIEW new_book_view AS
SELECT bseq, title, price, image
FROM (SELECT row_number() OVER(ORDER BY regdate)row_num, bseq, title, price, image
      FROM ebook
      WHERE useyn = 'y')
WHERE row_num <= 4 ;


DROP VIEW cart_view;
--��ٱ��� ���� View ����
--�ʿ��� �÷�: īƮ�Ϸù�ȣ, ȸ��id, å��ȣ, ȸ����, å����, ����, ��ٱ��� �������, ó�����
--���� ���̺�: cart, member, ebook
CREATE OR REPLACE VIEW cart_view AS
SELECT c.cseq, c.id, c.bseq, m.name, e.title,
        e.price, c.indate, c.result
FROM cart c, member m, ebook e
WHERE c.id = m.id
AND c.bseq = e.bseq
AND result = 'n';    --�ֹ� ��ó��


DROP VIEW like_view;
--���ϱ� ���� View ����
--�ʿ��� �÷� : å��ȣ, å����, ����, ����
CREATE OR REPLACE VIEW like_view AS
SELECT bseq, title, price, image
FROM (SELECT bseq, title, price, image
      FROM ebook
      WHERE likeyn = 'y');


DROP VIEW order_view;
--�ֹ� ���� ��ȸ �� : order_view
--�÷���: �ֹ��󼼹�ȣ, �ֹ���ȣ, ȸ��ID, å��ȣ, å����, ȸ����, ����, �ֹ���, ó�����
CREATE OR REPLACE VIEW order_view AS
SELECT d.odseq, o.oseq, o.id, e.bseq, e.title, m.name, e.price, o.indate, d.result
FROM orders o, order_detail d, ebook e , member m 
WHERE d.oseq = o.oseq
AND e.bseq = d.bseq
AND o.id=m.id;


--����ں� �ֹ����� ��ȸ
SELECT * FROM order_view
WHERE id='one'
AND result ='1'
AND oseq = 2;


--����ں� �ֹ���ȣ ��� ��ȸ
SELECT distinct oseq FROM order_view
WHERE id='one'
AND result = '1';


--�������� ��ǰ��� ��ȸ
SELECT bseq, regdate, title, price, useyn, bestyn
FROM    (SELECT row_number() over(ORDER BY name) rn, bseq, regdate, title, price, useyn, bestyn
        FROM ebook    
        WHERE name LIKE '%'||''||'%')
WHERE rn <= 20 AND rn > 10; 