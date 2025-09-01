-- ===============================================
-- 1. INNER JOIN
-- Retrieve all bookings and the respective users who made those bookings
-- ===============================================
SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id;


-- ===============================================
-- 2. LEFT JOIN
-- Retrieve all properties and their reviews, including properties with no reviews
-- ===============================================
SELECT 
    p.property_id,
    p.name AS property_name,
    p.city,
    p.country,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date
FROM properties p
LEFT JOIN reviews r ON p.property_id = r.property_id;


-- ===============================================
-- 3. FULL OUTER JOIN
-- Retrieve all users and all bookings,
-- even if a user has no booking OR a booking has no valid user
-- ===============================================

-- PostgreSQL (direct FULL OUTER JOIN support)
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.status
FROM users u
FULL OUTER JOIN bookings b ON u.user_id = b.user_id;

