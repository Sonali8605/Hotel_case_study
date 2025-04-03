# Hotel Case Study - SQL Analysis

## Introduction
This case study analyzes hotel sales data to gain business insights. The dataset includes details of hotel bookings and customer transactions, allowing us to identify customer segments, booking trends, and spending behaviors. 

## Datasets Used
- **Hotel Sales Dataset**: Contains booking details such as booking ID, customer ID, booking status, check-in/check-out dates, number of rooms, hotel ID, amount paid, discount, and date of booking.
- **Hotel City Dataset**: Contains details about hotel locations, including `hotel_id` and `city`.

## Business Objectives
1. Identify customer segments based on booking patterns and spending behavior.
2. Analyze booking trends and discount patterns to optimize pricing strategies.
3. Assess booking patterns to improve operational efficiency.

## Key Business Metrics & SQL Queries

### 1. Customer Spending & Booking Behavior
#### a. Average amount spent per booking for each customer

SELECT customer_id, AVG(amount) AS avg_spending
FROM hotel_sales
GROUP BY customer_id
ORDER BY avg_spending DESC;

#### b. Frequency of bookings and cancellation rate per customer

SELECT customer_id, 
       COUNT(booking_id) AS booking_frequency, 
       COUNT(IF(status = 'Cancelled', 1, NULL)) AS cancelled_booking, 
       CASE 
           WHEN COUNT(status) = 0 THEN 0 
           ELSE COUNT(IF(status = 'Cancelled', 1, NULL)) / COUNT(status) 
       END AS cancelled_rate
FROM hotel_sales
GROUP BY customer_id;
### 2. City-Wise Booking Insights
#### a. Average booking amount per city

SELECT city, AVG(amount) AS avg_booking_amount
FROM hotel_sales hs
JOIN hotel_city hc ON hs.hotel_id = hc.hotel_id
GROUP BY city
ORDER BY avg_booking_amount DESC;
#### b. Average discount across cities

SELECT city, AVG(discount) AS avg_discount
FROM hotel_sales hs
JOIN hotel_city hc ON hs.hotel_id = hc.hotel_id
GROUP BY city
ORDER BY avg_discount DESC;
### 3. Seasonal Demand Patterns
#### a. Average length of stay

SELECT AVG(DATEDIFF(check_out, check_in)) AS avg_stay_duration
FROM hotel_sales;
b. Monthly and Quarterly Stay Patterns

SELECT MONTH(check_in) AS month, COUNT(*) AS total_bookings
FROM hotel_sales
GROUP BY month
ORDER BY total_bookings DESC;

SELECT QUARTER(check_in) AS quarter, COUNT(*) AS total_bookings
FROM hotel_sales
GROUP BY quarter
ORDER BY total_bookings DESC;
## Conclusion
This SQL analysis provides actionable insights into customer booking behavior, pricing strategies, and operational efficiencies. By leveraging these insights, hotels can optimize pricing, improve marketing strategies, and enhance customer satisfaction.

Thank you!
