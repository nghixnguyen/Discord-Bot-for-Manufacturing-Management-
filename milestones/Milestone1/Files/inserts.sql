USE autoManufactureDB;

INSERT INTO users (user_id, username, dob) VALUES (1, "Alice", "1998-12-01"), (2, "Bob", "2012-03-29"), (3, 'Trudi', "2006-05-13"), (4, 'Eva', '1990-07-15'), 
												(5, 'Daniel', '1985-04-03'), (6, 'Grace', '2000-09-18'), (7, 'Michael', '1978-12-05'), (8, 'Olivia', '1995-02-28'),
												(9, 'William', '1982-06-10'), (10, 'Sophia', '1993-11-20'), (11, 'Henry', '2005-03-08'), (12, 'Hoa', '1999-08-22');
INSERT INTO employee (employee_id, users_id, employee_name) VALUES (1, 1, "Alice"), (2, 4, "Eva"), (3, 5, "Daniel"), (4, 6, "Grace"), 
																	(5, 7, "Michael"), (6, 9, "William"), (7, 11, "Henry"), (8, 12, "Hoa"); 
INSERT INTO manager (manager_id, employee_id, manager_name) VALUES (1, 1, 'Inventory Manager'), (2, 6, 'Product Manager'), (3, 8, 'Manufacture Manager');
INSERT INTO account (account_id, user_id, created, manager_account_id) VALUES (1, 1, '2023-01-15', 1), (2, 9, '2023-02-28', 2), (3, 12, '2023-03-10', 3);
INSERT INTO region (region_id, location, zipcode) VALUES (1, "california", 94025), (2, "new york", 10001), (3, "texas", 49572);
INSERT INTO device (device_id, device_type, device_ip) VALUES (1, "samsung phone", "192.158.1.38"), (2, "apple tablet", "255.255.255.255"), (3, "hp laptop", "192.0.2.1");
INSERT INTO account_device (used_id, acc_id, device_id) VALUES (1, 1, 1), (2, 3, 2), (3, 3, 3);
INSERT INTO account_region (hosted_id, region_id, account_id) VALUES (1, 1, 1), (2, 2, 2), (3, 3, 3);
INSERT INTO quality_criteria (criteria_id, criteria_des, criteria_category) VALUES (1, 'Tread Depth', 'Tire Quality'), (2, 'Tire Traction', 'Tire Quality'),
																					(3, 'Door Alignment', 'Car Door Quality'), (4, 'Door Paint Finish', 'Car Door Quality'),
                                                                                    (5, 'Seat Comfort', 'Car Seat Quality'), (6, 'Seat Material Durability', 'Car Seat Quality'),
                                                                                    (7, 'Belt Strength', 'Seat Belt Quality'), (8, 'Belt Buckle Functionality', 'Seat Belt Quality'),
                                                                                    (9, 'Airbag Assembly', 'Safety Features'), (10, 'Crash Test Performance', 'Safety Features'),
                                                                                    (11, 'Material Resistance to Wear', 'General Durability'), (12, 'Corrosion Resistance', 'General Durability'),
                                                                                    (13, 'Fit and Finish', 'Overall Quality'), (15, 'Noise Level', 'User Experience');
INSERT INTO manage_criteria (action_id, criteria_id, criteria_manage_id, modify) VALUES (1, 1, 1, '2023-01-15 08:00:00'), (2, 4, 3, '2023-02-28 12:30:00'), (3, 11, 2, '2023-03-10 16:45:00');
INSERT INTO category (category_id, category_name, category_type) VALUES (1, 'Tire', 'Wheel and Tire'), (2, 'Door', 'Body Parts'), (3, 'Seat', 'Interior Parts'),
																		(4, 'Seat Belt', 'Safety Parts'), (5, 'Airbag', 'Safety Parts'), (6, 'Transmission', 'Transmission Parts');
INSERT INTO manage_category (action_id, category_manage_id, categories_id, modify) VALUES (1, 2, 1, '2023-01-15 08:15:32'), (2, 1, 2, '2023-02-20 12:45:21'), (3, 3, 3, '2023-03-25 15:30:45'),
																							(4, 2, 4, '2023-04-05 09:10:27'), (5, 3, 5, '2023-05-10 18:20:14'), (6, 2, 6, '2023-10-21 14:00:4');

