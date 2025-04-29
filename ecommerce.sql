  -- creating the database
  CREATE DATABASE ecommerce;

  USE ecommerce;

-- 1. brand
CREATE TABLE brand (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

-- 2. product_category
CREATE TABLE product_category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

-- 3. product
CREATE TABLE product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    brand_id INT,
    category_id INT,
    base_price DECIMAL(10,2),
    description TEXT,
    FOREIGN KEY (brand_id) REFERENCES brand(id),
    FOREIGN KEY (category_id) REFERENCES product_category(id)
);

-- 4. product_item
CREATE TABLE product_item (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    sku VARCHAR(100) NOT NULL UNIQUE,
    stock_quantity INT DEFAULT 0,
    price_override DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

-- 5. product_image
CREATE TABLE product_image (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_item_id INT NOT NULL,
    image_url VARCHAR(500) NOT NULL,
    alt_text VARCHAR(255),
    FOREIGN KEY (product_item_id) REFERENCES product_item(id)
);

-- 6. color
CREATE TABLE color (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    hex_code VARCHAR(7)  -- e.g., #FFFFFF
);

-- 7. size_category
CREATE TABLE size_category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 8. size_option
CREATE TABLE size_option (
    id INT AUTO_INCREMENT PRIMARY KEY,
    size_category_id INT NOT NULL,
    value VARCHAR(50) NOT NULL,
    FOREIGN KEY (size_category_id) REFERENCES size_category(id)
);

-- 9. product_variation
CREATE TABLE product_variation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_item_id INT NOT NULL,
    color_id INT,
    size_option_id INT,
    FOREIGN KEY (product_item_id) REFERENCES product_item(id),
    FOREIGN KEY (color_id) REFERENCES color(id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(id)
);

-- 10. attribute_category
CREATE TABLE attribute_category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 11. attribute_type
CREATE TABLE attribute_type (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category_id INT,
    data_type VARCHAR(50) NOT NULL, -- e.g., 'text', 'number', 'boolean'
    FOREIGN KEY (category_id) REFERENCES attribute_category(id)
);

-- 12. product_attribute
CREATE TABLE product_attribute (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_item_id INT NOT NULL,
    attribute_type_id INT NOT NULL,
    value VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_item_id) REFERENCES product_item(id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(id)
);
