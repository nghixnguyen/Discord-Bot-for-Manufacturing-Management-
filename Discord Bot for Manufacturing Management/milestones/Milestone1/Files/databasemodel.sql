-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema autodb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------
DROP DATABASE IF EXISTS autoManufactureDB; 

CREATE DATABASE IF NOT EXISTS autoManufactureDB; 

USE autoManufactureDB;

DROP TABLE IF EXISTS `users` ;

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` INT UNSIGNED NOT NULL,
  `username` VARCHAR(64) NOT NULL,
  `dob` DATE NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `employee` ;

CREATE TABLE IF NOT EXISTS `employee` (
  `employee_id` INT UNSIGNED NOT NULL,
  `users_id` INT UNSIGNED NOT NULL,
  `employee_name` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `user_id_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `users_id_fk`
    FOREIGN KEY (`users_id`)
    REFERENCES `users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `manager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `manager` ;

CREATE TABLE IF NOT EXISTS `manager` (
  `manager_id` INT UNSIGNED NOT NULL,
  `employee_id` INT UNSIGNED NOT NULL,
  `manager_name` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`manager_id`),
  INDEX `employee_id_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `employee_id_fk`
    FOREIGN KEY (`employee_id`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `account` ;

CREATE TABLE IF NOT EXISTS `account` (
  `account_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `created` DATE NOT NULL,
  `manager_account_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`account_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `manager_acc_fk_idx` (`manager_account_id` ASC) VISIBLE,
  CONSTRAINT `user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `manager_acc_fk`
    FOREIGN KEY (`manager_account_id`)
    REFERENCES `manager` (`manager_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `region` ;

