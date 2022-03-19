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
    title   VARCHAR2(100),
    category CHAR(1),
    price_rent   NUMBER(7),
    price   NUMBER(7),
    content VARCHAR2(1000) DEFAULT NULL,
    image   VARCHAR2(50),
    useyn   CHAR(1) DEFAULT 'y',
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
    name    VARCHAR2(40),
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


--���� ���̺� ����
DROP TABLE review CASCADE CONSTRAINTS;

CREATE TABLE review(
    rseq    NUMBER(10) NOT NULL PRIMARY KEY,
    id      VARCHAR2(20),
    bseq   NUMBER(5),
    rating  NUMBER(2,1),
    content VARCHAR2(4000),
    indate DATE DEFAULT SYSDATE,
    FOREIGN KEY (id) REFERENCES member(id),
    FOREIGN KEY (bseq) REFERENCES ebook(bseq)
);

DROP SEQUENCE review_seq;
CREATE SEQUENCE review_seq START WITH 1 INCREMENT BY 1;


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
    oseq    NUMBER(10),
    bseq    NUMBER(5),
    result  CHAR(1)  DEFAULT 'n',
    FOREIGN KEY (oseq) REFERENCES orders(oseq),
    FOREIGN KEY (bseq) REFERENCES ebook(bseq)
);

ALTER TABLE order_detail ADD quantity NUMBER(5) DEFAULT 1;


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
    rep     CHAR(1) DEFAULT 'n',
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
    indate     DATE DEFAULT SYSDATE
);

DROP SEQUENCE notice_seq;
CREATE SEQUENCE notice_seq START WITH 1 INCREMENT BY 1;



---------------���õ�����-----------------------

--������
insert into manager values('admin', '1234', '������', '010-1111-1111');


--�����
insert into member(id, pwd, name, zip_num, address, phone) values
('one', '1111', '������', '06129', '����Ư���� ������ ���ﵿ 818-3', '017-777-7777');
insert into member(id, pwd, name, zip_num, address, phone) values
('two', '2222', '�����', '06129', '����Ư���� ������ ���ﵿ 818-3', '011-123-4567');
UPDATE member SET email='abc@email.com' WHERE name='������';
UPDATE member SET email='test@email.com' WHERE name='�����';
commit;

--å
insert into ebook(bseq, title, category, price_rent, price, content, image) values(
ebook_seq.nextval, '������ ������', '1','2000', '12600', '�������� ����� ���ܿ� �ô븦 ��ư��� �츮 �̿����� ���� �ӳ��� ��ξֶ��� �����ϰ� ���ӷ����ϰ� ��Ƴ� ��ǰ', 'book1.jpg');
insert into ebook(bseq, title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '�� ���� �̸� �� ����', '1','2500', '14400','��� �׸����� ����ϼҽ� ��ȭ�� �� ���� ������� ���� �������� ����������ũ�� �̾߱⸦ ���ս�Ų ����� �ſ� ��Ư�ϰ� ��Ȥ���� ������', 'book2.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values( 
ebook_seq.nextval, '���� ��', '1', '0', '0', '�����𿡰Լ� ���۵Ǿ� ���������Է� �̾����� �̾߱�� ���������Լ� ����� ������� ���ϸ� ���̴� �̾߱Ⱑ ���θ� �ѳ���� ������ �� ������ �޿����� �̾߱�', 'book3.jpg');

insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '���� ��ũ', '2','2500', '16200', '���� ��ũ ������� ��� ����Ǿ� �츮�� ���� �ٲ��� �����ϰ� �׸� �� �ְ� ���ش�', 'book4.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '���� �ƺ� ������ �ƺ�', '2','2500', '14220', '���� ���� ���� �� �ƹ����� ���� ������ ����� ������ ������� ��', 'book5.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '��, �̰߰� ����ϰ� ������ �ٷ���', '2','0', '0', '������ �ڽ����ϰ� ��ġ�� ������ ���ӷ� ���� �ŷ��� Ž���ϸ� ���� �ŷ��� ���ڽɸ��� �߿��� ������ ������ �ٺ����� ��а� ����� ����', 'book6.jpg');

insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '���� ���� ���� ������ ���Ͽ�', '3','2500', '14400', '�����̰� ������� �����϶󡯴� �� ���� �����̴�.', 'book7.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '������ X����', '3','2500', '14400', '20�� ����ɿ� �⸶�� ������ �ĺ��ڸ� ���������� �����ϴ� å', 'book8.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval,  '���Ź��� �����: �����', '3','0', '0', 'tvN �����Ź��� ����硵�� ����� ������ ���� ������ ��ǵ�', 'book9.jpg');

insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '����ŷ(Wealthinking)', '4','2500', '14400', '�����ߴ� �ҳ�� �������� �۷ι� ��� ȸ���� �Ǳ����, �ֻ��� ���� �̸� �ְ� ���ϴ� ������ �ο� ���� ��� ��', 'book10.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '�� ��ƶ� �װ� �ְ��� ������', '4','2500', '13500', '��ε��� ���� ����� ��ư��� ������� ����, �� ��ε��� �ذ��ϱ� ���� ������� ���� ���λ� ���������̴�.', 'book11.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '���踦 ��ġ�� ������� ���� �ɸ� ó����', '4','0', '0', '���� �ɸ����ڰ� �˷��ִ� ��ó���� ����� ģ���� ���踦 �δ� ��', 'book12.jpg');

insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '���� ���̵��� ��� ��Ȱ', '5','2000', '11000', '�ָ��� ���� ���, �����̼� ���� ���? �ٽ� ��� �λ��� ����̴�.', 'book13.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '���� ��Ʈ�� Ű��� ��������', '5','1500', '9000', 'ȸ�� ��, ������ ����� Ư�̻����� ���̱� �����ߴ�.', 'book14.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '�߹���� �����ڴ� �ູ�� �޲۴�', '5','0', '0', ' �ູ�� �� ���� �λ�. ���� ���� ����������, ��ƺ��� �Ѵ�.', 'book15.jpg');

insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '�Ļ��ϰ� ������!', '6','1000', '8000', '�̰��� ���� �丮��, �������ǰ����� [����]���� �ٽ� �丮�ϴ�!', 'book16.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '�ƱⰡ ������', '6','1000', '8500', '������ ���������� �Ϻ��� �������� �޲ٴ� ���� �Ϸ� ���� ��Ż�� �ӽ�?!', 'book17.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '£��', '6','0', '0', 'Į���� ����� ���� ���� ��ư��� ������ £�� ����̾߱�', 'book18.jpg');

-- ��ٱ���
insert into cart(cseq, id, bseq) values(cart_seq.nextval, 'one', 1);

--����
insert into review(rseq, id, bseq, rating) VALUES(review_seq.nextval,'one',1,5);

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
update qna SET reply='�亯����', rep='n';

insert into qna (qseq, subject, content, id)
values(qna_seq.nextval, '�׽�Ʈ2', '��������2', 'one');

-- notice
insert into notice (nseq, subject, content)
values(notice_seq.nextval, '����1', '�������� ����1');

insert into notice (nseq, subject, content)
values(notice_seq.nextval, '����2', '�������� ����2');

insert into review(rseq, id, bseq, rating, content) 
VALUES(review_seq.nextval, 'one', 1, 3, '�ʹ� ��վ��!');
insert into review(rseq, id, bseq, rating, content) 
VALUES(review_seq.nextval, 'two', 1, 1, 'ó���� ��̷ο��µ� �ڷΰ����� ��̾����');
insert into review(rseq, id, bseq, rating, content) 
VALUES(review_seq.nextval, 'one', 1, 4, '����ֽ��ϴ� �ð������ٸ𸣰� �þ��');
insert into review(rseq, id, bseq, rating, content) 
VALUES(review_seq.nextval, 'two', 1,5, '�����ӿ� ���ڰ� �ִ� ������ ������ �ϱ��� �ִ� ������ �Ҽ��̴�. ���� ������ �Ը��ϰ� �ϴ� ����� �� ���� �ڵ��ƺ��� �ϴ� ������ �ִ� �Ҽ��̴�.');
insert into review(rseq, id, bseq, rating, content) 
VALUES(review_seq.nextval, 'one', 1, 2, '����ֽ��ϴ� �ð������ٸ𸣰� �þ��');
insert into review(rseq, id, bseq, rating, content) 
VALUES(review_seq.nextval, 'one', 1, 5, '�����ؿ�');
insert into review(rseq, id, bseq, rating, content) 
VALUES(review_seq.nextval, 'one', 1, 2, '�ֺ����� �𸣰ھ��');
insert into review(rseq, id, bseq, rating, content) 
VALUES(review_seq.nextval, 'one', 2, 3, '��̾����');
insert into review(rseq, id, bseq, rating, content) 
VALUES(review_seq.nextval, 'one', 3, 3, '��̷ο���!');
commit;


