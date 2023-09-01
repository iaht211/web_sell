1. lấy ra sản phẩm có đánh giá trung bình cao nhất trong danh mục sản phẩm có id = 1
select product.product_id, product.name, product.rate_star
from product join category using (category_id)
where category_id = 1
order by rate_star desc limit 1;
select * from rate;
2. liệt kê sản phẩm đang có 
select product_id, name, price, rate_star
from product;

3. liệt kê đơn hàng đang trong trạng thái chờ xác nhận 
select * from order_detail where status_name = 'pending' ;

4. đếm sản phẩm trong các danh mục 
select category.category_id, category.category_name, count(product.product_id)
from category join product using(category_id)
group by (category.category_id);

5. sắp xếp sản phẩm trong danh mục theo thứ tự đánh giá từ cao xuống thấp (dựa trên rate_star) trong 1 danh mục
select product_id, price, rate_star 
from product 
where category_id = 1 
group by product_id
order by rate_star desc;

6. sắp xếp đơn hàng theo giá trị từ cao -> thấp của 1 người 
select orders.order_id, total_money, orders.status_id
from orders join order_detail using (order_detail_id)
where orders.user_id = 1
order by order_detail.total_money desc;

7. tính tổng giá trị tiền đã mua của 1 người dùng
select orders.user_id, sum(order_detail.total_money) as total_money
from orders join order_detail using (order_detail_id)
where orders.user_id = 1
group by (orders.user_id);
8. top 3 sản phẩm được mua nhiều nhất 

select product.product_id, product.name, sum(cart.pieces) as num_buy
from product join cart using(product_id)
group by (product.product_id)
order by num_buy 
limit 3;

9. đếm số người dùng theo quyền truy cập 
select role_id, count(*) as number_user
from users 
group by (role_id);
select * from users;
10. đưa ra các danh mục đang có 
select * from category;
