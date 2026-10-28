-- Reset before the experiment:
-- UPDATE portfolio3_account_demo SET balance = 1000.00, version_no = 0 WHERE account_id = 1;
-- Session A: lock the row and leave transaction open.
BEGIN;
SELECT account_id, account_name, balance FROM portfolio3_account_demo WHERE account_id = 1 FOR UPDATE;
-- Session B's UPDATE will wait until this transaction commits.
UPDATE portfolio3_account_demo
SET balance = balance + 100, version_no = version_no + 1
WHERE account_id = 1;
COMMIT;
