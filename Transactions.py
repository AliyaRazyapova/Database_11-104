import psycopg2
from threading import Thread
import time


def transaction(year):
    con = psycopg2.connect(
        dbname="usersdb",
        user="postgres",
        password="123",
        host="localhost",
        port=5433
    )
    con.autocommit = False
    cur = con.cursor()
    con.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_SERIALIZABLE)
    try:
        postgresql_select_query = "SELECT * FROM track WHERE trackid = 1;"
        cur.execute(postgresql_select_query)
        mobile_records = cur.fetchall()
        for elem in mobile_records:
            print(elem)
        cur.execute(f"UPDATE track SET year={year} WHERE trackid = 1;")
        postgresql_select_query = "SELECT * FROM track WHERE trackid = 1;"
        cur.execute(postgresql_select_query)
        mobile_records = cur.fetchall()
        for elem in mobile_records:
            print(elem)
        time.sleep(5)
        con.commit()
        print(f'Транзакция cо значением {year} завершена')
    except (Exception, psycopg2.DatabaseError) as error:
        print("Ошибка в транзакции. Отмена всех остальных операций транзакции", error)
        con.rollback()
        transaction(year)
    finally:
        cur.close()
        con.close()


th1 = Thread(target=transaction, args=(2001, ))
th2 = Thread(target=transaction, args=(2003, ))
th1.start()
th2.start()

