# Portfolio 4: NoSQL and Advanced Data Models

## Introduction

This portfolio extends the PureHaven Hotel Management System case study by demonstrating with NoSQL and Advanced data models:

- **MongoDB** — document database
- **Redis** — key-value store
- **Apache Cassandra** — wide-column database
- **Neo4j** — graph database

These demonstrations complement rather than automatically replace the relational PostgreSQL design developed for the wider PureHaven project.

## Case study and demonstration data

PureHaven is a single-hotel case study. The examples used here are purely fictional data with values for demonstration purposes - `PH-DEMO-0001`, guest Daniel Musa, room `101` (Deluxe), and a sample stay beginning **1 November 2026**.

## MongoDB — Document model

### Purpose

MongoDB represents a reservation as a nested document containing guest details, assigned rooms, stay dates, reservation status, payment summary, and special requests. This is convenient when an application commonly retrieves a booking as one complete unit.

### Implementation

The database and collection were created in MongoDB Atlas, and a reservation document was inserted. The database was queried using a filter, and the status was updated to `checked_in`.

MongoDB stores documents internally as **BSON (Binary JSON)**. JSON-compatible syntax was used to define and insert the demonstration document. The sample script is in the portfolio 4 folder.


### Suitability
Suitable for retrieving a booking record and all related details as a single document.


---

## Redis — Key-value model

### Purpose

Redis was used as a fast key-value store for a temporary booking session. The key `ph:booking-session:PH-DEMO-0001` stores a JSON string containing the booking reference, guest, and status. The command key is in the portfolio 4 folder.


### Suitability
Suitable for short-lived booking sessions, cache entries, and temporary state.

---

## Apache Cassandra — Wide-column model

### Purpose

Cassandra was used to model room occupancy by hotel and date. This is a query-oriented design intended to retrieve room status for a specified hotel and day.

### Environment and keyspace

The implementation was done in the Astra DB CQL console. The `purehaven` keyspace was created, and the database instance was named `PureHaven_db`. The sample SQL is in the portfolio 4 folder.


### Suitability
Suitable for retrieving room occupancy by hotel and date.

---

## Neo4j — Graph model

### Purpose

Neo4j represents entities as nodes and their connections as relationships.

### Graph structure

The demonstration contains four node types:

- `Guest` — Daniel Musa
- `Reservation` — `PH-DEMO-0001`
- `Room` — room `101`, type `Deluxe`
- `Amenity` — Wi-Fi

Relationships:

```text
(Guest)-[:MADE]->(Reservation)
(Reservation)-[:ALLOCATED_TO]->(Room)
(Room)-[:HAS_AMENITY]->(Amenity)
```

### Suitability
Suitable for traversing relationships between guests, bookings, rooms, and amenities.


## Conclusion

The demonstrations basically show that different data models can support different requirements. MongoDB provides flexible reservation documents; Redis supports short-lived, fast-access values; Cassandra stores occupancy data organised around hotel and date; and Neo4j represents relationships among guests, reservations, rooms, and amenities.

A real deployment could use all these technologies selectively while maintaining PostgreSQL as the RDBMS of record where structured relationships and transactional consistency are central.
