-- Purge ghost accounts and consolidate duplicate borrowers
WITH ValidAccounts AS (
    SELECT 
        account_id, 
        borrower_id, 
        actual_recovery_rate, 
        risk_segment
    FROM raw_accounts
    WHERE borrower_id IS NOT NULL -- Drop orphaned records
),
MasterBorrowers AS (
    SELECT 
        borrower_id,
        name,
        email,
        ROW_NUMBER() OVER(PARTITION BY name, email ORDER BY created_at ASC) as rn
    FROM raw_borrowers
)
-- Create Clean Entity Master
SELECT 
    a.account_id,
    b.borrower_id AS master_borrower_id,
    a.actual_recovery_rate,
    a.risk_segment
INTO clean_master_accounts
FROM ValidAccounts a
JOIN MasterBorrowers b 
    ON a.borrower_id = b.borrower_id
WHERE b.rn = 1; -- Keep only the earliest created chronological profile
