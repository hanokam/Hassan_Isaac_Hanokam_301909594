-- Session B: run after Session A has acquired its FOR UPDATE lock.
BEGIN;
UPDATE portfolio3_account_demo
SET balance = balance + 200, version_no = version_no + 1
WHERE account_id = 1;
COMMIT;
