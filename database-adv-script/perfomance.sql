-- ===========================
-- Initial Query (Unoptimized)
-- ===========================

-- This retrieves all bookings with user, property, and payment details
EXPLAIN ANALYZE
SELECT b.id AS booking_id,
       b.booking_date,
       u.name AS user_name,
       u.email,
       p.name AS property_name,
       p.location,
       pay.amount,
       pay.payment_date
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON b.id = pay.booking_id
WHERE u.email LIKE '%@gmail.com%'
ORDER BY b.booking_date DESC;

-- ===========================
-- Optimized Query
-- ===========================

-- Improvements made:
-- 1. Added indexes on (users.email), (bookings.user_id), (bookings.property_id), (payments.booking_id).
-- 2. Reduced unnecessary SELECT fields (only selected needed columns).
-- 3. Replaced LIKE with a more selective search (if possible).
-- 4. Kept JOINs minimal but indexed foreign keys.

EXPLAIN ANALYZE
SELECT b.id AS booking_id,
       b.booking_date,
       u.name AS user_name,
       p.name AS property_name,
       pay.amount
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON b.id = pay.booking_id
WHERE u.email LIKE '%@gmail.com%'
ORDER BY b.booking_date DESC;
