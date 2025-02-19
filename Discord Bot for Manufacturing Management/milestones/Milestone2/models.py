"""
In this file you must implement all your database models.
If you need to use the methods from your database.py call them
statically. For instance:
       # opens a new connection to your database
       connection = Database.connect()
       # closes the previous connection to avoid memory leaks
       connection.close()
"""

from database import Database 
from database import Query


class TestModel:
    """
    This is an object model example. Note that
    this model doesn't implement a DB connection.
    """

    def __init__(self, ctx):
        self.ctx = ctx
        self.author = ctx.message.author.name

    def response(self):
        return f'Hi, {self.author}. I am alive'

class RetailOrder:
  def __init__(self):
      self.retail_name = None
      self.order_date = None
      self.product_name = None
      self.product_description = None
      self.product_amount = None
      
class Retail:
    def __init__(self, retail_id=None):
        self._id = retail_id
        self._name = None

    def _load(self): 
        retail_data = Database.select(Query.GET_RETAIL)

    @staticmethod
    def remove_retails_in_zip(zip_code):
        Database.delete(Query.REMOVE_RETAILS_IN_ZIP, (zip_code,))

    @staticmethod
    def get_retail_order_history(retail_name):
        retail_name = f"%{retail_name}%"
        retail_order_history = []
        order_history_data = Database.select(Query.GET_RETAIL_ORDER_HISTORY, (retail_name))
        for tmp_order in order_history_data:
            order = RetailOrder()
            order.retail_name = tmp_order['retail_name']
            order.order_date = tmp_order['order_date']
            order.product_name = tmp_order['product_name']
            order.product_description = tmp_order['product_des']
            order.product_amount = tmp_order['product_amount']
            retail_order_history.append(order)
        return retail_order_history
        
class Delivery:
    def __init__(self, delivery_id=None):
        self._id = delivery_id
        self._name = None
  
    def _load(self): 
        delivery_data = Database.select(Query.GET_DELIVERY)
  
    @staticmethod
    def remove_deliver_by_shipping_method(shipping_method):
        shipping_method = f"%{shipping_method}%"
        Database.delete(Query.REMOVE_DELIVER_BY_SHIPPING_METHOD, (shipping_method))

class Shipping:
    def __init__(self, shipping_id=None):
        self._id = shipping_id
        self._name = None
  
    def _load(self): 
        shipping_data = Database.select(Query.GET_SHIPPING)
    
class Category:
    def __init__(self, category_id=None):
        self._id = category_id
        self._type = None
  
    def _load(self): 
        category_data = Database.select(Query.GET_CATEGORY)

class Product:
    def __init__(self, product_id = None):
        self._id = product_id
        self._name = None
        self._load()

    def _load(self): 
        product_data = Database.select(Query.GET_PRODUCT)
      
    @staticmethod
    def get_products_by_first_letter(first_letter):
        products = []
        product_data = Database.select(Query.GET_PRODUCTS_ON_NAME, (first_letter))
        for tmp_product in product_data:
            product = Product(product_id=tmp_product['product_id'])
            product._name = tmp_product['product_name']
            product._category_name = tmp_product['category_name']
            products.append(product)
        return products

    @staticmethod
    def get_products_with_min_quantity(min_quantity):
        products = []
        product_data = Database.select(Query.GET_PRODUCTS_WITH_MIN_QUANTITY, (min_quantity))
        for tmp_product in product_data:
            product = Product(product_id=tmp_product['product_id'])
            product._name = tmp_product['product_name']
            product.total_quantity = tmp_product['total_quantity']
            products.append(product)
        return products


    @staticmethod
    def get_retail_orders_of_product(product_name):
        retail_orders = []
        product_name = f"%{product_name}%"
        retail_order_data = Database.select(Query.GET_RETAIL_ORDERS_OF_PRODUCT, (product_name))
        for tmp_order in retail_order_data:
            retail_order = Retail()
            retail_order.retail_name = tmp_order['retail_name']
            retail_order.order_count = tmp_order['order_amount']
            retail_orders.append(retail_order)
        return retail_orders

    @staticmethod
    def update_product_category(category_type, product_name):
        category = []
        Database.select(Query.UPDATE_PRODUCT_CATEGORY, (category_type, product_name))
        updated_data = Database.select(Query.GET_PRODUCT_CATEGORY)
        for tmp_product_category in updated_data:
            product = Product(product_id=tmp_product_category['product_id'])
            product._name = tmp_product_category['product_name']
            product._category_type = tmp_product_category['category_type']
            category.append(product)
        return category
      
    @staticmethod
    def calculate_avg_quality(product_name):
        product_name = f"%{product_name}%"
        avg_quality = Database.select(Query.CALCULATE_AVG_QUALITY, (product_name,), fetch=True)
        if avg_quality and avg_quality[0]['avg_quality'] is not None:
            return avg_quality[0]['avg_quality']
        return None


class User:
    def __init__(self, user_id=None, username=None):
        self._id = user_id
        self._username = username

    @staticmethod
    def get_user_by_username(username):
        user_data = Database.select(Query.GET_USER_BY_USERNAME, (username))
        return User(user_id=user_data[0]['user_id'],
                    username=user_data[0]['username'])
    
class Device:
    def __init__(self, device_id = None):
        self._id = device_id
        self._type = None
        self._ip = None
        self._load()
  
    def _load(self):
        device_data = Database.select(Query.GET_DEVICE, (self._id))
  
    @staticmethod
    def get_devices_by_user(username):
        devices = []
        device_data = Database.select(Query.GET_DEVICES_OF_USER, (username,))
        for tmp_device in device_data:
            device = Device(device_id=None)  # Assuming device_id is not used here
            device._type = tmp_device['device_type']
            device._ip = tmp_device['device_ip']
            devices.append(device)
        return devices
