-- Guest lookup: recorded expanded-data plan used idx_reservations_guest_id.
EXPLAIN (ANALYZE, BUFFERS)
SELECT
    reservation_id,
    booking_reference,
    check_in_date,
    check_out_date,
    reservation_status
FROM reservations
WHERE guest_id = 1;

-- Upcoming reservations: recorded plan used the composite index via
-- Bitmap Index Scan, then Bitmap Heap Scan and top-N heapsort.
EXPLAIN (ANALYZE, BUFFERS)
SELECT
    reservation_id,
    booking_reference,
    check_in_date,
    check_out_date,
    reservation_status
FROM reservations
WHERE check_in_date >= CURRENT_DATE
  AND reservation_status IN ('confirmed', 'pending')
ORDER BY check_in_date
LIMIT 20;