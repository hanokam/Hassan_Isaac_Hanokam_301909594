# MIT8103-Advanced Database Management Systems - CA

**Isaac Hanokam Hassan**

**301909594**

## Case Study: PureHaven Hotel Management System

### Introduction
PureHaven Hotel is a hospitality business that requires a good and reliable database system to help manage its daily operations. Operations that include booking, room reservation, managing room information,  payment documentation, etc. 

The proposal is to create a relational database system built with PostgreSQL. The database will organize hotel information into related tables to improve data accuracy, reduce unnecessary data duplication, and support efficient reporting.


### Problem Statement
Managing hotel records using paper records or disconnected spreadsheets can lead to inconsistent records across room reservations, room rates, payment, and tracking. Room assignments and reservation can also be harder to track.
PureHaven needs a structured relational database that stores related information consistently and supports accurate information retrieval and regular updates.


### Objectives
The purpose is to design and implement a relation database for PureHaven Hotel.

The Objectives are:
* To store guest, room, staff, reservation and payment information.
* Support reservations involving more than one room.
* Represent relationships between hotel records using primary and foreign keys.
* Record the nightly rate for each room assignment.
* Reduce data redundancy.


### Intended Users
* Receptionist (register guests, manage reservations)
* Hotel Manager (review reservations and room information)
* Accountant (review payment records)
* Database Administrator (maintain the database, permissions, and integrity)


### Scope
The database covers guest registration, room records, room types, room assignments, reservations, guest stays, and payments.
The protype does not include a booking website, an online payment gateway, or an accounting system.


### Proposed Technology
* Relational database: PostgreSQL
* Database administration interface: pgAdmin.


### Expected Outcome
* The outcome is a tested and documented PostgreSQL database prototype with related tables, defined keys, sample data, and a normalisation explanation. 
* The design will provide a foundation for later query optimisation, transaction processing, NoSQL modelling, and distributed or cloud database exercises.	


### Relational Schema
The written representation of the database tables and their keys is represented as follows.
Notation: PK = primary key, FK = foreign key, UK = unique key/alternate key.
* **GUESTS**
guest\_id PK, full\_name, email UK, phone, registered\_at
* **STAFF**
staff\_id PK, full\_name, email UK, job\_role
* **ROOM\_TYPES**
room\_type\_id PK, type\_name UK, description, capacity, nightly\_rate
* **ROOMS**
room\_id PK, room\_number UK, room\_type\_id FK, floor\_number, room\_status
* **RESERVATIONS**
reservation\_id PK, booking\_reference UK, guest\_id FK, staff\_id FK, check\_in\_date, check\_out\_date, reservation\_status, booked\_at
* **RESERVATION\_ROOMS**
reservation\_room\_id PK, reservation\_id FK, room\_id FK, nightly\_rate; UNIQUE(reservation\_id, room\_id)
* **PAYMENTS**
payment\_id PK, reservation\_id FK, payment\_reference UK, amount, payment\_method, payment\_status, paid\_at
* **STAYS**
stay\_id PK, reservation\_room\_id FK + UNIQUE, check\_in\_at, check\_out\_at


### Keys and constraints
Constraint		Example					Purpose
Primary key		guests.guest\_id				Uniquely identifies each record.
Foreign key		reservations.guest\_id			Ensures a reservation references an existing guest.
Unique			rooms.room\_number			Prevents duplicate room numbers.
Not null		guests.full\_name			Requires essential information.
Check			check\_out\_date > check\_in\_date		Rejects invalid date ranges.
Check			capacity > 0				Prevents zero or negative room capacity.
Default			room\_status DEFAULT 'available'		Supplies an initial status when one is not provided.
Unique combination	UNIQUE (reservation\_id, room\_id)	Prevents the same room from being assigned twice to one reservation.


### Normalisation
Normalisation helps reduce unnecessary duplication and avoid data anomalies.

First Normal Form (1NF)
* Each column stores a single value, and each table has a key identifying its rows.
* Example: Instead of storing room numbers as "101, 201" in a reservation field, we store each room assignment as a separate row in reservation\_rooms.

Second Normal Form (2NF)
* A table in 1NF must have every non-key attribute dependent on the whole of each candidate key, not just part of a composite key.
* Example: Reservation details belong in reservations, while room details belong in rooms. The junction table stores the agreed rate for the specific room assignment. The use of a surrogate primary key in reservation\_rooms simplifies key management; the unique pair (reservation\_id, room\_id) also prevents duplicate assignments.

Third Normal Form (3NF)
* Non-key attributes should depend on the primary key. In practical terms, unrelated descriptive information should be stored with the entity it describes.
* Example: type\_name, capacity, and the standard nightly\_rate are stored in room\_types. If a room type's description changes, we update one record instead of many room records.

