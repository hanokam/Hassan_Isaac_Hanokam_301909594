`Name:` **Isaac Hanokam Hassan**

`Student ID:` **301909594**

# Portfolio 5: Distributed and Cloud Database Exercise

## Introduction
This portfolio investigates how a cloud-hosted PostgreSQL database can support a hotel management system through branching, snapshots, read replicas, consistency checks, and a discussion of sharding and availability.

The case study is **PureHaven Hotel**, a single-hotel reservation system. The practical demonstration uses a small fictional reservation record and a Neon cloud PostgreSQL project, done on the browser; no local database server or Docker installation was required.

## Objectives
1. Create and query a cloud-hosted PostgreSQL database.
2. Create a separate database branch for testing.
3. Demonstrate branch isolation by changing a record in the test branch and checking production.
4. Create a manual snapshot using the platform's Backup & Restore interface.
5. Create a read replica and execute a read query using its compute.
6. Compare the same reservation on the primary and replica.
7. Discuss replication, consistency, sharding, availability, and recovery limitations.

## Cloud environment and sample data
A Neon project named `PureHaven-Distributed-DB` was created on the Free plan. A sample reservation was added to the `production` branch. The record used was fictional.

### SQL used to create the sample table
```sql
CREATE TABLE IF NOT EXISTS reservations (
    reservation_id SERIAL PRIMARY KEY,
    booking_reference VARCHAR(20) UNIQUE NOT NULL,
    guest_name VARCHAR(100) NOT NULL,
    room_number VARCHAR(10) NOT NULL,
    check_in_date DATE NOT NULL,
    reservation_status VARCHAR(20) NOT NULL
);

INSERT INTO reservations (
    booking_reference,
    guest_name,
    room_number,
    check_in_date,
    reservation_status
)
VALUES (
    'PH-DEMO-0001',
    'Daniel Musa',
    '101',
    '2026-11-01',
    'confirmed'
)
ON CONFLICT (booking_reference) DO NOTHING;

SELECT * FROM reservations;
```

## Branching and isolation experiment
A branch named `purehaven-test-branch` was created from the `production` branch. The reservation was visible in the test branch.

The following update was executed only while the test branch was selected:

```sql
UPDATE reservations
SET reservation_status = 'checked_in'
WHERE booking_reference = 'PH-DEMO-0001';

SELECT booking_reference, guest_name, reservation_status
FROM reservations
WHERE booking_reference = 'PH-DEMO-0001';
```

The test branch returned `checked_in`. After switching back to `production`, the same reservation still returned `confirmed`.


**Finding:** The test change was isolated from the production branch. This illustrates why database branching is useful for testing and development without changing the parent branch.

**Important distinction:** Branching is not the same as read replication or an independent backup. A branch is a separate database branch based on a parent state; it should not be described as proof of automatic failover.

## Snapshot and recovery evidence
A manual snapshot was created successfully through Neon’s **Backup & Restore** interface for the production branch. The interface also showed a point-in-time history window. The dashboard indicated that scheduled snapshot configuration required an upgrade.

A snapshot provides a recovery point. It is different from a read replica: a replica can serve read queries, while a snapshot is intended to support recovery to an earlier state.

This portfolio records successful snapshot creation. It does **not** claim that a restore operation was performed or that a full disaster-recovery test was completed.

## Read replica demonstration
A read replica was created in the Neon project without upgrading the plan. The replica was visible in the Computes/Read Replicas interface. The compute selector was changed to the replica, and the reservation SELECT query ran successfully.

The following read-only query was used:

```sql
SELECT
    booking_reference,
    guest_name,
    room_number,
    reservation_status
FROM reservations
WHERE booking_reference = 'PH-DEMO-0001';
```

The primary and replica were then checked separately:

```sql
SELECT booking_reference, reservation_status
FROM reservations
WHERE booking_reference = 'PH-DEMO-0001';
```

Both returned `PH-DEMO-0001` with status `confirmed` at the time of testing.

**Finding:** The replica successfully served the sample read query, and the primary and replica returned matching status values during the check.

**Limitation:** This is a point-in-time check for one sample row. It does not prove that replication lag is always zero, that all data is identical, or that automatic failover is configured and tested.

## Distributed database concepts

### Replication
Replication copies data from a primary database to one or more replicas. A read replica may serve reporting and other read-only requests, reducing the read workload on the primary database.

For PureHaven, reservation creation, cancellation, and payment-related changes should be handled with appropriate transactional guarantees on the primary or another correctly configured write endpoint. A replica may lag behind recent writes, so the application should avoid relying on potentially stale replica results for decisions where up-to-date availability is critical.

### Consistency
Consistency concerns whether clients observe the same and sufficiently up-to-date data across database nodes. The primary and read replica returned the same status for `PH-DEMO-0001` during this exercise.

That result is evidence of agreement at the time of the test, not a guarantee of zero lag under all conditions. A production system should understand the provider's replication guarantees and route read-after-write operations appropriately.

### Sharding
Sharding divides a dataset across multiple database nodes or partitions. For a future PureHaven hotel chain, a possible shard key would be `hotel_id`, with each hotel’s reservations assigned to a shard or shard group.

**Implementation status:** Sharding was discussed as a design option; it was not deployed in this single-hotel exercise. For one hotel, sharding would likely add unnecessary complexity.

### Availability and failover
A read replica provides an additional place to run read queries, but its existence alone does not establish high availability or automatic failover. A complete availability design would specify how the application detects primary failure, promotes or reconnects to a suitable endpoint, prevents conflicting writes, and restores service.

For a production hotel system, the design should include monitoring, tested recovery procedures, secure connection management, regular backups, and documented recovery point and recovery time objectives (RPO and RTO).

### Cloud compute and scale-to-zero
The Neon dashboard showed compute autoscaling configuration from 0.25 CU to 2 CU, and scale-to-zero after five minutes of inactivity. The dashboard also indicated that changing the scale-to-zero setting required a plan upgrade.

A compute may be suspended or idle while database storage remains available. A successful later query demonstrated that the production reservation was still present. This distinction is relevant when considering performance and availability in a serverless database environment.

## Conclusion
This exercise demonstrated a cloud-hosted PostgreSQL environment for PureHaven, database branch isolation, manual snapshot creation, and successful read queries through a read replica. The primary and replica returned matching status values for the sample reservation during a consistency check.
