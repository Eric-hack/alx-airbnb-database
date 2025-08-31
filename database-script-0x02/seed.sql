-- seed.sql
-- Insert sample data for Airbnb Database

-- Insert Users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
    (gen_random_uuid(), 'John', 'Doe', 'john@example.com', 'hashed_pw_123', '+233201111111', 'guest'),
    (gen_random_uuid(), 'Mary', 'Smith', 'mary@example.com', 'hashed_pw_456', '+233202222222', 'host'),
    (gen_random_uuid(), 'Admin', 'User', 'admin@example.com', 'hashed_pw_admin', '+233203333333', 'admin'),
    (gen_random_uuid(), 'Kwame', 'Boateng', 'kwame@example.com', 'hashed_pw_kwame', '+233204444444', 'guest'),
    (gen_random_uuid(), 'Ama', 'Mensah', 'ama@example.com', 'hashed_pw_ama', '+233205555555', 'host');

-- Insert Properties
INSERT INTO properties (property_id, host_id, name, description, address, city, country, pricepernight)
VALUES
    (gen_random_uuid(), (SELECT user_id FROM users WHERE email='mary@example.com'), 'Cozy Beach House', 'Beautiful house near the beach', '123 Beach Rd', 'Accra', 'Ghana', 150.00),
    (gen_random_uuid(), (SELECT user_id FROM users WHERE email='ama@example.com'), 'Modern Apartment', 'Stylish apartment in city center', '45 Ring Rd', 'Kumasi', 'Ghana', 100.00);

-- Insert Bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
    (gen_random_uuid(), (SELECT property_id FROM properties WHERE name='Cozy Beach House'),
     (SELECT user_id FROM users WHERE email='john@example.com'), '2025-09-10', '2025-09-15', 750.00, 'confirmed'),

    (gen_random_uuid(), (SELECT property_id FROM properties WHERE name='Modern Apartment'),
     (SELECT user_id FROM users WHERE email='kwame@example.com'), '2025-10-01', '2025-10-05', 400.00, 'pending');

-- Insert Payments
INSERT INTO payments (payment_id, booking_id, amount, payment_method)
VALUES
    (gen_random_uuid(), (SELECT booking_id FROM bookings WHERE status='confirmed'), 750.00, 'mobile_money');

-- Insert Reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
VALUES
    (gen_random_uuid(), (SELECT property_id FROM properties WHERE name='Cozy Beach House'),
     (SELECT user_id FROM users WHERE email='john@example.com'), 5, 'Amazing stay, highly recommend!'),

    (gen_random_uuid(), (SELECT property_id FROM properties WHERE name='Modern Apartment'),
     (SELECT user_id FROM users WHERE email='kwame@example.com'), 4, 'Great location, clean apartment.');

-- Insert Messages
INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
VALUES
    (gen_random_uuid(),
     (SELECT user_id FROM users WHERE email='john@example.com'),
     (SELECT user_id FROM users WHERE email='mary@example.com'),
     'Hi Mary, is the Beach House available for next month?'),

    (gen_random_uuid(),
     (SELECT user_id FROM users WHERE email='mary@example.com'),
     (SELECT user_id FROM users WHERE email='john@example.com'),
     'Yes John, it is available. You can book anytime!');
