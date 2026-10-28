-- Session A: execute first and leave transaction open.
BEGIN ISOLATION LEVEL READ COMMITTED;
SELECT account_id, account_name, balance FROM portfolio3_account_demo WHERE account_id = 1;

-- After Session B commits, execute this SELECT separately:
SELECT account_id, account_name, balance FROM portfolio3_account_demo WHERE account_id = 1;
COMMIT;
