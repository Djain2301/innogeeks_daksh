create table roles(
	roles_id serial primary key,
	role_name varchar(10)
)
insert into roles (role_name) values ('Buyer'); --role_id=1
insert into roles (role_name) values ('Seller'); --role_id=2
insert into roles (role_name) values ('Admin'); -- role_id=3
select * from roles;
--drop table users;
create table users(
	user_id serial primary key,
	user_name varchar(50),
	age int,
	gender char(1),
	address varchar(255),
	role_id int references roles(roles_id)
);

insert into users (user_name, age, gender,address, role_id)
values
('User1',20,'M','New Delhi',1),
('User2',18,'M','Kolkata',1),
('User3',30,'F','Jaipur',2),
('User4',45,'M','Noida',2),
('User5',16,'F','Kashmir',1),
('User6',27,'M','Surat',3),
('User7',55,'M','Mumbai',1),
('User8',32,'F','Bangalore',3);

select * from users;

create table products(
	product_id serial primary key,
	product_name varchar(100),
	price int,
	quantity int
);
insert into products(product_name, price,quantity)
values
('Product1', 100,50),
('Product2', 400,13),
('Product3', 300,40),
('Product4', 500,50),
('Product5', 1000,10);

select * from products;

create table orders(
	order_id serial primary key,
	buyer_id int references users(user_id),
	seller_id int references users(user_id),
	product_id int references products(product_id),
	order_value int,
	order_date date
);
select * from orders;
--seller id ==3,4 admin id==6,8
-- ('Product1', 100,50),
-- ('Product2', 400,13),
-- ('Product3', 300,40),
-- ('Product4', 500,50),
-- ('Product5', 1000,10);
insert into orders(buyer_id, seller_id,product_id,order_date)
values
(1,3,1,now()),
(5,3,3,now()),
(3,4,4,now()),
(2,4,2,now()),
(7,3,5,now());
insert into orders(buyer_id, seller_id, product_id, order_value, order_date)
values (1,4,4,500,now());

create or replace function fn_order_update()
returns trigger
language PLPGSQL
as
$$
	begin
	update orders set order_value= order_value+(select price from products where product_id=new.product_id);
	delete from orders where order_value= order_value-(select price from products where product_id=new.product_id)
		and product_id=new.product_id;
	update products set quantity=quantity-1 where product_id= new.product_id;
	return NEW;
	end;
$$

create trigger on_addition_of_order
before insert
on orders
for each row
	execute procedure fn_order_update();
	
