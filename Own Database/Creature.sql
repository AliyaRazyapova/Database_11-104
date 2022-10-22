CREATE DATABASE taksi_d;

CREATE TABLE Driver(
    first_name varchar(20),
    last_name varchar(20),
    car_id bigint,
    category_license varchar(20),
    work_experience int,
    phone_number varchar(20),
    rating double precision,
    age int
);

CREATE TABLE Car(
    mark varchar(20),
    color varchar(20),
    plate_number varchar(20),
    brand varchar(20),
    model varchar(20),
    mileage varchar(25),
    year_of_manufacture date
);

CREATE TABLE "Order"(
    driver_id bigint,
    client_id bigint,
    price int,
    location_id bigint,
    departure_time time,
    arrival_time time
);

CREATE TABLE Client(
    first_name varchar(20),
    last_name varchar(20),
    phone_number varchar(20),
    card_number varchar(20),
    rating double precision
);

CREATE TABLE Location_address(
    country varchar(30),
    city varchar(30),
    street varchar(30),
    number_house varchar(10)
);

CREATE TABLE Feedback(
    order_id bigint,
    text varchar(1000),
    rating int
);