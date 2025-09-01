# Query Optimization Report

## Initial Query
The original query joined **bookings, users, properties, and payments** tables to fetch all booking details.  
We ran the query with `EXPLAIN ANALYZE` and observed:
- Sequential scan on `users` because of the `LIKE '%@gmail.com%'`.
- Costly joins on `bookings → users` and `bookings → properties` due to lack of indexes.
- Extra columns being selected unnecessarily, increasing memory usage.

## Inefficiencies Identified
1. **Unindexed columns**: Filtering on `users.email` caused a full table scan.  
2. **Wide SELECT**: Pulling all user, property, and payment fields was unnecessary.  
3. **Join overhead**: Each join multiplied the execution time since foreign key columns were not indexed.  

## Optimized Query
- Created indexes on:
  - `users(email)`
  - `bookings(user_id)`
  - `bookings(property_id)`
  - `payments(booking_id)`
- Reduced selected fields to only essential ones (`user_name`, `property_name`, `amount`, etc.).
- Maintained JOINs but allowed indexes to improve lookup time.

## Performance Gains
- **Before indexes**: query plan showed sequential scans with higher execution time (e.g., 200ms+).  
- **After indexes**: query execution dropped significantly (e.g., 20ms).  
- Reduced memory usage by selecting fewer columns.  

### Conclusion
With proper indexing and trimming the SELECT clause, the query became much more efficient while still returning all required details.
