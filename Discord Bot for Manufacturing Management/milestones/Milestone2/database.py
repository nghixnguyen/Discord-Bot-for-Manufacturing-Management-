# In this file you must implement your main query methods 
# so they can be used by your database models to interact with your bot.

import os
import pymysql.cursors

# note that your remote host where your database is hosted
# must support user permissions to run stored triggers, procedures and functions.
db_host = os.environ["DB_HOST"]
db_username = os.environ["DB_USER"]
db_password = os.environ["DB_PASSWORD"]
db_name = os.environ["DB_NAME"]


class Database:

    @staticmethod
    def connect(bot_name = None):
        """
        This method creates a connection with your database
        IMPORTANT: all the environment variables must be set correctly
                   before attempting to run this method. Otherwise, it
                   will throw an error message stating that the attempt
                   to connect to your database failed.
        """
        try:
            conn = pymysql.connect(host=db_host,
                                   port=3306,
                                   user=db_username,
                                   password=db_password,
                                   db=db_name,
                                   charset="utf8mb4", cursorclass=pymysql.cursors.DictCursor)
            print("Bot {} connected to database {}".format(bot_name, db_name))
            return conn
        except ConnectionError as err:
            print(f"An error has occurred: {err.args[1]}")
            print("\n")

    #TODO: needs to implement the internal logic of all the main query operations
    def get_response(self, query, values=None, fetch=False, many_entities=False):
        """
        query: the SQL query with wildcards (if applicable) to avoid injection attacks
        values: the values passed in the query
        fetch: If set to True, then the method fetches data from the database (i.e with SELECT)
        many_entities: If set to True, the method can insert multiple entities at a time.
        """
        connection = Database.connect()
        cursor = connection.cursor()
        if values:
          if many_entities:
            cursor.executemany(query, values)
          else:
            cursor.execute(query, values)
        else:
          cursor.execute(query)
        connection.close()
      
        if fetch:
            return cursor.fetchall()
        return None
           
        # your code here
        response = None
        return response

    @staticmethod
    def select(query, values=None, fetch=True):
        database = Database()
        return database.get_response(query, values=values, fetch=fetch)

    @staticmethod
    def insert(query, values=None, many_entities=False):
        database = Database()
        return database.get_response(query, values=values, many_entities=many_entities)

    @staticmethod
    def update(query, values=None):
        database = Database()
        return database.get_response(query, values=values)

    @staticmethod
    def delete(query, values=None):
        database = Database()
        return database.get_response(query, values=values)

  
class Query:

    GET_PRODUCT = """SELECT * FROM product"""

    GET_RETAIL = """SELECT * FROM retail"""

    GET_DEVICE = """SELECT * FROM device"""

    GET_CATEGORY = """SELECT * FROM category"""

    GET_DELIVERY = """SELECT * FROM delivery"""

    GET_SHIPPING = """SELECT * FROM shipping"""

    GET_PRODUCTS_WITH_MIN_QUANTITY = """SELECT p.product_id, p.product_name, SUM(pi.product_quantity) as total_quantity FROM product p JOIN product_inventory pi ON p.product_id = pi.parts_id GROUP BY p.product_id, p.product_name HAVING total_quantity > %s"""

    
    GET_PRODUCTS_ON_NAME  = """SELECT p.product_id, p.product_name, p.product_des, c.category_name FROM product p JOIN product_category pc ON p.product_id = pc.products_id JOIN category c ON pc.product_category_id = c.category_id WHERE LEFT(p.product_name, 1) = %s ORDER BY c.category_name, p.product_name"""

    GET_DEVICES_OF_USER = """SELECT d.device_type, d.device_ip FROM users u JOIN account a ON u.user_id = a.user_id JOIN account_device ad ON a.account_id = ad.acc_id JOIN device d ON ad.device_id = d.device_id WHERE u.username = %s"""

    GET_USER_BY_USERNAME = """SELECT * FROM users WHERE username = %s"""

    GET_RETAIL_ORDERS_OF_PRODUCT = """SELECT r.retail_name, SUM(ro.product_amount) as order_amount FROM retail_order ro JOIN retail r ON ro.retail_order_id = r.retail_id JOIN product p ON ro.product_order_id = p.product_id WHERE p.product_name LIKE %s GROUP BY r.retail_name"""

    GET_PRODUCT_CATEGORY = """SELECT p.product_id, p.product_name, c.category_type FROM product p JOIN product_category pc ON p.product_id = pc.products_id JOIN category c ON pc.product_category_id = c.category_id"""

    UPDATE_PRODUCT_CATEGORY = """UPDATE product p JOIN product_category pc ON p.product_id = pc.products_id JOIN category c ON pc.product_category_id = c.category_id SET c.category_type LIKE %s WHERE p.product_name LIKE %s"""

    REMOVE_RETAILS_IN_ZIP = """DELETE r FROM retail r LEFT JOIN retail_order ro ON r.retail_id = ro.retail_order_id WHERE r.retail_zip = %s AND ro.order_id IS NULL"""

    REMOVE_DELIVER_BY_SHIPPING_METHOD = """DELETE d FROM delivery d JOIN shipping_delivery sd ON d.delivery_id = sd.deliver_id JOIN shipping s ON sd.shipped_id = s.shipping_id WHERE s.shipping_type NOT LIKE %s"""

    GET_RETAIL_ORDER_HISTORY = """SELECT r.retail_name, ro.order_date, p.product_name, p.product_des, ro.product_amount FROM retail_order ro JOIN retail r ON ro.retail_order_id = r.retail_id JOIN product p ON ro.product_order_id = p.product_id WHERE r.retail_name LIKE %s ORDER BY ro.order_date DESC"""

    CALCULATE_AVG_QUALITY = """SELECT AVG(qc.quality_status) as avg_quality FROM product_quality pq JOIN quality_criteria qc ON pq.quality_criteria_id = qc.criteria_id WHERE pq.product_id = (SELECT product_id FROM product WHERE product_name LIKE %s)"""
