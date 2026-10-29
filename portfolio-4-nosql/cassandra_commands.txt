-- Keyspace purehaven was created through the Astra DB portal.
CREATE TABLE IF NOT EXISTS purehaven.room_occupancy_by_hotel_day (
    hotel_id text,
    stay_date date,
    room_id text,
    room_type text,
    occupancy_status text,
    booking_reference text,
    PRIMARY KEY ((hotel_id, stay_date), room_id)
);

INSERT INTO purehaven.room_occupancy_by_hotel_day
(hotel_id, stay_date, room_id, room_type, occupancy_status, booking_reference)
VALUES ('PUREHAVEN', '2026-11-01', '101', 'Deluxe', 'occupied', 'PH-DEMO-0001');

SELECT *
FROM purehaven.room_occupancy_by_hotel_day
WHERE hotel_id = 'PUREHAVEN'
AND stay_date = '2026-11-01';
