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
    content VARCHAR2(4000),
    indate DATE DEFAULT SYSDATE,
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

ALTER TABLE order_detail ADD quantity NUMBER(5) DEFAULT 1;


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
UPDATE member SET email='abc@email.com' WHERE name='김형주';
UPDATE member SET email='test@email.com' WHERE name='김민진';
commit;

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

--리뷰
insert into review(rseq, id, bseq, rating) VALUES(review_seq.nextval,'one',1,5);

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
update qna SET reply='답변내용', rep='n';

insert into qna (qseq, subject, content, id)
values(qna_seq.nextval, '테스트2', '질문내용2', 'one');

-- notice
insert into notice (nseq, subject, content)
values(notice_seq.nextval, '공지1', '공지사항 샘플1');

insert into notice (nseq, subject, content)
values(notice_seq.nextval, '공지2', '공지사항 샘플2');

insert into review(rseq, id, bseq, rating, content) 
VALUES(review_seq.nextval, 'one', 1, 3, '너무 재밌어요!');
insert into review(rseq, id, bseq, rating, content) 
VALUES(review_seq.nextval, 'two', 1, 1, '처음엔 흥미로웠는데 뒤로갈수록 재미없어요');
insert into review(rseq, id, bseq, rating, content) 
VALUES(review_seq.nextval, 'one', 1, 4, '재미있습니다 시간가는줄모르고 봤어요');
insert into review(rseq, id, bseq, rating, content) 
VALUES(review_seq.nextval, 'two', 1,5, '가슴속에 잠자고 있던 따뜻한 감정을 일깨워 주는 감동의 소설이다. 가끔 가슴을 먹먹하게 하는 내용과 현 삶을 뒤돌아보게 하는 마력이 있는 소설이다.');
insert into review(rseq, id, bseq, rating, content) 
VALUES(review_seq.nextval, 'one', 1, 2, '재미있습니다 시간가는줄모르고 봤어요');
insert into review(rseq, id, bseq, rating, content) 
VALUES(review_seq.nextval, 'one', 1, 5, '돈값해요');
insert into review(rseq, id, bseq, rating, content) 
VALUES(review_seq.nextval, 'one', 1, 2, '왜보는지 모르겠어요');
insert into review(rseq, id, bseq, rating, content) 
VALUES(review_seq.nextval, 'one', 2, 3, '재미없어요');
insert into review(rseq, id, bseq, rating, content) 
VALUES(review_seq.nextval, 'one', 3, 3, '흥미로워요!');
commit;


--------------------------------------------------

--우편번호 테이블 생성 및 데이터 insert
@zip;

--조회시 간단하게 조회하기위해 뷰로 생성
--베스트 셀러 조회 뷰
DROP VIEW best_book_view;

CREATE OR REPLACE VIEW best_book_view AS
SELECT bseq, title,price_rent, price, image
FROM (SELECT row_number() OVER(ORDER BY regdate)row_num, bseq, title,price_rent, price, image
      FROM ebook
      WHERE bestyn = 'y')
WHERE row_num <= 4 ;


--무료 책 조회
DROP VIEW free_book_view;

CREATE OR REPLACE VIEW free_book_view AS
SELECT bseq, title,price_rent, price, image
FROM (SELECT row_number() OVER(ORDER BY regdate)row_num, bseq, title,price_rent, price, image
      FROM ebook
      WHERE price = 0 AND price_rent = 0)
WHERE row_num <= 4 ;


--장바구니 보기 View 생성
--필요한 컬럼: 카트일련번호, 회원id, 책번호, 회원명, 책제목, 가격, 장바구니 등록일자, 처리결과
--관련 테이블: cart, member, ebook
--cart 데이터 확인을 위해 insert
insert into cart(cseq, id, bseq) values(cart_seq.nextval, 'two', 3);
commit;

DROP VIEW cart_view;

CREATE OR REPLACE VIEW cart_view AS
SELECT c.cseq, c.id, c.bseq, m.name, e.title,
        e.price, c.indate, c.result
FROM cart c, member m, ebook e
WHERE c.id = m.id
AND c.bseq = e.bseq
AND result = 'n';    --주문 미처리


--찜하기 보기 View 생성
--필요한 컬럼 : 책번호, 책제목, 가격, 사진
--찜하기를 조회하기위한 update
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
--주문 내역 조회 뷰 : order_view
--컬러명: 주문상세번호, 주문번호, 회원ID, 책번호, 책제목, 회원명, 가격, 주문일, 처리결과
CREATE OR REPLACE VIEW order_view AS
SELECT d.odseq, o.oseq, o.id, e.bseq, e.title, m.name mname, d.quantity, e.price, o.indate, d.result
FROM orders o, order_detail d, ebook e , member m 
WHERE d.oseq = o.oseq
AND e.bseq = d.bseq
AND o.id=m.id;

