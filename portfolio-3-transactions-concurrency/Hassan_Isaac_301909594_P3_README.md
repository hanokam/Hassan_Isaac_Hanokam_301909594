# Portfolio 3: Transactions, Isolation and Concurrency Control

## Aim
Demonstrate COMMIT, ROLLBACK, READ COMMITTED, a lost-update anomaly, row-level locking, and SERIALIZABLE conflict handling using a separate demonstration table. The experiments do not modify the hotel's operational tables.

## Environment
- Database: `PureHaven_Hotel`
- Demonstration table: `portfolio3_account_demo`
- Columns: `account_id`, `account_name`, `balance`, `version_no`

## Experiments and observed outcomes
1. **COMMIT:** Account A increased from 1000.00 to 1100.00 and the value persisted.
2. **ROLLBACK:** A temporary increase of 500.00 was undone; the balance returned to 1100.00.
3. **READ COMMITTED:** After Session B committed an increase, a later SELECT in Session A saw the new committed value.
4. **Lost update:** Two sessions read 1000.00. Session B wrote 1400.00 and committed, then Session A wrote a stale value of 1300.00. The final value was 1300.00, illustrating how stale absolute writes can overwrite another change.
5. **Row-level lock:** Using `SELECT ... FOR UPDATE` made the competing update wait. Both increments were applied; final Account A balance was 1300.00 and `version_no` was 2.
6. **SERIALIZABLE:** Session A reduced Account A by 100.00 and committed. Session B's commit failed with SQLSTATE `40001` due to read/write dependencies. Final observed state: Account A 900.00/version 1; Account B 1000.00/version 0.

## Screenshot evidence
- `01_setup_demo_table.png`
- `02_commit_result.png`
- `03_rollback_result.png`
- `04_read_committed.png`
- `05_lost_update.png`
- `06_row_lock_result.png`
- `07_serializable_conflict.png`
- `08_serializable_final_state.png`

## Conclusion
The experiments illustrate how PostgreSQL handles transaction completion and concurrent access. COMMIT preserves changes, ROLLBACK discards uncommitted changes, READ COMMITTED allows later statements to see newly committed data, Row-level locks coordinate concurrent writes, and SERIALIZABLE may abort a transaction when a safe serial execution cannot be guaranteed.

## Limitations
These are controlled demonstrations using a small synthetic table, not a production financial system or a performance benchmark. Serializable failures should be handled by retrying the **entire transaction** when appropriate.
