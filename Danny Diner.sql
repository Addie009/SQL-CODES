 --1. What is the total amount each customer spent at the restaurant?

SELECT customer_id, sum(price) as total_spent
FROM Customer
group by customer_id
order by total_spent desc

 --2. How many days has each customer visited the restaurant?

SELECT customer_id, count(order_date) as total_visit
FROM Customer
group by customer_id
order by total_visit desc

 --3. What was the first item from the menu purchased by each customer?

SELECT customer_id, min(product_name) first_item
FROM Customer
group by customer_id
order by first_item

 --4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT TOP 1 product_name,  count(customer_id) as most_purchased
FROM Customer
group by product_name
order by most_purchased desc

 --5. Which item was the most popular for each customer?
SELECT customer_id, max(product_name) as most_poplar
FROM Customer
group by customer_id
order by most_poplar

 --6. Which item was purchased first by the customer after they became a member?
SELECT customer_id, min(product_name) as after_member
FROM Customer
WHERE member = 'Y'
GROUP BY customer_id
order by after_member

-- 7. Which item was purchased just before the customer became a member?
select customer_id, min(product_name) before_member
from Customer
where member = 'N'
group by customer_id
order by before_member


 --8. What is the total items and amount spent by each member before they became a member?
select customer_id, COUNT(product_name) as total_item, SUM(price) as total_amount
from Customer
where member = 'N'
group by customer_id

 --9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
SELECT customer_id,
sum(CASE 
     WHEN product_name = 'Sushi' THEN price*20
	 ELSE price*10
END) as total_point
FROM Customer
group by customer_id

--10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
select C.customer_id, M.Join_date, 
sum(CASE
     WHEN c.customer_id = 'join_date' THEN price*2
	 ELSE price*2
END) as total_point
from Customer as c
inner join member_join_date as m
on c.customer_id = m.customer_id
where Join_date <= '2021-01-31'
group by c.customer_id, m.Join_date


