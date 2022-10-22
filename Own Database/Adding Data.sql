INSERT INTO Driver (first_name, last_name, car_id,
                    category_license, work_experience,
                    phone_number, rating, age) VALUES
            ('Vasya', 'Pupkin', 1, 'economy', 1, '89871112231', 4.5, 34),
            ('Petya', 'Lopuk', 2, 'business', 4, '89871112232', 4.8, 39),
            ('Ivan', 'Ivanov', 3, 'economy', 2, '89871112233', 3.4, 27),
            ('Nikita', 'Smirnov', 4, 'business', 3, '89871112234', 3.8, 52),
            ('Andrew', 'Kuznetsov', 5, 'economy', 1, '89871112235', 1.6, 56);

INSERT INTO Car (mark, color, plate_number, brand,
                 model, mileage, year_of_manufacture) VALUES
            ('Kia', 'white', 'C528XC', 'Rio', 'X', '20', '04.11.2021'),
            ('Toyota', 'black', 'X802CO', 'Camry', 'XV50', '100', '24.11.2018'),
            ('Kia', 'black', 'A006KA', 'Rio', 'X', '50', '05.05.2020'),
            ('Hyundai', 'black', 'H787OY', 'Grandeur', 'IV', '85', '02.02.2019'),
            ('Hyundai', 'white', 'O315MT', 'Solaris', 'V6', '25', '08.07.2021');

INSERT INTO "Order" (driver_id, client_id, price, location_id,
                     departure_time, arrival_time) VALUES
            (1, 1, 267, 1, '23:34', '00:00'),
            (2, 2, 690, 2, '18:34', '19:10'),
            (3, 3, 195, 3, '15:23', '15:37'),
            (4, 4, 430, 4, '02:47', '03:02'),
            (5, 5, 234, 5, '08:25', '08:45');

INSERT INTO Client (first_name, last_name, phone_number,
                    card_number, rating) VALUES
            ('Nikita', 'Ivanov','80008881101', '4719 5600 1314 9031', 4.7),
            ('Ivan', 'Smirnov','80008881101', '4719 5600 1314 9031', 3.5),
            ('Nikita', 'Shpak','80008881101', '4719 5600 1314 9031', 4.3),
            ('Petya', 'Egorov','80008881101', '4719 5600 1314 9031', 4.9),
            ('Egor', 'Ivanov','80008881101', '4719 5600 1314 9031', 4.2);

INSERT INTO Location_address (country, city, street,
                              number_house) VALUES
            ('Russia', 'Kazan', 'Parina', 22),
            ('Russia', 'Kazan', 'Bauman', 57),
            ('Russia', 'Kazan', 'Kremlin', 35),
            ('Russia', 'Kazan', 'Kutuya', 46),
            ('Russia', 'Kazan', 'Adoratsky', 5);

INSERT INTO Feedback (order_id, text, rating) VALUES
            (1, 'Good', 4),
            (2, 'Good', 4),
            (3, 'Good', 5),
            (4, 'Good', 3),
            (5, 'Good', 4);