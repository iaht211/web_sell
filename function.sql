 -- tinh tien cho don hang trong giỏ hàng bằng cart_id
create or replace function p_money(id int)
returns int
language plpgsql
as
$$
declare
	product_money int;
begin
	select sum(product.price*cart.pieces) into product_money
	from cart join product using(product_id)
	where cart.cart_id = id;
	return product_money;
end;
$$;
select p_money(id => 1);
-- tính star trung bình cho 1 sản phẩm
 create or replace function star_one(id int)
        returns float
        language plpgsql
        as
        $$
            declare
	        avg_star float;
            begin
	        select avg(star) into avg_star
	        from rate
	        where product_id = id;
	        return avg_star;
            end;
          $$;
select  star_one(1);
-- cập nhật cột tính đánh giá trung bình của sản phẩm 
CREATE OR REPLACE PROCEDURE total_star()
LANGUAGE plpgsql
AS $$
BEGIN
	ALTER TABLE product
	DROP COLUMN IF EXISTS rate_star;
	
	ALTER TABLE product
	ADD COLUMN rate_star FLOAT;
	
	UPDATE product AS p
	SET rate_star = (
		SELECT AVG(r.star)
		FROM rate AS r
		WHERE r.product_id = p.product_id
	);
END;
$$;
call total_star();
select * from product;
-- trigger tính tiền cho sản phẩm khi thực hiện thêm sản phẩm vào cart
create or replace function calculate_p_money()
returns trigger 
language plpgsql
as $$
declare
p_money int;
begin
	select (price) into p_money
	from product 
	where product_id = new.product_id;
	p_money := p_money * new.pieces;
	update cart
	set money = p_money
	where new.cart_id = cart_id and new.product_id = product_id;
	return new;
end;
$$;
create trigger calculate_p_money_trigger
after insert 
on cart
for each row 
execute procedure calculate_p_money(); 
 insert into cart(cart_id, product_id, pieces, order_detail_id)
 values (1, 4, 1, 1);
select * from cart;
select * from order_detail;
select * from orders;
select * from customer_buy;

--trigger thực hiện không cho phép đăng kí khi trạng thái đơn hàng đã 
create or replace function check_buy()
returns trigger
language plpgsql
as $$
declare
order_status int;
cart_row cart;
begin
SELECT * INTO cart_row FROM cart WHERE cart_id = NEW.cart_id;

	SELECT orders.status_id INTO order_status FROM orders
	JOIN order_detail USING (order_detail_id)
	WHERE order_detail_id = cart_row.order_detail_id;

	if order_status >= 2 then
	raise exception 'không thể sửa sản phẩm đã mua nữa';
	end if;
	return new;
end;
$$;
create trigger check_buy_strigger
before insert 
on cart
for each row 
execute procedure check_buy();
-- tự động cập nhật tính lại giá tiền của đơn hàng khi có sự thay đổi trong giỏ hàng 
create or replace function calculate_total_money()
returns trigger
language plpgsql
as $$
declare
o_money int;
begin
	select sum(money) into o_money
	from cart
	where cart_id = new.cart_id;
	update order_detail
	set total_money = o_money
	where order_detail_id = new.order_detail_id;
return new;
end;
$$;
create trigger update_total_money
after update or insert
on cart
for each row
execute  procedure calculate_total_money();
 insert into cart(cart_id, product_id, pieces, order_detail_id)
 values (1, 4, 1, 1);
select * from order_detail;
 
 
 
 
 
 
 
 
