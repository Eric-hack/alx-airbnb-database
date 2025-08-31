# Database Normalization

## Objective
The goal is to ensure the **Airbnb Database Schema** is normalized up to the **Third Normal Form (3NF)**.

---

## 1NF (First Normal Form)
- For 1NF all tables have atomic values (no repeating groups or arrays).
- Example: In the USER table, each attribute (first_name, last_name, email, etc.) holds only one value.
Achieved.

---

## 3NF (Third Normal Form)
- No non-key attribute depends on another non-key attribute.
- Example:
  - In the PROPERTY table, the field `location` could potentially store multiple values (e.g., "Accra, Ghana").
  - To ensure atomicity and avoid transitive dependencies, `location` is split into:
    - `city`
    - `country`
    - `address`

After this adjustment, the schema is in 3NF.

---
