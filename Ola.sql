--SQL statement for creating the bookings table

CREATE TABLE bookings 
(
    date DATE,
    time TIME,
    booking_id VARCHAR(20),
    booking_status VARCHAR(50),
    customer_id INT,
    vehicle_type VARCHAR(20),
    pickup_location VARCHAR(50),
    drop_location VARCHAR(50),
    avg_vtat FLOAT,
    avg_ctat FLOAT,
    cancelled_by_customer VARCHAR(255),
    reason_for_cancelling_by_customer VARCHAR(255),
    cancelled_by_driver VARCHAR(255),
	incomplete_rides VARCHAR(255),
    incomplete_rides_reason VARCHAR(255),
    booking_value FLOAT,
    ride_distance FLOAT,
    driver_ratings FLOAT,
    customer_rating FLOAT
);


-- SQL Questions And Answers:

CREATE VIEW Successful_Booking As
SELECT * FROM bookings 
WHERE booking_status = 'Success';

--1. Retrieve all successful bookings:
SELECT * FROM Successful_Booking	

CREATE VIEW ride_distance AS
SELECT vehicle_type, ROUND(AVG(ride_distance)::numeric, 2)
AS avg_distance FROM bookings
GROUP BY 1;

--2. Find the average ride distance for each vehicle type:
SELECT * FROM ride_distance

CREATE VIEW cancelled_ride_by_customer AS
SELECT COUNT(*) FROM bookings
WHERE booking_status = 'cancelled_by_customer';

--3. Get the total number of cancelled rides by customers:
SELECT * FROM cancelled_ride_by_customer

CREATE VIEW most_no_of_bookings_by_customer AS
SELECT customer_id, COUNT(booking_id) AS total_rides
FROM bookings
GROUP BY 1
ORDER BY total_rides DESC
LIMIT 5;

--4. List the top 5 customers who booked the highest number of rides:
SELECT * FROM most_no_of_bookings_by_customer

CREATE VIEW cancelled_rides_reason AS
SELECT COUNT(*) 
FROM bookings 
WHERE cancelled_by_driver = 'Personal & Car related issues';

--5. Get the number of rides cancelled by drivers due to personal and car-related issues: 
SELECT * FROM cancelled_rides_reason

CREATE VIEW driver_rating AS
SELECT MAX(driver_ratings) AS max_rating,
MIN(driver_ratings) AS min_rating
FROM bookings
WHERE vehicle_type = 'Prime Sedan';

--6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
SELECT * FROM driver_rating


CREATE VIEW cust_rating AS
SELECT vehicle_type, ROUND(AVG(customer_rating)::numeric,2) as avg_cust_rating
FROM bookings
GROUP BY 1;

--8. Find the average customer rating per vehicle type:
SELECT * FROM cust_rating

CREATE VIEW total_ride_value AS
SELECT ROUND(SUM(booking_value)::numeric,2) as tot_book_value
FROM BOOKINGS
WHERE booking_Status  = 'Success';

--9. Calculate the total booking value of rides completed successfully:
SELECT * FROM total_ride_value


CREATE VIEW incomplete_rides AS
SELECT booking_id, incomplete_rides_reason
FROM bookings
WHERE incomplete_rides = 'Yes';

--10. List all incomplete rides along with the reason:
SELECT * FROM incomplete_rides