create database shopping;
use shopping;

/* 주문_제품 */
DROP TABLE IF EXISTS order_items;

/* 주문 */
DROP TABLE IF EXISTS orders;

/* 고객 */
DROP TABLE IF EXISTS customers;

/* 제품 */
DROP TABLE IF EXISTS products;

/* 고객 */
CREATE TABLE CUSTOMERS (
	cust_id 	 INT PRIMARY KEY, /* 고객_ID */
	cust_name 	 VARCHAR(20) NOT NULL, /* 고객_이름 */
	address 	 VARCHAR(40) NOT NULL, /* 주소 */
	postal_code  VARCHAR(10) NOT NULL, /* 우편번호 */
	cust_email 	 VARCHAR(30) NOT NULL, /* 고객_이메일주소 */
	phone_number VARCHAR(15), /* 전화번호 */
	gender 		 CHAR(1), /* 성별 */
	join_date 	 DATE NOT NULL /* 가입일 */
);

/* 제품 */
CREATE TABLE PRODUCTS (
	product_id 	 INT PRIMARY KEY, /* 제품_ID */
	product_name VARCHAR(125) NOT NULL, /* 제품_이름 */
	category	 VARCHAR(30) NOT NULL, /* 제품분류 */
	maker		 VARCHAR(50) NOT NULL, /* 제조사 */
	price		 INT NOT NULL /* 제품가격 */
);

/* 주문 */
CREATE TABLE ORDERS (
	order_id 	 INT PRIMARY KEY, /* 주문_ID */
	order_date 	 DATE NOT NULL, /* 주문일 */
	cust_id 	 INT NOT NULL, /* 고객_ID */
	order_status VARCHAR(20) NOT NULL, /* 주문상태 */
	order_total  INT, /* 주문 총금액 */
    CONSTRAINT fk_order_customer FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
);


