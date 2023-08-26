create database pizza_restaurant;

use pizza_restaurant;

create table `customer`(
customer_id int not null,
customer_firstname varchar(50),
customer_lastname varchar(50),
customer_phone varchar(50),
primary key customer_id(customer_id)
);

create table `orders`(
order_id int not null,
order_timestamp timestamp not null,
primary key order_id (order_id)
);

create table `pizza`(
pizza_id int not null,
pizza_type varchar(50),
pizza_price decimal(5,2),
primary key (pizza_id)
);

create table `customer_orders`(
customer_id int not null,
order_id int not null,
foreign key(customer_id) references customer (customer_id),
foreign key(order_id) references orders (order_id)
);

create table `pizza_orders`(
pizza_id int not null,
order_id int not null,
quantity int not null,
foreign key(pizza_id) references pizza(pizza_id),
foreign key(order_id) references orders(order_id)
);

insert into `pizza`(pizza_id, pizza_type, pizza_price)
	values(1, 'Pepperoni & Cheese', 7.99),
		  (2, 'Vegetarian', 9.99),
          (3, 'Meat Lovers', 14.99),
          (4, 'Hawaiian', 12.99);
          
-- first order
insert into `customer`(customer_firstname, customer_lastname, customer_phone)
	values('Trevor', 'Page', '226-555-4982');

insert into `orders`(order_timestamp)
	values('2014-10-9 9:47:00');

insert into `customer_orders`(customer_id, order_id)
	values(1,1);
    
insert into `pizza_orders`(pizza_id, order_id, quantity)
	values(1,1,1),(3,1,1);
    
-- second order
insert into `customer`(customer_firstname, customer_lastname, customer_phone)
	values('John', 'Doe', '555-555-4982');

insert into `orders`(order_timestamp)
	values('2014-10-9 13:20:00');

insert into `customer_orders`(customer_id, order_id)
	values(2,2);
    
insert into `pizza_orders`(pizza_id, order_id, quantity)
	values(2,2,1),(3,2,2);

-- third order
insert into`order`(order_timestamp)
	values('2014-10-9 9:47:00');
    
select * from `orders`;

insert into`customer_order`(customer_id, order_id)
	values(1,3);
    
insert into `pizza_orders`(pizza_id, order_id, quantity)
	values(3,3,1),(4,3,1);

-- Q4 task
select c.customer_id, c.customer_firstname, c.customer_lastname, sum(p.pizza_price*po.quantity) from customer as c
join `customer_order` as co on c.customer_id = co.customer_id
join `orders` as o on co.order_id = o.order_id
join `pizza_orders` as po on o.order_id = po.order_id
join `pizza` as p on po.pizza_id = p.pizza_id
group by c.customer_id;

-- Q5 task
select c.customer_id, c.customer_firstname, c.customer_lastname, date(o.order_timestamp), sum(p.price*po.quantity) from customers as c
join `customer_order` as co on c.customer_id = co.customer_id
join `order` as o on co.order_id = o.order_id
join `pizza_orders` as po on o.order_id = po.order_id
join `pizza` as p on op.pizza_id = p.pizza_id
group by c.customer_id;