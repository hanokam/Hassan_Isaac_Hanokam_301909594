-- PureHaven Portfolio 5: cloud PostgreSQL sample data
CREATE TABLE IF NOT EXISTS reservations (
    reservation_id SERIAL PRIMARY KEY,
    booking_reference VARCHAR(20) UNIQUE NOT NULL,
    guest_name VARCHAR(100) NOT NULL,
    room_number VARCHAR(10) NOT NULL,
    check_in_date DATE NOT NULL,
    reservation_status VARCHAR(20) NOT NULL
);

INSERT INTO reservations (
    booking_reference, guest_name, room_number, check_in_date, reservation_status
)
VALUES ('PH-DEMO-0001', 'Daniel Musa', '101', '2026-11-01', 'confirmed')
ON CONFLICT (booking_reference) DO NOTHING;

SELECT * FROM reservations;
