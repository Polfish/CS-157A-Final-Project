-- Drop database to create a new one
DROP DATABASE IF EXISTS finance_tracker_dev;

-- Create database
CREATE DATABASE finance_tracker_dev;

-- Use the database
USE finance_tracker_dev;

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
-- CREATE VIEW AS MonthlySpendingReport
-- ;

-- UserBudgetReport view
-- CREATE VIEW AS UserBudgetReport
-- ;

-- NetWorthBudget view
CREATE VIEW AS NetWorthBudget
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