-- Roles table
CREATE TABLE IF NOT EXISTS role (
    id INT AUTO_INCREMENT PRIMARY KEY,
    role VARCHAR(20) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Clients table
CREATE TABLE IF NOT EXISTS client (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    mail VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(20) NOT NULL UNIQUE,
    city VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    role_id INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (role_id) REFERENCES role(id)
);

-- Inquiries table
CREATE TABLE IF NOT EXISTS inquiries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255),
    mail VARCHAR(255),
    inquiry_msg TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Admin table
CREATE TABLE IF NOT EXISTS admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    admin_name VARCHAR(255) NOT NULL UNIQUE,
    mail VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(20) NOT NULL UNIQUE,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    role_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES role(id)
);

-- Service category table
CREATE TABLE IF NOT EXISTS service_category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Sample photos table
CREATE TABLE IF NOT EXISTS sample_photos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    file_path VARCHAR(255) NOT NULL,
    service_category_id INT NOT NULL,
    service_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (service_category_id) REFERENCES service_category(id)
);

-- Photoshoot table
CREATE TABLE IF NOT EXISTS photoshoot (
    id INT AUTO_INCREMENT PRIMARY KEY,
    photoshoot_name VARCHAR(255) NOT NULL UNIQUE,
    price VARCHAR(255) NOT NULL,
    durarion VARCHAR(20) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    service_category_id INT NOT NULL,
    FOREIGN KEY (service_category_id) REFERENCES service_category(id)
);

-- Frames table
CREATE TABLE IF NOT EXISTS frames (
    id INT AUTO_INCREMENT PRIMARY KEY,
    material_name VARCHAR(255) NOT NULL UNIQUE,
    size VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL,
    price VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    service_category_id INT NOT NULL,
    FOREIGN KEY (service_category_id) REFERENCES service_category(id)
);

-- Printings table
CREATE TABLE IF NOT EXISTS printings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    printing_name VARCHAR(255) NOT NULL UNIQUE,
    price VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    service_category_id INT NOT NULL,
    FOREIGN KEY (service_category_id) REFERENCES service_category(id)
);

-- Feedback table
CREATE TABLE IF NOT EXISTS feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    feedback TEXT NOT NULL,
    rating INT NOT NULL,
    reply_msg TEXT DEFAULT NULL,
    client_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES client(id)
);

-- Cart table
CREATE TABLE IF NOT EXISTS cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    service_category_id INT NOT NULL,
    service_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    client_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (service_category_id) REFERENCES service_category(id),
    FOREIGN KEY (client_id) REFERENCES client(id)
);

-- Orders table
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES client(id)
);

-- Order details table
CREATE TABLE IF NOT EXISTS order_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    service_category_id INT NOT NULL,
    service_id INT NOT NULL,
    quantity INT NOT NULL,
    status ENUM('processing','editing','awaiting_approval','reediting','approved','in_production','ready_for_delivery','delivered','cancelled') NOT NULL DEFAULT 'processing',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (service_category_id) REFERENCES service_category(id),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Order delivery details table
CREATE TABLE IF NOT EXISTS order_delivery_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    sender_phone_number VARCHAR(30) NOT NULL,
    receiver_phone_number VARCHAR(30) NOT NULL,
    receiver_name VARCHAR(255) NOT NULL,
    receiver_district VARCHAR(255) NOT NULL,
    receiver_city VARCHAR(255) NOT NULL,
    receiver_street VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Client photos for orders
CREATE TABLE IF NOT EXISTS client_photos_for_orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_details_id INT NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    client_message TEXT DEFAULT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_details_id) REFERENCES order_details(id)
);

-- Edited photos table
CREATE TABLE IF NOT EXISTS edited_photos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_details_id INT NOT NULL,
    photo_path VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_details_id) REFERENCES order_details(id)
);

-- Payment details table
CREATE TABLE IF NOT EXISTS payment_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    client_id INT NOT NULL,
    advance_amount DECIMAL(10,2),
    total_amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Cash','Card') NOT NULL,
    status ENUM('processing','parcial_payment','complete','failed') NOT NULL DEFAULT 'processing',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES client(id),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Invoice table
CREATE TABLE IF NOT EXISTS invoice (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);
