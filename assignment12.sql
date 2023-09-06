drop database if exists pizza_restaurant;
create database pizza_restaurant;

use pizza_restaurant;

create table `customer`(
customer_id int not null auto_increment,
customer_name varchar(50),
customer_phone varchar(50),
primary key customer_id(customer_id)
);

create table `orders`(
order_id int not null auto_increment,
order_timestamp timestamp not null,
primary key order_id(order_id)
);

create table `pizza`(
pizza_id int not null,
pizza_type varchar(50),
pizza_price decimal(5,2),
primary key pizza_id(pizza_id)
);

create table `customer_orders`(
customer_id int not null,
order_id int not null,
foreign key(customer_id) references `customer`(customer_id),
foreign key(order_id) references `orders`(order_id)
);

create table `pizza_orders`(
pizza_id int not null,
order_id int not null,
quantity int not null default 1,
foreign key(pizza_id) references `pizza`(pizza_id),
foreign key(order_id) references `orders`(order_id)
);

insert into `pizza`(pizza_id, pizza_type, pizza_price)
	values(1, 'Pepperoni & Cheese', '7.99'),
		(2, 'Vegetarian', '9.99'),
        (3, 'Meat Lovers', '14.99'),
        (4, 'Hawaiian', '12.99');
        
-- first order
insert into `customer`(customer_id, customer_name, customer_phone)
	values(1, 'Trevor Page', '226-555-4982');

insert into `orders`(order_timestamp)
	values('2014-10-9 9:47:00');
    
insert into `customer_orders`(customer_id, order_id)
	values(1,1);
    
insert into `pizza_orders`(pizza_id, order_id, quantity)
	values(1,1,1),(3,1,1);

-- second order
insert into `customer`(customer_id, customer_name, customer_phone)
	values(2, 'John Doe', '555-555-4982');
    
insert into `orders`(order_timestamp)
	values('2014-10-9 13:20:00');
    
insert into `customer_orders`(customer_id, order_id)
	values(2,2);

insert into `pizza_orders`(pizza_id, order_id, quantity)
	values(2,2,1),(3,2,2);
    
-- third order 
insert into `orders`(order_timestamp)
	values('2014-10-9 9:47:00');
    
insert into `customer_orders`(customer_id, order_id)
	values(1, 3);
    
insert into `pizza_orders`(pizza_id, order_id, quantity)
	values(3,3,1),(4,3,1);

-- Q4 task
select c.customer_id, customer_name, SUM(po.quantity * p.pizza_price) AS total_spent
		from `customer_orders` co
        join `customer` c on co.customer_id = c.customer_id
        join `orders` o on o.order_id = co.order_id
        join `pizza_orders` po on po.order_id = po.order_id
        join `pizza` p on po.pizza_id = p.pizza_id
        group by c.customer_id;

-- Q5 task
select c.customer_id, customer_name, order_timestamp, SUM(po.quantity * p.pizza_price) AS total_spent
	from `customer_orders` co
        join `customer` c on co.customer_id = c.customer_id
        join `orders` o on o.order_id = co.order_id
        join `pizza_orders` po on po.order_id = po.order_id
        join `pizza` p on po.pizza_id = p.pizza_id
        group by c.customer_id, o.order_timestamp
        order by c.customer_id;
