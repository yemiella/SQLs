CREATE TABLE product_categories (id INT PRIMARY KEY UNIQUE NOT NULL,
name VARCHAR (25) NOT NULL);

CREATE TABLE options (id INT PRIMARY KEY UNIQUE NOT NULL, name VARCHAR(50) NOT NULL);

CREATE TABLE option_group (id INT PRIMARY KEY UNIQUE NOT NULL, name VARCHAR(55) NOT NULL);

CREATE TABLE products (id INT PRIMARY KEY UNIQUE NOT NULL, name VARCHAR(100) NOT NULL, price FLOAT,
product_decription VARCHAR (1000) NOT NULL, product_categories_id INT UNIQUE NOT NULL,
FOREIGN KEY (product_categories_id) REFERENCES product_categories (id));


CREATE TABLE product_option (id INT  PRIMARY KEY UNIQUE NOT NULL,
option_id INT UNIQUE NOT NULL, product_id INT UNIQUE NOT NULL,
option_group_id INT UNIQUE NOT NULL, product_option_price int not null,
FOREIGN KEY (product_id) REFERENCES products(id), FOREIGN KEY (option_id) REFERENCES options(id),
FOREIGN KEY (option_group_id) REFERENCES option_group(id));

CREATE TABLE users (id INT PRIMARY KEY UNIQUE NOT NULL, user_id VARCHAR(300) UNIQUE NOT NULL,
user_password VARCHAR (16) NOT NULL, user_fullname VARCHAR (500) NOT NULL);

CREATE TABLE orders (id INT PRIMARY KEY UNIQUE NOT NULL, user_id INT UNIQUE NOT NULL, order_amt FLOAT NOT NULL,
order_name VARCHAR (100) NOT NULL, order_address VARCHAR (1000) NOT NULL, order_date TIMESTAMP NOT NULL,
shipped_date TIMESTAMP NOT NULL, order_cancelled BOOLEAN NOT NULL, oder_cancelled_date TIMESTAMP NOT NULL,
FOREIGN KEY (user_id) REFERENCES users(id));

CREATE TABLE order_details (id INT PRIMARY KEY UNIQUE NOT NULL, order_id INT UNIQUE NOT NULL,
product_id INT UNIQUE NOT NULL, name VARCHAR, qunatity INT NOT NULL,
FOREIGN KEY (order_id) REFERENCES orders(id), FOREIGN KEY (product_id) REFERENCES products(id));



SELECT users.id as UID, orders.id as orders_id,orders.order_amt,
order_details.id as order_details_id,
order_details.product_id, order_details.name, order_details.qunatity
from orders
join users on users.id = orders.user_id
join order_details on orders.id=order_details.order_id;

select users.id as uid, count(orders.*) as order_counts
from orders
Join users on orders.user_id = users.id
group by 1
Having count(orders.*) = 3

select users.id as uid, count(orders.*) as order_counts
from orders
Join users on orders.user_id = users.id
group by 1
Having count(orders.*) < 1


select users.id, sum(orders.order_amt) as sum_of_amt_spent from orders
join users on users.id = orders.user_id
where orders.order_date between '2017-01-01' and '2017-12-31'
group by users.id
order by sum(orders.order_amt) desc limit 5;
