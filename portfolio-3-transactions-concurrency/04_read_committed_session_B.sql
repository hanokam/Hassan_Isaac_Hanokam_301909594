-- Session B: execute after Session A's first SELECT.
BEGIN;
UPDATE portfolio3_account_demo SET balance = balance + 50 WHERE account_id = 1;
COMMIT;