INSERT INTO schedule (schedule_id, schedule_time, target_amount) VALUES (1, "2023-12-01", 6), (2,"2023-12-02", 4), (3, "2023-12-03", 9);
INSERT INTO manage_schedule (action_id, schedule_manage_id, schedule_id, modify) VALUES (1, 3, 1, '2023-12-01 08:00:00'), (2, 3, 2, '2023-12-02 12:30:00'), (3, 1, 3, '2023-12-03 15:45:00');
INSERT INTO inventory (inventory_id, inventory_name, inventory_date) VALUES (1, "First Quarter Inventory", "2022-2-19 19:34:53"), 
																			(2, "Second Quarter Inventory", "2022-6-30 17:20:18"), 
                                                                            (3, "Third Quarter Inventory", "2022-9-27 22:03:29");
INSERT INTO manage_inventory (action_id, inventory_manage_id, inventory_id, modify) VALUES (1, 1, 1, '2022-2-19 20:00:00'), (2, 1, 2, '2022-6-30 18:15:00'), (3, 2, 3, '2022-9-27 22:45:00'); 
INSERT INTO raw_material (material_id, material_name, material_des) VALUES (1, 'Synthetic Rubber', 'Main material for tire production'), (2, 'Tempered Glass', 'Used in car windows and windshields'),
																			(3, 'Leather', 'Material for car seat upholstery'), (4, 'Nylon', 'Used in seat belts for strength'),
                                                                            (5, 'Airbag Fabric', 'Special fabric for airbag production'), (6, 'Foam', 'Material for car seat cushions');
INSERT INTO manage_material (action_id, material_manage_id, material_id, material_quantity) VALUES (1, 2, 1, 500), (2, 2, 2, 200), (3, 3, 3, 100), (4, 1, 4, 300), (5, 2, 5, 150), (6, 2, 6, 400);
INSERT INTO shipping (shipping_id, shipping_type, shipping_date) VALUES (1, 'Standard Shipping', '2023-01-15 08:00:00'), (2, 'Express Shipping', '2023-01-16 12:30:00'), (3, 'Next Day Shipping', '2023-01-17 16:45:00'); 
INSERT INTO manage_shipping (action_id, shipping_manage_id, ship_id, autopart_id, shipping_amount) VALUES (1, 1, 1, 1, 10), (2, 2, 2, 2, 15), (3, 3, 3, 3, 20);
INSERT INTO delivery (delivery_id, delivery_name, delivery_address) VALUES (1, "fedEx", "1597 Sloat Blvd, San Francisco, CA 94132"), 
																			(2, "USPS", "317 W Portal Ave, San Francisco, CA 94127"), 
                                                                            (3, "UPS","1728 Ocean Ave, San Francisco, CA 94112");
INSERT INTO shipping_delivery (link_id, shipped_id, deliver_id) VALUES (1, 1, 1), (2, 2, 2), (3, 3, 3);
INSERT INTO supplier (supplier_id, supplier_name, supplier_address) VALUES (1, "Continental AG", "2400 Executive Hills Dr, Auburn Hills, MI 48326 "), 
																			(2, "Valeo", "480 Wrangler Drive, Suite 200 TX 75019, Coppell, United States"), 
																			(3, "Lear Corporation","3553 Westwind Blvd, Santa Rosa, CA 95403");
INSERT INTO material_supplier (link_id, materials_id, suppliers_id) VALUES (1, 1, 2), (2, 2, 3), (3, 3, 1), (4, 4, 3), (5, 5, 1), (6, 6, 2);
INSERT INTO warehouse (warehouse_id, warehouse_name, warehouse_address) VALUES (1, "San Francisco Mercantile Warehouse", "1770 Yosemite Ave, San Francisco, CA 94124"), 
																				(2, "DHL Supply Chain North America", "360 Westar Blvd Westerville, OH 4308"), 
                                                                                (3, "XPO Logistics","2200 Claremont Ct, Hayward, CA 94545");
INSERT INTO warehouse_inventory (link_id, warehouses_id, inventories_id, product_id, product_quantity) VALUES (1, 1, 1, 1, 100), (2, 1, 2, 2, 150), (3, 1, 3, 3, 200), (4, 2, 1, 1, 120), (5, 2, 2, 2, 180),
																												(6, 2, 3, 3, 240), (7, 3, 1, 1, 80), (8, 3, 2, 2, 120), (9, 3, 3, 3, 160);
INSERT INTO retail (retail_id, retail_name, retail_address, retail_zip) VALUES (1, "America Tire", "1155 El Camino Real, Millbrae, CA 94030", 94030), 
																				(2, "O'Reilly Auto Parts", "2150 Taraval St, San Francisco, CA 94116", 94116), 
                                                                                (3, "Parkside Paint & Body","1830 Taraval St, San Francisco, CA 94116", 94116);
INSERT INTO customer (customer_id, customer_name, customer_address) VALUES (1, "Alexa", "7031 Mission St, Daly City, CA 94014"), 
																			(2, "Siri", "3251 20th Ave, San Francisco, CA 94132"), 
                                                                            (3, "Anna","2125 Chestnut St, San Francisco, CA 94123");
