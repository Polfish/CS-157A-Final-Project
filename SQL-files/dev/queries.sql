-- These are example queries
-- MonthlySpendingReport


-- UserBudgetReport


-- NetWorthReport
SELECT *, CURRENT_DATE() as date
FROM (
SELECT x.user_id, SUM(y.balance) - SUM(z.amount) as net_worth
FROM user x
JOIN account y
ON x.user_id = y.user_id
JOIN transaction z
ON y.account_id = z.account_id
WHERE balance >= 0
GROUP BY user_id 
) zero_and_above

UNION

SELECT *, CURRENT_DATE() as date
FROM (
SELECT x.user_id, SUM(y.balance) + SUM(z.amount) as net_worth
FROM user x
JOIN account y
ON x.user_id = y.user_id
JOIN transaction z
ON y.account_id = z.account_id
WHERE balance < 0
GROUP BY user_id 
) below_zero
ORDER BY user_id;