create database pizzahut;

select * from pizzas;

create table orders (order_id int not null, 
order_date date not null,
order_time time not null,
primary key (order_id));

create table orders_details (order_details_id int not null, 
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key (order_details_id));



-- Retrieve the total number of orders placed.

select count(order_id) as totalcount from orders;


select * from pizzas;

select * from order_details;

-- Identify the highest-priced pizza.

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

select * from orders;
select * from orders_details;
select * from pizza_types;
select * from pizzas;


-- Identify the most common pizza size ordered.

SELECT 
    pizzas.size,
    COUNT(orders_details.order_details_id) AS orders_count
FROM
    pizzas
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY pizzas.size
ORDER BY orders_count DESC
LIMIT 1;

select * from orders;
select * from orders_details;
select * from pizza_types;
select * from pizzas;

-- List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name, SUM(orders_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;



-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category, SUM(orders_details.quantity) AS total_quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details
GROUP BY pizza_types.category
ORDER BY total_quantity DESC;

-- Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(order_time) AS hours, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(order_time);

-- Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    pizza_types.category, COUNT(pizza_types.name) AS name_count
FROM
    pizza_types
GROUP BY pizza_types.category
ORDER BY name_count;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    round(AVG(quantity),0) as Avg_Pizza_Ordered_Per_Day
FROM
    (SELECT 
        orders.order_date, SUM(orders_details.quantity) AS quantity
    FROM
        orders
    JOIN orders_details ON orders.order_id = orders_details.order_id
    GROUP BY orders.order_date) AS order_quantity;
    
-- Determine the top 3 most ordered pizza types based on revenue.

select pizza_types.name, round(sum(orders_details.quantity * pizzas.price),0) as Revenue from pizza_types join pizzas on
pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details
group by pizza_types.name
order by Revenue desc limit 3;

-- Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pizza_types.category,
    ROUND(SUM(orders_details.quantity * pizzas.price) / (SELECT 
                    ROUND(SUM(orders_details.quantity * pizzas.price),
                                2) AS Total_Sales
                FROM
                    orders_details
                        JOIN
                    pizzas ON pizzas.pizza_id = orders_details.pizza_id) * 100,
            2) AS Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details
GROUP BY pizza_types.category
ORDER BY Revenue DESC;

-- Analyze the cumulative revenue generated over time.

SHOW VARIABLES LIKE 'net_write_timeout';


select orders.order_date, sum(orders_details.quantity * pizzas.price) as Revenue
from orders_details JOIN pizzas ON pizzas.pizza_id = orders_details.pizza_id
join orders 
group by orders.order_date;


SHOW VARIABLES LIKE 'net_read_timeout';
SET GLOBAL net_read_timeout = 600;

SET GLOBAL wait_timeout = 600;







