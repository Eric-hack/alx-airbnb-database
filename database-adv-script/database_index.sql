-- Create indexes for high-usage columns in User, Booking, and Property tables

-- Index on Users table (commonly filtered/joined by email or id)
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_id ON users(id);

-- Index on Bookings table (commonly filtered/joined by user_id and property_id)
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_date ON bookings(booking_date);

-- Index on Properties table (commonly searched by location or id)
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_id ON properties(id);
