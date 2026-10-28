-- Session B: start and read before either session updates.
BEGIN ISOLATION LEVEL SERIALIZABLE;
SELECT account_id, balance FROM portfolio3_account_demo
WHERE account_id IN (1, 2) ORDER BY account_id;
-- After both sessions have read:
UPDATE portfolio3_account_demo
SET balance = balance - 100, version_no = version_no + 1
WHERE account_id = 2;
-- In the observed run, this COMMIT failed with SQLSTATE 40001.
COMMIT;
