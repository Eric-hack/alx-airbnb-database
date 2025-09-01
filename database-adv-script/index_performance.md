# Index Performance Analysis

## Objective
The goal of this task is to improve query performance by identifying frequently used columns in the **Users**, **Bookings**, and **Properties** tables and creating appropriate indexes.

---

## Indexes Implemented
- **Users table**
  - `idx_users_email` → improves lookups by email (e.g., login/authentication).
  - `idx_users_id` → optimizes joins on user_id.

- **Bookings table**
  - `idx_bookings_user_id` → speeds up queries filtering bookings by a user.
  - `idx_bookings_property_id` → optimizes joins between bookings and properties.
  - `idx_bookings_date` → accelerates queries filtering or ordering by booking date.

- **Properties table**
  - `idx_properties_location` → improves searches by location.
  - `idx_properties_id` → optimizes joins and lookups by property_id.

---

## Performance Measurement

### Example Query Without Index
```sql
EXPLAIN ANALYZE
SELECT u.name, COUNT(b.id) AS total_bookings
FROM users u
JOIN bookings b ON u.id = b.user_id
WHERE u.email = 'john.doe@example.com'
GROUP BY u.name;
