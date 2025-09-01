
-- Partitioning the Booking table by start_date
-- Step 1: Create a new partitioned table (assumes PostgreSQL)
DROP TABLE IF EXISTS booking_partitioned CASCADE;

CREATE TABLE booking_partitioned (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    payment_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(50)
) PARTITION BY RANGE (start_date);

-- Step 2: Create partitions for each year (example: 2023, 2024, 2025)
CREATE TABLE booking_2023 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE booking_2024 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE booking_2025 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Step 3: Example query testing performance
-- Fetch bookings in 2024 (will only scan booking_2024 partition)
EXPLAIN ANALYZE
SELECT *
FROM booking_partitioned
WHERE start_date BETWEEN '2024-03-01' AND '2024-03-31';
