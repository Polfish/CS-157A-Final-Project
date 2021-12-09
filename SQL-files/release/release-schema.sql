-- Drop database to create a new one
DROP DATABASE IF EXISTS finance_tracker;

-- Create database
CREATE DATABASE finance_tracker;

-- Use the database
USE finance_tracker;

-- Create tables
CREATE TABLE user (
    user_id INT AUTO_INCREMENT,
    username VARCHAR(128),
    password VARCHAR(128),
    PRIMARY KEY (user_id)
);

CREATE TABLE budget (
    budget_id INT AUTO_INCREMENT,
    user_id INT,
    budget_name VARCHAR(128),
    amount DOUBLE,
    startDate DATE,
    endDate DATE,
    PRIMARY KEY (budget_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE account (
    account_id INT AUTO_INCREMENT,
    account_name VARCHAR(128),
    user_id INT,
    balance DOUBLE,
    PRIMARY KEY (account_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE category (
    category_id INT AUTO_INCREMENT,
    category_name VARCHAR(128),
    PRIMARY KEY (category_id)
);

CREATE TABLE transaction (
    transaction_id INT AUTO_INCREMENT,
    category_id INT,
    account_id INT,
    date DATE,
    notes VARCHAR(128),
    amount DOUBLE,
    PRIMARY KEY (transaction_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id),
    FOREIGN KEY (account_id) REFERENCES account(account_id)
);

-- Creating user views
-- MonthlySpendingReport view
CREATE VIEW monthly_spending_report AS
SELECT x.user_id, x.username, z.amount, w.category_name, EXTRACT(YEAR_MONTH FROM z.date) as month
FROM user x
JOIN account y
ON x.user_id = y.user_id
JOIN transaction z
ON y.account_id = z.account_id
JOIN category w
ON z.category_id = w.category_id
GROUP BY x.user_id, z.amount, month, w.category_name
ORDER BY x.user_id;

-- UserBudgetReport view
CREATE VIEW user_budget_report AS
SELECT x.user_id, x.username, y.budget_name, amount, startDate, endDate
FROM user x
JOIN budget y
ON x.user_id = y.user_id;

-- NetWorthBudget view
CREATE VIEW net_worth_report AS
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
ORDER BY user_id;