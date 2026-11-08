`Name:` **Isaac Hanokam Hassan**

`Student ID:` **301909594**
# Portfolio 2: Query Processing and Optimisation

## Objective
Demonstrate SQL reporting queries, examine query execution plan analysis, and investigate indexes for reservation lookups.

## Environment
- Database: `PureHaven_Hotel`
- DBMS: PostgreSQL
- Client: pgAdmin 4

## Reporting queries
Four reports were implemented and tested:
1. Upcoming reservations using joins, date/status filters, ordering, and `LIMIT`.
2. Payment totals grouped by payment status using `COUNT()` and `SUM()`.
3. Room charges per reservation using joins, date arithmetic, and aggregation.
4. Guest reservation counts using joins, `COUNT()`, grouping, and ordering.

## Dataset and validation
The expanded test database contained 503 guests, 64 rooms, and 3,003 reservations. The reservation status counts were: 150 cancelled, 100 checked out, 2,602 confirmed, and 151 pending. Validation returned zero invalid guest/staff references and zero invalid date ranges. Generated records are synthetic.

## Indexes
The following indexes were verified on `reservations`:
- `idx_reservations_guest_id`: B-tree index on `guest_id`.
- `idx_reservations_status_checkin`: composite B-tree index on `(reservation_status, check_in_date)`.
- `reservations_booking_reference_key`: unique index on `booking_reference`.
- `reservations_pkey`: primary-key index on `reservation_id`.

## Observed execution plans
**Original guest lookup:** Sequential scan; one actual row; execution time 0.032 ms.

**Expanded guest lookup:** Index Scan using `idx_reservations_guest_id`; seven actual rows; execution time 0.027 ms; three shared buffer hits.

**Upcoming reservations:** Bitmap Index Scan using `idx_reservations_status_checkin`, followed by Bitmap Heap Scan and top-N heapsort; 525 rows matched the conditions, 20 were returned; execution time 0.465 ms; 33 shared buffer hits.

## Analysis
The plans demonstrate that PostgreSQL chooses access methods based on query conditions, available indexes, table statistics, and estimated costs. A sequential scan was chosen for the tiny original table, while the expanded guest lookup used the guest index. The upcoming-reservations query used the composite index to identify matching rows before retrieving and sorting them.

These timings are individual observations, not a controlled benchmark. The 0.032 ms and 0.027 ms measurements were taken on different dataset sizes, so the difference cannot be attributed solely to the index. A controlled comparison with equivalent data and cache conditions would be required to quantify the index's effect.

Indexes can speed up selective lookups but consume storage and add maintenance overhead to inserts, updates, and deletes. The actual execution plan should guide evaluation rather than assuming an index is always faster.

## Conclusion
The activity demonstrated SQL reporting, composite index creation, index verification, and data validation. The observed plans illustrated sequential, index, and bitmap access strategies. The experiment also showed why timing results must be interpreted cautiously.
