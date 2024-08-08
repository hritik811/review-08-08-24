create table Product(
	id serial primary key,
	name char(20),
	price int
);


create table Order1(
    id serial primary key,
    product_id int,
    quantity int,
    price int,
    purchase_date date,
    foreign key (product_id) references Product(id)
);


INSERT INTO Product (name, price) VALUES
('Product A', 10),('Product B', 20),('Product C', 30),('Product D', 40),('Product E', 50);


INSERT INTO Order1 (product_id, quantity, price, purchase_date) VALUES
(1, 2, 20, '01-01-2024'),(2, 1, 20, '01-02-2024'),(3, 3, 90, '01-02-2024'),(4, 1, 40, '01-03-2924'),(5, 2, 100, '01-04-2024');

INSERT INTO Order1 (product_id, quantity, price, purchase_date) VALUES
(1, 2, 20, '02-02-2024'), (3, 1, 20, '02-02-2024'), (3, 3, 90, '01-03-2024');


	
select *from Order1

--return product purchased on given date
	
select Product.name, Order1.purchase_date
from Product
join Order1 on Product.id = Order1.product_id
where Order1.purchase_date = '02-02-2024'; 


--no of product purchased on particular date

select count(*) as NumberOfProducts
from Order1
where purchase_date = '02-02-2024'; 


--max price product on particular date

select Product.name, Product.price
from Product
join Order1 ON Product.id = Order1.product_id
where Order1.purchase_date = '02-02-2024'
order by Product.price desc
limit 1;


--created a function for calculating total sale on that particular date
create or replace function total_sales(sales_date DATE)
returns numeric as $$
declare
    total_sales numeric := 0;
begin
    select sum(Order1.quantity * Product.price) into total_sales
    from Order1
    join Product on Order1.product_id = Product.id
    where Order1.purchase_date = sales_date;

    return total_sales;
end; $$
language plpgsql;




























