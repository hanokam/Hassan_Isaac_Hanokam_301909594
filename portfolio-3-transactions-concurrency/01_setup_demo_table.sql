DROP TABLE IF EXISTS portfolio3_account_demo;
CREATE TABLE portfolio3_account_demo (
    account_id INTEGER PRIMARY KEY,
    account_name TEXT NOT NULL,
    balance NUMERIC(12,2) NOT NULL CHECK (balance >= 0),
    version_no INTEGER NOT NULL DEFAULT 0
);
INSERT INTO portfolio3_account_demo (account_id, account_name, balance, version_no)
VALUES (1, 'Demo Account A', 1000.00, 0),
       (2, 'Demo Account B', 1000.00, 0);
SELECT * FROM portfolio3_account_demo ORDER BY account_id;
