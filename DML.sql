INSERT INTO offices (country, phone) VALUES
('Egypt', '123-456-7890'),
('Germany', '123-456-7891');

INSERT INTO cars (plate_id, model, year, status, office_id, price_per_day) VALUES
('ABC123', 'Toyota Camry', 2022, 'active', 1, 50.00),
('XYZ789', 'Honda Civic', 2021, 'active', 1, 45.00),
('DEF456', 'Ford Mustang', 2023, 'active', 2, 75.00);

INSERT INTO customers (fname, lname, email, password, phone) VALUES
('John', 'Doe', 'john@example.com', 'password123', '123-555-0101'),
('Jane', 'Smith', 'jane@example.com', 'password456', '123-555-0102');
INSERT INTO admin (fname, lname, email, password) VALUES
('Admin', 'User', 'admin@example.com', 'adminpass123'),
('Super', 'Admin', 'super@example.com', 'superpass456');

INSERT INTO reservations (customer_ssn, plate_id, reservation_date, pickup_date, return_date, price, status) VALUES
(1, 'ABC123', '2023-12-01 10:00:00', '2023-12-02 10:00:00', '2023-12-05 10:00:00', 150.00, 'active'),
(2, 'XYZ789', '2023-12-02 14:00:00', '2023-12-03 14:00:00', '2023-12-04 14:00:00', 45.00, 'completed');

INSERT INTO payments (reservation_id, amount) VALUES
(1, 150.00),
(2, 45.00);