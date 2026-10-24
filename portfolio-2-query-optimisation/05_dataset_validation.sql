-- Table counts
SELECT
    (SELECT COUNT(*) FROM guests) AS guests,
    (SELECT COUNT(*) FROM rooms) AS rooms,
    (SELECT COUNT(*) FROM reservations) AS reservations,
    (SELECT COUNT(*) FROM reservation_rooms) AS room_assignments,
    (SELECT COUNT(*) FROM payments) AS payments;

-- Reservation counts by status
SELECT reservation_status, COUNT(*) AS reservation_count
FROM reservations
GROUP BY reservation_status
ORDER BY reservation_status;

-- Invalid guest/staff references (expected: 0)
SELECT COUNT(*) AS invalid_references
FROM reservations r
LEFT JOIN guests g ON g.guest_id = r.guest_id
LEFT JOIN staff s ON s.staff_id = r.staff_id
WHERE g.guest_id IS NULL
   OR (r.staff_id IS NOT NULL AND s.staff_id IS NULL);

-- Invalid date ranges (expected: 0)
SELECT COUNT(*) AS invalid_date_ranges
FROM reservations
WHERE check_out_date <= check_in_date;

-- Index definitions
SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'reservations'
ORDER BY indexname;