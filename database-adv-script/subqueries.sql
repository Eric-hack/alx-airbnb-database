-- Query 1: Find all properties where the average rating is greater than 4.0
SELECT 
    p.id AS property_id,
    p.name AS property_name,
    (SELECT AVG(r.rating) 
     FROM reviews r 
     WHERE r.property_id = p.id) AS avg_rating
FROM properties p
WHERE (SELECT AVG(r.rating) 
       FROM reviews r 
       WHERE r.property_id = p.id) > 4.0
ORDER BY avg_rating DESC;

-- Query 2: Correlated subquery to find users who have made more than 3 bookings
SELECT 
    u.id AS user_id,
    u.username,
    u.email
FROM users u
WHERE (
    SELECT COUNT(*) 
    FROM bookings b 
    WHERE b.user_id = u.id
) > 3
ORDER BY u.id;
