CREATE DATABASE car_rental;

USE car_rental;

CREATE TABLE offices (
    office_id INT PRIMARY KEY AUTO_INCREMENT,
    country VARCHAR(255) NOT NULL,
    phone VARCHAR(20)    
);

CREATE TABLE cars (
    plate_id VARCHAR(10) PRIMARY KEY,
    model VARCHAR(20) NOT NULL,
    year INT NOT NULL,
    status ENUM('active', 'rented','out_of_service') DEFAULT 'active',
    office_id INT NOT NULL,
    price_per_day DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (office_id) REFERENCES offices(office_id) ON DELETE RESTRICT
);

CREATE TABLE customers (
    SSN INT PRIMARY KEY AUTO_INCREMENT,
    fname VARCHAR(30) NOT NULL,
    lname VARCHAR(30) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(20) NOT NULL,
    phone VARCHAR(20) NOT NULL    
);

CREATE TABLE reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_ssn INT NOT NULL,
    plate_id VARCHAR(10) NOT NULL,  
    reservation_date DATETIME NOT NULL,
    pickup_date DATETIME NOT NULL,
    return_date DATETIME NOT NULL,
    actual_return_date DATETIME,   
    cancellation_date DATETIME,
    price DECIMAL(10, 2) NOT NULL,
    status ENUM('active','picked_up','completed', 'cancelled') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_ssn) REFERENCES customers(SSN) ON DELETE RESTRICT,
    FOREIGN KEY (plate_id) REFERENCES cars(plate_id) ON DELETE RESTRICT
);

CREATE TABLE admin (
    admin_ssn INT PRIMARY KEY AUTO_INCREMENT,
    fname VARCHAR(30) NOT NULL,
    lname VARCHAR(30) NOT NULL,
    email VARCHAR(50) NOT NULL,
    password VARCHAR(20) NOT NULL    
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    reservation_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id) ON DELETE RESTRICT
);

ALTER TABLE customers MODIFY COLUMN password VARCHAR(255);                          