CREATE TABLE IF NOT EXISTS `region` (
  `region_id` INT UNSIGNED NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `zipcode` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`region_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `account_region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `account_region` ;

CREATE TABLE IF NOT EXISTS `account_region` (
  `hosted_id` INT UNSIGNED NOT NULL,
  `region_id` INT UNSIGNED NOT NULL,
  `account_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`hosted_id`),
  INDEX `region_id_idx` (`region_id` ASC) VISIBLE,
  INDEX `account_id_idx` (`account_id` ASC) VISIBLE,
  CONSTRAINT `region_id`
    FOREIGN KEY (`region_id`)
    REFERENCES `region` (`region_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `account_id`
    FOREIGN KEY (`account_id`)
    REFERENCES `account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `device`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `device` ;

CREATE TABLE IF NOT EXISTS `device` (
  `device_id` INT UNSIGNED NOT NULL,
  `device_type` VARCHAR(45) NOT NULL,
  `device_ip` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`device_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `account_device`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `account_device` ;

CREATE TABLE IF NOT EXISTS `account_device` (
  `used_id` INT UNSIGNED NOT NULL,
  `acc_id` INT UNSIGNED NOT NULL,
  `device_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`used_id`),
  INDEX `account_id_idx` (`acc_id` ASC) VISIBLE,
  INDEX `device_id_idx` (`device_id` ASC) VISIBLE,
  CONSTRAINT `acc_id`
    FOREIGN KEY (`acc_id`)
    REFERENCES `account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `device_id`
    FOREIGN KEY (`device_id`)
    REFERENCES `device` (`device_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `quality_criteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `quality_criteria` ;

CREATE TABLE IF NOT EXISTS `quality_criteria` (
  `criteria_id` INT UNSIGNED NOT NULL,
  `criteria_des` VARCHAR(512) NOT NULL,
  `criteria_category` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`criteria_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `manage_criteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `manage_criteria` ;

CREATE TABLE IF NOT EXISTS `manage_criteria` (
  `action_id` INT UNSIGNED NOT NULL,
  `criteria_id` INT UNSIGNED NOT NULL,
  `criteria_manage_id` INT UNSIGNED NOT NULL,
  `modify` TIMESTAMP NOT NULL,
  PRIMARY KEY (`action_id`),
  INDEX `criteria_id_idx` (`criteria_id` ASC) VISIBLE,
  INDEX `manager_id_idx` (`criteria_manage_id` ASC) VISIBLE,
  CONSTRAINT `criteria_id_fk`
    FOREIGN KEY (`criteria_id`)
    REFERENCES `quality_criteria` (`criteria_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `criteria_manage_fk`
    FOREIGN KEY (`criteria_manage_id`)
    REFERENCES `manager` (`manager_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product` ;

CREATE TABLE IF NOT EXISTS `product` (
  `product_id` INT UNSIGNED NOT NULL,
  `product_name` VARCHAR(64) NOT NULL,
  `product_des` VARCHAR(512) NOT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `product_quality`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_quality` ;

CREATE TABLE IF NOT EXISTS `product_quality` (
  `link_id` INT UNSIGNED NOT NULL,
  `product_criteria_id` INT UNSIGNED NOT NULL,
  `product_id` INT UNSIGNED NOT NULL,
  `quality_status` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`link_id`),
  INDEX `criteria_id_idx` (`product_criteria_id` ASC) VISIBLE,
  INDEX `product_id_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `product_criteria_fk`
    FOREIGN KEY (`product_criteria_id`)
    REFERENCES `quality_criteria` (`criteria_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `product_id_fk`
    FOREIGN KEY (`product_id`)
    REFERENCES `product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category` ;

CREATE TABLE IF NOT EXISTS `category` (
  `category_id` INT UNSIGNED NOT NULL,
  `category_name` VARCHAR(256) NOT NULL,
  `category_type` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `product_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_category` ;

CREATE TABLE IF NOT EXISTS `product_category` (
  `link_id` INT UNSIGNED NOT NULL,
  `products_id` INT UNSIGNED NOT NULL,
  `product_category_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`link_id`),
  INDEX `product_id_idx` (`products_id` ASC) VISIBLE,
  INDEX `category_id_idx` (`product_category_id` ASC) VISIBLE,
  CONSTRAINT `products_id_fk`
    FOREIGN KEY (`products_id`)
    REFERENCES `product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `product_category_fk`
    FOREIGN KEY (`product_category_id`)
    REFERENCES `category` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `manage_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `manage_category` ;

CREATE TABLE IF NOT EXISTS `manage_category` (
  `action_id` INT UNSIGNED NOT NULL,
  `category_manage_id` INT UNSIGNED NOT NULL,
  `categories_id` INT UNSIGNED NOT NULL,
  `modify` TIMESTAMP NOT NULL,
  PRIMARY KEY (`action_id`),
  INDEX `manage_id_idx` (`category_manage_id` ASC) VISIBLE,
  INDEX `category_id_idx` (`categories_id` ASC) VISIBLE,
  CONSTRAINT `category_manage_fk`
    FOREIGN KEY (`category_manage_id`)
    REFERENCES `manager` (`manager_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `categories_id_fk`
    FOREIGN KEY (`categories_id`)
    REFERENCES `category` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `schedule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schedule` ;

CREATE TABLE IF NOT EXISTS `schedule` (
  `schedule_id` INT UNSIGNED NOT NULL,
  `schedule_time` DATE NOT NULL,
  `target_amount` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`schedule_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `manage_schedule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `manage_schedule` ;

CREATE TABLE IF NOT EXISTS `manage_schedule` (
  `action_id` INT UNSIGNED NOT NULL,
  `schedule_manage_id` INT UNSIGNED NOT NULL,
  `schedule_id` INT UNSIGNED NOT NULL,
  `modify` TIMESTAMP NOT NULL,
  PRIMARY KEY (`action_id`),
  INDEX `manage_id_idx` (`schedule_manage_id` ASC) VISIBLE,
  INDEX `schedule_id_idx` (`schedule_id` ASC) VISIBLE,
  CONSTRAINT `schedule_manage_fk`
    FOREIGN KEY (`schedule_manage_id`)
    REFERENCES `manager` (`manager_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `schedule_id_fk`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `schedule` (`schedule_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `product_schedule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_schedule` ;

CREATE TABLE IF NOT EXISTS `product_schedule` (
  `link_id` INT UNSIGNED NOT NULL,
  `part_id` INT UNSIGNED NOT NULL,
  `product_schedule_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`link_id`),
  INDEX `product_id_idx` (`part_id` ASC) VISIBLE,
  INDEX `schedule_id_idx` (`product_schedule_id` ASC) VISIBLE,
  CONSTRAINT `part_id_fk`
    FOREIGN KEY (`part_id`)
    REFERENCES `product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `product_schedule_fk`
    FOREIGN KEY (`product_schedule_id`)
    REFERENCES `schedule` (`schedule_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inventory` ;

CREATE TABLE IF NOT EXISTS `inventory` (
  `inventory_id` INT UNSIGNED NOT NULL,
  `inventory_name` VARCHAR(64) NOT NULL,
  `inventory_date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`inventory_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `manage_inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `manage_inventory` ;

CREATE TABLE IF NOT EXISTS `manage_inventory` (
  `action_id` INT UNSIGNED NOT NULL,
  `inventory_manage_id` INT UNSIGNED NOT NULL,
  `inventory_id` INT UNSIGNED NOT NULL,
  `modify` TIMESTAMP NOT NULL,
  PRIMARY KEY (`action_id`),
  INDEX `manage_id_idx` (`inventory_manage_id` ASC) VISIBLE,
  INDEX `inventory_id_idx` (`inventory_id` ASC) VISIBLE,
  CONSTRAINT `inventory_manage_fk`
    FOREIGN KEY (`inventory_manage_id`)
    REFERENCES `manager` (`manager_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `inventory_id_fk`
    FOREIGN KEY (`inventory_id`)
    REFERENCES `inventory` (`inventory_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `product_inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_inventory` ;

CREATE TABLE IF NOT EXISTS `product_inventory` (
  `link_id` INT UNSIGNED NOT NULL,
  `parts_id` INT UNSIGNED NOT NULL,
  `product_inventory_id` INT UNSIGNED NOT NULL,
  `product_quantity` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`link_id`),
  INDEX `product_id_idx` (`parts_id` ASC) VISIBLE,
  INDEX `inventory_id_idx` (`product_inventory_id` ASC) VISIBLE,
  CONSTRAINT `parts_id_fk`
    FOREIGN KEY (`parts_id`)
    REFERENCES `product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `product_inventory_fk`
    FOREIGN KEY (`product_inventory_id`)
    REFERENCES `inventory` (`inventory_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `raw_material`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `raw_material` ;

CREATE TABLE IF NOT EXISTS `raw_material` (
  `material_id` INT UNSIGNED NOT NULL,
  `material_name` VARCHAR(64) NOT NULL,
  `material_des` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`material_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `manage_material`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `manage_material` ;

CREATE TABLE IF NOT EXISTS `manage_material` (
  `action_id` INT UNSIGNED NOT NULL,
  `material_manage_id` INT UNSIGNED NOT NULL,
  `material_id` INT UNSIGNED NOT NULL,
  `material_quantity` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`action_id`),
  INDEX `manage_id_idx` (`material_manage_id` ASC) VISIBLE,
  INDEX `material_id_idx` (`material_id` ASC) VISIBLE,
  CONSTRAINT `material_manage_fk`
    FOREIGN KEY (`material_manage_id`)
    REFERENCES `manager` (`manager_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `material_id_fk`
    FOREIGN KEY (`material_id`)
    REFERENCES `raw_material` (`material_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supplier` ;

CREATE TABLE IF NOT EXISTS `supplier` (
  `supplier_id` INT UNSIGNED NOT NULL,
  `supplier_name` VARCHAR(64) NOT NULL,
  `supplier_address` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `material_supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `material_supplier` ;

CREATE TABLE IF NOT EXISTS `material_supplier` (
  `link_id` INT UNSIGNED NOT NULL,
  `materials_id` INT UNSIGNED NOT NULL,
  `suppliers_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`link_id`),
  INDEX `materials_id_idx` (`materials_id` ASC) VISIBLE,
  INDEX `supplier_id_idx` (`suppliers_id` ASC) VISIBLE,
  CONSTRAINT `materials_id_fk`
    FOREIGN KEY (`materials_id`)
    REFERENCES `raw_material` (`material_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `suppliers_id_fk`
    FOREIGN KEY (`suppliers_id`)
    REFERENCES `supplier` (`supplier_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shipping`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shipping` ;

CREATE TABLE IF NOT EXISTS `shipping` (
  `shipping_id` INT UNSIGNED NOT NULL,
  `shipping_type` VARCHAR(64) NOT NULL,
  `shipping_date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`shipping_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `manage_shipping`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `manage_shipping` ;

CREATE TABLE IF NOT EXISTS `manage_shipping` (
  `action_id` INT UNSIGNED NOT NULL,
  `shipping_manage_id` INT UNSIGNED NOT NULL,
  `ship_id` INT UNSIGNED NOT NULL,
  `autopart_id` INT UNSIGNED NOT NULL,
  `shipping_amount` INT NOT NULL,
  PRIMARY KEY (`action_id`),
  UNIQUE INDEX `autopart_id_UNIQUE` (`autopart_id` ASC) VISIBLE,
  INDEX `shipping_manage_id_idx` (`shipping_manage_id` ASC) VISIBLE,
  INDEX `ship_id_idx` (`ship_id` ASC) VISIBLE,
  CONSTRAINT `shipping_manage_fk`
    FOREIGN KEY (`shipping_manage_id`)
    REFERENCES `manager` (`manager_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `ship_id_fk`
    FOREIGN KEY (`ship_id`)
    REFERENCES `shipping` (`shipping_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delivery` ;

CREATE TABLE IF NOT EXISTS `delivery` (
  `delivery_id` INT UNSIGNED NOT NULL,
  `delivery_name` VARCHAR(64) NOT NULL,
  `delivery_address` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`delivery_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shipping_delivery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shipping_delivery` ;

CREATE TABLE IF NOT EXISTS `shipping_delivery` (
  `link_id` INT UNSIGNED NOT NULL,
  `shipped_id` INT UNSIGNED NOT NULL,
  `deliver_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`link_id`),
  INDEX `ship_deliver_FK_idx` (`deliver_id` ASC) VISIBLE,
  INDEX `ship_fk_idx` (`shipped_id` ASC) VISIBLE,
  CONSTRAINT `deliver_fk`
    FOREIGN KEY (`deliver_id`)
    REFERENCES `delivery` (`delivery_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ship_fk`
    FOREIGN KEY (`shipped_id`)
    REFERENCES `shipping` (`shipping_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `contact_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contact_list` ;

CREATE TABLE IF NOT EXISTS `contact_list` (
  `list_id` INT UNSIGNED NOT NULL,
  `contact_type` VARCHAR(64) NOT NULL,
  `information` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`list_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `manage_contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `manage_contact` ;

CREATE TABLE IF NOT EXISTS `manage_contact` (
  `action_id` INT UNSIGNED NOT NULL,
  `contact_manage_id` INT UNSIGNED NOT NULL,
  `contact_id` INT UNSIGNED NOT NULL,
  `contact_date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`action_id`),
  INDEX `contact_manage_fk_idx` (`contact_manage_id` ASC) VISIBLE,
  INDEX `contact_id_fk_idx` (`contact_id` ASC) VISIBLE,
  CONSTRAINT `contact_manage_fk`
    FOREIGN KEY (`contact_manage_id`)
    REFERENCES `manager` (`manager_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `contact_id_fk`
    FOREIGN KEY (`contact_id`)
    REFERENCES `contact_list` (`list_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `retail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `retail` ;

CREATE TABLE IF NOT EXISTS `retail` (
  `retail_id` INT UNSIGNED NOT NULL,
  `retail_name` VARCHAR(128) NOT NULL,
  `retail_address` VARCHAR(128) NOT NULL,
  `retail_zip` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`retail_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `retail_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `retail_order` ;

CREATE TABLE IF NOT EXISTS `retail_order` (
  `order_id` INT UNSIGNED NOT NULL,
  `order_date` TIMESTAMP NOT NULL,
  `retail_order_id` INT UNSIGNED NOT NULL,
  `product_order_id` INT UNSIGNED NOT NULL,
  `product_amount` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `retail_order_fk_idx` (`retail_order_id` ASC) VISIBLE,
  INDEX `product_order_fk_idx` (`product_order_id` ASC) VISIBLE,
  CONSTRAINT `retail_order_fk`
    FOREIGN KEY (`retail_order_id`)
    REFERENCES `retail` (`retail_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `product_order_fk`
    FOREIGN KEY (`product_order_id`)
    REFERENCES `product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warehouse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `warehouse` ;

CREATE TABLE IF NOT EXISTS `warehouse` (
  `warehouse_id` INT UNSIGNED NOT NULL,
  `warehouse_name` VARCHAR(64) NOT NULL,
  `warehouse_address` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`warehouse_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warehouse_inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `warehouse_inventory` ;

CREATE TABLE IF NOT EXISTS `warehouse_inventory` (
  `link_id` INT UNSIGNED NOT NULL,
  `warehouses_id` INT UNSIGNED NOT NULL,
  `inventories_id` INT UNSIGNED NOT NULL,
  `product_id` INT UNSIGNED NOT NULL,
  `product_quantity` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`link_id`),
  INDEX `warehouse_id_fk_idx` (`warehouses_id` ASC) VISIBLE,
  INDEX `inventory_id_fk_idx` (`inventories_id` ASC) VISIBLE,
  CONSTRAINT `warehouse_id_fk`
    FOREIGN KEY (`warehouses_id`)
    REFERENCES `warehouse` (`warehouse_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `inventories_id_fk`
    FOREIGN KEY (`inventories_id`)
    REFERENCES `inventory` (`inventory_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer` ;

CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` INT UNSIGNED NOT NULL,
  `customer_name` VARCHAR(64) NOT NULL,
  `customer_address` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer_product` ;

CREATE TABLE IF NOT EXISTS `customer_product` (
  `register_id` INT UNSIGNED NOT NULL,
  `customers_id` INT UNSIGNED NOT NULL,
  `register_date` TIMESTAMP NOT NULL,
  `buyer_product_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`register_id`),
  INDEX `customer_id_fk_idx` (`customers_id` ASC) VISIBLE,
  INDEX `product_id_fk_idx` (`buyer_product_id` ASC) VISIBLE,
  CONSTRAINT `customer_id_fk`
    FOREIGN KEY (`customers_id`)
    REFERENCES `customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `buy_product_id_fk`
    FOREIGN KEY (`buyer_product_id`)
    REFERENCES `product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `find_retail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `find_retail` ;

CREATE TABLE IF NOT EXISTS `find_retail` (
  `link_id` INT UNSIGNED NOT NULL,
  `cus_id` INT UNSIGNED NOT NULL,
  `retails_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`link_id`),
  INDEX `cus_id_idx` (`cus_id` ASC) VISIBLE,
  INDEX `retails_id_idx` (`retails_id` ASC) VISIBLE,
  CONSTRAINT `cus_fk`
    FOREIGN KEY (`cus_id`)
    REFERENCES `customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `retails_id_fk`
    FOREIGN KEY (`retails_id`)
    REFERENCES `retail` (`retail_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery_contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delivery_contact` ;

CREATE TABLE IF NOT EXISTS `delivery_contact` (
  `contacts_id` INT UNSIGNED NOT NULL,
  `deliveries_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`contacts_id`),
  INDEX `deliveries_fk_idx` (`deliveries_id` ASC) VISIBLE,
  CONSTRAINT `deliver_contactid_fk`
    FOREIGN KEY (`contacts_id`)
    REFERENCES `contact_list` (`list_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `deliveries_fk`
    FOREIGN KEY (`deliveries_id`)
    REFERENCES `delivery` (`delivery_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supplier_contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supplier_contact` ;

CREATE TABLE IF NOT EXISTS `supplier_contact` (
  `contacts_id` INT UNSIGNED NOT NULL,
  `supply_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`contacts_id`),
  INDEX `supply_fk_idx` (`supply_id` ASC) VISIBLE,
  CONSTRAINT `supplier_contactid_fk`
    FOREIGN KEY (`contacts_id`)
    REFERENCES `contact_list` (`list_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `supply_fk`
    FOREIGN KEY (`supply_id`)
    REFERENCES `supplier` (`supplier_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warehouse_contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `warehouse_contact` ;

CREATE TABLE IF NOT EXISTS `warehouse_contact` (
  `contacts_id` INT UNSIGNED NOT NULL,
  `warehou_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`contacts_id`),
  INDEX `store_fk_idx` (`warehou_id` ASC) VISIBLE,
  CONSTRAINT `warehouse_contactid_fk`
    FOREIGN KEY (`contacts_id`)
    REFERENCES `contact_list` (`list_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `store_fk`
    FOREIGN KEY (`warehou_id`)
    REFERENCES `warehouse` (`warehouse_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer_contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer_contact` ;

CREATE TABLE IF NOT EXISTS `customer_contact` (
  `contacts_id` INT UNSIGNED NOT NULL,
  `consumer_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`contacts_id`),
  INDEX `consumer_fk_idx` (`consumer_id` ASC) VISIBLE,
  CONSTRAINT `customer_contactid_fk`
    FOREIGN KEY (`contacts_id`)
    REFERENCES `contact_list` (`list_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `consumer_fk`
    FOREIGN KEY (`consumer_id`)
    REFERENCES `customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `retail_contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `retail_contact` ;

CREATE TABLE IF NOT EXISTS `retail_contact` (
  `contacts_id` INT UNSIGNED NOT NULL,
  `seller_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`contacts_id`),
  INDEX `seller_fk_idx` (`seller_id` ASC) VISIBLE,
  CONSTRAINT `retail_contactid_fk`
    FOREIGN KEY (`contacts_id`)
    REFERENCES `contact_list` (`list_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `seller_fk`
    FOREIGN KEY (`seller_id`)
    REFERENCES `retail` (`retail_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
