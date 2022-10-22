-- 1. Вывести список самолетов в порядке убывания количества мест
SELECT aircraft_code, count( * ) FROM seats
GROUP BY aircraft_code
ORDER BY count DESC;

-- 2. Вывести список самолетов в порядке возрастания
-- соотношения количества мест бизнес-класса к количеству мест эконом-класса
SELECT aircraft_code, fare_conditions, count( * )
FROM seats
GROUP BY aircraft_code, fare_conditions
ORDER BY aircraft_code, fare_conditions;

-- 3. Вывести список самолетов в порядке убывания количества полетов
SELECT aircraft_code, count( aircraft_code ) 
FROM seats NATURAL JOIN flights
GROUP BY aircraft_code
ORDER BY count DESC;

-- 4. Вывести список самолетов со средним временем продолжительности полета каждого
SELECT aircraft_code, AVG(age(scheduled_arrival, scheduled_departure))
FROM flights
GROUP by aircraft_code;

-- 5. Вывести среднее время задержки вылета в каждом аэропорту
SELECT departure_airport, AVG(actual_departure - scheduled_departure)
FROM flights
WHERE actual_departure IS NOT null GROUP BY departure_airport

-- 6. Вывести наименьшее и наибольшее суммарное время задержки вылета в каждом аэропорту
SELECT departure_airport, MIN(hour + minutes/60), MAX(hour + minutes/60), SUM(hour + minutes/60)
FROM (SELECT departure_airport, EXTRACT(hour from timedif) AS hour,
	  EXTRACT(minutes FROM timedif) AS minutes
	  FROM (SELECT departure_airport, actual_departure - scheduled_departure AS timedif FROM flights
WHERE status = 'Arrived' ) AS delaytime) AS time
GROUP BY departure_airport;

-- -- 7. Вывести количество бронирований вылета из Москвы (доступ к значению города из JSON
-- объекта airport_name -> 'ru' )
SELECT COUNT(bookings.book_ref) FROM bookings
JOIN tickets ON bookings.book_ref = tickets.book_ref
JOIN ticket_flights ON tickets.ticket_no = ticket_flights.ticket_no
JOIN flights ON ticket_flights.flight_id = flights.flight_id
JOIN airports_data ON flights.departure_airport = airports_data.airport_code
WHERE city = '{"en": "Moscow", "ru": "Москва"}';

-- 8. Вывести все полеты между городами в разных временных поясах за один день (любой)
SELECT flights.flight_id, a.timezone,
d.timezone
FROM (select timezone, flight_id FROM flights
JOIN airports_data ON flights.arrival_airport = airports_data.airport_code) as a
JOIN (select timezone, flight_id FROM flights
JOIN airports_data ON flights.departure_airport = airports_data.airport_code)as d
on a.flight_id = d.flight_id
JOIN flights ON flights.flight_id = a.flight_id
WHERE flights.scheduled_departure::date = '2017-08-19' AND NOT a.timezone = d.timezone ;

-- 9. Вывести данные пассажиров и даты перелетов в/из Москвы у которых в номере паспорта есть сочетание 473
SELECT passenger_id, passenger_name, contact_data, flights.scheduled_arrival, flights.scheduled_departure
FROM tickets
JOIN ticket_flights ON tickets.ticket_no = ticket_flights.ticket_no
JOIN flights on ticket_flights.flight_id = flights.flight_id
JOIN airports_data on flights.departure_airport = airports_data.airport_code
JOIN airports_data a ON a.airport_code = flights.arrival_airport
WHERE tickets.ticket_no LIKE '%473%' AND (airports_data.city = '{"en": "Moscow", "ru": "Москва"}' OR
a.city = '{"en": "Moscow", "ru": "Москва"}');

-- 10. Вывести всю информацию по конкретному бронированию (код бронирования, дата, сумма,
-- номера билетов, имя, паспорт пассажиров, время вылета, аэропорт вылета, время прилета,
-- аэропорт прилета, модель самолета). Код бронирования выбрать любой.
SELECT bookings.book_ref, book_date, total_amount, tickets.ticket_no, tickets.passenger_name,
tickets.contact_data, flights.scheduled_departure, airports_data.airport_code, flights.scheduled_arrival,
airports_data.airport_code, ad.model -> 'ru' AS aircraft_model
FROM bookings
LEFT JOIN tickets ON bookings.book_ref = tickets.book_ref
LEFT JOIN ticket_flights ON tickets.ticket_no = ticket_flights.ticket_no
LEFT JOIN flights ON flights.flight_id = ticket_flights.flight_id
LEFT JOIN airports_data ON flights.departure_airport = airports_data.airport_code
LEFT JOIN airports_data a ON flights.arrival_airport = a.airport_code
LEFT JOIN aircrafts_data ad ON flights.aircraft_code = ad.aircraft_code
WHERE bookings.book_ref = '000012';