INSERT INTO contact_list (list_id, contact_type, information) VALUES (1, 'Email', 'delivery@example.com'), (2, 'Phone', '(555) 123-4567'), (3, 'Email', 'supplier@example.com'),
																		(4, 'Phone', '(555) 987-6543'), (5, 'Email', 'warehouse@example.com'), (6, 'Phone', '(555) 789-0123'),
                                                                        (7, 'Email', 'retail@example.com'), (8, 'Phone', '(555) 456-7890'), (9, 'Email', 'customer@example.com'), 
                                                                        (10, 'Phone', '(555) 321-0987'), (11, 'Email', 'delivery2@example.com'), (12, 'Phone', '(555) 876-5432'),
                                                                        (13, 'Email', 'supplier2@example.com'), (14, 'Phone', '(555) 234-5678'), (15, 'Email', 'warehouse2@example.com');
INSERT INTO manage_contact (action_id, contact_manage_id, contact_id, contact_date) VALUES (1, 1, 1, '2023-01-15 08:00:00'), (2, 3, 3, '2023-01-17 16:45:00'), (3, 2, 4, '2023-01-19 14:00:00'),
																							(4, 3, 6, '2023-01-20 11:45:00'), (5, 2, 8, '2023-01-22 10:45:00'), (6, 2, 11, '2023-01-25 17:00:00'),
                                                                                            (7, 3, 12, '2023-01-26 19:15:00'), (8, 1, 13, '2023-01-27 21:30:00'), (9, 2, 14, '2023-01-28 23:45:00');
INSERT INTO warehouse_contact (contacts_id, warehou_id) VALUES (5, 1), (2, 2), (15, 3);
INSERT INTO supplier_contact (contacts_id, supply_id) VALUES (3, 1), (4, 2), (13, 3);
INSERT INTO delivery_contact (contacts_id, deliveries_id) VALUES (1, 1), (6, 2), (11, 3);
INSERT INTO customer_contact (contacts_id, consumer_id) VALUES (8, 1), (9, 2), (10, 3);
INSERT INTO retail_contact (contacts_id, seller_id) VALUES (7, 1), (12, 2), (14, 3);
INSERT INTO product (product_id, product_name, product_des) VALUES (1, "car tire", "5m tire for toyota seda"), (2, "car door glass", "23x56cm side door glass for suv"), (3, "seatbelt","3m seatbelt");
INSERT INTO product_quality (link_id, product_criteria_id, product_id, quality_status) VALUES (1, 1, 1, 1), (2, 3, 2, 0), (3, 7, 3, 1), (4, 8, 3, 1), (5, 2, 1, 0);
INSERT INTO product_category (link_id, products_id, product_category_id) VALUES (1, 1, 1), (2, 2, 2), (3, 3, 4);
INSERT INTO product_schedule (link_id, part_id, product_schedule_id) VALUES (1, 1, 1), (2, 2, 3), (3, 3, 2);
INSERT INTO product_inventory (link_id, parts_id, product_inventory_id, product_quantity) VALUES (1, 1, 1, 100), (2, 1, 3, 67), (3, 1, 2, 3), (4, 2, 1, 50), 
																									(5, 2, 3, 92), (6, 3, 2, 1), (7, 3, 1, 201), (8, 3, 3, 75);
INSERT INTO retail_order (order_id, order_date, retail_order_id, product_order_id, product_amount) VALUES (1, '2023-01-15 08:00:00', 1, 1, 50), (2, '2023-01-15 10:30:00', 1, 2, 30), 
																											(3, '2023-01-15 12:45:00', 2, 1, 40), (4, '2023-01-16 09:15:00', 2, 3, 20),
                                                                                                            (5, '2023-01-16 11:30:00', 3, 2, 25), (6, '2023-01-17 14:20:00', 3, 3, 35);
INSERT INTO customer_product (register_id, customers_id, register_date, buyer_product_id) VALUES (1, 1, '2023-01-15 08:00:00', 1), (2, 1, '2023-01-15 10:30:00', 2), (3, 2, '2023-01-15 12:45:00', 1),
																									(4, 2, '2023-01-16 09:15:00', 3), (5, 3, '2023-01-16 11:30:00', 2), (6, 3, '2023-01-17 14:20:00', 3);
                                                                                                                                                                         
INSERT INTO find_retail (link_id, cus_id, retails_id) VALUES (1, 1, 1), (2, 1, 2), (3, 2, 1), (4, 2, 3), (5, 3, 2), (6, 3, 3);







