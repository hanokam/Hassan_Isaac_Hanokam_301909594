-- COMMIT example
BEGIN;
UPDATE portfolio3_account_demo SET balance = balance + 100 WHERE account_id = 1;
SELECT * FROM portfolio3_account_demo ORDER BY account_id;
COMMIT;
SELECT * FROM portfolio3_account_demo ORDER BY account_id;

-- ROLLBACK example (run after the COMMIT example)
BEGIN;
UPDATE portfolio3_account_demo SET balance = balance + 500 WHERE account_id = 1;
SELECT * FROM portfolio3_account_demo ORDER BY account_id;
ROLLBACK;
SELECT * FROM portfolio3_account_demo ORDER BY account_id;
