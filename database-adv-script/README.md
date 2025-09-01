# SQL Joins Queries – Airbnb Database

This directory contains advanced SQL join queries for the **ALX Airbnb Database Project**.  
The queries demonstrate the use of `INNER JOIN`, `LEFT JOIN`, and `FULL OUTER JOIN` to fetch relational data from multiple tables.

---

##  Files
- **joins_queries.sql** → Contains the SQL queries for joins.
- **README.md** → Documentation explaining the queries.

---

##  Database Context
The Airbnb database has the following key tables with sample data:

- **users** (id, name, email, password, created_at)
- **properties** (id, owner_id, title, location, price, created_at)
- **bookings** (id, user_id, property_id, start_date, end_date, status, created_at)
- **reviews** (id, user_id, property_id, rating, comment, created_at)

---

##  Queries

### 1. INNER JOIN – Retrieve all bookings and the respective users who made those bookings
### 2. LEFT JOIN – Retrieve all properties and their reviews (including properties without reviews)
### 3. FULL OUTER JOIN – Retrieve all users and all bookings


