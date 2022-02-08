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