--------------------------------------------------

--�����ȣ ���̺� ���� �� ������ insert
@zip;

--��ȸ�� �����ϰ� ��ȸ�ϱ����� ��� ����
--����Ʈ ���� ��ȸ ��
DROP VIEW best_book_view;

CREATE OR REPLACE VIEW best_book_view AS
SELECT bseq, title,price_rent, price, image
FROM (SELECT row_number() OVER(ORDER BY regdate)row_num, bseq, title,price_rent, price, image
      FROM ebook
      WHERE bestyn = 'y')
WHERE row_num <= 4 ;


--���� å ��ȸ
DROP VIEW free_book_view;

CREATE OR REPLACE VIEW free_book_view AS
SELECT bseq, title,price_rent, price, image
FROM (SELECT row_number() OVER(ORDER BY regdate)row_num, bseq, title,price_rent, price, image
      FROM ebook
      WHERE price = 0 AND price_rent = 0)
WHERE row_num <= 4 ;


--��ٱ��� ���� View ����
--�ʿ��� �÷�: īƮ�Ϸù�ȣ, ȸ��id, å��ȣ, ȸ����, å����, ����, ��ٱ��� �������, ó�����
--���� ���̺�: cart, member, ebook
--cart ������ Ȯ���� ���� insert
insert into cart(cseq, id, bseq) values(cart_seq.nextval, 'two', 3);
commit;

DROP VIEW cart_view;

CREATE OR REPLACE VIEW cart_view AS
SELECT c.cseq, c.id, c.bseq, m.name, e.title,
        e.price, c.indate, c.result
FROM cart c, member m, ebook e
WHERE c.id = m.id
AND c.bseq = e.bseq
AND result = 'n';    --�ֹ� ��ó��


--���ϱ� ���� View ����
--�ʿ��� �÷� : å��ȣ, å����, ����, ����
--���ϱ⸦ ��ȸ�ϱ����� update
UPDATE ebook SET likeyn= 'y' WHERE bseq =6;
commit;

DROP VIEW like_view;

CREATE OR REPLACE VIEW like_view AS
SELECT bseq, title, price, image
FROM (SELECT row_number() OVER(ORDER BY regdate)row_num, bseq, title, price, image
      FROM ebook
      WHERE likeyn = 'y')
WHERE row_num <= 4 ;

DROP VIEW order_view;
--�ֹ� ���� ��ȸ �� : order_view
--�÷���: �ֹ��󼼹�ȣ, �ֹ���ȣ, ȸ��ID, å��ȣ, å����, ȸ����, ����, �ֹ���, ó�����
CREATE OR REPLACE VIEW order_view AS
SELECT d.odseq, o.oseq, o.id, e.bseq, e.title, m.name mname, d.quantity, e.price, o.indate, d.result
FROM orders o, order_detail d, ebook e , member m 
WHERE d.oseq = o.oseq
AND e.bseq = d.bseq
AND o.id=m.id;

----------------------------------------------------------------

--����ں� �ֹ����� ��ȸ
SELECT * FROM order_view
WHERE id='one'
AND result ='y'
AND oseq = 2;


--����ں� �ֹ���ȣ ��� ��ȸ
SELECT distinct oseq FROM order_view
WHERE id='one'
AND result = 'y';


--�������� ��ǰ��� ��ȸ
SELECT bseq, regdate, title, price, useyn, bestyn
FROM    (SELECT row_number() over(ORDER BY name) rn, bseq, regdate, title, price, useyn, bestyn
        FROM ebook    
        WHERE name LIKE '%'||''||'%')
WHERE rn <= 20 AND rn > 10; 


