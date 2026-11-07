-- PureHaven Hotel Management System
-- Portfolio 1: Database Design and Modelling

CREATE TABLE guests (
    guest_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(120) NOT NULL,
    email VARCHAR(150) UNIQUE,
    phone VARCHAR(30),
    registered_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE room_types (
    room_type_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    capacity INTEGER NOT NULL CHECK (capacity > 0),
    nightly_rate NUMERIC(12, 2) NOT NULL CHECK (nightly_rate >= 0)
);

CREATE TABLE rooms (
    room_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type_id INTEGER NOT NULL
        REFERENCES room_types(room_type_id),
    floor_number INTEGER NOT NULL CHECK (floor_number >= 0),
    room_status VARCHAR(20) NOT NULL DEFAULT 'available'
        CHECK (room_status IN ('available', 'maintenance', 'out_of_service'))
);

CREATE TABLE staff (
    staff_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(120) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    job_role VARCHAR(50) NOT NULL
);

CREATE TABLE reservations (
    reservation_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    booking_reference VARCHAR(20) NOT NULL UNIQUE,
    guest_id INTEGER NOT NULL REFERENCES guests(guest_id),
    staff_id INTEGER REFERENCES staff(staff_id),
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    reservation_status VARCHAR(20) NOT NULL DEFAULT 'confirmed'
        CHECK (reservation_status IN (
            'pending', 'confirmed', 'checked_in',
            'checked_out', 'cancelled'
        )),
    booked_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (check_out_date > check_in_date)
);

CREATE TABLE reservation_rooms (
    reservation_room_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    reservation_id INTEGER NOT NULL
        REFERENCES reservations(reservation_id),
    room_id INTEGER NOT NULL REFERENCES rooms(room_id),
    nightly_rate NUMERIC(12, 2) NOT NULL CHECK (nightly_rate >= 0),
    UNIQUE (reservation_id, room_id)
);

CREATE TABLE payments (
    payment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    reservation_id INTEGER NOT NULL
        REFERENCES reservations(reservation_id),
    payment_reference VARCHAR(50) NOT NULL UNIQUE,
    amount NUMERIC(12, 2) NOT NULL CHECK (amount > 0),
    payment_method VARCHAR(20) NOT NULL
        CHECK (payment_method IN (
            'cash', 'card', 'bank_transfer', 'online'
        )),
    payment_status VARCHAR(20) NOT NULL DEFAULT 'pending'
        CHECK (payment_status IN (
            'pending', 'completed', 'failed', 'refunded'
        )),
    paid_at TIMESTAMPTZ
);

CREATE TABLE stays (
    stay_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    reservation_room_id INTEGER NOT NULL UNIQUE
        REFERENCES reservation_rooms(reservation_room_id),
    check_in_at TIMESTAMPTZ,
    check_out_at TIMESTAMPTZ,
    CHECK (
        check_out_at IS NULL
        OR (
            check_in_at IS NOT NULL
            AND check_out_at > check_in_at
        )
    )
);
