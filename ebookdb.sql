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
insert into notice (nseq, subject, content)
values(notice_seq.nextval, '����1', '�������� ����1');

insert into notice (nseq, subject, content)
values(notice_seq.nextval, '����2', '�������� ����2');
commit;


--------------------------------------------------

--�����ȣ ���̺� ���� �� ������ insert
@zip;