----------------------------------------------------------------

--사용자별 주문내역 조회
SELECT * FROM order_view
WHERE id='one'
AND result ='y'
AND oseq = 2;


--사용자별 주문번호 목록 조회
SELECT distinct oseq FROM order_view
WHERE id='one'
AND result = 'y';


--페이지별 상품목록 조회
SELECT bseq, regdate, title, price, useyn, bestyn
FROM    (SELECT row_number() over(ORDER BY name) rn, bseq, regdate, title, price, useyn, bestyn
        FROM ebook    
        WHERE name LIKE '%'||''||'%')
WHERE rn <= 20 AND rn > 10; 


---------------------------------------------
--ebook테이블에 저자컬럼 추가
ALTER TABLE ebook ADD author VARCHAR2(40);
UPDATE ebook SET author='김호연' WHERE title='불편한 편의점';
UPDATE ebook SET author='기욤 뮈소' WHERE title='센 강의 이름 모를 여인';
UPDATE ebook SET author='최은영' WHERE title='밝은 밤';
UPDATE ebook SET author='김미경' WHERE title='세븐 테크';
UPDATE ebook SET author='로버트 기요사키' WHERE title='부자 아빠 가난한 아빠';
UPDATE ebook SET author='앙드레 코스톨라니' WHERE title='돈, 뜨겁게 사랑하고 차갑게 다루어라';
UPDATE ebook SET author='파스칼 브뤼크네르' WHERE title='아직 오지 않은 날들을 위하여';
UPDATE ebook SET author='열린공감TV' WHERE title='윤석열 X파일';
UPDATE ebook SET author='tvn 제작진' WHERE title='벌거벗은 세계사: 사건편';
UPDATE ebook SET author='켈리 최' WHERE title='웰씽킹(Wealthinking)';
UPDATE ebook SET author='권민창' WHERE title='잘 살아라 그게 최고의 복수다';
UPDATE ebook SET author='후션즈' WHERE title='관계를 망치는 사람들을 위한 심리 처방전';
UPDATE ebook SET author='김두루미' WHERE title='전직 아이돌의 배우 생활';
UPDATE ebook SET author='이신유' WHERE title='만능 차트로 키우는 동물병원';
UPDATE ebook SET author='제법넓은강' WHERE title='추방당한 각성자는 행복을 꿈꾼다';
UPDATE ebook SET author='인기영' WHERE title='식사하고 가세요!';
UPDATE ebook SET author='이정' WHERE title='아기가 생겼어요';
UPDATE ebook SET author='이경하' WHERE title='짙은';
commit;


-----------------------------------------------
--추가사항
alter table ebook add rseq NUMBER (10);
alter table ebook add ratingAvg NUMBER(2,1);
alter table ebook add bestyn CHAR(1) DEFAULT 'n';

-- 카테고리 별 조회
select bseq, title, author, price, price_rent, image
from ebook
group by category
having category=1;

--new_book 조회 뷰
DROP VIEW new_book_view;

CREATE OR REPLACE VIEW new_book_view AS
SELECT bseq, title, author, price, price_rent, image, ratingAvg, regdate
FROM (SELECT row_number() OVER(ORDER BY regdate)row_num, bseq, title, author, price, price_rent, image, ratingAvg, regdate
      FROM ebook
      WHERE SUBSTR(REGDATE,0,8) BETWEEN (TO_CHAR(TRUNC(SYSDATE,'MM'),'YYYYMMDD') ) AND (LAST_DAY(SYSDATE))) 
order by regdate desc;


-- 리뷰 보기 View 생성
-- 필요한 컬럼: 도서상품 번호, 리뷰 일련번호, 회원 id, 회원명, 상품명, 
-- 등록일자, 별점, 내용
-- 관련 테이블: cart, member, ebook
CREATE OR REPLACE VIEW review_view AS
SELECT e.bseq, r.rseq, m.id, m.name, e.title, r.indate, r.rating, r.content
 FROM ebook e, review r, member m
WHERE e.bseq=r.bseq  and r.id=m.id;


-- 리뷰테이블에서 별점 평균을 구해서 ebook 테이블에 별점평균 업데이트
update ebook
set ratingAvg = (select r.avg from 
(select bseq, avg(rating) as avg from review group by bseq) r where r.bseq =1)
where bseq=1;


--베스트 셀러 조회 뷰
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