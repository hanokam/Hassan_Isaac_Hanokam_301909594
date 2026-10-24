-- Query 1: Upcoming reservations
SELECT
    r.booking_reference,
    g.full_name AS guest_name,
    r.check_in_date,
    r.check_out_date,
    r.reservation_status
FROM reservations AS r
JOIN guests AS g ON g.guest_id = r.guest_id
WHERE r.check_in_date >= CURRENT_DATE
  AND r.reservation_status IN ('confirmed', 'pending')
ORDER BY r.check_in_date
LIMIT 20;

-- Query 2: Payment summary by status
SELECT
    payment_status,
    COUNT(*) AS number_of_payments,
    SUM(amount) AS total_amount
FROM payments
GROUP BY payment_status
ORDER BY total_amount DESC;

-- Query 3: Total room charge per reservation
SELECT
    r.booking_reference,
    g.full_name AS guest_name,
    r.check_in_date,
    r.check_out_date,
    SUM(
        rr.nightly_rate * (r.check_out_date - r.check_in_date)
    ) AS total_room_charge
FROM reservations AS r
JOIN guests AS g ON g.guest_id = r.guest_id
JOIN reservation_rooms AS rr ON rr.reservation_id = r.reservation_id
WHERE r.reservation_status <> 'cancelled'
GROUP BY
    r.reservation_id,
    r.booking_reference,
    g.full_name,
    r.check_in_date,
    r.check_out_date
ORDER BY total_room_charge DESC
LIMIT 20;

-- Query 4: Top guests by reservation count
SELECT
    g.guest_id,
    g.full_name,
    COUNT(r.reservation_id) AS reservation_count
FROM guests AS g
JOIN reservations AS r ON r.guest_id = g.guest_id
GROUP BY g.guest_id, g.full_name
ORDER BY reservation_count DESC, g.full_name
LIMIT 10;