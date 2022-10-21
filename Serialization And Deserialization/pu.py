#TODO
# 1) Построить объектную модель предметной области по сформированной ранее
#   концептуальной модели
# 2) Наполнить данными и сериализовать их в JSON файл
# 3) Десериализовать JSON файл в объекты
# 4) Наполнить данными и сериализовать их в XML файл
# 5) Десериализовать XML файл в объекты

import json
import pyconvert.pyconv
import xmltodict

# 1) Построить объектную модель предметной области по сформированной ранее
#  концептуальной модели
class Driver(object):
    def __init__(self, order, first_name, last_name,
                 car_id, category_license,
                 work_experience, phone_number,
                 rating, age):
        self.order = order
        self.first_name = first_name
        self.last_name = last_name
        self.car_id = car_id
        self.category_license = category_license
        self.work_experience = work_experience
        self.phone_number = phone_number
        self.rating = rating
        self.age = age

class Car(object):
    def __init__(self, driver, mark, color, plate_number,
                 model, mileage, year_of_manufacture):
        self.driver = driver
        self.mark = mark
        self.color = color
        self.plate_number = plate_number
        self.model = model
        self.mileage = mileage
        self.year_of_manufacture = year_of_manufacture

class Order(object):
    def __init__(self, driver_id, client_id, price,
                 location_id, departure_time, arrival_time):
        self.driver_id = driver_id
        self.client_id = client_id
        self.price = price
        self.location_id = location_id
        self.departure_time = departure_time
        self.arrival_time = arrival_time

class Client(object):
    def __init__(self, order, first_name, last_name, phone_number,
                 card_number, rating):
        self.order = order
        self.first_name = first_name
        self.last_name = last_name
        self.phone_number = phone_number
        self.card_number = card_number
        self.rating = rating

class Location_address(object):
    def __init__(self, order, country, city, street, number_house):
        self.order = order
        self.country = country
        self.city = city
        self.street = street
        self.number_house = number_house

class Feedback(object):
    def __init__(self, order, order_id, text, rating):
        self.order = order
        self.order_id = order_id
        self.text = text
        self.rating = rating

class Result(object):
    def __init__(self, order, driver, car,
                 client, location_adress, feedback):
        self.order = order
        self.driver = driver
        self.car = car
        self.client = client
        self.location_adress = location_adress
        self.feedback = feedback

class DataBase(object):
    def __init__(self, orders):
        self.orders = orders

# 2) Наполнить данными и сериализовать их в JSON файл
order1 = Order(501, 301, 238, 201, "13:15", "13:13")
driver1 = Driver(order1, "Pupkin", "Vasya", 500, "econom", "5 year", "+1111111111", 4, 56)
car1 = Car(driver1, "Lada Granta", "white", "S666EX", "sedan", "90000", "2017")
client1 = Client(order1, "Ardamonov", "Alex", "+1111111112", "S666EX", 5)
location_adress1 = Location_address(order1, "Russia", "Kazan", "Parina", 22)
feedback1 = Feedback(order1, 23, "Cool driver!", 5)
result1 = Result(order1, driver1, car1, client1, location_adress1, feedback1)

order2 = Order(502, 302, 430, 202, "8:40", "8:30")
driver2 = Driver(order2, "Morozov", "Sasha", 400, "business", "3 year", "+2222222222", 5, 34)
car2 = Car(driver2, "Kia Rio", "black", "X777ER", "hatchback", "54000", "2019")
client2 = Client(order2, "Sokolov", "Nikita", "+2222222223", "X777ER", 5)
location_adress2 = Location_address(order2, "Russia", "Moscow", "Tverskaya", 10)
feedback2 = Feedback(order2, 12, "Okey", 5)
result2 = Result(order2, driver2, car2, client2, location_adress2, feedback2)

data_base = DataBase([result1, result2])

r = json.dumps(data_base, default=lambda x: x.__dict__, ensure_ascii=False, indent=2)

file = open("data.json","w")
file.write(r)
file.close()

# 3) Десериализовать JSON файл в объекты
d = json.loads(r)
print(d)

# 4) Наполнить данными и сериализовать их в XML файл
xml = str(pyconvert.pyconv.convert2XML(data_base).toprettyxml())

f = open("data.xml","w")
f.write(xml)
f.close()

# 5) Десериализовать XML файл в объекты
dicts = xmltodict.parse(xml)
print(dicts)