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


--관리자 테이블 생성
DROP TABLE manager CASCADE CONSTRAINTS;

CREATE TABLE manager(
    id  VARCHAR2(20) NOT NULL PRIMARY KEY,
    pwd VARCHAR2(20),
    name    VARCHAR2(40),
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


--리뷰 테이블 생성
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
    oseq    NUMBER(10),
    bseq    NUMBER(5),
    result  CHAR(1)  DEFAULT 'n',
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
    rep     CHAR(1) DEFAULT 'n',
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
    indate     DATE DEFAULT SYSDATE
);

DROP SEQUENCE notice_seq;
CREATE SEQUENCE notice_seq START WITH 1 INCREMENT BY 1;



---------------샘플데이터-----------------------

--관리자
insert into manager values('admin', '1234', '관리자', '010-1111-1111');


--사용자
insert into member(id, pwd, name, zip_num, address, phone) values
('one', '1111', '김형주', '06129', '서울특별시 강남구 역삼동 818-3', '017-777-7777');
insert into member(id, pwd, name, zip_num, address, phone) values
('two', '2222', '김민진', '06129', '서울특별시 강남구 역삼동 818-3', '011-123-4567');

--책
insert into ebook(bseq, title, category, price_rent, price, content, image) values(
ebook_seq.nextval, '불편한 편의점', '1','2000', '12600', '편의점을 무대로 힘겨운 시대를 살아가는 우리 이웃들의 삶의 속내와 희로애락을 따뜻하고 유머러스하게 담아낸 작품', 'book1.jpg');
insert into ebook(bseq, title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '센 강의 이름 모를 여인', '1','2500', '14400','고대 그리스의 디오니소스 신화와 센 강을 배경으로 전해 내려오는 ‘데스마스크’ 이야기를 결합시킨 소재로 매우 독특하고 매혹적인 스릴러', 'book2.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values( 
ebook_seq.nextval, '밝은 밤', '1', '0', '0', '증조모에게서 시작되어 ‘나’에게로 이어지는 이야기와 ‘나’에게서 출발해 증조모로 향하며 쓰이는 이야기가 서로를 넘나들며 서서히 그 간격을 메워가는 이야기', 'book3.jpg');

insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '세븐 테크', '2','2500', '16200', '가지 테크 혁명들이 어떻게 연결되어 우리의 삶을 바꿀지 생생하게 그릴 수 있게 해준다', 'book4.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '부자 아빠 가난한 아빠', '2','2500', '14220', '유년 시절 겪은 두 아버지를 통해 가난한 사람과 부자의 사고방식을 비교', 'book5.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '돈, 뜨겁게 사랑하고 차갑게 다루어라', '2','0', '0', '투자자 코스톨라니가 넘치는 기지와 유머로 돈의 매력을 탐지하며 증권 거래와 투자심리에 중요한 변수인 투자의 근본적인 비밀과 기술을 설명', 'book6.jpg');

insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '아직 오지 않은 날들을 위하여', '3','2500', '14400', '‘나이가 들었으면 포기하라’는 건 이제 옛말이다.', 'book7.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '윤석열 X파일', '3','2500', '14400', '20대 대통령에 출마한 윤석열 후보자를 집중적으로 검증하는 책', 'book8.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval,  '벌거벗은 세계사: 사건편', '3','0', '0', 'tvN 〈벌거벗은 세계사〉가 들려준 프레임 밖의 역사적 사건들', 'book9.jpg');

insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '웰씽킹(Wealthinking)', '4','2500', '14400', '가난했던 소녀공 시절부터 글로벌 기업 회장이 되기까지, 최상위 부자 켈리 최가 말하는 진정한 부에 대한 모든 것', 'book10.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '잘 살아라 그게 최고의 복수다', '4','2500', '13500', '고민들을 갖고 힘들게 살아가는 사람들을 위해, 그 고민들을 해결하기 위한 방법들을 담은 ‘인생 공략집’이다.', 'book11.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '관계를 망치는 사람들을 위한 심리 처방전', '4','0', '0', '관계 심리학자가 알려주는 상처받은 사람이 친밀한 관계를 맺는 법', 'book12.jpg');

insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '전직 아이돌의 배우 생활', '5','2000', '11000', '멀리서 보면 희극, 가까이서 보면 비극? 다시 사는 인생은 희극이다.', 'book13.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '만능 차트로 키우는 동물병원', '5','1500', '9000', '회귀 후, 동물의 수명과 특이사항이 보이기 시작했다.', 'book14.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '추방당한 각성자는 행복을 꿈꾼다', '5','0', '0', ' 행복한 적 없던 인생. 쉽지 않은 세상이지만, 살아보려 한다.', 'book15.jpg');

insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '식사하고 가세요!', '6','1000', '8000', '미각을 잃은 요리사, 가상현실게임인 [리얼]에서 다시 요리하다!', 'book16.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '아기가 생겼어요', '6','1000', '8500', '윤리적 교육적으로 완벽한 선생님을 꿈꾸던 내가 하룻 밤의 일탈로 임신?!', 'book17.jpg');
insert into ebook(bseq,  title, category, price_rent,  price, content, image) values(
ebook_seq.nextval, '짙은', '6','0', '0', '칼잡이 지운과 목적 없이 살아가는 수한의 짙은 사랑이야기', 'book18.jpg');

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
insert into notice (nseq, subject, content)
values(notice_seq.nextval, '공지1', '공지사항 샘플1');

insert into notice (nseq, subject, content)
values(notice_seq.nextval, '공지2', '공지사항 샘플2');
commit;


--------------------------------------------------

--우편번호 테이블 생성 및 데이터 insert
@zip;

