
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

```mermaid
erDiagram
  USER {
    int user_id PK
    string first_name
    string last_name
    string email
    string password_hash
    string phone_number
    string role
    date created_at
  }

  PROPERTY {
    int property_id PK
    int host_id FK
    string name
    string description
    string address
    string city
    string country
    float pricepernight
    date created_at
    date updated_at
  }

  BOOKING {
    int booking_id PK
    int property_id FK
    int user_id FK
    date start_date
    date end_date
    float total_price
    string status
    date created_at
  }

  PAYMENT {
    int payment_id PK
    int booking_id FK
    float amount
    date payment_date
    string payment_method
  }

  REVIEW {
    int review_id PK
    int property_id FK
    int user_id FK
    int rating
    string comment
    date created_at
  }

  MESSAGE {
    int message_id PK
    int sender_id FK
    int recipient_id FK
    string message_body
    date sent_at
  }

  USER ||--o{ PROPERTY : hosts
  USER ||--o{ BOOKING  : makes
  PROPERTY ||--o{ BOOKING : has
  BOOKING ||--o{ PAYMENT : pays
  PROPERTY ||--o{ REVIEW : has
  USER ||--o{ REVIEW : writes
  USER ||--o{ MESSAGE : sends
  MESSAGE }o--|| USER : receives
