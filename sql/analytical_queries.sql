-- Generate the final data for the ₹10 Cr Capital Reallocation Matrix
SELECT 
    channel,
    SUM(amount) AS true_operational_revenue,
    COUNT(payment_id) AS total_attributed_payments,
    AVG(time_to_pay_hours) AS avg_hours_to_convert
FROM feat_attribution_matrix
WHERE payment_type = 'Operational' 
  AND channel IS NOT NULL
GROUP BY channel
ORDER BY true_operational_revenue DESC;

-- Expose the Attribution Fraud (Organic vs Operational Split)
SELECT 
    payment_type,
    SUM(amount) AS total_revenue,
    COUNT(payment_id) AS volume,
    ROUND(COUNT(payment_id) * 100.0 / SUM(COUNT(payment_id)) OVER(), 2) AS percentage_of_total
FROM feat_attribution_matrix
GROUP BY payment_type;
