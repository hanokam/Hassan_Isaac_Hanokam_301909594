-- Session B: run after Session A has read the starting balance.
BEGIN;
SELECT balance FROM portfolio3_account_demo WHERE account_id = 1;
UPDATE portfolio3_account_demo SET balance = 1400.00 WHERE account_id = 1;
COMMIT;
