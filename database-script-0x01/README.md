# Database Schema (DDL) - database-script-0x01

This folder contains the SQL DDL to create the Airbnb database schema.

Files:
- schema.sql : PostgreSQL DDL (tables, constraints, indexes)
- README.md  : this file

How to run:
- PostgreSQL:
  - Ensure Postgres is running and you have permission to create the uuid-ossp extension:
    psql -U <user> -d <db> -f schema.sql

Notes:
- The script uses UUID default generation via uuid_generate_v4() (uuid-ossp extension).
- A trigger updates properties.updated_at on UPDATE.
