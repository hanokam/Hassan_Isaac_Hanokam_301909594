-- Run on the selected branch/compute to compare results.
SELECT booking_reference, guest_name, room_number, reservation_status
FROM reservations
WHERE booking_reference = 'PH-DEMO-0001';

-- Run only while the test branch is selected.
-- This intentionally changes the test branch, not production.
UPDATE reservations
SET reservation_status = 'checked_in'
WHERE booking_reference = 'PH-DEMO-0001';

-- Read-only check for primary and replica.
SELECT booking_reference, reservation_status
FROM reservations
WHERE booking_reference = 'PH-DEMO-0001';
