-- Reset both accounts before the experiment:
-- UPDATE portfolio3_account_demo SET balance = 1000.00, version_no = 0;
BEGIN ISOLATION LEVEL SERIALIZABLE;
SELECT account_id, balance FROM portfolio3_account_demo
WHERE account_id IN (1, 2) ORDER BY account_id;
-- After both sessions have read the rows:
UPDATE portfolio3_account_demo
SET balance = balance - 100, version_no = version_no + 1
WHERE account_id = 1;
-- Commit Session A before attempting Session B's COMMIT.
COMMIT;
