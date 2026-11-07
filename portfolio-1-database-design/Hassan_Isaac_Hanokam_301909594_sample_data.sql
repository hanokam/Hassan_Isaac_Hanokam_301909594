
-- PureHaven Hotel: sample data

INSERT INTO guests (full_name, email, phone)
VALUES
    ('Amina Bello', 'amina@test.com', '08030000001'),
    ('Daniel James', 'daniel@test.com', '08030000002'),
    ('Grace Musa', 'grace@test.com', '08030000003');

INSERT INTO room_types (type_name, description, capacity, nightly_rate)
VALUES
    ('Standard', 'Comfortable standard accommodation', 2, 35000.00),
    ('Deluxe', 'Spacious room with upgraded amenities', 2, 55000.00),
    ('Suite', 'Premium suite accommodation', 4, 95000.00);

INSERT INTO rooms (room_number, room_type_id, floor_number)
VALUES
    ('101', 1, 1),
    ('102', 1, 1),
    ('201', 2, 2),
    ('301', 3, 3);

INSERT INTO staff (full_name, email, job_role)
VALUES
    ('Samuel Ade', 'samuel@test.com', 'Receptionist'),
    ('Esther John', 'esther@test.com', 'Hotel Manager');

INSERT INTO reservations (
    booking_reference, guest_id, staff_id,
    check_in_date, check_out_date, reservation_status
)
VALUES
    ('PH-2026-001', 1, 1, DATE '2026-11-10', DATE '2026-11-13', 'confirmed'),
    ('PH-2026-002', 2, 1, DATE '2026-11-12', DATE '2026-11-15', 'confirmed'),
    ('PH-2026-003', 3, 2, DATE '2026-11-20', DATE '2026-11-22', 'pending');

INSERT INTO reservation_rooms (
    reservation_id, room_id, nightly_rate
)
VALUES
    (1, 1, 35000.00),
    (1, 3, 55000.00),
    (2, 2, 35000.00),
    (3, 4, 95000.00);

INSERT INTO payments (
    reservation_id, payment_reference, amount,
    payment_method, payment_status, paid_at
)
VALUES
    (1, 'PAY-PH-001', 50000.00, 'bank_transfer',
     'completed', CURRENT_TIMESTAMP),
    (2, 'PAY-PH-002', 35000.00, 'card',
     'completed', CURRENT_TIMESTAMP),
    (3, 'PAY-PH-003', 20000.00, 'cash',
     'pending', NULL);

-- Verify room assignments.
SELECT
    r.booking_reference,
    g.full_name AS guest_name,
    rm.room_number,
    rt.type_name AS room_type,
    rr.nightly_rate,
    r.check_in_date,
    r.check_out_date
FROM reservations AS r
JOIN guests AS g
    ON r.guest_id = g.guest_id
JOIN reservation_rooms AS rr
    ON r.reservation_id = rr.reservation_id
JOIN rooms AS rm
    ON rr.room_id = rm.room_id
JOIN room_types AS rt
    ON rm.room_type_id = rt.room_type_id
ORDER BY r.reservation_id, rm.room_number;