---------------------------------------------
--ebook���̺� �����÷� �߰�
ALTER TABLE ebook ADD author VARCHAR2(40);
UPDATE ebook SET author='��ȣ��' WHERE title='������ ������';
UPDATE ebook SET author='��� ����' WHERE title='�� ���� �̸� �� ����';
UPDATE ebook SET author='������' WHERE title='���� ��';
UPDATE ebook SET author='��̰�' WHERE title='���� ��ũ';
UPDATE ebook SET author='�ι�Ʈ ����Ű' WHERE title='���� �ƺ� ������ �ƺ�';
UPDATE ebook SET author='�ӵ巹 �ڽ�����' WHERE title='��, �̰߰� ����ϰ� ������ �ٷ���';
UPDATE ebook SET author='�Ľ�Į ���ũ�׸�' WHERE title='���� ���� ���� ������ ���Ͽ�';
UPDATE ebook SET author='��������TV' WHERE title='������ X����';
UPDATE ebook SET author='tvn ������' WHERE title='���Ź��� �����: �����';
UPDATE ebook SET author='�̸� ��' WHERE title='����ŷ(Wealthinking)';
UPDATE ebook SET author='�ǹ�â' WHERE title='�� ��ƶ� �װ� �ְ��� ������';
UPDATE ebook SET author='�ļ���' WHERE title='���踦 ��ġ�� ������� ���� �ɸ� ó����';
UPDATE ebook SET author='��η��' WHERE title='���� ���̵��� ��� ��Ȱ';
UPDATE ebook SET author='�̽���' WHERE title='���� ��Ʈ�� Ű��� ��������';
UPDATE ebook SET author='����������' WHERE title='�߹���� �����ڴ� �ູ�� �޲۴�';
UPDATE ebook SET author='�α⿵' WHERE title='�Ļ��ϰ� ������!';
UPDATE ebook SET author='����' WHERE title='�ƱⰡ ������';
UPDATE ebook SET author='�̰���' WHERE title='£��';
commit;


-----------------------------------------------
--�߰�����
alter table ebook add rseq NUMBER (10);
alter table ebook add ratingAvg NUMBER(2,1);
alter table ebook add bestyn CHAR(1) DEFAULT 'n';

-- ī�װ� �� ��ȸ
select bseq, title, author, price, price_rent, image
from ebook
group by category
having category=1;

--new_book ��ȸ ��
DROP VIEW new_book_view;

CREATE OR REPLACE VIEW new_book_view AS
SELECT bseq, title, author, price, price_rent, image, ratingAvg, regdate
FROM (SELECT row_number() OVER(ORDER BY regdate)row_num, bseq, title, author, price, price_rent, image, ratingAvg, regdate
      FROM ebook
      WHERE SUBSTR(REGDATE,0,8) BETWEEN (TO_CHAR(TRUNC(SYSDATE,'MM'),'YYYYMMDD') ) AND (LAST_DAY(SYSDATE))) 
order by regdate desc;


-- ���� ���� View ����
-- �ʿ��� �÷�: ������ǰ ��ȣ, ���� �Ϸù�ȣ, ȸ�� id, ȸ����, ��ǰ��, 
-- �������, ����, ����
-- ���� ���̺�: cart, member, ebook
CREATE OR REPLACE VIEW review_view AS
SELECT e.bseq, r.rseq, m.id, m.name, e.title, r.indate, r.rating, r.content
 FROM ebook e, review r, member m
WHERE e.bseq=r.bseq  and r.id=m.id;


-- �������̺��� ���� ����� ���ؼ� ebook ���̺� ������� ������Ʈ
update ebook
set ratingAvg = (select r.avg from 
(select bseq, avg(rating) as avg from review group by bseq) r where r.bseq =1)
where bseq=1;


--����Ʈ ���� ��ȸ ��
DROP VIEW best_book_view;

CREATE OR REPLACE VIEW best_book_view AS
SELECT bseq, title,price_rent, price, image
FROM (SELECT row_number() OVER(ORDER BY regdate)row_num, bseq, title,price_rent, price, image
      FROM ebook
      WHERE bestyn = 'y')
WHERE row_num <= 4 ;


--wishlist
DROP TABLE wishlist;

CREATE TABLE wishlist(
    wseq    NUMBER(10)  PRIMARY KEY,
    bseq    NUMBER(5),
    id      VARCHAR2(20), 
     FOREIGN KEY (bseq) REFERENCES ebook(bseq),
     FOREIGN KEY (id) REFERENCES member(id)
 );
    
DROP SEQUENCE wishlist_seq;
CREATE SEQUENCE wishlist_seq START WITH 1 INCREMENT BY 1;




--WISHLIST view
CREATE OR REPLACE VIEW wishlist_view AS
SELECT w.wseq, e.bseq, m.id  ,e.title, e.price
FROM wishlist w, member m, ebook e
WHERE m.id=w.id;