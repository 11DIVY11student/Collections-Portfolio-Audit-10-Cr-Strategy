-- Standardize timestamps and stack all channels into a unified ledger
WITH UnifiedTouchpoints AS (
    SELECT account_id, 'call' AS channel, CAST(event_at AS TIMESTAMPTZ) AS interaction_time FROM raw_calls
    UNION ALL
    SELECT account_id, 'whatsapp', CAST(event_at AS TIMESTAMPTZ) FROM raw_whatsapp
    UNION ALL
    SELECT account_id, 'sms', CAST(event_at AS TIMESTAMPTZ) FROM raw_sms
    UNION ALL
    SELECT account_id, 'field_visit', CAST(event_at AS TIMESTAMPTZ) FROM raw_field_visits
)
SELECT * 
INTO golden_unified_ledger
FROM UnifiedTouchpoints;
