
# Entity-Relationship Diagram (ERD) Requirements

## Objective
This document defines the entities, attributes, and relationships for the **Airbnb Database** schema, as represented in the ERD.

---

## Entities and Attributes

### 1. User
- **user_id**: Primary Key, UUID, Indexed
- **first_name**: VARCHAR, NOT NULL
- **last_name**: VARCHAR, NOT NULL
- **email**: VARCHAR, UNIQUE, NOT NULL
- **password_hash**: VARCHAR, NOT NULL
- **phone_number**: VARCHAR, NULL
- **role**: ENUM (guest, host, admin), NOT NULL
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### 2. Property
- **property_id**: Primary Key, UUID, Indexed
- **host_id**: Foreign Key → User(user_id)
- **name**: VARCHAR, NOT NULL
- **description**: TEXT, NOT NULL
- **location**: VARCHAR, NOT NULL
- **pricepernight**: DECIMAL, NOT NULL
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- **updated_at**: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

### 3. Booking
- **booking_id**: Primary Key, UUID, Indexed
- **property_id**: Foreign Key → Property(property_id)
- **user_id**: Foreign Key → User(user_id)
- **start_date**: DATE, NOT NULL
- **end_date**: DATE, NOT NULL
- **total_price**: DECIMAL, NOT NULL
- **status**: ENUM (pending, confirmed, canceled), NOT NULL
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### 4. Payment
- **payment_id**: Primary Key, UUID, Indexed
- **booking_id**: Foreign Key → Booking(booking_id)
- **amount**: DECIMAL, NOT NULL
- **payment_date**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- **payment_method**: ENUM (credit_card, paypal, stripe), NOT NULL

### 5. Review
- **review_id**: Primary Key, UUID, Indexed
- **property_id**: Foreign Key → Property(property_id)
- **user_id**: Foreign Key → User(user_id)
- **rating**: INTEGER, CHECK (1 <= rating <= 5), NOT NULL
- **comment**: TEXT, NOT NULL
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### 6. Message
- **message_id**: Primary Key, UUID, Indexed
- **sender_id**: Foreign Key → User(user_id)
- **recipient_id**: Foreign Key → User(user_id)
- **message_body**: TEXT, NOT NULL
- **sent_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

---

## Relationships

1. **User ↔ Property**
   - A User (host) can list many Properties.
   - Each Property belongs to exactly one User (host).

2. **User ↔ Booking**
   - A User (guest) can make many Bookings.
   - Each Booking belongs to exactly one User.

3. **Property ↔ Booking**
   - A Property can be booked many times.
   - Each Booking belongs to exactly one Property.

4. **Booking ↔ Payment**
   - A Booking can have one or more Payments.
   - Each Payment belongs to exactly one Booking.

5. **Property ↔ Review**
   - A Property can have many Reviews.
   - Each Review belongs to exactly one Property.

6. **User ↔ Review**
   - A User (guest) can write many Reviews.
   - Each Review belongs to exactly one User.

7. **User ↔ Message**
   - A User can send many Messages and receive many Messages.
   - Each Message has one sender and one recipient.

---

## Notes
- All Primary Keys are indexed automatically.
- Additional indexes include:
  - **email** in the User table.
  - **property_id** in the Property and Booking tables.
  - **booking_id** in the Booking and Payment tables.

---

**File Location:** `alx-airbnb-database/ERD/requirements.md`

## Diagram (Mermaid)

```mermaid
erDiagram
  USER {
    UUID user_id PK
    VARCHAR first_name
    VARCHAR last_name
    VARCHAR email UNIQUE
    VARCHAR password_hash
    VARCHAR phone_number
    ENUM role
    TIMESTAMP created_at
  }
  PROPERTY {
    UUID property_id PK
    UUID host_id FK
    VARCHAR name
    TEXT description
    VARCHAR address
    VARCHAR city
    VARCHAR country
    DECIMAL pricepernight
    TIMESTAMP created_at
    TIMESTAMP updated_at
  }
  BOOKING {
    UUID booking_id PK
    UUID property_id FK
    UUID user_id FK
    DATE start_date
    DATE end_date
    DECIMAL total_price
    ENUM status
    TIMESTAMP created_at
  }
  PAYMENT {
    UUID payment_id PK
    UUID booking_id FK
    DECIMAL amount
    TIMESTAMP payment_date
    ENUM payment_method
  }
  REVIEW {
    UUID review_id PK
    UUID property_id FK
    UUID user_id FK
    INTEGER rating
    TEXT comment
    TIMESTAMP created_at
  }
  MESSAGE {
    UUID message_id PK
    UUID sender_id FK
    UUID recipient_id FK
    TEXT message_body
    TIMESTAMP sent_at
  }

  USER ||--o{ PROPERTY : hosts
  USER ||--o{ BOOKING  : makes
  PROPERTY ||--o{ BOOKING : has
  BOOKING ||--o{ PAYMENT : pays
  PROPERTY ||--o{ REVIEW : has
  USER ||--o{ REVIEW : writes
  USER ||--o{ MESSAGE : sends
  MESSAGE }o--|| USER : receives
