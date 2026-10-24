CREATE INDEX idx_reservations_guest_id
ON reservations (guest_id);

CREATE INDEX idx_reservations_status_checkin
ON reservations (reservation_status, check_in_date);

ANALYZE reservations;

-- Verify index definitions
SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'reservations'
ORDER BY indexname;