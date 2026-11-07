# Portfolio 2: Query Processing and Optimisation

### Objective
Demonstrate reporting queries, query execution-plan analysis, index creation, and a cautious interpretation of performance measurements using PostgreSQL and pgAdmin.

### Environment
- Database: `PureHaven_Hotel`
- DBMS: PostgreSQL
- Client: pgAdmin 4
- Dataset after expansion: 503 guests, 64 rooms, 3,003 reservations.
- The generated records are synthetic test data.

### Files
- `01_reporting_queries.sql` — four reporting queries.
- `02_baseline_explain.sql` — baseline plan and expanded-data guest lookup.
- `03_create_indexes.sql` — indexes created during the experiment.
- `04_optimised_explain.sql` — guest lookup and upcoming-reservations plans after indexing.
- `05_dataset_validation.sql` — validation queries and final index listing.
- `performance-comparison.md` — analysis based on observed results.
- `screenshots/` — screenshot from queries.
