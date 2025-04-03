CREATE database hotel;
use hotel;
select * from hotel_sales;
select * from hotel_city;

ALTER TABLE hotel_sales
RENAME COLUMN ï»¿booking_id to booking_id; 

Alter table hotel_city
RENAME COLUMN ï»¿hotel_id to hotel_id;


SELECT COUNT(hotel_id) FROM hotel_city;

SELECT COUNT(booking_id) FROM hotel_sales;


SET SQL_SAFE_UPDATES = 0;

ALTER TABLE hotel_sales
ADD COLUMN duration date;


UPDATE hotel_sales
SET duration = DATEDIFF(check_out, check_in);

ALTER TABLE hotel_sales
ADD COLUMN rate INT;
SET SQL_SAFE_UPDATES = 0;

UPDATE hotel_sales  
SET rate = ROUND(  
    CASE  
        WHEN no_of_rooms = 1 THEN price/duration  
        WHEN no_of_rooms != 1 THEN (price/duration)/no_of_rooms  
        ELSE 0  
    END
);

SET SQL_SAFE_UPDATES = 1;  -- Re-enable safe mode after the update


SELECT * FROM hotel_sales;

-- 1.a. Average amount spent per booking for each customer, C

SELECT customer_id, AVG(amount) AS avg_spending
FROM hotel_sales
GROUP BY customer_id
ORDER BY avg_spending DESC;

-- 1.b. Frequency of bookings and cancellation rate for each customer
SELECT customer_id, 
	COUNT(booking_id) AS booking_frquency, 
	COUNT(IF(status = 'Cancelled',1,NULL)) AS cancelled_booking,
CASE
WHEN COUNT(status) = 0 THEN 0
ELSE COUNT(IF(status = 'Cancelled',1,NULL)) / COUNT(status)
END AS cancelled_rate
FROM hotel_sales
GROUP BY customer_id;

-- 2.a. Average booking amount per city
SELECT customer_id, AVG(amount) AS avg_booking
FROM hotel_sales
GROUP BY customer_id
ORDER BY avg_booking DESC;

-- 2.b  Average discounts across cities peak versus off-season demand across cities
SELECT customer_id, AVG(discount) AS avg_booking
FROM hotel_sales
GROUP BY customer_id
ORDER BY avg_booking DESC;

-- 3.a. Average length of stay, seasonal demand patterns (Monthly/Quaterly stay patterns)
SELECT AVG(duration)
FROM hotel_sales;