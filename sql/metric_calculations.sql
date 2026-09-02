-- The 72-Hour Attribution Engine: Match payments to the most recent prior interaction
WITH PaymentMatches AS (
    SELECT 
        p.payment_id,
        p.account_id,
        p.amount,
        p.event_at AS payment_time,
        i.channel,
        i.interaction_time,
        -- Calculate hour difference
        EXTRACT(EPOCH FROM (p.event_at - i.interaction_time))/3600 AS time_to_pay_hours,
        -- Rank interactions by closeness to payment time
        ROW_NUMBER() OVER(PARTITION BY p.payment_id ORDER BY i.interaction_time DESC) as rn
    FROM clean_payments p
    LEFT JOIN golden_unified_ledger i 
        ON p.account_id = i.account_id 
        AND i.interaction_time <= p.event_at
)
SELECT 
    payment_id,
    account_id,
    amount,
    channel,
    time_to_pay_hours,
    CASE 
        WHEN time_to_pay_hours <= 72 THEN 'Operational'
        ELSE 'Organic' 
    END AS payment_type
INTO feat_attribution_matrix
FROM PaymentMatches
WHERE rn = 1; -- Keep only the immediate prior interaction
