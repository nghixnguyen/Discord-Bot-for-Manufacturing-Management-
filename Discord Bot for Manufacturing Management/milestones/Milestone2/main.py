"""
The code below is just representative of the implementation of a Bot. 
However, this code was not meant to be compiled as it. It is the responsability 
of all the students to modifify this code such that it can fit the 
requirements for this assignments.
"""
import os
import discord
from discord.ext import commands
from models import *
from database import Database
from prettytable import PrettyTable


TOKEN = os.environ["DISCORD_TOKEN"]

intents = discord.Intents.all()

bot = commands.Bot(command_prefix='!', intents=discord.Intents.all())

@bot.event
async def on_ready():
  print(f'Bot {bot.user} has connected to Discord!')
  Database.connect(bot.user)

@bot.command(name="test")
async def _test(ctx):
  testModel = TestModel(ctx)
  response = testModel.response()
  await ctx.send(response)

@bot.command(name="listPoductsOnName", description="get a list of products with same first letter in name of product")
async def _command1(ctx, first_letter):
  try:
      products = Product.get_products_by_first_letter(first_letter)
      if not products:
          await ctx.send("No products found for the given first letter. Please             check the letter and enter again.")
          return      
      table = PrettyTable()
      table.field_names = ["Product Name", "Category"]
      for product in products:
          table.add_row([product._name, product._category_name])
      await ctx.send(f"```{table}```")
  except Exception as e:
      await ctx.send(f"Invalid command syntax. Please check again. Error: {e}")

@bot.command(name="listDevicesOfUser", description="get list of the device types and ip of all devices associated with a specific user name")
async def _command2(ctx, username):
  try:
      devices = Device.get_devices_by_user(username)
      if not devices:
          await ctx.send(f"No devices found for the user: {username}")
          return
      table = PrettyTable()
      table.field_names = ["Device Type", "Device IP"]
      for device in devices:
          table.add_row([device._type, device._ip])
      await ctx.send(f"Devices associated with user {username}:\n```{table}```")
  except Exception as e:
      await ctx.send(f"An error occurred. Please try again. Error: {e}")

@bot.command(name="listProductsWithMinQuantity", description="get a list of products that have a total quantity across all inventories above a user-specified amount")
async def _command3(ctx, quantity):
  try:
    min_quantity = int(quantity)
    products = Product.get_products_with_min_quantity(min_quantity)
    if not products:
        await ctx.send(f"No products found with a total quantity above {min_quantity}")
        return
    table = PrettyTable()
    table.field_names = ["Product Name", "Total Quantity"]
    for product in products:
        table.add_row([product._name, product.total_quantity])
    await ctx.send(f"Products with a total quantity above {min_quantity}:\n```{table}```")
  except ValueError:
    await ctx.send("Invalid input. Please provide a valid quantity.")
    
@bot.command(name="listRetailOrdersOfProduct", description="get a list of names and order counts of retails who have placed orders containing specified product")
async def _command4(ctx, *args):
  try:
    product_name = " ".join(args)
    retail_orders = Product.get_retail_orders_of_product(product_name)
    if not retail_orders:
        await ctx.send(f"No retail orders found for the product: {product_name}")
        return
    table = PrettyTable()
    table.field_names = ["Retail Name", "Order Count"]
    for order in retail_orders:
        table.add_row([order.retail_name, order.order_count])
    await ctx.send(f"Retail orders containing product {product_name}:\n```{table}```")
  except Exception as e:
    await ctx.send(f"An error occurred. Please try again. Error: {e}")

@bot.command(name="insertMarterialOrderBy", description=" insert materials ordered by a manager, along with the quantity, and order date")
async def _command5(ctx, *args):
  await ctx.send("This method is not implemented yet")

@bot.command(name="insertScheduleFor", description="insert a new schedule to manufacture a specific product")
async def _command6(ctx, *args):
  await ctx.send("This method is not implemented yet")

@bot.command(name="updateProductQuantity", description="update the quantity of a product in a warehouse's inventory")
async def _command7(ctx, inventory_name, product_name, quantity_to_update):
  await ctx.send("This method is not implemented yet")

@bot.command(name="updateProductCategory", description="update the category type of a product ")
async def _command8(ctx, category_type, product_name):
  updated_data = Product.update_product_category(category_type, product_name)
  table = PrettyTable()
  table.field_names = ["Category Type", "Product Name"]
  for product in updated_data:
      table.add_row([product._category_type, product._name])
  await ctx.send(f"```\n{table}\n```")

@bot.command(name="removeRetailsIn", description="remove retails in area zip who have not orders any products")
async def _command9(ctx, zip_code):
  try:
      Retail.remove_retails_in_zip(zip_code)
      await ctx.send(f"Retails in zip code {zip_code} successfully removed if they haven't ordered any products.")
  except Exception as e:
      await ctx.send(f"An error occurred. Please try again. Error: {e}")
  
@bot.command(name="removeDeliver", description="remove delivers who do not provide shipping method")
async def _command10(ctx, *args):
  try:
      shipping_method = " ".join(args)
      Delivery.remove_deliver_by_shipping_method(shipping_method)
      await ctx.send(f"Delivers not providing {shipping_method} successfully removed.")
  except Exception as e:
      await ctx.send(f"An error occurred. Please try again. Error: {e}")
    

@bot.command(name="trackProductInventory", description="If a retail order is placed, the product and its quantity in inventory will decrease based on the ordered amount.")
async def _command11(ctx, *args):
  await ctx.send("This method is not implemented yet")

@bot.command(name="modifyQualityCriteria", description="modify quality criteria descriptions and log the changes with time")
async def _command12(ctx, *args):
  await ctx.send("This method is not implemented yet")

@bot.command(name="trackProductQuantity", description="input the quantity of a specific product in stock")
async def _command13(ctx, *args):
  await ctx.send("This method is not implemented yet")

@bot.command(name="avgProductQuality", description="Calculate the average quality status of a product based on its linked quality criteria.")
async def _command_average(ctx, *args):
  try:
      product_name = " ".join(args)
      avg_quality = Product.calculate_avg_quality(product_name)
      if avg_quality is not None:
          await ctx.send(f"Average quality status for product {product_name}: {avg_quality:.2f}")
      else:
          await ctx.send(f"No quality information found for the product: {product_name}")
  except Exception as e:
      await ctx.send(f"An error occurred. Please try again. Error: {e}")

@bot.command(name="retailHistoryOrders", description="Retrieve the order history for a specific retail, including order dates, product details, and quantities.")
async def _command_order(ctx, *args):
  try:
      retail_name = " ".join(args)
      retail_order_history = Retail.get_retail_order_history(retail_name)
      if not retail_order_history:
          await ctx.send(f"No order history found for the retail: {retail_name}")
          return
      table = PrettyTable()
      table.field_names = ["Order Date", "Product Name", "Product Description", "Quantity"]
      for order in retail_order_history:
          table.add_row([order.order_date, order.product_name, order.product_description, order.product_amount])
      await ctx.send(f"Order history for retail {retail_name}:\n```{table}```")
  except Exception as e:
      await ctx.send(f"An error occurred. Please try again. Error: {e}")

bot.run(TOKEN)
