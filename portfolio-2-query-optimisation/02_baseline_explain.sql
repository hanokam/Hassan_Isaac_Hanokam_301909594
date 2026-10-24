EXPLAIN (ANALYZE, BUFFERS)
SELECT
    reservation_id,
    booking_reference,
    check_in_date,
    check_out_date,
    reservation_status
FROM reservations
WHERE guest_id = 1;

-- Expanded dataset: run ANALYZE, then the same query.
ANALYZE reservations;

EXPLAIN (ANALYZE, BUFFERS)
SELECT
    reservation_id,
    booking_reference,
    check_in_date,
    check_out_date,
    reservation_status
FROM reservations
WHERE guest_id = 1;