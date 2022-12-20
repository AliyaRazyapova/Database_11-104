-- 1
SELECT count(passenger_name) FROM flights f
JOIN ticket_flights tf ON f.flight_id = tf.flight_id
JOIN boarding_passes bs ON bs.flight_id = tf.flight_id
JOIN tickets t ON t.ticket_no = tf.ticket_no
WHERE bs.seat_no = '12D' AND f.flight_no = 'PG0521';

-- 2
SELECT MIN(amount), MAX(amount), AVG(amount) FROM flights f
JOIN ticket_flights tf ON tf.flight_id = f.flight_id
WHERE f.actual_departure >= '2017-08-06'
AND f.actual_departure <= '2017-08-10 23:59:59';

-- 3
SELECT f.flight_no, tf.fare_conditions,
MIN(amount), MAX(amount), AVG(amount) FROM flights f
JOIN ticket_fligths tf ON tf.flight_id = f.flight_id
WHERE (f.flight_no = 'PG0521'
	   OR f.flight_no = 'PG0118'
	   OR f.flight_no = 'PG0210')
	   AND (tf.fare_conditions = 'Economy'
		   OR tf.fare_conditions = 'Comfort'
		   OR tf.fare_conditions = 'Business')
		   GROUP BY f.flight_no, tf.fare_conditions;

-- 4
SELECT sum(f.count) FROM
	(SELECT count(f.flight_no) FROM flights f
	 	GROUP BY f.departure_airport) as f;