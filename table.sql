
CREATE TABLE role (
	role_id int ,
    name varchar(20) NOT NULL,
    PRIMARY KEY (role_id)
);
CREATE TABLE category(
    category_id int ,
    category_name varchar(50) NOT NULL,
    description varchar(500),
    PRIMARY KEY (category_id)
);
CREATE TABLE feedback (
	feedback_id int ,
    user_id int NOT NULL,
    subject_name varchar(50),
    note varchar(500), 
    PRIMARY KEY (feedback_id)
);
CREATE TABLE rate (
	rate_id int , 
    product_id int  NOT NULL,
    star int  NOT NULL CHECK (star > 0 and star <= 5),
    note varchar(500),
    PRIMARY KEY (rate_id)  
);
CREATE TABLE users (
	user_id int,
    first_name varchar(20),
    last_name varchar(20),
    email varchar(100),
    phone_number varchar(20) NOT NULL,
    address varchar(100) NOT NULL,
    u_password varchar(50) NOT NULL,
    role_id	int NOT NULL,
    created_at time, 
    updated_at time, 
    PRIMARY KEY (user_id)
);
CREATE TABLE product (
	product_id int  ,
    category_id int NOT NULL,
    name varchar(50),
    price int DEFAULT 0,
    thumnail varchar(500),
    description varchar(500),
    created_at time,
    update_at time,
    rate_star numeric(2,1),
    PRIMARY KEY (product_id)
);
CREATE TABLE cart (
	cart_id int NOT NULL,
    product_id int NOT NULL,
    pieces int NOT NULL,
    money int,
	order_detail_id int not null,
    PRIMARY KEY (cart_id, product_id)
   

);
CREATE TABLE order_detail (
	order_detail_id int ,
    first_name varchar(20),
    last_name varchar(20),
    adress varchar(100),
    phone_number varchar(20),
    total_money int,
    time_order time,
	status_name varchar(20),
    PRIMARY KEY (order_detail_id)
);
CREATE TABLE orders (
	order_id int ,
    status_id int, 
    order_detail_id int NOT NULL,
    user_id int NOT NULL,
    note varchar(500),
    PRIMARY KEY (order_id)
);
ALTER TABLE "users" ADD FOREIGN KEY ("role_id") REFERENCES "role" ("role_id");

ALTER TABLE "rate" ADD FOREIGN KEY ("product_id") REFERENCES "product" ("product_id");

ALTER TABLE "product" ADD FOREIGN KEY ("category_id") REFERENCES "category" ("category_id");

ALTER TABLE "feedback" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "cart" ADD FOREIGN KEY ("product_id") REFERENCES "product" ("product_id");

ALTER TABLE "orders" ADD FOREIGN KEY ("order_detail_id") REFERENCES "order_detail" ("order_detail_id");

ALTER TABLE "orders" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "cart" ADD FOREIGN KEY ("order_detail_id") REFERENCES "order_detail" ("order_detail_id");

-- thêm dữ liệu vào bảng 

-- Thêm dữ liệu cho bảng role
INSERT INTO role (role_id, name)
VALUES (1, 'Admin'),
       (2, 'User'),
       (3, 'Guest');

-- Thêm dữ liệu cho bảng category
INSERT INTO category (category_id, category_name, description)
VALUES (1, 'Electronics', 'Electronic products'),
       (2, 'Clothing & Accessories', 'Clothing and fashion accessories'),
       (3, 'Home & Kitchen', 'Home and kitchen appliances'),
       (4, 'Health & Beauty', 'Health and beauty products'),
       (5, 'Toys & Games', 'Toys and games');

-- Thêm dữ liệu cho bảng users
INSERT INTO users (user_id, first_name, last_name, email, phone_number, address, u_password, role_id)
VALUES (1, 'John', 'Doe', 'john@example.com', '123456789', '123 Main St', 'password123', 2),
       (2, 'Jane', 'Smith', 'jane@example.com', '987654321', '456 Elm St', 'password456', 2);

-- Thêm dữ liệu cho bảng product
INSERT INTO product (product_id, category_id, title, price, thumnail, description)
VALUES (1, 1, 'Smartphone', 1000, 'smartphone.jpg', 'High-quality smartphone'),
       (2, 1, 'Laptop', 1500, 'laptop.jpg', 'Powerful laptop'),
       (3, 2, 'T-Shirt', 20, 'tshirt.jpg', 'Comfortable t-shirt'),
       (4, 2, 'Jeans', 50, 'jeans.jpg', 'Stylish jeans');
	   
-- Thêm dữ liệu cho bảng order_detail
INSERT INTO order_detail (order_detail_id, first_name, last_name, adress, phone_number, total_money, time_order)
VALUES (1, 'John', 'Doe', '123 Main St', '123456789', 3500, CURRENT_TIME),
       (2, 'Jane', 'Smith', '456 Elm St', '987654321', 60, CURRENT_TIME);

-- Thêm dữ liệu cho bảng cart
INSERT INTO cart (cart_id, product_id, pieces, money, order_detail_id)
VALUES (1, 1, 2, 2000, 1),
       (1, 2, 1, 1500, 1),
       (2, 3, 3, 60, 2);

-- Thêm dữ liệu cho bảng orders
INSERT INTO orders (order_id, status_id, order_detail_id, user_id, note)
VALUES (1, 1, 1, 1, 'Order placed successfully'),
       (2, 2, 2, 2, 'Order processing');

-- Thêm dữ liệu cho bảng feedback
INSERT INTO feedback (feedback_id, user_id, subject_name, note)
VALUES (1, 1, 'Product Quality', 'The product quality is excellent'),
       (2, 2, 'Shipping Delay', 'The shipping was delayed');

-- Thêm dữ liệu cho bảng rate
INSERT INTO rate (rate_id, product_id, star, note)
VALUES (1, 1, 4, 'Great product'),
       (2, 2, 5, 'Excellent laptop');

-- Thêm dữ liệu cho bảng order_detail (tiếp tục từ bước trước)
INSERT INTO order_detail (order_detail_id, first_name, last_name, adress, phone_number, total_money, time_order)
VALUES (3, 'John', 'Doe', '789 Oak St', '555123456', 500, CURRENT_TIME),
       (4, 'Jane', 'Smith', '987 Maple St', '555987654', 1500, CURRENT_TIME);

-- Thêm dữ liệu cho bảng orders (tiếp tục từ bước trước)
INSERT INTO orders (order_id, status_id, order_detail_id, user_id, note)
VALUES (3, 1, 3, 1, 'Order placed successfully'),
       (4, 3, 4, 2, 'Order pending');

