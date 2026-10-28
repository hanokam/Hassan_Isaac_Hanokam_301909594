-- Reset before the experiment:
-- UPDATE portfolio3_account_demo SET balance = 1000.00, version_no = 0 WHERE account_id = 1;
-- Session A: read 1000.00 and leave transaction open.
BEGIN;
SELECT balance FROM portfolio3_account_demo WHERE account_id = 1;
-- After Session B commits its absolute write:
UPDATE portfolio3_account_demo SET balance = 1300.00 WHERE account_id = 1;
COMMIT;
