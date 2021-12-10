-- These are example queries
-- Using \G as end of statement to get clean vertical output
-- MonthlySpendingReport
SELECT x.user_id, x.username, z.amount, w.category_name, EXTRACT(YEAR_MONTH FROM z.date) as month
FROM user x
JOIN account y
ON x.user_id = y.user_id
JOIN transaction z
ON y.account_id = z.account_id
JOIN category w
ON z.category_id = w.category_id
GROUP BY x.user_id, z.amount, month, w.category_name
ORDER BY x.user_id\G

-- UserBudgetReport
SELECT x.user_id, x.username, y.budget_name, amount, startDate, endDate
FROM user x
JOIN budget y
ON x.user_id = y.user_id\G

-- NetWorthReport
SELECT *, CURRENT_DATE() as date
FROM (
SELECT x.user_id, x.username, SUM(y.balance) - SUM(z.amount) as net_worth
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
SELECT x.user_id, x.username, SUM(y.balance) + SUM(z.amount) as net_worth
FROM user x
JOIN account y
ON x.user_id = y.user_id
JOIN transaction z
ON y.account_id = z.account_id
WHERE balance < 0
GROUP BY user_id 
) below_zero
ORDER BY user_id\G