/* 주문_제품 */
CREATE TABLE ORDER_ITEMS (
	order_item_id 	INT PRIMARY KEY, /* 주문상세_ID */
	sell_price 		INT NOT NULL, /* 판매가격 */
	quantity 		INT NOT NULL, /* 수량 */
	product_id 		INT, /* 제품_ID */
	order_id 		INT, /* 주문_ID */
    CONSTRAINT fk_order_items_products FOREIGN KEY (product_id) REFERENCES products(product_id),
    CONSTRAINT fk_order_items_orders FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

        
/*customers*/       
INSERT INTO customers VALUES(100, '김고객', '서울시 종로구 동숭동', '03084', 'kys@abc.com', '010-3232-5423', 'M', '2010/10/22');
INSERT INTO customers VALUES(110, '이고객', '서울시 강남구 논현동', '06038', 'ljh@abc.com', '010-7623-1328', 'F', '2011/11/02');
INSERT INTO customers VALUES(120, '박고객', '경기도 광명시 광명동', '14204', 'lhj@abc.com', '010-3232-5423', 'M', '2016/03/07');
INSERT INTO customers VALUES(130, '장고객', '경기도 군포시 광정동', '15843', 'oym@abc.com', '010-939-2000', 'F', '2014/08/22');
INSERT INTO customers VALUES(140, '주고객', '서울시 노원구 공릉동', '01796', 'jjy@abc.com', '010-510-5500', 'F', '2010/02/12');
INSERT INTO customers VALUES(150, '최고객', '경상남도 거제시 거제면', '53285', 'cmr@abc.com', '010-3258-6800', 'F', '2011/10/21');
INSERT INTO customers VALUES(160, '오고객', '전라북도 남원시 금동', '55769', 'kwj@abc.com', '010-9832-5522', 'M', '2009/06/28');
INSERT INTO customers VALUES(170, '우고객', '서울시 광진구 광장동', '04965', 'bsp@abc.com', '010-3001-1177', 'M', '2004/05/03');
INSERT INTO customers VALUES(180, '조고객', '서울시 구로구 고척동', '08240', 'luj@abc.com', '010-4123-9876', 'M', '2002/05/29');

/*products*/
INSERT INTO products VALUES(200, '모카골드', '커피', '동서식품', 20000);
INSERT INTO products VALUES(210, '프랜치카페', '커피', '남양유업', 20000);
INSERT INTO products VALUES(220, '카누', '커피', '동서식품', 18000);
INSERT INTO products VALUES(230, '맥스웰 하우스', '커피', '동서식품', 10000);
INSERT INTO products VALUES(300, '복숭아 홍차', '차', '담터', 9000);
INSERT INTO products VALUES(310, '얼그레이', '차', '트와이닝', 15000);
INSERT INTO products VALUES(320, '율무차', '차', '다농원', 13000);
INSERT INTO products VALUES(400, '마카다미아 쇼콜라', '초콜렛', '삼광식품', 10000);
INSERT INTO products VALUES(410, 'ABC 초콜렛', '초콜렛', '롯데', 15000);
INSERT INTO products VALUES(420, '킨더 조이 보이', '초콜렛', '킨더', 1000);
INSERT INTO products VALUES(430, '오레오', '쿠키', '동서식품', 2000);
INSERT INTO products VALUES(440, '촉촉한 초코칩', '쿠키', '오리온', 3000);     
INSERT INTO products VALUES(510, '월드콘', '아이스크림', '롯데', 1200);     
INSERT INTO products VALUES(520, '브라보콘', '아이스크림', '해태', 1200);     

/*orders*/
INSERT INTO orders VALUES(1, '2017/10/10', 110, '구매확정', 77500);
INSERT INTO orders VALUES(2, '2017/10/10', 120, '구매확정', 140000);
INSERT INTO orders VALUES(3, '2017/10/10', 170, '구매확정', 122000);
INSERT INTO orders VALUES(4, '2017/10/15', 110, '구매확정', 54750);
INSERT INTO orders VALUES(5, '2017/10/17', 110, '구매확정', 53000);
INSERT INTO orders VALUES(6, '2017/11/03', 120, '구매확정', 96000);
INSERT INTO orders VALUES(7, '2017/11/08', 140, '구매확정', 54750);
INSERT INTO orders VALUES(8, '2017/11/13', 130, '구매확정', 53000);
INSERT INTO orders VALUES(9, '2017/11/13', 180, '구매확정', 20000);

/*order_items*/
INSERT INTO order_items VALUES(1, 8000, 5, 300, 1);
INSERT INTO order_items VALUES(2, 15000, 2, 410, 1);
INSERT INTO order_items VALUES(3, 2500, 3, 440, 1);
INSERT INTO order_items VALUES(4, 14000, 10, 310, 2);
INSERT INTO order_items VALUES(5, 19000, 2, 210, 3);
INSERT INTO order_items VALUES(6, 15000, 5, 410, 3);
INSERT INTO order_items VALUES(7, 3000, 10, 440, 3);

INSERT INTO order_items VALUES(8, 990, 25, 420, 4);
INSERT INTO order_items VALUES(9, 3000, 10, 440, 4);

INSERT INTO order_items VALUES(10, 19000, 1, 200, 5);
INSERT INTO order_items VALUES(11, 9000, 1, 300, 5);
INSERT INTO order_items VALUES(12, 12500, 2, 320, 5);

INSERT INTO order_items VALUES(13, 20000, 3, 200, 6);
INSERT INTO order_items VALUES(14, 18000, 2, 220, 6);

INSERT INTO order_items VALUES(15, 990, 25, 420, 7);
INSERT INTO order_items VALUES(16, 3000, 10, 440, 7);

INSERT INTO order_items VALUES(17, 19000, 1, 200, 8);
INSERT INTO order_items VALUES(18, 9000, 1, 300, 8);
INSERT INTO order_items VALUES(19, 12500, 2, 320, 8);

INSERT INTO order_items VALUES(20, 20000, 1, 200, 9);


COMMIT;